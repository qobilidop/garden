# Survey record

This directory is the survey's maintained, resumable state. Shared survey
workflow and conventions live in the current `run-survey` skill; this README
contains only the local record map, commands, update ledger, and
survey-specific integration points. Historical events live in `log.tsv`, and
superseded content lives in git history.

## Start here

From the repository root:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/agent-assisted-evidence-synthesis/record status
./dev.sh python3 surveys/agent-assisted-evidence-synthesis/record/check.py
```

The first command reports the standing-query state. The second validates the
catalog, log, queries, source notes, claim/evidence bindings, bibliography, and
manuscript citations, then prints the counts copied into `status.md`.

## Record map

Each entry names the content it alone owns:

- `README.md` — local navigation, commands, update ledger, and integration
  checklist.
- `protocol.md` — survey-specific objective, questions, scope, selection
  boundaries, taxonomy, and legacy record qualifications. Shared method stays
  in the `run-survey` skill.
- `status.md` — dated publication and coverage state, derived counts, and work
  deferred to a future update.
- `catalog.tsv` — one current disposition per surfaced work, with status,
  exclusion code, metadata, abstract-level taxonomy facets, and priority.
- `log.tsv` — append-only search, snowball, audit, and exploratory events.
- `queries.tsv` — exact standing searches, limits, and `last_reconciled` dates.
- `sources/` — anchored evidence notes for 31 selected works.
- `syntheses/` — current cross-paper interpretation, with
  `current-position.md` as its entry point.
- `claims.md` — stable `Cxx` synthesis propositions, their scope, and prior
  frontier.
- `evidence.md` — stable `Exxx` findings binding source anchors to claims and
  manuscript sections.
- `check.py` — this survey's schema, vocabularies, count assertions, and local
  closure exemptions for the shared validator.

The manuscript bibliography is adjacent state under `../manuscript/`:
`references.tsv` maps citekeys to identifiers, `references-manual.bib` holds
manual or corrected entries, and `references.bib` is generated.

## External evidence homes

Four method-canon works already have canonical full-text notes in `library/`:
Kitchenham and Charters 2007, Petersen et al. 2008, Wohlin 2014, and PRISMA
2020. Their citekeys are explicitly exempt from *local* evidence closure in
`check.py` rather than duplicating those notes under `sources/`. Every other
manuscript citation is locally bound through `evidence.md`.

## Update ledger

One row records each human-approved, fully reconciled update batch. Detailed
events remain canonical in `log.tsv`; this table alone records the batch-level
human gate.

| Date | Prior cutoff | New cutoff | Qids succeeded / failed | Raw results | Unique new | Screened | Parked | Included | Human gate |
|---|---|---|---|---:|---:|---:|---:|---:|---|
| 2026-08-09 | 2026-08-08 | 2026-08-09 | 16 / 1 (+24 chases, 3 primary-complete) | 1,708 | 683 | 585 | 76 standing | +130 (776 total) | approved 2026-08-09 |

*Raw results* counts query, chase, and publisher-reference rows before
reconciliation. *Unique new* is the catalog-row delta; *Screened* is the batch
flow, not a current status; *Parked* is the standing total. The include-level
delta is 130 because one include decision rediscovered an existing work and one
work was reclassified out of scope after deep reading.

## Local update operations

Follow the current `run-survey` workflow and the choices in `protocol.md`. The
local staging command is:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/agent-assisted-evidence-synthesis/record fetch --all
```

For this survey, reconciliation must update affected source notes, thematic
syntheses, `claims.md`, `evidence.md`, the manuscript, and the landing-page
reading list. Re-screen every parked row and refresh both citation directions
for each critical work. Advance query dates and append the update-ledger row
only after the human-gated batch is fully reconciled.

If citations change, regenerate the bibliography and both manuscript formats:

```console
./dev.sh python3 skills/run-survey/scripts/make_references.py --manuscript surveys/agent-assisted-evidence-synthesis/manuscript
./dev.sh python3 site/scripts/build-manuscripts.py
```

Finish with `check.py` and copy its derived counts into `status.md` and any
manuscript surfaces that publish them; do not estimate them independently.
