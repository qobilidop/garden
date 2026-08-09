# Current survey status

- **Coverage through:** 2026-08-08
- **Catalog:** 1,292 works (646 included, 634 excluded, 12 parked);
  25 deep-read with evidence notes
- **Maintenance state:** reconciled through the coverage date;
  updates on demand
- **Manuscript:** draft under continuing human review

Counts are mechanical — regenerate with the shared update tool's
`status` command or `scripts/check.py` rather than editing them here
after every small change.

## Deferred to the next update

- **Build the syntheses layer.** `record/syntheses/` (cross-source
  understanding between `sources/` evidence and the manuscript) is
  now the standard record shape; this survey predates it. Distill
  the manuscript's four organizing findings into thematic synthesis
  files plus a `current-position.md` entry point, then re-check that
  every manuscript findings claim has a synthesis home.
- **Start the claims ledger.** `record/claims.md` (statused synthesis
  claims with scope, anchored evidence, and closest established
  result) is now standard; seed it from the manuscript's four
  organizing findings when building the syntheses layer.
- **Fill per-row decided keys.** Historical log rows carry counts
  only; future search and snowball rows record their
  `included_keys`/`excluded_keys` per the unified write contract.
