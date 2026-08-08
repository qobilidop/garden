---
name: ingest-post
description: Ingest a post (blog post, org announcement, Q&A answer) into the sys library — HTML snapshot to shadow, load-bearing figures to the Drive store, synthesis notes plus a curated discussions list to sys. Use when asked to ingest, add, or capture a post or article (given a URL) into the library.
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

Same rule as ingest-paper §2 — `<lowercase-author><year>-<slug>` with URL
slug preferred and both candidates normalized. Posts usually take the
slug branch (`openai2026-ten-advances-in-mathematics`,
`weng2026-harness`).

## 3. Capture to tiers

- **Snapshot → shadow** (always):
  `shadow/library/posts/<year>/<citekey>/<slug>-snapshot.html`, the page
  as-found. When the origin blocks non-browser clients (403 to curl and
  WebFetch), capture the Wayback original-content record instead
  (`web.archive.org/web/<ts>id_/<url>`) and verify its text against the
  live page through the user's browser; the frontmatter comment records
  this.
- **Figures → store** (only when load-bearing — content diagrams, not
  site chrome or related-post cards):
  `shadow/store/library/posts/<year>/<citekey>/figures/`. View them; the
  synthesis should reflect what they show.
- **Archive**: mutable page, so the Wayback snapshot must be no older
  than `retrieved` — except that an older snapshot verified
  byte-identical to the capture suffices, with a frontmatter comment
  (trigger `https://web.archive.org/save/<url>` otherwise).

## 4. Discussions

Sweep where the audience actually is; access paths that work today:

- HN: Algolia API (open) — search title and site URL;
  `hn.algolia.com/api/v1/search?query=...&tags=story`.
- Reddit: `old.reddit.com/search.json?q=url:"<slug>"` through the user's
  browser session (anonymous clients are blocked). Ignore bot mirrors
  (r/hackernews, r/hypeurls).
- X: search through the user's browser session; there is no free
  anonymous read path. Status IDs encode UTC creation time
  (`(id >> 22) + 1288834974657` ms).
- Others as found: Lobsters (`lobste.rs/domains/<domain>.json`), Tildes,
  Mastodon (public RSS/API).

Curate for quality, not coverage: gauge comment counts first —
single-digit-comment threads are not interesting regardless of
views/points; prefer distinct audiences over same-audience echoes. If any
thread exists, keep at least the best one — never prune to empty. List
chronologically, shortest working URL form, each annotated `# YYYY-MM-DD`
(UTC creation date).

## 5. Provenance frontmatter

`notes.md` opens with (omit what doesn't apply — no venue field, no DOI;
comments only for non-obvious facts like the figure tier or an archive
rule deviation):

```yaml
---
citekey: <citekey>
work:
  title: <title>
  author: <author or org>
  date: <publication date>
source:  # snapshot → shadow; figures (N PNGs) → store   <- only if figures
  url: <page url>
  archived: <wayback snapshot url>
discussions:
  - <thread url>  # <YYYY-MM-DD>
retrieved: <today>
notes-by: <agent name + model, or human name>
notes-date: <today>
---
```

## 6. Synthesis notes

Same bar as ingest-paper §5: read the shadow snapshot, write
transformation not compression, include an honest assessment (durable vs
era-bound, unverified claims, author's stake), and read the library —
cite related entries by citekey and say what this work adds against them.

Before proposing commits, self-review the notes against the source:
every attribution (who did what) and number re-checked, and every
criticism verified as carefully as a claim — an unfair critique is a
worse error than a missed one.

## 7. Close

- `tools/store.sh push` only when figures went to store.
- Verify all tiers at the citekey paths, then propose the commits (sys:
  notes; shadow: snapshot + manifest when pushed), each ending with the
  agent's attribution trailer. Commit only on the user's word.
