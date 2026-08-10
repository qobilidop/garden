import assert from 'node:assert/strict'
import test from 'node:test'
import {
  checkAvailability,
  parseArgs,
  requestCapture,
} from './archive-library.mjs'
import { sourcesFromFrontmatter } from '../site/src/lib/library-sources.mjs'

function response({ status = 200, json = {} } = {}) {
  return {
    ok: status >= 200 && status < 300,
    status,
    async json() {
      return json
    },
  }
}

test('parses flat post and paper source schemas', () => {
  assert.deepEqual(
    sourcesFromFrontmatter('source: https://example.com/post # snapshot'),
    [{ type: 'source', url: 'https://example.com/post' }],
  )
  assert.deepEqual(
    sourcesFromFrontmatter(
      'sources:\n  pdf: https://example.com/work.pdf # store\n  html: https://example.com/work',
    ),
    [
      { type: 'pdf', url: 'https://example.com/work.pdf' },
      { type: 'html', url: 'https://example.com/work' },
    ],
  )
})

test('rejects nested and archived source metadata', () => {
  assert.throws(
    () => sourcesFromFrontmatter('source:\n  url: https://example.com'),
    /flat http\(s\) scalars/,
  )
  assert.throws(
    () =>
      sourcesFromFrontmatter(
        'sources:\n  pdf: https://example.com/work.pdf\n    archived: https://web.archive.org/example',
      ),
    /archived links are maintained externally/,
  )
  assert.throws(
    () =>
      sourcesFromFrontmatter(
        'sources:\n  html: https://example.com/post',
        'library/posts/2026/example/notes.md',
      ),
    /posts use source/,
  )
  assert.throws(
    () =>
      sourcesFromFrontmatter(
        'source: https://example.com/paper',
        'library/papers/2026/example/notes.md',
      ),
    /papers use a sources/,
  )
  assert.throws(
    () =>
      sourcesFromFrontmatter(
        'sources:\n  pdf: https://example.com/one.pdf\n  pdf: https://example.com/two.pdf',
      ),
    /Duplicate sources.pdf/,
  )
})

test('falls back to CDX when the availability API has no snapshot', async () => {
  const calls = []
  const fetchImpl = async (url) => {
    calls.push(String(url))
    if (String(url).includes('/wayback/available')) {
      return response({ json: { archived_snapshots: {} } })
    }
    return response({
      json: [
        ['timestamp', 'statuscode'],
        ['20260810010203', '200'],
      ],
    })
  }
  const result = await checkAvailability('https://example.com/post', { fetchImpl })
  assert.equal(result.available, true)
  assert.equal(result.via, 'cdx')
  assert.equal(calls.length, 2)
})

test('reports missing only after both indexes return no capture', async () => {
  const fetchImpl = async (url) =>
    String(url).includes('/wayback/available')
      ? response({ json: { archived_snapshots: {} } })
      : response({ json: [['timestamp', 'statuscode']] })
  assert.deepEqual(
    await checkAvailability('https://example.com/missing', { fetchImpl }),
    { available: false },
  )
})

test('trusts a clean primary miss when the defensive CDX check times out', async () => {
  const fetchImpl = async (url) => {
    if (String(url).includes('/wayback/available')) {
      return response({ json: { archived_snapshots: {} } })
    }
    throw new Error('timeout')
  }
  assert.deepEqual(
    await checkAvailability('https://example.com/missing', { fetchImpl }),
    {
      available: false,
      via: 'availability',
      warning: 'CDX fallback failed: timeout',
    },
  )
})

test('Save Page Now requests are explicit and bounded by CLI options', async () => {
  let requested
  await requestCapture('https://example.com/post#section', {
    fetchImpl: async (url) => {
      requested = String(url)
      return response({ status: 302 })
    },
  })
  assert.equal(
    requested,
    'https://web.archive.org/save/https://example.com/post%23section',
  )
  assert.deepEqual(
    parseArgs(['--request-missing', '--max-requests', '4', '--delay-ms', '0']),
    {
      list: false,
      requestMissing: true,
      maxRequests: 4,
      delayMs: 0,
    },
  )
})
