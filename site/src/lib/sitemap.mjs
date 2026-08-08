// The closed link namespace: wiki slugs and library citekeys, scanned from
// the repo at config load. Used by the wikilink plugin (resolution) and
// asserted collision-free — a wiki page shadowing a citekey is a build error.
import { readdirSync } from 'node:fs'
import { globSync } from 'node:fs'
import { basename, dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const repoRoot = fileURLToPath(new URL('../../..', import.meta.url))

export function wikiSlugs() {
  return readdirSync(join(repoRoot, 'wiki'))
    .filter((f) => f.endsWith('.md'))
    .map((f) => basename(f, '.md'))
}

export function citekeys() {
  return globSync('library/**/notes.md', { cwd: repoRoot }).map((p) =>
    basename(dirname(p)),
  )
}

// base: the site base path, e.g. '/sys0'
export function buildResolveMap(base) {
  const resolve = new Map()
  for (const slug of wikiSlugs()) resolve.set(slug, `${base}/wiki/${slug}/`)
  for (const key of citekeys()) {
    if (resolve.has(key)) {
      throw new Error(`Name collision between wiki page and citekey: ${key}`)
    }
    resolve.set(key, `${base}/library/${key}/`)
  }
  return resolve
}
