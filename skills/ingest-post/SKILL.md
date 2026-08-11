---
name: ingest-post
description: Ingest a post (blog post, org announcement, Q&A answer) into the sys library — HTML snapshot to shadow, load-bearing figures to the Drive store, synthesis notes plus a curated discussions list to sys. Use when asked to ingest, add, or capture a post or article (given a URL) into the library. For formally published research papers (arXiv, DOI, venue), use ingest-paper instead.
compatibility: "Requires the sys repo with its private shadow/ checkout and network access; the rclone store: remote only when figures are captured."
---

# Ingest a post

Work from the sys repo root. Requires the private `shadow/` checkout; the
rclone `store:` remote only when the post has figures. A post is a
single-author, informally published, web-native work with no
version-of-record — the snapshot in shadow *is* the record. Multi-author
threads-as-works are out of scope until one arrives.

## 1. Resolve the work

Metadata comes from the captured page itself (title tag, meta tags, post
header): title, author, publication date. Org-authored posts use the org
as author. Never trust memory for bibliographic facts.

## 2. Citekey

Same rule as `../ingest-paper/SKILL.md` §2 —
`<lowercase-author><year>-<short-label>`, with an established name first and a
concise canonical URL slug second. Posts often take the URL-slug branch
(`weng2026-harness`, `weng2026-scaling-laws`).

## 3. Capture to tiers

- **Snapshot → shadow** (always):
  `shadow/library/posts/<year>/<citekey>/<slug>-snapshot.html`, the page
  as-found. Run `tools/capture.sh <url> <dest>`. When the origin already
  blocks non-browser clients, capture through the user's browser or use a
  verified existing Wayback original-content record
  (`web.archive.org/web/<ts>id_/<url>`); the frontmatter comment records
  that acquisition fallback. Per `AGENTS.md` §Library, ingestion never
  requests or waits for a new archive capture.
- **Author-versioned source** (a gist or other git-backed page): pin the
  revision — capture the raw file at its commit sha alongside the page
  snapshot and verify the two agree. When the work is the
  author's own canonicalization of an earlier post (tweet → gist),
  record the original appearance as a second identity — frontmatter
  comment plus first discussions entry, with a text capture to shadow.
- **Figures → store** (only when load-bearing — content diagrams, not
  site chrome or related-post cards):
  `shadow/store/library/posts/<year>/<citekey>/figures/`. View them; the
  synthesis should reflect what they show.
- **Paywalled source**: the free preview is the record — capture it,
  state the paywall in a frontmatter comment, scope the notes to it, and
  name re-capture through the user's browser session as the upgrade
  path. Claims about the gated remainder from secondary sources are not
  asserted.

## 4. Discussions

Start with bounded exact queries and expand only when a lead warrants it:

- HN: query the exact title first through Algolia, capped at ten hits; query
  the canonical URL only if needed. This is normally enough to recover the
  story, points, comment count, and UTC creation date.
- Reddit/X: follow an exact indexed lead or search through an already-usable
  browser session. Do not bootstrap a browser solely to prove that no thread
  exists. Ignore bot mirrors (r/hackernews, r/hypeurls).
- Others as a concrete lead suggests: Lobsters
  (`lobste.rs/domains/<domain>.json`), Tildes, Mastodon (public RSS/API).

Curate for quality, not coverage: gauge comment counts first —
single-digit-comment threads are not interesting regardless of
views/points; prefer distinct audiences over same-audience echoes. If any
thread exists, keep at least the best one — never prune to empty. List
chronologically, shortest working URL form, each annotated `# YYYY-MM-DD`
(UTC creation date).

## 5. Provenance frontmatter

`notes.md` opens with (omit what doesn't apply — no venue field, no DOI;
comments only for non-obvious facts like the figure tier or an acquisition
fallback):

```yaml
---
citekey: <citekey>
work:
  title: <title>
  author: <author or org>
  date: <publication date — ISO to known precision: YYYY[-MM[-DD]]; never invent finer parts>
source: <page url>  # snapshot → shadow; figures (N PNGs) → store   <- only if figures
discussions:
  - <thread url>  # <YYYY-MM-DD>
retrieved: <today>
notes-by: <agent name + model, or human name>
notes-date: <today>
synthesis: <the notes' one-sentence take, when they have one>
---
```

## 6. Synthesis notes

Same bar as ingest-paper §5: the H1 is `work.title` verbatim and
`synthesis:` carries the notes' one-sentence take when they have one;
read the shadow snapshot, write transformation not compression, include
an honest assessment (durable vs era-bound, unverified claims, author's
stake), and read the library — cite related entries by citekey and say
what this work adds against them.
Writeback: update the `wiki/` topic pages this work touches
(skills/tend-wiki).

Before proposing commits, self-review the notes against the source:
every attribution (who did what) and number re-checked, and every
criticism verified as carefully as a claim — an unfair critique is a
worse error than a missed one. WebFetch summaries are leads, never
sources — assert only what the captured record contains.

## 7. Close

- `tools/store.sh push` only when figures went to store.
- Always run `node tools/check-ingest.mjs <citekey>` after capture (and after
  the store push when figures exist). It reuses the site's canonical source
  parser and checks the fresh notes, direct non-empty snapshot, and any files
  under the exact `figures/` tier against their manifest entries and byte sizes
  without printing the library inventory.
- Run `npm --prefix site run build` on the host, then propose the commits
  (sys: notes; shadow: snapshot + manifest when pushed), each ending with the
  agent's attribution trailer. Commit only on the user's word. When the request
  is only to commit and push, successful pushes complete it; wait for Pages and
  verify live routes only when publication or deployment verification is in
  scope.
