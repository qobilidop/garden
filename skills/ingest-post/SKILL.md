---
name: ingest-post
description: Ingest or refresh a post (blog post, org announcement, Q&A answer) in the sys library. Use when asked to ingest, add, capture, revisit, update, or check a post or article. For formally published research papers (arXiv, DOI, venue), use ingest-paper instead.
compatibility: "Requires the sys repo with its private shadow/ checkout and network access; the rclone store: remote only when figures are captured."
---

# Ingest a post

Work from the sys repo root. Requires the private `shadow/` checkout; the
rclone `store:` remote only when the post has figures. A post is a
single-author, informally published, web-native work with no
version-of-record. Retrieval is live-first and repeatable; preservation is
stateful because the snapshot in shadow identifies the exact evidence behind
the notes. Multi-author threads-as-works are out of scope until one arrives.

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
  that acquisition fallback.
- **Author-versioned source** (a gist or other git-backed page): pin the
  revision — capture the raw file at its commit sha alongside the page
  snapshot and verify the two agree. When the work is the
  author's own canonicalization of an earlier post (tweet → gist),
  record the original appearance as a second identity — frontmatter
  comment plus first discussions entry, with a text capture to shadow.
- **Figures → store** (only when load-bearing — content diagrams, not
  site chrome or related-post cards):
  `shadow/store/library/posts/<year>/<citekey>/figures/`. View them; the
  synthesis should reflect what they show. When the image viewer cannot render
  an SVG directly, make a temporary raster preview with an available renderer,
  inspect that preview, and store the original SVG. The preview is review
  material, not a preservation artifact; discard it after selection.
- **Paywalled source**: the free preview is the record — capture it,
  state the paywall in a frontmatter comment, scope the notes to it, and
  name re-capture through the user's browser session as the upgrade
  path. Claims about the gated remainder from secondary sources are not
  asserted.

### Revisiting an existing post

Fetch the live origin into a fresh temporary file before consulting the stored
snapshot. Compare SHA-256 first: identical bytes mean no source change; a
different hash is only a prompt for a substantive diff because templates,
timestamps, and tracking parameters can change without changing the work.
Keep the candidate outside shadow and discard it after an unchanged comparison.
If the live fetch fails, retain `retrieved` and the current snapshot; a verified
Wayback capture may be evaluated as a new candidate but is not silently treated
as the same source version.

- Unchanged work: retain the existing snapshot and make no sys or shadow
  commit. A health check is not a new evidence version.
- Material change: reconcile the synthesis against the fresh source, replace
  the snapshot in the same path, and commit the public notes and shadow update
  together. Shadow git history retains the prior evidence version.
- Version-addressed source: a raw artifact pinned to a Git commit or equivalent
  immutable revision may be the evidence identity; still retain the consulted
  bytes when deletion would otherwise make the notes unauditable.

`retrieved` means the date the source version supporting the current notes was
captured. Update it only when the notes are reconciled to a materially changed
source; never bump it merely because the URL was fetched successfully.

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
- Request missing public redundancy with:

  ```console
  node tools/archive-library.mjs --citekey <citekey> \
    --request-missing --max-requests 1 --delay-ms 0
  ```

  This records no archive URL in frontmatter and never polls an accepted
  submission; report a service failure without blocking the locally preserved
  ingestion.
- Run `npm --prefix site run build` on the host, then propose the commits
  (sys: notes; shadow: snapshot + manifest when pushed), each ending with the
  agent's attribution trailer. Commit only on the user's word. When the request
  is only to commit and push, successful pushes complete it; wait for Pages and
  verify live routes only when publication or deployment verification is in
  scope.
