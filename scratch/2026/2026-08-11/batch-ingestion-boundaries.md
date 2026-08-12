---
author: Codex GPT-5.6 Sol
---

# Batch ingestion needs orchestration without weaker item judgment

Three ingestion batches established a recurring shape: the Riemann-zeta and
MatrAIx pair, the eleven-part Democratizing AI Compute series, and a seven-work
reading set. The item-level work differed, but store synchronization,
validation, builds, and commit planning repeated. `ingest-batch` now owns only
that coordination; `ingest-paper` and `ingest-post` remain canonical for every
source-specific decision.

## Classify the whole set before capture

The reading set initially included Bret Victor's *Media for Thinking the
Unthinkable*. Its page is derived from a talk, so an HTML snapshot may preserve
the presentation surface without preserving the work itself. The post was
excluded before the batch shipped. This earns a classify-first batch rule, not
yet a talk-ingestion workflow: one boundary case does not establish whether the
canonical artifact should be video, slides, transcript, page, or a combination.

Unsupported items are now left uncaptured while supported independent items
continue. The talk-derived page remains a staged question for a future
recurrence.

## Raw HTML is evidence, not maintained source

The staged whitespace check for the Research Debt paper snapshot and the
Transformative Tools for Thought post snapshot reported 77 source-origin
whitespace diagnostics. This is the same mechanism previously observed in PDF
transcripts: mechanical fidelity and ordinary text style are different
properties. The paper ingestion check now excludes both transcript and raw
`*-snapshot.html` paths while continuing to check authored and manifest files.
`check-ingest` remains responsible for the promised capture tiers.

This is a subtraction: source snapshots were removed from an unsuitable lint,
not normalized or surrounded with another compensating check.

## Vector figures need a review-only rendering path

Four load-bearing figures in the reading set were SVGs that the direct image
viewer could not display. Temporary raster previews made visual selection
possible while the original vectors remained the stored artifacts. Post
ingestion now makes this fallback explicit: inspect a temporary rendering,
preserve the source SVG, and discard the derivative.

## Rejected promotions

No archive-policy change was made. The live-first post refresh policy and
post-ingestion archive request in `b3f3612` are newer deliberate decisions than
the earlier archive-maintenance reflection. No global agent rule or memory was
added: the earned changes are local procedures, and the talk boundary is not
yet stable enough to characterize as a user preference or general policy.
