#!/usr/bin/env node
// Screenshot a page in headless Chrome over the DevTools protocol.
//
//   node shot.mjs <url> <out.png> [--scheme light|dark] [--size WxH]
//                 [--hover X,Y] [--frames N --every MS] [--clip X,Y,W,H]
//                 [--reduced-motion]
//
// Why not `chrome --screenshot`: it clamps the window to ~500px wide
// (narrow layouts come out cropped, not reflowed) and ignores the
// color-scheme flags. Emulating media over the protocol fixes both;
// --hover fires :hover, --frames samples an animation. Requires
// Chrome at $CHROME or the macOS default path.
import { spawn } from 'node:child_process'
import { existsSync, mkdtempSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'

const args = process.argv.slice(2)
const positional = args.filter((a, i) => !a.startsWith('--') && !(i > 0 && args[i - 1].startsWith('--') && !['--reduced-motion'].includes(args[i - 1])))
const opt = (name, fallback) => { const i = args.indexOf(name); return i >= 0 ? args[i + 1] : fallback }
const [url, out] = positional
if (!url || !out) { console.error('usage: shot.mjs <url> <out.png> [--scheme light|dark] [--size WxH] [--hover X,Y] [--frames N --every MS] [--clip X,Y,W,H] [--reduced-motion]'); process.exit(2) }
const scheme = opt('--scheme', 'light')
const [width, height] = opt('--size', '1280x900').split('x').map(Number)
const hover = opt('--hover', null)?.split(',').map(Number)
const frames = Number(opt('--frames', '1'))
const every = Number(opt('--every', '200'))
const clip = opt('--clip', null)?.split(',').map(Number)
const reducedMotion = args.includes('--reduced-motion')

const chrome = process.env.CHROME ?? '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
if (!existsSync(chrome)) { console.error(`shot.mjs: Chrome not found at ${chrome}; set $CHROME`); process.exit(1) }
const port = 9300 + Math.floor(Math.random() * 500)
const profile = mkdtempSync(join(tmpdir(), 'shot-'))
const proc = spawn(chrome, ['--headless=new', '--no-first-run', '--disable-gpu', '--hide-scrollbars',
  `--remote-debugging-port=${port}`, `--user-data-dir=${profile}`, `--window-size=${width},${height}`, 'about:blank'], { stdio: 'ignore' })
const sleep = (ms) => new Promise((r) => setTimeout(r, ms))
try {
  let targets
  for (let i = 0; i < 40 && !targets; i++) { try { targets = await (await fetch(`http://127.0.0.1:${port}/json`)).json() } catch { await sleep(250) } }
  if (!targets) throw new Error('Chrome did not open its debugging port')
  const page = targets.find((t) => t.type === 'page')
  const ws = new WebSocket(page.webSocketDebuggerUrl)
  await new Promise((resolve, reject) => { ws.onopen = resolve; ws.onerror = reject })
  let id = 0; const pending = new Map()
  ws.onmessage = (e) => { const m = JSON.parse(e.data); if (m.id && pending.has(m.id)) { pending.get(m.id)(m.result); pending.delete(m.id) } }
  const send = (method, params = {}) => new Promise((r) => { pending.set(++id, r); ws.send(JSON.stringify({ id, method, params })) })
  await send('Emulation.setEmulatedMedia', { features: [
    { name: 'prefers-color-scheme', value: scheme },
    { name: 'prefers-reduced-motion', value: reducedMotion ? 'reduce' : 'no-preference' },
  ] })
  await send('Page.navigate', { url })
  await sleep(1500)
  if (hover) { await send('Input.dispatchMouseEvent', { type: 'mouseMoved', x: hover[0], y: hover[1] }); await sleep(600) }
  const shotParams = { format: 'png', ...(clip ? { clip: { x: clip[0], y: clip[1], width: clip[2], height: clip[3], scale: 1 } } : {}) }
  for (let i = 0; i < frames; i++) {
    const shot = await send('Page.captureScreenshot', shotParams)
    const file = frames > 1 ? out.replace(/\.png$/, `-${i}.png`) : out
    writeFileSync(file, Buffer.from(shot.data, 'base64'))
    if (i < frames - 1) await sleep(every)
  }
  ws.close()
  console.log(`wrote ${frames} file(s) to ${out}`)
} finally {
  proc.kill()
}
