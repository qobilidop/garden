// The closed link namespace: wiki slugs, library citekeys, and notebook
// IDs (note-XXXX, notebook/AGENTS.md), scanned from the repo at config load. Used by the wikilink plugin (resolution and
// display labels) and asserted collision-free — a wiki page shadowing a
// citekey is a build error.
import { readdirSync, readFileSync } from 'node:fs'
import { globSync } from 'node:fs'
import { basename, dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'
import { sourcesFromFrontmatter } from './library-sources.mjs'

const repoRoot = fileURLToPath(new URL('../../..', import.meta.url))

export function wikiSlugs() {
  return readdirSync(join(repoRoot, 'wiki'))
    .filter((f) => f.endsWith('.md'))
    .map((f) => basename(f, '.md'))
}

export function noteIds() {
  return readdirSync(join(repoRoot, 'notebook'))
    .filter((f) => /^note-[0-9a-z]{4}\.md$/.test(f))
    .map((f) => basename(f, '.md'))
}

export function citekeys() {
  return [...libraryFiles().keys()]
}

function libraryFiles() {
  const map = new Map()
  for (const p of globSync('library/**/notes.md', { cwd: repoRoot })) {
    const key = basename(dirname(p))
    const file = join(repoRoot, p)
    const frontmatter = readFileSync(file, 'utf8').match(/^---\n([\s\S]*?)\n---\n/)?.[1] ?? ''
    sourcesFromFrontmatter(frontmatter, p)
    const declared = frontmatter.match(/^citekey:\s*(\S+)\s*$/m)?.[1]
    const match = key.match(/^[a-z][a-z-]*\d{4}-([a-z0-9]+(?:-[a-z0-9]+){0,2})$/)
    if (!match || key.length > 28) {
      throw new Error(
        `Invalid library citekey "${key}": expected <author><year>-<label>, ` +
          'at most 28 characters total and three lowercase label tokens',
      )
    }
    if (declared !== key) {
      throw new Error(
        `Library citekey mismatch: ${p} declares "${declared ?? '(missing)'}", ` +
          `but its directory is "${key}"`,
      )
    }
    if (map.has(key)) {
      throw new Error(`Duplicate library citekey "${key}": ${map.get(key)} and ${file}`)
    }
    map.set(key, file)
  }
  return map
}

// Hover-card text from a note's frontmatter: title, author, venue · date.
function workTip(file) {
  const fm = readFileSync(file, 'utf8').match(/^---\n([\s\S]*?)\n---\n/)?.[1] ?? ''
  const field = (name) => {
    let v = fm.match(new RegExp(`^\\s{2}${name}: *(.+)$`, 'm'))?.[1]?.trim()
    if (!v) return undefined
    if (v.startsWith('"') && v.endsWith('"')) v = v.slice(1, -1)
    return v
  }
  const dateShort = field('date')?.match(/^\d{4}(-\d{2})?/)?.[0]
  // synthesis is top-level frontmatter (no indent), unlike the work fields
  let synthesis = fm.match(/^synthesis: *(.+)$/m)?.[1]?.trim()
  if (synthesis?.startsWith('"') && synthesis.endsWith('"')) {
    synthesis = synthesis.slice(1, -1).replace(/\\"/g, '"')
  }
  const meta = [
    field('title'),
    field('author'),
    [field('venue'), dateShort].filter(Boolean).join(' · '),
  ]
    .filter(Boolean)
    .join('\n')
  return synthesis ? `${meta}\n\n${synthesis}` : meta
}

// Display labels: a citekey's author-year prefix is the system's short
// handle (hubert2025-alphaproof → hubert2025) — the idiom the notes
// themselves use in prose. Prefix collisions get scholarly a/b suffixes
// in citekey order. Wiki pages label by their H1 title.
function citekeyLabels(keys) {
  const prefixOf = (k) => k.match(/^([a-z-]+?\d{4})/)?.[1] ?? k
  const byPrefix = new Map()
  for (const k of [...keys].sort()) {
    const p = prefixOf(k)
    if (!byPrefix.has(p)) byPrefix.set(p, [])
    byPrefix.get(p).push(k)
  }
  const labels = new Map()
  for (const [prefix, group] of byPrefix) {
    if (group.length === 1) {
      labels.set(group[0], prefix)
    } else {
      group.forEach((k, i) => {
        labels.set(k, prefix + String.fromCharCode(97 + i))
      })
    }
  }
  return labels
}

function wikiTitle(slug) {
  return h1(join(repoRoot, 'wiki', `${slug}.md`)) ?? slug
}

function noteTitle(id) {
  return h1(join(repoRoot, 'notebook', `${id}.md`)) ?? id
}

function h1(file) {
  return readFileSync(file, 'utf8').match(/^#\s+(.+)$/m)?.[1]?.trim()
}

// Every name that must never appear bare in prose: citekeys, their
// author-year prefixes, wiki slugs, and note IDs. The wikilink plugin lints text
// against this set so unlinked mentions fail the build.
export function bareNames() {
  const names = new Set([...wikiSlugs(), ...noteIds()])
  for (const key of citekeys()) {
    names.add(key)
    const prefix = key.match(/^([a-z-]+?\d{4})/)?.[1]
    if (prefix) names.add(prefix)
  }
  return [...names]
}

// Config-load lint over all content: dead [[targets]] and bare unlinked
// mentions both throw here, which aborts `astro build` with a non-zero
// exit — errors thrown later, inside the markdown pipeline, are logged
// by the content layer but do NOT fail the build. Regex-level scan: it
// does not exempt fenced code blocks (none of the content uses citekeys
// in code; revisit if that changes).
export function lintContent(resolve) {
  const bare = bareNames()
  const bareRe = new RegExp(
    `(?<![\\w/-])(${bare
      .sort((a, b) => b.length - a.length)
      .map((n) => n.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'))
      .join('|')})(?![\\w/-])`,
    'g',
  )
  const files = [
    ...globSync('wiki/*.md', { cwd: repoRoot }),
    ...globSync('library/**/notes.md', { cwd: repoRoot }),
    ...globSync('notebook/note-*.md', { cwd: repoRoot }),
  ]
  const violations = []
  for (const rel of files) {
    let body = readFileSync(join(repoRoot, rel), 'utf8')
    body = body.replace(/^---\n[\s\S]*?\n---\n/, '')
    const masked = body.replace(/\[\[([^\]]*)\]\]/g, (_whole, inner) => {
      const target = inner.split('|', 1)[0].split('#', 1)[0].trim()
      if (!resolve.has(target)) {
        violations.push(`${rel}: unresolved wikilink [[${target}]]`)
      }
      return ''
    })
    for (const m of masked.matchAll(bareRe)) {
      violations.push(`${rel}: bare mention "${m[1]}" — wrap it in [[...]]`)
    }
  }
  if (violations.length > 0) {
    throw new Error(`Content lint failed:\n  ${violations.join('\n  ')}`)
  }
}

// base: the site base path ('' at the domain root, '/sub' under a prefix)
// Returns Map<name, {href, label, kind}>
export function buildResolveMap(base) {
  const resolve = new Map()
  for (const slug of wikiSlugs()) {
    resolve.set(slug, {
      href: `${base}/wiki/${slug}/`,
      label: wikiTitle(slug),
      kind: 'wiki',
    })
  }
  const files = libraryFiles()
  const labels = citekeyLabels([...files.keys()])
  for (const [key, label] of labels) {
    if (resolve.has(key)) {
      throw new Error(`Name collision between wiki page and citekey: ${key}`)
    }
    resolve.set(key, {
      href: `${base}/library/${key}/`,
      label,
      kind: 'library',
      tip: workTip(files.get(key)),
    })
  }
  for (const id of noteIds()) {
    if (resolve.has(id)) {
      throw new Error(`Name collision on notebook ID: ${id}`)
    }
    resolve.set(id, {
      href: `${base}/notebook/${id}/`,
      label: noteTitle(id),
      kind: 'note',
    })
  }
  return resolve
}
