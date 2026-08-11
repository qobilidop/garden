#!/usr/bin/env node
import {
  existsSync,
  readFileSync,
  readdirSync,
  statSync,
} from 'node:fs'
import { dirname, join, relative, resolve, sep } from 'node:path'
import { fileURLToPath, pathToFileURL } from 'node:url'
import { librarySources } from '../site/src/lib/library-sources.mjs'

function usage() {
  return `Usage: node tools/check-ingest.mjs <citekey> [citekey ...]

Validates the local preservation tiers for freshly ingested library works.
Source-frontmatter parsing is shared with the site and archive tooling.
`
}

function nonEmptyFile(path, label) {
  if (!existsSync(path) || !statSync(path).isFile() || statSync(path).size === 0) {
    throw new Error(`missing or empty ${label}: ${path}`)
  }
  return statSync(path).size
}

function filesUnder(directory) {
  if (!existsSync(directory)) return []
  const files = []
  for (const entry of readdirSync(directory, { withFileTypes: true })) {
    const path = join(directory, entry.name)
    if (entry.isDirectory()) files.push(...filesUnder(path))
    else if (entry.isFile()) files.push(path)
  }
  return files
}

function snapshotsIn(directory) {
  if (!existsSync(directory)) return []
  return readdirSync(directory, { withFileTypes: true })
    .filter(
      (entry) => entry.isFile() && entry.name.endsWith('-snapshot.html'),
    )
    .map((entry) => join(directory, entry.name))
}

function manifestAt(shadowRoot) {
  const path = join(shadowRoot, 'store.manifest.json')
  const entries = JSON.parse(readFileSync(path, 'utf8'))
  return new Map(
    entries.filter((entry) => !entry.IsDir).map((entry) => [entry.Path, entry]),
  )
}

function verifyManifestFile({ localPath, storePath, manifest }) {
  const size = nonEmptyFile(localPath, 'store file')
  const entry = manifest.get(storePath)
  if (!entry) throw new Error(`store manifest is missing ${storePath}`)
  if (entry.Size !== size) {
    throw new Error(
      `store manifest size mismatch for ${storePath}: local=${size}, manifest=${entry.Size}`,
    )
  }
}

export function checkIngest(
  citekeys,
  { repoRoot, output = console.log } = {},
) {
  if (!citekeys?.length) throw new Error('at least one citekey is required')
  const root = resolve(repoRoot)
  const shadowRoot = join(root, 'shadow')
  const sources = librarySources(root)
  let manifest

  for (const citekey of [...new Set(citekeys)]) {
    const records = sources.filter((record) => record.citekey === citekey)
    if (records.length === 0) throw new Error(`unknown citekey: ${citekey}`)

    const noteFiles = new Set(records.map((record) => record.file))
    if (noteFiles.size !== 1) {
      throw new Error(`citekey resolves to multiple notes files: ${citekey}`)
    }
    const noteFile = [...noteFiles][0]
    const notePath = relative(root, noteFile).split(sep).join('/')
    const match = notePath.match(
      /^library\/(papers|posts)\/(\d{4})\/([^/]+)\/notes\.md$/,
    )
    if (!match || match[3] !== citekey) {
      throw new Error(`unexpected notes path for ${citekey}: ${notePath}`)
    }

    const [, kind, year] = match
    const tiers = ['notes']
    if (kind === 'papers') {
      const paperRoot = join(shadowRoot, 'library', 'papers', year, citekey)
      const types = new Set(records.map((record) => record.type))
      if (!types.has('pdf') && !types.has('html')) {
        throw new Error(`paper has no pdf or html source: ${citekey}`)
      }
      if (types.has('pdf')) {
        nonEmptyFile(join(paperRoot, 'transcript.md'), 'transcript')
        tiers.push('transcript')
        const storePath = `library/papers/${year}/${citekey}/${citekey}.pdf`
        manifest ??= manifestAt(shadowRoot)
        verifyManifestFile({
          localPath: join(shadowRoot, 'store', storePath),
          storePath,
          manifest,
        })
        tiers.push('pdf+manifest')
      }
      const snapshots = snapshotsIn(paperRoot)
      if (types.has('html') && snapshots.length === 0) {
        throw new Error(`missing HTML snapshot: ${citekey}`)
      }
      for (const snapshot of snapshots) {
        nonEmptyFile(snapshot, 'HTML snapshot')
      }
      if (snapshots.length > 0) {
        tiers.push(`${snapshots.length} snapshot`)
      }
    } else {
      const postRoot = join(shadowRoot, 'library', 'posts', year, citekey)
      const snapshots = snapshotsIn(postRoot)
      if (snapshots.length === 0) throw new Error(`missing snapshot: ${citekey}`)
      for (const snapshot of snapshots) nonEmptyFile(snapshot, 'snapshot')
      tiers.push(`${snapshots.length} snapshot`)

      const postStoreRoot = join(
        shadowRoot,
        'store',
        'library',
        'posts',
        year,
        citekey,
      )
      if (existsSync(postStoreRoot)) {
        const unexpected = readdirSync(postStoreRoot, { withFileTypes: true })
          .filter((entry) => entry.name !== 'figures')
          .map((entry) => entry.name)
        if (unexpected.length > 0) {
          throw new Error(
            `unexpected post store tier for ${citekey}: ${unexpected.join(', ')}`,
          )
        }
      }
      const figureRoot = join(postStoreRoot, 'figures')
      const figures = filesUnder(figureRoot)
      if (figures.length > 0) {
        manifest ??= manifestAt(shadowRoot)
        for (const figure of figures) {
          const storePath = relative(join(shadowRoot, 'store'), figure)
            .split(sep)
            .join('/')
          verifyManifestFile({ localPath: figure, storePath, manifest })
        }
        tiers.push(`${figures.length} figure+manifest`)
      }
    }
    output(`ok\t${citekey}\t${kind.slice(0, -1)}\t${tiers.join(', ')}`)
  }
}

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..')
if (process.argv[1] && import.meta.url === pathToFileURL(resolve(process.argv[1])).href) {
  const citekeys = process.argv.slice(2)
  if (citekeys.length === 0 || citekeys.includes('--help')) {
    process.stdout.write(usage())
    process.exitCode = citekeys.includes('--help') ? 0 : 2
  } else {
    try {
      checkIngest(citekeys, { repoRoot })
    } catch (error) {
      console.error(`check-ingest: ${error.message}`)
      process.exitCode = 1
    }
  }
}
