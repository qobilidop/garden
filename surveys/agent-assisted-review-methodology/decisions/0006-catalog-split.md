# 0006 — Committed catalog split under the 100KB guard

- Status: accepted (agent judgment, 2026-08-08; amends 0001 specifics)

The full disposition catalog reached 301KB (1,291 rows), over the
repo's file-size guard. Committed record: `catalog-included.tsv`
(672 includes — the citable map substrate) and
`catalog-adjudicated.tsv` (every overturn/adjudication/U with
rationale — the near-miss exclusion record in PRISMA item-16b
spirit). The full catalog.tsv is gitignored and goes to shadow at
baseline freeze with the other frozen sets; consensus-exclusion
rows are regenerable from work/ passes.
