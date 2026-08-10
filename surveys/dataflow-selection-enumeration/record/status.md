# Current survey status

- **Coverage through:** 2026-08-09
- **Baseline:** the initial campaign was labeled closed on 2026-08-04;
  publication review found that 422 candidate rows remained unadjudicated, so
  the bounded-closure claim is withdrawn; migrated to the shared record shape
  and updated 2026-08-09
- **Maintenance state:** bounded search snapshot through the coverage date;
  evidence synthesis reconciled, candidate screening backlog open
- **Manuscript:** publication-review revision completed; continuing human review

The catalog holds 924 works: 120 deep-read, 247 screened, 422
candidate, 135 excluded, no parked rows. `sources/` holds 129 notes
on the unified template (119 full-text, 10 abstract-only); the
evidence ledger's 64 records are certainty-graded (36 high, 19
moderate, 9 low). These are snapshot records, not targets and not
measures of worldwide completeness. In particular, `candidate` means
unresolved at abstract-screening level, not included evidence.

Use the machine-generated views rather than editing counts here after
every small change:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record status
./dev.sh python3 surveys/dataflow-selection-enumeration/record/check.py
```

Updates are staged on demand; the standing queries and their last
reconciled dates live in `queries.tsv`. Any plausible close
competitor or new vocabulary theme starts an update immediately.

Current interpretation is summarized in `syntheses/current-position.md`.
Publication-snapshot requirements are in `protocol.md`; update execution steps
are in the README's To update procedure.

## Open work before any closure claim

- **Adjudicate all candidate rows at abstract level.** The backlog contains 422
  rows accumulated across the campaign, not only the latest batch. The
  2026-08-09 update added four title-screened examples — Java symbolic
  evaluation via large-block encoding (`arxiv:2608.04513`),
  probabilistic symbolic execution in PRISM
  (`doi:10.31274/td-20260804-208`), SORTeD Rashomon-set enumeration
  (`doi:10.52202/085713-1489`), and explicit-MPC distillation trees
  (`doi:10.1109/lcsys.2026.3721668`); none was judged critical, all
  await abstract screening. Until the entire backlog is resolved, the record
  may support a dated search snapshot but not bounded mapping closure.
- **Recover identifiers and titles for the legacy-keyed rows.** Ten
  rows carry `legacy:` keys (no registrar identifier or recoverable
  title at migration time) and two DOI-keyed rows
  (`doi:10.5591/978-1-57735-516-8/ijcai11-143`,
  `doi:10.1145/1015090.1015263`) still lack titles; upgrade them
  when registrar coverage or primary copies surface.
- **Harden the PDF build.** PDF/A-2b output and Poppler structural
  diagnostics are not part of the shared manuscript build; the
  original implementation lived in the pre-merge standalone
  repository and is not in this one, so this is a rebuild, not a
  port.
