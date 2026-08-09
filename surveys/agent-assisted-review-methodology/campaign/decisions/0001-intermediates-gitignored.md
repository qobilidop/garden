# 0001 — Raw search dumps and intermediates stay out of the public repo

- Status: accepted (Bili, 2026-08-08, mid-campaign directive)

`logs/raw/` (unfiltered API responses), `candidates.tsv` (deduped
pool, regenerable from raw + script), and `work/` (screening batches
and other scratch) are gitignored to avoid repo bloat. What commits:
`logs/searches.tsv` (queries, dates, counts), `catalog.tsv`
(dispositions with rationale — the curated record), sources/,
syntheses/, claims, decisions, baseline. Kitchenham's
retain-unfiltered-results rule is honored locally during the
campaign; at baseline freeze, archival copies of the frozen result
sets go to shadow (mirrored path), not sys0.
