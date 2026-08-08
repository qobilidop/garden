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

// resolve: Map<name, href>
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
        const href = resolve.get(name)
        if (href === undefined) {
          throw new Error(
            `Unresolved wikilink [[${name}]] in ${file.path ?? 'unknown file'}`,
          )
        }
        if (m.index > last) {
          parts.push({ type: 'text', value: node.value.slice(last, m.index) })
        }
        parts.push({
          type: 'link',
          url: anchor ? `${href}#${slugifyAnchor(anchor)}` : href,
          data: { hProperties: { className: ['wikilink'] } },
          children: [{ type: 'text', value: (alias ?? name).trim() }],
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
