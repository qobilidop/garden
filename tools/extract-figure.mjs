#!/usr/bin/env node
// extract-figure.mjs — list or extract the figures in a post capture
// (<citekey>.html from capture-post.mjs): inlined rasters and top-level
// inline SVGs, numbered as their fig-N ids. Figures are derived views of the
// capture, never a preserved tier: extract one to look at it, then discard.
//
//   node tools/extract-figure.mjs <capture.html>            list: N, format, bytes, section, caption
//   node tools/extract-figure.mjs <capture.html> <N> <out>  write figure N to <out> (.png/.jpg/… or .svg)
import { readFileSync, writeFileSync } from 'node:fs'

const ICON_SVG_BYTES = 4096 // same threshold as capture-post.mjs: smaller SVGs are icons, not figures
const ATTRS = String.raw`(?:[^>"']|"[^"]*"|'[^']*')*` // attribute-aware: quoted values may hold '>'
const DATA_SRC = String.raw`\ssrc=(?:"data:image\/[^"]*"|'data:image\/[^']*'|data:image\/[^\s>"']*)`
const FIGURE = new RegExp(String.raw`<img\b${ATTRS}?${DATA_SRC}${ATTRS}>|<svg\b${ATTRS}>|<\/svg>`, 'gi')
const DATA = /\ssrc="?data:image\/([a-z+.-]+);base64,([^"\s>]*)/i
const HEADING = /<h[1-4]\b[^>]*>([\s\S]*?)<\/h[1-4]>/gi
const CAPTION = /<figcaption\b[^>]*>([\s\S]*?)<\/figcaption>/i

function text(html) {
  return html.replace(/<[^>]+>/g, ' ').replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&#39;/g, "'").replace(/\s+/g, ' ').trim()
}

function figures(html) {
  const out = []
  let depth = 0
  let svgStart = -1
  const push = (start, end, format, bytes) => {
    const headings = [...html.slice(0, start).matchAll(HEADING)]
    const section = headings.length ? text(headings.at(-1)[1]) : ''
    const caption = text(html.slice(end, end + 4000).match(CAPTION)?.[1] ?? '')
    out.push({ format, bytes, section, caption, start, end })
  }
  for (const m of html.matchAll(FIGURE)) {
    const tag = m[0]
    if (/^<svg/i.test(tag)) { if (depth === 0) svgStart = m.index; depth += 1; continue }
    if (/^<\/svg/i.test(tag)) {
      if (depth === 0) continue
      depth -= 1
      if (depth === 0) {
        const [start, end] = [svgStart, m.index + tag.length]
        if (end - start >= ICON_SVG_BYTES) push(start, end, 'svg', () => Buffer.from(html.slice(start, end)))
      }
      continue
    }
    if (depth > 0) continue
    const d = tag.match(DATA)
    if (!d) continue // a transparent placeholder for an image that never loaded: not a figure
    push(m.index, m.index + tag.length, d[1], () => Buffer.from(d[2], 'base64'))
  }
  return out
}

const [file, n, out] = process.argv.slice(2)
if (!file) {
  process.stdout.write('Usage: node tools/extract-figure.mjs <capture.html> [<N> <out>]\n')
  process.exitCode = 2
} else {
  const figs = figures(readFileSync(file, 'utf8'))
  if (!n) {
    figs.forEach((f, i) => {
      process.stdout.write(`${String(i + 1).padStart(2)}  ${f.format.padEnd(4)} ${String(f.bytes().length).padStart(8)}B  ${f.section.slice(0, 40).padEnd(40)}  ${f.caption.slice(0, 80)}\n`)
    })
  } else {
    const f = figs[Number(n) - 1]
    if (!f || !out) { console.error('extract-figure: bad figure number or missing output path'); process.exitCode = 2 }
    else { writeFileSync(out, f.bytes()); process.stdout.write(`wrote ${out} (${f.format}, fig-${n})\n`) }
  }
}
