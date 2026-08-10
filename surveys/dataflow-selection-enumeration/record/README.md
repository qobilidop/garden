# Survey record

This directory is the survey's maintained, resumable state. Shared survey
workflow and conventions live in the current `run-survey` skill; this README
contains only the local record map, local commands, update-batch ledger, and
survey-specific integration points. Historical events live in `log.tsv`, and
superseded content lives in git history.

## Start here

From the repository root:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record status
./dev.sh python3 surveys/dataflow-selection-enumeration/record/check.py
```

The first command reports the registered-query state; the second validates the
catalog, log, queries, source notes, claim/evidence bindings, bibliography, and
manuscript citations, then prints the counts copied into `status.md`. The TSVs
use RFC 4180 quoting, so inspect them with a CSV-aware tool rather than bare
`awk` or `cut`.

## Record map

Each entry names the content it alone owns:

- `README.md` — local navigation, commands, update-batch ledger, and local
  integration checklist.
- `protocol.md` — survey-specific objective, scope, selection boundaries,
  record choices, and publication/novelty qualifications. Shared method stays
  in the `run-survey` skill.
- `status.md` — dated publication and coverage state, derived counts, and work
  deferred to a future update.
- `catalog.tsv` — one current disposition per discovered work, with its
  identifier, status, exclusion code, metadata, cluster, priority, rationale,
  and fallback URL.
- `log.tsv` — append-only search, snowball, audit, and exploratory events.
- `queries.tsv` — exact standing queries, source-specific limits, and
  `last_reconciled` dates.
- `sources/` — anchored reading notes on screened and deep-read primary works;
  `evidence.md` identifies which notes support current findings.
- `syntheses/` — current cross-paper interpretation; its README maps the
  thematic files and formal workspace.
- `claims.md` — stable `Cxx` synthesis propositions with scope,
  qualifications, and prior frontier.
- `evidence.md` — stable `Exxx` literature findings binding source anchors to
  `Cxx` claims and manuscript sections.
- `check.py` — this survey's schema and vocabulary declaration for the shared
  validator.

The manuscript bibliography is adjacent state under `../manuscript/`:
`references.tsv` maps citekeys to identifiers, `references-manual.bib` holds
manual or corrected entries, and `references.bib` is generated.

## Update ledger

One row records each human-approved, fully reconciled update batch. Detailed
events remain canonical in `log.tsv`; this table alone records the batch-level
human gate.

| Date | Prior cutoff | New cutoff | Qids succeeded / failed | Raw results | Unique new | Screened | Parked | Excluded | Candidate | Human gate |
|---|---|---|---|---:|---:|---:|---:|---:|---:|---|
| 2026-08-09 | 2026-08-04 | 2026-08-09 | 22 / 0 | 1108 | 872 | 872 | 0 | 20 | 4 | approved 2026-08-09 (dual-pass + adjudication; 4 candidates, 20 excluded-with-memory, 848 dropped) |

Here *Screened* is the number processed by that batch, not the current catalog
status. *Candidate* is the number left unresolved at the human gate; it does
not mean evidence inclusion. Dropped equals Screened minus Parked, Excluded,
and Candidate.

## Local update operations

Follow the current `run-survey` workflow and the choices in `protocol.md`. The
local staging command is:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record fetch --all
```

For this survey, reconciliation must touch every affected layer: source notes,
the thematic syntheses and `syntheses/unified-framework/`, `claims.md`,
`evidence.md`, the manuscript, and the landing-page reading list.
`syntheses/approach-guarantees.md` and
`syntheses/closest-work-audit.md` are mandatory checks for a plausible closer
work or changed correspondence result. Advance `queries.tsv` dates and append
the update-ledger row only after the human-gated batch is fully reconciled.

If citations change, regenerate the bibliography and both manuscript renders:

```console
./dev.sh python3 skills/run-survey/scripts/make_references.py --manuscript surveys/dataflow-selection-enumeration/manuscript
./dev.sh python3 site/scripts/build-manuscripts.py
```

Finish by running `check.py` and copying its derived counts into `status.md`;
do not estimate or independently recompute them in prose.
