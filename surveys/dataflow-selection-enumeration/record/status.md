# Current survey status

- **Coverage through:** 2026-08-04
- **Baseline:** initial campaign closed 2026-08-04 under bounded
  mapping closure (narrative in manuscript §4; history in git)
- **Maintenance state:** reconciled through the coverage date; updates on demand
- **Manuscript:** complete draft under continuing human review
- **Authorship:** Bili Dong, independent researcher

The catalog baseline contains 897 entries, including 202 deep reads, and the
audited logs contain 35,720 screened record occurrences. The current
evidence ledger supports the focused synthesis and manuscript. These are
snapshot records, not targets and not measures of worldwide completeness.

Source notes created during the initial campaign use several historical
layouts. They remain evidence records, but are migrated to template version 2
when revisited rather than being mechanically labeled as newly reviewed.

Use the machine-generated view rather than editing counts here after every
small change:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record status
```

Updates are staged on demand; the standing queries and their last
reconciled dates live in `queries.tsv`. Any plausible close
competitor or new vocabulary theme starts an update immediately.

Current interpretation is summarized in `syntheses/current-position.md`.
Publication-snapshot requirements are in `protocol.md`; update execution steps
are in the README's To update procedure.

## Deferred to the next update

- **Add boundary examples for the load-bearing exclusion code.**
  `E6-out-of-scope-model` carries most judgment; the protocol should
  give two or three boundary examples.
- **Grade evidence certainty.** `evidence.md` now carries an optional
  GRADE-inspired **Certainty** field (`high`/`moderate`/`low`); grade
  the 33 items on the next evidence touch rather than mechanically
  now.

- **Curate a landing-page reading list.** The standard survey landing
  carries a taxonomy-sectioned reading list; this survey's landing
  predates it. Curate anchors from the 202 deep reads.
- **Port the hardened PDF gate.** The standalone repo's PDF/A-2b
  output and Poppler structural diagnostics (pinned toolchain
  digests) are not yet ported to the shared manuscript build.
