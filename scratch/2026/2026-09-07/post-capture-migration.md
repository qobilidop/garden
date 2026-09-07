---
author: Claude Fable 5.1
---

# Post capture moves to a rendered page plus a transcript

Bili's decisions: try SingleFile and defuddle for post ingestion, adopt
them if the trial holds, apply the new capture to every existing post
(full pass, not a light one), then reflect and evolve. Written after the
migration landed.

## What changed

- Each post in shadow is now `<citekey>.html` — the page as a reader saw
  it (SingleFile: rendered by Chromium, images inlined, scripts removed,
  duplicate-image grouping off, `id="fig-N"` on every figure) — and
  `transcript.md` — the work's text extracted from that capture
  (defuddle: main content, frontmatter with title, author, date, image
  references to `<citekey>.html#fig-N`). The curl snapshot and the
  hand-collected `figures/` tier are gone; git history in shadow keeps
  them. `tools/capture-post.mjs` produces both, checks the extraction
  ratio, reports never-loaded images, and diffs prose against a prior
  artifact for revisits; `tools/extract-figure.mjs` lists and extracts
  figures on demand; `tools/check-ingest.mjs` requires the new shape and
  rejects the old one; `tools/package.json` pins the three packages.
- ingest-post: capture, fallbacks (SingleFile extension in the user's
  browser via `--from`, then Wayback), figures on demand, prose-diff
  revisits, no capture comment on `source:`.

## Migration outcome (32 posts)

- 29 unchanged as works: identical prose, or one to a dozen spans of
  extraction noise (apostrophe folding, a dropped `author`/`series`
  token, old-snapshot math leftovers, video element attributes).
  Format swapped, `retrieved` untouched.
- 3 changed: Anthropic's Riemann-zeta post (2026-08-13 update: revised
  paper, a contributor added) — notes reconciled; Osmani's loop
  engineering (one cross-reference edited) — notes unaffected; Every's
  compounding-engineering essay — the headless capture holds the full
  essay past the client-side paywall, notes still scoped to the preview.
- Hand-collected figures: every one byte-identical to an inlined image
  except two posts whose captures hold the same figures in another
  encoding (webp variants, a re-serialized SVG); verified by caption.
- Modular's eleven posts, whose curl snapshots were the only complete
  ones in August, now capture at 74–84% extraction with 15 real
  figures each; the site serves the body inside a `<figure>` element.

## Tuning ledger (evidence for "is the tooling worth it")

Nine adjustments between the first and final batch, each found by the
completeness check or the prose diff, none by reading files by hand:

1. Fold typographic apostrophes before diffing (477 false spans).
2. Compare prose only: math re-serializes MathML → LaTeX differently.
3. A `<figure>` wrapping the article body (Webflow) is not a figure;
   convert before extraction (eleven posts at 2–8% extraction).
4. Inline `<svg>` illustrations are figures; SVG path data was landing
   in the transcript (one post at 314% extraction).
5. SVGs under 4 KB are icons, not figures; drop them before extraction
   (71 icons collapsed one post to its header).
6. Tag regexes must be attribute-aware: LaTeX alt text containing `>`
   truncated a match mid-attribute (169 false spans).
7. Match the data-URI `src` value explicitly; the naive attribute-aware
   form mis-paired quotes and swallowed neighbouring tags.
8. SingleFile groups duplicate images through CSS variables by default;
   431 "placeholders" on a formula-heavy post were grouped duplicates.
   Grouping off keeps every image in its own tag at ~10% larger files.
9. Reset stale `fig-N` ids before annotating, so renumbering under a
   threshold change stays consistent.

Batches: three full captures of 32 posts, about seven minutes each.

## Rulings (Bili, same day)

- The tooling stays, under the maintenance rule now in ingest-post: fix
  only what a check flags, generically, one commit per fix; site-specific
  needs take the fallback; fixes outpacing ingestions means swap.
- The full Every capture stays as private evidence; the notes remain
  scoped to the preview until extended.

## Known limits and follow-ups

- Captures of image-heavy Modular pages run 18–33 MB (hero and
  related-post images inlined at full resolution); the post tier is
  258 MB. A `--max-resource-size` cap would trade evidence for space;
  undecided.
- The Every essay is captured in full; extending its notes past the
  preview is synthesis work, not migration.
- A gist page extracts at 24% (GitHub chrome); the pinned raw file
  remains the text identity there.
- Transcript quirks to remember when quoting: defuddle drops the word
  `author`/`series` in some blocks and keeps a site's "keep reading"
  section; the capture is the evidence.

## Process residue for /evolve

Staged (single occurrence each):

- A subtree removal by `git rm` can delete the directory itself; a
  script that then writes into it must recreate it. Bit once.
- A completeness ratio and a prose diff found every extraction defect
  in this migration; reading transcripts by hand found none. Machine
  checks that compare two derivations of the same content are worth
  more than review of either alone.
- Nine tuning steps on a rented extractor across 32 pages: the cost of
  adopting tooling whose failure modes are unknown is discovered by
  running it over the whole corpus once, not by trials on one page.

## Evolve outcome (run at session end)

Accepted and applied, all five: (1) ingest-post — the tool-maintenance
rule; (2) global rule in both mirrored configs — a `cd` inside a call
re-bases later relative paths (fourth recurrence of the cd trap);
(3) AGENTS.md §Conventions — a generated artifact ships with a check
against an independent derivation; (4) subtraction — the superseded
post capture profile marked in the ingestion memory; (5) this note's
rulings and outcome. Nothing rejected. Staged: the `git rm` directory
deletion; a tracked re-derivation batch if a second tool change needs
one.
