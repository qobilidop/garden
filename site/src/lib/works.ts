// Helpers for reading library entries: display titles from the note body,
// shelf position (papers/posts, year) from the file path, and citation
// fields from frontmatter.
import type { CollectionEntry } from 'astro:content'

export function extractTitle(body: string): string | undefined {
  return body.match(/^#\s+(.+)$/m)?.[1]?.trim()
}

export interface Shelf {
  kind: 'papers' | 'posts'
  year: string
}

export function shelfOf(entry: CollectionEntry<'library'>): Shelf | undefined {
  const m = (entry.filePath ?? '').match(/library\/(papers|posts)\/(\d{4})\//)
  return m ? { kind: m[1] as Shelf['kind'], year: m[2] } : undefined
}

export interface Work {
  title?: string
  author?: string
  venue?: string
  date?: string
  doi?: string
  arxiv?: string
}

export function workOf(entry: CollectionEntry<'library'>): Work {
  const w = (entry.data as Record<string, unknown>).work
  return (w ?? {}) as Work
}

const MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

// work.date values are free-form but ISO-prefixed ("2026-08-02 (arXiv v1)…",
// "2007-07", "1981"); parse the prefix for sorting and month display.
export function dateOf(entry: CollectionEntry<'library'>): {
  sortKey: string
  month?: string
} {
  // Unquoted YAML dates arrive as Date objects, bare years as numbers.
  const raw = workOf(entry).date as unknown
  const s =
    raw instanceof Date ? raw.toISOString().slice(0, 10) : String(raw ?? '')
  const m = s.match(/^(\d{4})(?:-(\d{2}))?(?:-(\d{2}))?/)
  if (!m) return { sortKey: '0000' }
  return {
    sortKey: [m[1], m[2] ?? '00', m[3] ?? '00'].join('-'),
    month: m[2] ? MONTHS[Number(m[2]) - 1] : undefined,
  }
}

export function fieldOf(
  entry: CollectionEntry<'library'>,
  key: string,
): string | undefined {
  const v = (entry.data as Record<string, unknown>)[key]
  return typeof v === 'string' ? v : undefined
}
