#!/usr/bin/env node
// capture-post.mjs — preserve a web post into the local shadow tier as two
// artifacts: <citekey>.html, the page as a reader saw it (SingleFile: rendered
// by a real Chromium, images/CSS/fonts inlined, scripts removed) with a
// mechanical `id="fig-N"` added to each inlined image; and transcript.md, the
// work's text extracted from that capture (defuddle: main content only, YAML
// frontmatter with title/author/date), whose image references point at
// <citekey>.html#fig-N. Prints a JSON record: metadata read from the page,
// word counts and their ratio (a low ratio flags a truncated extraction),
// figure count, and SHA-256 of both files.
//
//   node tools/capture-post.mjs <url> <dir> <citekey> [--compare <old>] [--from <html>]
//
// --from <html>: skip the browser and take an existing page file as the
// capture — one saved by the SingleFile extension from the user's own browser
// session, or a legacy snapshot to re-extract. <url> stays the page's origin
// (it anchors relative links).
// --compare <old>: also extract the text of an earlier evidence file (a
// legacy *-snapshot.html or a transcript.md), diff the two normalized texts,
// and report changed/unchanged with a word diff saved beside the capture as
// compare.diff. Nothing is deleted or overwritten except the two artifacts.
//
// Pinned versions live in tools/package.json (npm ci --prefix tools). Runs on
// the host: needs Chrome (macOS default path) and network.
import { spawnSync } from 'node:child_process'
import { createHash } from 'node:crypto'
import { existsSync, mkdirSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { dirname, join, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'
import { parseHTML } from 'linkedom'

const TOOLS = dirname(fileURLToPath(import.meta.url))
const BIN = join(TOOLS, 'node_modules', '.bin')
const CHROME = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
// A figure is an inlined raster (<img src="data:image/...">) or a top-level
// inline <svg> larger than an icon; both get fig-N ids in document order.
// Smaller SVGs are icons: no id, and dropped from the extraction input so
// they do not skew the extractor's content scoring (71 of them once
// collapsed a post to its header).
const ICON_SVG_BYTES = 4096
// SingleFile stands in a transparent SVG for an image that never loaded
// (lazy images below the fold); such a tag is a missing figure, reported
// but not numbered.
const PLACEHOLDER = /\ssrc=["']?data:image\/svg\+xml,<svg[^>]*><rect fill-opacity="0"\/><\/svg>/i
// Tag patterns are attribute-aware: a quoted value may contain '>' (LaTeX
// alt text on WordPress once truncated a plain [^>]* match mid-attribute).
const ATTRS = String.raw`(?:[^>"']|"[^"]*"|'[^']*')*`
const DATA_SRC = String.raw`\ssrc=(?:"data:image\/[^"]*"|'data:image\/[^']*'|data:image\/[^\s>"']*)`
const FIGURE = new RegExp(String.raw`<img\b${ATTRS}?${DATA_SRC}${ATTRS}>|<svg\b${ATTRS}>|<\/svg>`, 'gi')
const MIN_RATIO = 0.5

function usage() {
  return `Usage: node tools/capture-post.mjs <url> <dir> <citekey> [--compare <old.html|old.md>] [--from <capture.html>]\n`
}

function run(cmd, args, label) {
  const r = spawnSync(cmd, args, { encoding: 'utf8', maxBuffer: 1 << 28 })
  if (r.status !== 0) throw new Error(`${label} failed (${r.status}): ${(r.stderr || r.stdout).trim().slice(-600)}`)
  return r.stdout
}

function requireDeps() {
  for (const bin of ['single-file', 'defuddle']) {
    if (!existsSync(join(BIN, bin))) throw new Error(`missing ${bin}; run: npm ci --prefix tools`)
  }
}

function sha256(path) {
  return createHash('sha256').update(readFileSync(path)).digest('hex')
}

function visibleWords(html) {
  const text = html
    .replace(/<(script|style|noscript)\b[^>]*>[\s\S]*?<\/\1>/gi, ' ')
    .replace(/<!--[\s\S]*?-->/g, ' ')
    .replace(/<[^>]+>/g, ' ')
    .replace(/&[a-z#0-9]+;/gi, ' ')
  return text.split(/\s+/).filter(Boolean).length
}

// Walk the figures in document order. `onImage(tag, n)` returns the
// replacement for an inlined <img>; `onSvg(markup, n)` for a whole top-level
// <svg>…</svg> block (nested <svg> stay inside their parent); `onIcon(markup)`
// for an SVG below the icon threshold, which is not numbered.
function walkFigures(html, onImage, onSvg, onIcon = (svg) => svg, onMissing = (tag) => tag) {
  let out = ''
  let last = 0
  let n = 0
  let missing = 0
  let depth = 0
  let svgStart = -1
  for (const m of html.matchAll(FIGURE)) {
    const tag = m[0]
    if (/^<svg/i.test(tag)) {
      if (depth === 0) { svgStart = m.index; n += 1 }
      depth += 1
      continue
    }
    if (/^<\/svg/i.test(tag)) {
      if (depth === 0) continue
      depth -= 1
      if (depth === 0) {
        const end = m.index + tag.length
        const svg = html.slice(svgStart, end)
        if (svg.length < ICON_SVG_BYTES) { n -= 1; out += html.slice(last, svgStart) + onIcon(svg); last = end }
        else { out += html.slice(last, svgStart) + onSvg(svg, n); last = end }
      }
      continue
    }
    if (depth > 0) continue
    if (PLACEHOLDER.test(tag)) {
      missing += 1
      out += html.slice(last, m.index) + onMissing(tag)
      last = m.index + tag.length
      continue
    }
    n += 1
    out += html.slice(last, m.index) + onImage(tag, n)
    last = m.index + tag.length
  }
  return { html: out + html.slice(last), figures: n, missing }
}

// Add id="fig-N" to every figure in the capture; ids from an earlier run of
// this tool are reset first, so renumbering stays consistent.
function annotateFigures(html) {
  const reset = html.replace(/<(img|svg)\b id="fig-\d+"/gi, '<$1')
  const withId = (open, n) => (new RegExp(String.raw`^<(?:img|svg)\b${ATTRS}?\sid=`, 'i').test(open) ? null : n)
  return walkFigures(
    reset,
    (tag, n) => (withId(tag, n) === null ? tag : tag.replace(/^<img\b/i, `<img id="fig-${n}"`)),
    (svg, n) => {
      const open = svg.match(new RegExp(String.raw`^<svg\b${ATTRS}>`, 'i'))[0]
      return withId(open, n) === null ? svg : svg.replace(/^<svg\b/i, `<svg id="fig-${n}"`)
    },
  )
}

// Extraction input: a copy whose base URL is the origin (relative links
// resolve), whose figures are replaced by figure:N placeholders (the
// Markdown must not carry megabytes of base64 or SVG path data), and whose
// markup is corrected where an extractor would misread it — a <figure>
// wrapping the article body (Webflow) becomes a plain block, <noscript>
// fallbacks are unwrapped.
function extractionCopy(html, url) {
  const alt = (tag) => (tag.match(/\s(?:alt|aria-label|title)="([^"]*)"/i)?.[1] ?? '').replace(/"/g, '&quot;')
  const { html: replaced } = walkFigures(
    html,
    (tag, n) => `<img src="figure:${n}" alt="${alt(tag)}">`,
    (svg, n) => `<img src="figure:${n}" alt="${alt(svg.match(new RegExp(String.raw`^<svg\b${ATTRS}>`, 'i'))[0])}">`,
    () => '',
    (tag) => `<img src="figure:missing" alt="${alt(tag)}">`,
  )
  const { document } = parseHTML(replaced)
  for (const figure of [...document.querySelectorAll('figure')]) {
    const words = (figure.textContent ?? '').split(/\s+/).filter(Boolean).length
    if (words < 150) continue
    const div = document.createElement('div')
    for (const attr of figure.attributes) div.setAttribute(attr.name, attr.value)
    while (figure.firstChild) div.appendChild(figure.firstChild)
    figure.replaceWith(div)
  }
  for (const noscript of [...document.querySelectorAll('noscript')]) {
    const div = document.createElement('div')
    div.innerHTML = noscript.textContent ?? ''
    noscript.replaceWith(div)
  }
  const head = document.querySelector('head') ?? document.documentElement
  const base = document.createElement('base')
  base.setAttribute('href', url)
  head.insertBefore(base, head.firstChild)
  return document.toString()
}

function extract(html, url, citekey, workdir) {
  const input = join(workdir, 'extract.html')
  writeFileSync(input, extractionCopy(html, url))
  const md = run(join(BIN, 'defuddle'), ['parse', input, '--markdown', '--frontmatter'], 'defuddle')
  return md.replace(/\(figure:(\d+)\)/g, (m, n) => `(${citekey}.html#fig-${n})`)
}

function frontmatter(md) {
  const m = md.match(/^---\n([\s\S]*?)\n---\n/)
  const fields = {}
  if (!m) return fields
  for (const line of m[1].split('\n')) {
    const kv = line.match(/^([a-z_]+):\s*(.*)$/)
    if (!kv) continue
    let v = kv[2].trim()
    if (v.startsWith('"') && v.endsWith('"')) v = v.slice(1, -1)
    fields[kv[1]] = v
  }
  return fields
}

function bodyWords(md) {
  return md.replace(/^---\n[\s\S]*?\n---\n/, '').split(/\s+/).filter(Boolean).length
}

// The work's prose as a token stream: frontmatter, images, link targets,
// and math dropped (a rendered page re-serializes formulas differently from
// its source; MathML → LaTeX spelling is not an edit), then lowercase word
// tokens with typographic apostrophes folded to straight ones, twenty per
// line so a word diff stays readable.
function normalize(md) {
  const prose = md
    .replace(/^---\n[\s\S]*?\n---\n/, '')
    .replace(/\$\$[\s\S]*?\$\$/g, ' ')
    .replace(/\$[^$\n]*\$/g, ' ')
    .replace(/!\[[^\]]*\]\([^)]*\)/g, ' ')
    .replace(/\]\([^)]*\)/g, ']')
  const tokens = prose.toLowerCase().replace(/[’‘]/g, "'").match(/[a-z][a-z'-]+/g) ?? []
  const lines = []
  for (let i = 0; i < tokens.length; i += 20) lines.push(tokens.slice(i, i + 20).join(' '))
  return lines.join('\n')
}

function textOf(oldPath, url, workdir) {
  if (oldPath.endsWith('.md')) return readFileSync(oldPath, 'utf8')
  return extract(readFileSync(oldPath, 'utf8'), url, 'old', workdir)
}

function compare(oldPath, newMd, url, workdir, dir) {
  const a = join(workdir, 'old.txt')
  const b = join(workdir, 'new.txt')
  writeFileSync(a, normalize(textOf(oldPath, url, workdir)) + '\n')
  writeFileSync(b, normalize(newMd) + '\n')
  const r = spawnSync('git', ['diff', '--no-index', '--word-diff=plain', '--no-color', '--', a, b], { encoding: 'utf8', maxBuffer: 1 << 26 })
  const changed = r.status === 1
  const diff = changed ? r.stdout : ''
  const diffPath = join(dir, 'compare.diff')
  if (changed) writeFileSync(diffPath, diff)
  else if (existsSync(diffPath)) rmSync(diffPath)
  const added = (diff.match(/\{\+/g) || []).length
  const removed = (diff.match(/\[-/g) || []).length
  return { old: oldPath, changed, added_spans: added, removed_spans: removed, diff: changed ? diffPath : null }
}

function main(argv) {
  const args = [...argv]
  const option = (name) => {
    const i = args.indexOf(name)
    if (i < 0) return null
    const value = args[i + 1]
    args.splice(i, 2)
    return value ?? false
  }
  const old = option('--compare')
  const from = option('--from')
  if (args.length !== 3 || old === false || from === false) { process.stdout.write(usage()); return 2 }
  const [url, dirArg, citekey] = args
  const dir = resolve(dirArg)
  requireDeps()
  mkdirSync(dir, { recursive: true })
  const workdir = mkdtempSync(join(tmpdir(), 'capture-post-'))
  try {
    let raw = join(workdir, 'capture.html')
    if (from) raw = resolve(from)
    // Every image stays inline in its own tag (no duplicate grouping through
    // CSS variables): figure ids and extraction see each image where it is.
    else run(join(BIN, 'single-file'), ['--browser-executable-path', CHROME, '--group-duplicate-images=false', url, raw], 'single-file')
    const captured = readFileSync(raw, 'utf8')
    if (!captured.trim()) throw new Error('SingleFile produced an empty capture')
    const { html, figures, missing } = annotateFigures(captured)
    const md = extract(html, url, citekey, workdir)
    const htmlPath = join(dir, `${citekey}.html`)
    const mdPath = join(dir, 'transcript.md')
    writeFileSync(htmlPath, html)
    writeFileSync(mdPath, md)
    const fm = frontmatter(md)
    const words = bodyWords(md)
    const visible = visibleWords(html)
    const ratio = visible ? Number((words / visible).toFixed(2)) : 0
    const record = {
      url,
      canonical: html.match(/<link[^>]*rel=["']?canonical["']?[^>]*href=["']?([^"'\s>]+)/i)?.[1] ?? null,
      saved: html.match(/saved date:\s*([^\n]+?)\s*\n/)?.[1] ?? null,
      title: fm.title ?? null,
      author: fm.author ?? null,
      published: fm.published ?? null,
      site: fm.site ?? null,
      words,
      visible_words: visible,
      ratio,
      truncated: ratio < MIN_RATIO,
      figures,
      missing_images: missing,
      files: { html: htmlPath, transcript: mdPath },
      sha256: { html: sha256(htmlPath), transcript: sha256(mdPath) },
    }
    if (old) record.compare = compare(resolve(old), md, url, workdir, dir)
    process.stdout.write(JSON.stringify(record, null, 1) + '\n')
    if (record.truncated) process.stderr.write(`warning: extraction ratio ${ratio} < ${MIN_RATIO}; read the capture before trusting transcript.md\n`)
    if (missing > 0) process.stderr.write(`warning: ${missing} image(s) never loaded (placeholders in the capture); re-capture with a longer deferred-image wait\n`)
    return 0
  } finally {
    rmSync(workdir, { recursive: true, force: true })
  }
}

process.exitCode = (() => {
  try {
    return main(process.argv.slice(2))
  } catch (error) {
    console.error(`capture-post: ${error.message}`)
    return 1
  }
})()
