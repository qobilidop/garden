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
  date?: string | Date
  doi?: string
  arxiv?: string
}

export interface ExternalLink {
  label: string
  url: string
}

function recordOf(value: unknown): Record<string, unknown> | undefined {
  return value !== null && typeof value === 'object' && !Array.isArray(value)
    ? (value as Record<string, unknown>)
    : undefined
}

function httpUrlOf(value: unknown): string | undefined {
  if (typeof value !== 'string') return undefined
  try {
    const url = new URL(value)
    return url.protocol === 'http:' || url.protocol === 'https:'
      ? value
      : undefined
  } catch {
    return undefined
  }
}

function sourceTypeLabel(type: string): string {
  if (type === 'pdf' || type === 'html') return type.toUpperCase()
  return type
    .split('-')
    .filter(Boolean)
    .map((part) => part[0]?.toUpperCase() + part.slice(1))
    .join(' ')
}

function pushUnique(links: ExternalLink[], link: ExternalLink): void {
  if (!links.some(({ url }) => url === link.url)) links.push(link)
}

// Posts carry one `source`; papers carry typed `sources` such as PDF and
// HTML. Normalize both here so provenance presentation cannot drift from the
// note schema or be reimplemented by individual pages.
export function sourceLinksOf(
  entry: CollectionEntry<'library'>,
): ExternalLink[] {
  const data = entry.data as Record<string, unknown>
  const links: ExternalLink[] = []

  const singleUrl = httpUrlOf(data.source)
  if (singleUrl) pushUnique(links, { label: 'original', url: singleUrl })

  const sources = recordOf(data.sources)
  for (const [type, value] of Object.entries(sources ?? {})) {
    const url = httpUrlOf(value)
    const label = sourceTypeLabel(type)
    if (url) pushUnique(links, { label, url })
  }

  return links
}

function discussionHostLabel(url: string): string {
  const host = new URL(url).hostname.toLowerCase().replace(/^www\./, '')
  if (host === 'news.ycombinator.com') return 'Hacker News'
  if (host === 'x.com' || host === 'twitter.com') return 'X'
  if (host === 'reddit.com' || host.endsWith('.reddit.com')) return 'Reddit'
  if (host === 'lobste.rs') return 'Lobsters'
  return host
}

export function discussionLinksOf(
  entry: CollectionEntry<'library'>,
): ExternalLink[] {
  const raw = (entry.data as Record<string, unknown>).discussions
  if (!Array.isArray(raw)) return []

  const links = raw
    .map(httpUrlOf)
    .filter((url): url is string => url !== undefined)
    .map((url) => ({ label: discussionHostLabel(url), url }))
  const totals = new Map<string, number>()
  const seen = new Map<string, number>()
  for (const { label } of links) totals.set(label, (totals.get(label) ?? 0) + 1)

  return links.map(({ label, url }) => {
    if ((totals.get(label) ?? 0) === 1) return { label, url }
    const index = (seen.get(label) ?? 0) + 1
    seen.set(label, index)
    return { label: `${label} ${index}`, url }
  })
}

export function workOf(entry: CollectionEntry<'library'>): Work {
  const w = (entry.data as Record<string, unknown>).work
  return (w ?? {}) as Work
}

const MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

export function displayDateOf(
  entry: CollectionEntry<'library'>,
): string | undefined {
  const raw = workOf(entry).date
  if (raw instanceof Date) return raw.toISOString().slice(0, 10)
  return raw === undefined ? undefined : String(raw)
}

// work.date values are free-form but ISO-prefixed ("2026-08-02 (arXiv v1)…",
// "2007-07", "1981"); parse the prefix for sorting and month display.
export function dateOf(entry: CollectionEntry<'library'>): {
  sortKey: string
  month?: string
} {
  const s = displayDateOf(entry) ?? ''
  const m = s.match(/^(\d{4})(?:-(\d{2}))?(?:-(\d{2}))?/)
  if (!m) return { sortKey: '0000' }
  // Mixed precision, newest-first: year-only dates sort ABOVE the year's
  // month-dated entries (DESC-NULLS-FIRST convention), placing them
  // directly under the year header — which is their honest label, the
  // ledger logic one level up. '99' > any real month; missing days keep
  // CSL zero-padding (they only affect order within a month label).
  return {
    sortKey: [m[1], m[2] ?? '99', m[3] ?? '00'].join('-'),
    month: m[2] ? MONTHS[Number(m[2]) - 1] : undefined,
  }
}

export function fieldOf(
  entry: CollectionEntry<'library'>,
  key: string,
): string | undefined {
  const v = (entry.data as Record<string, unknown>)[key]
  if (v instanceof Date) return v.toISOString().slice(0, 10)
  return typeof v === 'string' ? v : undefined
}
