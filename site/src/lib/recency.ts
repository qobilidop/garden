// Build-time recency derived from the repository's canonical change ledger.
// Published builds require full Git history; dirty local content sorts first
// so a pre-commit preview still reflects the work in progress.
import { execFileSync } from 'node:child_process'
import { isAbsolute, relative, resolve, sep } from 'node:path'
import { MONTHS } from './works'

const WORKTREE_NOW = new Date().toISOString()
let root: string | undefined
let historyChecked = false

function git(args: string[]): string {
  return execFileSync('git', args, {
    cwd: repoRoot(),
    encoding: 'utf8',
  }).trim()
}

function repoRoot(): string {
  root ??= execFileSync('git', ['rev-parse', '--show-toplevel'], {
    encoding: 'utf8',
  }).trim()
  return root
}

function requireFullHistory(): void {
  if (historyChecked) return
  if (git(['rev-parse', '--is-shallow-repository']) !== 'false') {
    throw new Error(
      'site recency requires full Git history; configure checkout with fetch-depth: 0',
    )
  }
  historyChecked = true
}

function dirty(paths: string[]): boolean {
  return (
    git(['status', '--porcelain=v1', '--untracked-files=normal', '--', ...paths]) !== ''
  )
}

function committedAt(args: string[], paths: string[]): string | undefined {
  requireFullHistory()
  return (
    git(['log', ...args, '-1', '--format=%cI', '--', ...paths]) || undefined
  )
}

export function entryPath(filePath: string | undefined): string {
  if (!filePath) throw new Error('content entry has no filePath for recency')
  const absolute = isAbsolute(filePath)
    ? filePath
    : resolve(repoRoot(), 'site', filePath)
  const result = relative(repoRoot(), absolute)
  if (result === '..' || result.startsWith(`..${sep}`)) {
    throw new Error(`content path escapes repository: ${filePath}`)
  }
  return result.split(sep).join('/')
}

// Ingestion is the commit that first added the library note, not its latest
// edit or its separately recorded acquisition date.
export function ingestedAt(path: string): string {
  const timestamp = committedAt(['--follow', '--diff-filter=A'], [path])
  if (timestamp) return timestamp
  if (dirty([path])) return WORKTREE_NOW
  throw new Error(`no ingestion commit found for ${path}`)
}

// Wiki recency follows the topic file itself. A dirty local edit belongs at
// the top of its preview even though it has no commit timestamp yet.
export function wikiUpdatedAt(path: string): string {
  if (dirty([path])) return WORKTREE_NOW
  const timestamp = committedAt(['--follow'], [path])
  if (timestamp) return timestamp
  throw new Error(`no update commit found for ${path}`)
}

// Survey recency is public-facing: landing page or manuscript changes count;
// record-only maintenance does not move a survey on the homepage.
export function surveyUpdatedAt(slug: string): string {
  const paths = [`surveys/${slug}/index.md`, `surveys/${slug}/manuscript`]
  if (dirty(paths)) return WORKTREE_NOW
  const timestamp = committedAt([], paths)
  if (timestamp) return timestamp
  throw new Error(`no public update commit found for survey ${slug}`)
}

export function newest<T extends { id: string; timestamp: string }>(
  items: T[],
  limit = 5,
): T[] {
  return items
    .sort(
      (a, b) =>
        b.timestamp.localeCompare(a.timestamp) || a.id.localeCompare(b.id),
    )
    .slice(0, limit)
}

// "Aug 2026" for an ISO timestamp — the index pages' recency label.
export function monthLabel(timestamp: string): string {
  const d = new Date(timestamp)
  return `${MONTHS[d.getUTCMonth()]} ${d.getUTCFullYear()}`
}
