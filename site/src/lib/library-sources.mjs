import { readdirSync, readFileSync } from 'node:fs'
import { basename, dirname, join, relative } from 'node:path'

function frontmatterOf(text, file) {
  const match = text.match(/^---\r?\n([\s\S]*?)\r?\n---(?:\r?\n|$)/)
  if (!match) throw new Error(`Missing frontmatter: ${file}`)
  return match[1]
}

function sourceUrl(value, file, field) {
  const raw = value.replace(/\s+#.*$/, '').trim()
  try {
    const parsed = new URL(raw)
    if (parsed.protocol === 'http:' || parsed.protocol === 'https:') return raw
  } catch {
    // Fall through to the schema error below.
  }
  throw new Error(
    `Invalid ${field} in ${file}: source URLs must be flat http(s) scalars`,
  )
}

// One canonical source schema serves the site, ingestion checks, and archive
// maintenance. Posts have `source: <url>`; papers have a flat `sources:` map
// such as `pdf: <url>`, `html: <url>` for captured web-native content, and
// `record: <url>` for an uncaptured bibliographic landing page. Wayback
// coverage is derived external state and therefore never lives in note
// frontmatter.
export function sourcesFromFrontmatter(frontmatter, file = '<frontmatter>') {
  if (/^\s*archived:\s*/m.test(frontmatter)) {
    throw new Error(
      `Invalid source metadata in ${file}: archived links are maintained externally`,
    )
  }

  const lines = frontmatter.split(/\r?\n/)
  const singleIndex = lines.findIndex((line) => /^source:/.test(line))
  const groupIndex = lines.findIndex((line) => /^sources:/.test(line))
  if (singleIndex >= 0 && groupIndex >= 0) {
    throw new Error(
      `Invalid source metadata in ${file}: use source or sources, not both`,
    )
  }
  if (file.includes('library/posts/') && groupIndex >= 0) {
    throw new Error(`Invalid source metadata in ${file}: posts use source: <url>`)
  }
  if (file.includes('library/papers/') && singleIndex >= 0) {
    throw new Error(`Invalid source metadata in ${file}: papers use a sources: map`)
  }

  if (singleIndex >= 0) {
    const match = lines[singleIndex].match(/^source:\s*(.*)$/)
    return [
      {
        type: 'source',
        url: sourceUrl(match?.[1] ?? '', file, 'source'),
      },
    ]
  }

  if (groupIndex < 0) {
    throw new Error(`Missing source metadata: ${file}`)
  }
  if (!/^sources:\s*(?:#.*)?$/.test(lines[groupIndex])) {
    throw new Error(`Invalid sources mapping in ${file}`)
  }

  const sources = []
  for (let index = groupIndex + 1; index < lines.length; index += 1) {
    const line = lines[index]
    if (line === '' || /^\s+#/.test(line)) continue
    if (!/^\s/.test(line)) break
    const match = line.match(/^ {2}([a-z][a-z0-9-]*):\s*(.*)$/)
    if (!match) {
      throw new Error(
        `Invalid sources entry in ${file}: expected "  <type>: <url>"`,
      )
    }
    if (sources.some(({ type }) => type === match[1])) {
      throw new Error(`Duplicate sources.${match[1]} entry in ${file}`)
    }
    sources.push({
      type: match[1],
      url: sourceUrl(match[2], file, `sources.${match[1]}`),
    })
  }
  if (sources.length === 0) throw new Error(`Empty sources mapping: ${file}`)
  return sources
}

function noteFiles(directory) {
  const files = []
  for (const entry of readdirSync(directory, { withFileTypes: true })) {
    const path = join(directory, entry.name)
    if (entry.isDirectory()) files.push(...noteFiles(path))
    else if (entry.isFile() && entry.name === 'notes.md') files.push(path)
  }
  return files
}

export function librarySources(repoRoot) {
  const libraryRoot = join(repoRoot, 'library')
  return noteFiles(libraryRoot)
    .sort()
    .flatMap((file) => {
      const text = readFileSync(file, 'utf8')
      const relativeFile = relative(repoRoot, file)
      const frontmatter = frontmatterOf(text, relativeFile)
      const citekey = basename(dirname(file))
      return sourcesFromFrontmatter(frontmatter, relativeFile).map(
        ({ type, url }) => ({ citekey, type, url, file }),
      )
    })
}
