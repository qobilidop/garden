#!/usr/bin/env node
import { appendFileSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { fileURLToPath, pathToFileURL } from 'node:url'
import { librarySources } from '../site/src/lib/library-sources.mjs'

const DEFAULT_TIMEOUT_MS = 30_000
const CDX_TIMEOUT_MS = 10_000
const USER_AGENT = 'garden archive maintenance (+https://github.com/qobilidop/garden)'

function usage() {
  return `Usage: node tools/archive-library.mjs [options]

Periodically checks whether canonical library source URLs have a public
Wayback capture. The repository remains the authority for original URLs and
local preservation; archive coverage is external derived state.

Options:
  --list                 Print the source inventory without network access
  --citekey KEY          Limit work to one citekey (repeatable)
  --request-missing      Ask Save Page Now to capture URLs with no snapshot
  --max-requests N       Cap submissions per run (default: 10)
  --delay-ms N           Delay between submissions (default: 3000)
  --help                 Show this help

Without --request-missing, missing captures produce exit code 2. Network or
service errors produce exit code 1. Accepted submissions are verified by a
future run rather than polled immediately.
`
}

export function parseArgs(argv) {
  const options = {
    list: false,
    citekeys: [],
    requestMissing: false,
    maxRequests: 10,
    delayMs: 3_000,
  }
  for (let index = 0; index < argv.length; index += 1) {
    const argument = argv[index]
    if (argument === '--list') options.list = true
    else if (argument === '--request-missing') options.requestMissing = true
    else if (argument === '--help') options.help = true
    else if (argument === '--citekey') {
      const value = argv[index + 1]
      if (!value || value.startsWith('--')) {
        throw new Error('--citekey requires a value')
      }
      options.citekeys.push(value)
      index += 1
    } else if (argument === '--max-requests' || argument === '--delay-ms') {
      const value = Number(argv[index + 1])
      if (!Number.isInteger(value) || value < 0) {
        throw new Error(`${argument} requires a non-negative integer`)
      }
      if (argument === '--max-requests') options.maxRequests = value
      else options.delayMs = value
      index += 1
    } else {
      throw new Error(`Unknown option: ${argument}`)
    }
  }
  return options
}

function requestOptions(timeoutMs = DEFAULT_TIMEOUT_MS) {
  return {
    headers: { 'user-agent': USER_AGENT },
    signal: AbortSignal.timeout(timeoutMs),
  }
}

async function closestSnapshot(url, fetchImpl, timeoutMs) {
  const endpoint = new URL('https://archive.org/wayback/available')
  endpoint.searchParams.set('url', url)
  const response = await fetchImpl(endpoint, requestOptions(timeoutMs))
  if (!response.ok) {
    throw new Error(`availability API returned ${response.status}`)
  }
  const payload = await response.json()
  const closest = payload?.archived_snapshots?.closest
  return closest?.available && closest?.url ? closest.url : undefined
}

async function cdxSnapshot(url, fetchImpl, timeoutMs) {
  const endpoint = new URL('https://web.archive.org/cdx/search/cdx')
  endpoint.searchParams.set('url', url)
  endpoint.searchParams.set('output', 'json')
  endpoint.searchParams.set('fl', 'timestamp,statuscode')
  endpoint.searchParams.set('filter', 'statuscode:200')
  endpoint.searchParams.set('limit', '1')
  const response = await fetchImpl(
    endpoint,
    requestOptions(Math.min(timeoutMs, CDX_TIMEOUT_MS)),
  )
  if (!response.ok) throw new Error(`CDX API returned ${response.status}`)
  const rows = await response.json()
  const timestamp =
    Array.isArray(rows) && Array.isArray(rows[1]) ? rows[1][0] : undefined
  return timestamp
    ? `https://web.archive.org/web/${timestamp}/${url}`
    : undefined
}

export async function checkAvailability(
  url,
  { fetchImpl = fetch, timeoutMs = DEFAULT_TIMEOUT_MS } = {},
) {
  let availabilityError
  try {
    const snapshot = await closestSnapshot(url, fetchImpl, timeoutMs)
    if (snapshot) return { available: true, snapshot, via: 'availability' }
  } catch (error) {
    availabilityError = error
  }

  try {
    const snapshot = await cdxSnapshot(url, fetchImpl, timeoutMs)
    if (snapshot) return { available: true, snapshot, via: 'cdx' }
    if (availabilityError) throw availabilityError
    return { available: false }
  } catch (error) {
    if (!availabilityError) {
      return {
        available: false,
        via: 'availability',
        warning: `CDX fallback failed: ${error.message}`,
      }
    }
    throw new Error(`Wayback lookup failed: ${error.message}`)
  }
}

export async function requestCapture(
  url,
  { fetchImpl = fetch, timeoutMs = DEFAULT_TIMEOUT_MS } = {},
) {
  const encoded = encodeURI(url).replaceAll('#', '%23')
  const response = await fetchImpl(`https://web.archive.org/save/${encoded}`, {
    ...requestOptions(timeoutMs),
    redirect: 'manual',
  })
  if (response.status < 200 || response.status >= 400) {
    throw new Error(`Save Page Now returned ${response.status}`)
  }
}

function sleep(milliseconds) {
  return new Promise((resolvePromise) => setTimeout(resolvePromise, milliseconds))
}

function uniqueSources(sources) {
  const byUrl = new Map()
  for (const source of sources) {
    const existing = byUrl.get(source.url)
    if (existing) existing.entries.push(`${source.citekey}:${source.type}`)
    else {
      byUrl.set(source.url, {
        url: source.url,
        entries: [`${source.citekey}:${source.type}`],
      })
    }
  }
  return [...byUrl.values()]
}

export function selectSources(sources, citekeys = []) {
  if (citekeys.length === 0) return sources
  const requested = new Set(citekeys)
  const selected = sources.filter((source) => requested.has(source.citekey))
  const found = new Set(selected.map((source) => source.citekey))
  const unknown = [...requested].filter((citekey) => !found.has(citekey))
  if (unknown.length > 0) {
    throw new Error(`Unknown citekey: ${unknown.join(', ')}`)
  }
  return selected
}

function writeStepSummary(counts) {
  if (!process.env.GITHUB_STEP_SUMMARY) return
  appendFileSync(
    process.env.GITHUB_STEP_SUMMARY,
    [
      '## Library archive coverage',
      '',
      `- Sources checked: ${counts.checked}`,
      `- Already archived: ${counts.archived}`,
      `- Capture requests accepted: ${counts.requested}`,
      `- Missing and deferred: ${counts.deferred}`,
      `- Lookup warnings: ${counts.warnings}`,
      `- Errors: ${counts.errors}`,
      '',
    ].join('\n'),
  )
}

export async function run(
  options,
  { repoRoot, fetchImpl = fetch, output = console.log, wait = sleep } = {},
) {
  const sources = selectSources(librarySources(repoRoot), options.citekeys)
  if (options.list) {
    for (const source of sources) output(`${source.citekey}\t${source.type}\t${source.url}`)
    return 0
  }

  const counts = {
    checked: 0,
    archived: 0,
    requested: 0,
    deferred: 0,
    warnings: 0,
    errors: 0,
  }
  for (const source of uniqueSources(sources)) {
    counts.checked += 1
    const owner = source.entries.join(',')
    try {
      const result = await checkAvailability(source.url, { fetchImpl })
      if (result.available) {
        counts.archived += 1
        output(`archived\t${owner}\t${source.url}`)
        continue
      }
      if (result.warning) {
        counts.warnings += 1
        output(`warning\t${owner}\t${source.url}\t${result.warning}`)
      }
      if (!options.requestMissing || counts.requested >= options.maxRequests) {
        counts.deferred += 1
        output(`missing\t${owner}\t${source.url}`)
        continue
      }
      if (counts.requested > 0 && options.delayMs > 0) await wait(options.delayMs)
      await requestCapture(source.url, { fetchImpl })
      counts.requested += 1
      output(`requested\t${owner}\t${source.url}`)
    } catch (error) {
      counts.errors += 1
      output(`error\t${owner}\t${source.url}\t${error.message}`)
    }
  }

  output(
    `summary\tchecked=${counts.checked}\tarchived=${counts.archived}` +
      `\trequested=${counts.requested}\tdeferred=${counts.deferred}` +
      `\twarnings=${counts.warnings}\terrors=${counts.errors}`,
  )
  writeStepSummary(counts)
  if (counts.errors > 0) return 1
  if (!options.requestMissing && counts.deferred > 0) return 2
  return 0
}

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..')
if (process.argv[1] && import.meta.url === pathToFileURL(resolve(process.argv[1])).href) {
  try {
    const options = parseArgs(process.argv.slice(2))
    if (options.help) process.stdout.write(usage())
    else process.exitCode = await run(options, { repoRoot })
  } catch (error) {
    console.error(`archive-library: ${error.message}`)
    process.exitCode = 1
  }
}
