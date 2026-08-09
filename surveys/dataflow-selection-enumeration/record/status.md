# Current survey status

- **Coverage through:** 2026-08-04
- **Baseline:** closed under the recorded initial mapping protocol
- **Maintenance state:** reconciled through the coverage date; updates on demand
- **Manuscript:** complete draft under continuing human review
- **Authorship:** Bili Dong, independent researcher

The catalog baseline contains 897 entries, including 201 deep reads, and the
audited logs contain 35,720 screened record occurrences. The current
claim-evidence matrix supports the focused synthesis and manuscript. These are
snapshot records, not targets and not measures of worldwide completeness.

Source notes created during the initial campaign use several historical
layouts. They remain evidence records, but are migrated to template version 2
when revisited rather than being mechanically labeled as newly reviewed.

Use the machine-generated view rather than editing counts here after every
small change:

```console
./dev.sh python3 surveys/dataflow-selection-enumeration/record/scripts/update.py status
```

Updates are staged on demand; the registered queries and their last
reconciled executions live in `updates/`. Any plausible close
competitor or new vocabulary theme starts an update immediately.

Current interpretation is summarized in `syntheses/current-position.md`.
Publication-snapshot requirements are in `protocol.md`; update execution steps
are in `updates/README.md`.
