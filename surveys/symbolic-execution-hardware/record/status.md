# Current survey status

- **Coverage through:** 2026-08-12 strict-boundary search and citation-chase snapshot
- **Search through:** 2026-08-11 standing-query snapshot
- **Publication state:** publication candidate; manuscript, PDF render, and
  site integration validated on 2026-08-12
- **Coverage state:** bounded systematic map under the five-part
  path-conditioned symbolic-execution protocol; no mapping-closure claim

## Current counts

- **Catalog records:** 1,870
- **Include-level records:** 31
- **Critical deep reads:** 17
- **Mapping-depth includes:** 14
- **Parked:** 59
- **Excluded:** 1,780

The initial discovery funnel reconciles as 1,262 deduplicated database-search
records, 273 chase-only records, 41 Carter-lineage records, 48 Forbench
bibliography records, and 2 directly inspected primary additions. The strict
revision attempted 5 queries: 4 produced result sets and 1 failed with HTTP
429. It added 83 records after five aliases were collapsed, for a combined
catalog denominator of 1,709.

On 2026-08-12, backward and forward chases for nine newly promoted critical
works added 161 unique catalog records after overlap reconciliation: 159 were
excluded and 2 were parked for unavailable complete primary text. The current
denominator is therefore 1,870. These chases did not change the 31-work strict
include set.

## Method changes

- **2026-08-11 — Strict symbolic-execution boundary.** At the human author's
  direction, the survey stopped treating symbolic simulation and STE as
  include-level lineages and adopted a five-part operational test centered on
  path-conditioned hardware executions. Classical, concolic/dynamic, and
  selective/hybrid symbolic execution remain distinct core regimes. All 87
  prior includes, all 38 prior parked records, and 86 strict-query candidates
  were re-adjudicated; five candidate aliases collapsed into existing records,
  and positive inclusion required primary full text for all
  five operational conditions. Two complete thesis versions were added as
  primary records. The resulting strict corpus contains 14 classical, 11
  concolic, and 6 selective-hybrid works.

## Deferred to the next update

- Retry `s25`, which failed with HTTP 429, and reconcile it before advancing
  its date; retry retired `s24` only if symbolic-simulation discovery is again
  needed for boundary work.
- Re-screen the 59 parked records when complete primary text becomes
  available.
- Rerun active queries and both citation directions for the critical set;
  treat a newly verified mechanism or close comparator as grounds for an
  update.
