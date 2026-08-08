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

export function fieldOf(
  entry: CollectionEntry<'library'>,
  key: string,
): string | undefined {
  const v = (entry.data as Record<string, unknown>)[key]
  return typeof v === 'string' ? v : undefined
}
