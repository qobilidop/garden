---
name: ingest-post
description: Ingest or refresh a post (blog post, org announcement, Q&A answer) in the library. Use when asked to ingest, add, capture, revisit, update, or check a post or article. For formally published papers (arXiv, DOI, venue) use ingest-paper.
compatibility: "Requires the garden repo with its private shadow/ checkout and network access."
---

# Ingest a post

Work from the garden repo root. Requires the private `shadow/` checkout, Chrome,
and `npm ci --prefix tools` once (pinned capture and extraction tools). A post
is a single-author, informally published, web-native work with no
version-of-record. Retrieval is live-first and repeatable; preservation is
stateful because the capture in shadow identifies the exact evidence behind
the notes. Multi-author threads-as-works are out of scope until one arrives.

## 1. Resolve the work

Metadata comes from the captured page itself: the capture tool prints
title, author, publication date, and canonical URL as read from the page
(§3), and `transcript.md` opens with the same fields. Org-authored posts
use the org as author. Never trust memory for bibliographic facts. When
the citekey is not yet settled, capture into a scratch directory under a
provisional name and move the two artifacts once it is.

## 2. Citekey

Same rule as `../ingest-paper/SKILL.md` §2 —
`<lowercase-author><year>-<short-label>`, with an established name first and a
concise canonical URL slug second. Posts often take the URL-slug branch
(`weng2026-harness`, `weng2026-scaling-laws`).

## 3. Capture to tiers

- **Capture + transcript → shadow** (always), in
  `shadow/library/posts/<year>/<citekey>/`:

  ```console
  node tools/capture-post.mjs <url> shadow/library/posts/<year>/<citekey> <citekey>
  ```

  writes `<citekey>.html` — the page as a reader saw it (SingleFile:
  rendered by Chromium, images, CSS, and fonts inlined, scripts removed;
  each inlined image gets a mechanical `id="fig-N"`) — and
  `transcript.md` — the work's text extracted from that capture
  (defuddle: main content only, frontmatter with title, author, date;
  image references point at `<citekey>.html#fig-N`). The JSON record
  it prints carries the metadata for §5, the figure count, and the
  extraction ratio: `truncated: true` means read the capture before
  trusting the transcript. The transcript is a mechanical extraction
  with known quirks — math is the page's MathML re-serialized to
  LaTeX, and a word inside a code block can be dropped — so quotes,
  formulas, and numbers are verified against the capture, which is the
  evidence.
- **Figures** live inside the capture; there is no figures tier.
  `node tools/extract-figure.mjs <capture>` lists them by section and
  caption; `... <N> <out>` extracts one to look at (an SVG that the
  viewer cannot render gets a temporary raster preview). Extracted
  files are review material, never preserved; the synthesis should
  reflect what load-bearing figures show, and notes cite a figure as
  `<citekey>.html#fig-N` or by its caption.
- **Off the happy path** — a bot wall, login, or paywall, a git-backed
  source, or a capture check flagging the tool: open
  [references/capture-edge-cases.md](references/capture-edge-cases.md).
- **Revisiting an existing post** (refresh, health check, "has it
  changed?"): open [references/revisit.md](references/revisit.md) — it
  decides whether anything is committed at all.

## 4. Discussions

Start with bounded exact queries and expand only when a lead warrants it:

- HN: query the exact title first through Algolia (https only — plain http
  returns an empty result), capped at ten hits; query
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
comments only for non-obvious facts such as an acquisition fallback or a
paywall scope — the standard capture needs none):

```yaml
---
citekey: <citekey>
work:
  title: <title>
  author: <author or org>
  date: <publication date — ISO to known precision: YYYY[-MM[-DD]]; never invent finer parts>
source: <page url>
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
read `transcript.md` and look at the load-bearing figures in the capture,
write transformation not compression, include
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

- Always run `node tools/check-ingest.mjs <citekey>` after capture. It reuses
  the site's canonical source parser and checks the fresh notes, the
  non-empty capture and transcript, and that no legacy snapshot or
  `figures/` tier sits beside them, without printing the library inventory.
- Request missing public redundancy with:

  ```console
  node tools/archive-library.mjs --citekey <citekey> \
    --request-missing --max-requests 1 --delay-ms 0
  ```

  This records no archive URL in frontmatter and never polls an accepted
  submission; report a service failure without blocking the locally preserved
  ingestion.
- Run `npm --prefix site run build` on the host, then propose the commits
  (garden: notes; shadow: capture + transcript), each ending with the
  agent's attribution trailer. Commit only on the user's word. When the request
  is only to commit and push, successful pushes complete it; wait for Pages and
  verify live routes only when publication or deployment verification is in
  scope.
