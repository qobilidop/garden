# Terminology crosswalk

House terms are for filenames and operating prose — short, concrete,
one noun per ledger. Manuscript method sections speak the field's
established vocabulary; this table keeps the two languages bound.
Canon anchors: Kitchenham 2007 (SLR guidelines), Petersen 2008
(systematic mapping), Wohlin 2014 (snowballing), PRISMA 2020
(reporting), SEGRESS (SE reporting), all in the library.

| House | Established | Notes |
|---|---|---|
| updatable systematic map | systematic mapping study; cf. living systematic review | "living" (Cochrane/Elliott) implies a maintenance commitment; ours is the same infrastructure without the promise |
| `catalog.tsv` | study-selection record | one current row per work; PRISMA distinguishes records/reports/studies — the key grammar and E6 aliasing collapse reports onto works |
| `log.tsv` | search documentation / audit trail | Kitchenham: document the search as it happens |
| `queries.tsv` | search strategy | the registered query set with reconciliation state |
| screening | screening / study selection | canon term used as-is; the judgment step, not retrieval |
| facets, keywording | Petersen's classification scheme, built by keywording | canon terms used as-is |
| `deep-read` | full-text assessment | |
| `parked` | awaiting classification (Cochrane) | re-screened each update |
| exclusion codes E1–E7 | exclusion criteria with reasons | supports PRISMA 2020 item 16b (near-miss exclusions cited with reasons) |
| snowball (backward/forward) | Wohlin's backward/forward snowballing | a search method; hence a `snowball` subcommand of the search clients |
| bounded mapping closure | snowballing termination criterion | Wohlin: stop when an iteration finds nothing new; ours adds two predeclared no-add rounds |
| flow table | PRISMA 2020 flow diagram | table form; arithmetic must reconcile |
| `sources/` evidence notes | data extraction (forms) | pinpoint anchors to sections/tables of the primary work |
| `syntheses/` | (data) synthesis | the cross-source understanding layer |
| `claims.md` | synthesis claims ledger | statused assertions; cf. assurance-case claims (CAE/GSN) |
| `evidence.tsv` | evidence table / GRADE summary-of-findings; CAE claims–evidence binding; traceability matrix | one row per evidence item, binding claims and manuscript anchors to source anchors, caveat riding the row |
| protocol (`protocol.md` / README contract) | review protocol | Kitchenham: written and gated before the search |

Known conscious deviations from canon practice, always disclosed in
the manuscript's method or limitations: agent screening passes in
place of two human reviewers (no inter-rater statistic yet); raw
result sets discarded after reconciliation (Kitchenham saves them
for reanalysis); traceability, not reproducibility, as the bar.
