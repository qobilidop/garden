# Research record

This directory is an evidence system, not a chronological notebook.

## Evidence flow

1. Register every candidate work in `survey/catalog.tsv`.
2. Record reproducible closure searches in `survey/search-log.tsv`; keep the
   pre-protocol discovery history in `survey/exploratory-search-log.tsv`.
3. Create a structured source note for every work selected for deep reading.
4. Update the relevant thematic synthesis after each reading batch.
5. Reflect consequences in `terminology.md`, `claims.md`, examples, and, when a
   durable choice is made, a decision record.
6. Promote a claim into the manuscript only after its assumptions, evidence,
   closest existing result, and remaining obligations are explicit.

Mapping closure additionally requires reconciliation of all exploratory
additions, separate backward and forward chasing for every bounded closest-work
seed (`priority=critical`), two audited no-add rounds, and an independent
exclusion audit. The broader comparison table also includes boundary works that
are not snowballing seeds. The exact standard is in `survey/protocol.md`.

Raw downloads and disposable notes belong in the ignored `.scratch/`
directory. A reading task is not complete until its useful content is distilled
into the committed record.

## Status vocabulary

- Literature `candidate`: retained discovery-level or bibliographic record;
  it is not by itself a pending task and is permitted at closure when it is not
  a critical seed or the basis of a technical manuscript claim.
- Literature `screened`: title, abstract, or available source metadata has been
  adjudicated far enough to support the recorded scoped boundary.
- Literature `deep-read`: the full technical primary source has been read and
  anchored in a structured source note.
- Literature `excluded`: a stable exclusion code records why the work is out of
  scope, superseded, application-only, unobtainable, or duplicative.
- Literature priority is distinct from status: `critical` defines the bounded
  closest-work reading and snowballing seed set; `high` records discovery
  relevance, not an unresolved queue.
- Claims: `hypothesis`, `supported`, `needs-qualification`, `known-result`, or
  `rejected`.
- Decisions and terminology: `open`, `provisional`, `adopted`, or `superseded`.
