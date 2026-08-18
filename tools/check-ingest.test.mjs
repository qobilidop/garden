import assert from 'node:assert/strict'
import { mkdtempSync, mkdirSync, rmSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { dirname, join } from 'node:path'
import test from 'node:test'
import { checkIngest } from './check-ingest.mjs'

function write(path, contents) {
  mkdirSync(dirname(path), { recursive: true })
  writeFileSync(path, contents)
}

function note({ citekey, kind, year = '2026', sources }) {
  const sourceBlock =
    kind === 'posts'
      ? `source: ${sources.source}`
      : `sources:\n${Object.entries(sources)
          .map(([type, url]) => `  ${type}: ${url}`)
          .join('\n')}`
  return `---
citekey: ${citekey}
work:
  title: Example
  author: Example
  date: ${year}
${sourceBlock}
---

# Example
`
}

function fixture() {
  return mkdtempSync(join(tmpdir(), 'sys0-check-ingest-'))
}

function withFixture(run) {
  const root = fixture()
  try {
    run(root)
  } finally {
    rmSync(root, { recursive: true, force: true })
  }
}

test('validates paper and post preservation tiers compactly', () => {
  withFixture((root) => {
    write(
      join(root, 'library/papers/2026/li2026-example/notes.md'),
      note({
        citekey: 'li2026-example',
        kind: 'papers',
        sources: {
          pdf: 'https://example.com/paper.pdf',
          record: 'https://example.com/paper',
        },
      }),
    )
    write(
      join(root, 'shadow/library/papers/2026/li2026-example/transcript.md'),
      '# Transcript\n',
    )
    const pdf = join(
      root,
      'shadow/library/papers/2026/li2026-example/li2026-example.pdf',
    )
    write(pdf, 'pdf bytes')
    write(
      join(root, 'library/posts/2026/example2026-post/notes.md'),
      note({
        citekey: 'example2026-post',
        kind: 'posts',
        sources: { source: 'https://example.com/post' },
      }),
    )
    write(
      join(
        root,
        'shadow/library/posts/2026/example2026-post/post-snapshot.html',
      ),
      '<html>post</html>',
    )
    write(
      join(
        root,
        'shadow/library/posts/2026/example2026-post/figures/chart.png',
      ),
      'figure',
    )
    write(
      join(root, 'library/papers/2026/example2026-html/notes.md'),
      note({
        citekey: 'example2026-html',
        kind: 'papers',
        sources: { html: 'https://example.com/paper.html' },
      }),
    )
    write(
      join(
        root,
        'shadow/library/papers/2026/example2026-html/paper-snapshot.html',
      ),
      '<html>paper</html>',
    )
    const output = []
    checkIngest(
      ['example2026-post', 'li2026-example', 'example2026-html'],
      {
        repoRoot: root,
        output: (line) => output.push(line),
      },
    )
    assert.deepEqual(output, [
      'ok\texample2026-post\tpost\tnotes, 1 snapshot, 1 figure',
      'ok\tli2026-example\tpaper\tnotes, transcript, pdf',
      'ok\texample2026-html\tpaper\tnotes, 1 snapshot',
    ])
  })
})

test('validates an ordinary post without figures', () => {
  withFixture((root) => {
    write(
      join(root, 'library/posts/2026/example2026-post/notes.md'),
      note({
        citekey: 'example2026-post',
        kind: 'posts',
        sources: { source: 'https://example.com/post' },
      }),
    )
    write(
      join(
        root,
        'shadow/library/posts/2026/example2026-post/post-snapshot.html',
      ),
      '<html>post</html>',
    )

    const output = []
    checkIngest(['example2026-post'], {
      repoRoot: root,
      output: (line) => output.push(line),
    })
    assert.deepEqual(output, [
      'ok\texample2026-post\tpost\tnotes, 1 snapshot',
    ])
  })
})

test('rejects missing and empty HTML-native paper snapshots', () => {
  withFixture((root) => {
    write(
      join(root, 'library/papers/2026/example2026-html/notes.md'),
      note({
        citekey: 'example2026-html',
        kind: 'papers',
        sources: { html: 'https://example.com/paper.html' },
      }),
    )
    assert.throws(
      () => checkIngest(['example2026-html'], { repoRoot: root }),
      /missing HTML snapshot/,
    )
    write(
      join(
        root,
        'shadow/library/papers/2026/example2026-html/paper-snapshot.html',
      ),
      '',
    )
    assert.throws(
      () => checkIngest(['example2026-html'], { repoRoot: root }),
      /missing or empty HTML snapshot/,
    )
  })
})

test('rejects missing and empty post snapshots', () => {
  withFixture((root) => {
    write(
      join(root, 'library/posts/2026/example2026-post/notes.md'),
      note({
        citekey: 'example2026-post',
        kind: 'posts',
        sources: { source: 'https://example.com/post' },
      }),
    )
    assert.throws(
      () => checkIngest(['example2026-post'], { repoRoot: root }),
      /missing snapshot/,
    )
    write(
      join(
        root,
        'shadow/library/posts/2026/example2026-post/post-snapshot.html',
      ),
      '',
    )
    assert.throws(
      () => checkIngest(['example2026-post'], { repoRoot: root }),
      /missing or empty snapshot/,
    )
  })
})

test('rejects an empty captured figure', () => {
  withFixture((root) => {
    write(
      join(root, 'library/posts/2026/example2026-post/notes.md'),
      note({
        citekey: 'example2026-post',
        kind: 'posts',
        sources: { source: 'https://example.com/post' },
      }),
    )
    write(
      join(
        root,
        'shadow/library/posts/2026/example2026-post/post-snapshot.html',
      ),
      '<html>post</html>',
    )
    write(
      join(
        root,
        'shadow/library/posts/2026/example2026-post/figures/chart.png',
      ),
      '',
    )
    assert.throws(
      () => checkIngest(['example2026-post'], { repoRoot: root }),
      /missing or empty figure/,
    )
  })
})

test('fails when a PDF transcript is missing', () => {
  withFixture((root) => {
    write(
      join(root, 'library/papers/2026/li2026-example/notes.md'),
      note({
        citekey: 'li2026-example',
        kind: 'papers',
        sources: { pdf: 'https://example.com/paper.pdf' },
      }),
    )
    assert.throws(
      () => checkIngest(['li2026-example'], { repoRoot: root }),
      /missing or empty transcript/,
    )
  })
})

test('fails for a missing or empty PDF', () => {
  withFixture((root) => {
    write(
      join(root, 'library/papers/2026/li2026-example/notes.md'),
      note({
        citekey: 'li2026-example',
        kind: 'papers',
        sources: { pdf: 'https://example.com/paper.pdf' },
      }),
    )
    write(
      join(root, 'shadow/library/papers/2026/li2026-example/transcript.md'),
      '# Transcript\n',
    )
    const pdf = join(
      root,
      'shadow/library/papers/2026/li2026-example/li2026-example.pdf',
    )
    assert.throws(
      () => checkIngest(['li2026-example'], { repoRoot: root }),
      /missing or empty pdf/,
    )

    write(pdf, '')
    assert.throws(
      () => checkIngest(['li2026-example'], { repoRoot: root }),
      /missing or empty pdf/,
    )
  })
})
