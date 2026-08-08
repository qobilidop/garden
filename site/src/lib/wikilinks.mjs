// Remark plugin resolving [[target]] wikilinks against a closed namespace
// (wiki slugs + library citekeys). An unresolved target fails the build —
// dead links are CI errors, not 404s.
//
// Syntax: [[target]], [[target|alias]], [[target#anchor]].
import { visit } from 'unist-util-visit'

const LINK_RE = /\[\[([^[\]]+)\]\]/g

export function slugifyAnchor(anchor) {
  return anchor
    .trim()
    .toLowerCase()
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
}

// resolve: Map<name, {href, label, kind}>
// Display: explicit [[target|alias]] wins; otherwise the target's label
// (citekey author-year handle, or a wiki page's title).
// Dead targets and bare mentions are caught by lintContent() at config
// load (sitemap.mjs) — errors thrown here would only be logged by the
// content layer, not fail the build.
export default function remarkWikilinks({ resolve }) {
  return (tree, file) => {
    visit(tree, 'text', (node, index, parent) => {
      if (!parent || !LINK_RE.test(node.value)) return
      LINK_RE.lastIndex = 0
      const parts = []
      let last = 0
      for (const m of node.value.matchAll(LINK_RE)) {
        const [raw, inner] = m
        const [targetAndAnchor, alias] = inner.split('|', 2)
        const [target, anchor] = targetAndAnchor.split('#', 2)
        const name = target.trim()
        const entry = resolve.get(name)
        if (entry === undefined) {
          throw new Error(
            `Unresolved wikilink [[${name}]] in ${file.path ?? 'unknown file'}`,
          )
        }
        if (m.index > last) {
          parts.push({ type: 'text', value: node.value.slice(last, m.index) })
        }
        const hProperties = {
          className: ['wikilink', `wikilink-${entry.kind}`],
        }
        if (entry.tip) hProperties['data-tip'] = entry.tip
        parts.push({
          type: 'link',
          url: anchor ? `${entry.href}#${slugifyAnchor(anchor)}` : entry.href,
          data: { hProperties },
          children: [
            { type: 'text', value: (alias ?? entry.label ?? name).trim() },
          ],
        })
        last = m.index + raw.length
      }
      if (last < node.value.length) {
        parts.push({ type: 'text', value: node.value.slice(last) })
      }
      parent.children.splice(index, 1, ...parts)
      return index + parts.length
    })
  }
}
