# Survey record

This directory is the survey's maintained, resumable state. Shared survey
workflow and conventions live in the current `run-survey` skill; this README
contains only the local record map, commands, update ledger, and
survey-specific integration points. Historical events, including corrective
audits, live in `log.tsv`, and superseded content lives in git history.

## Start here

From the repository root:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/symbolic-execution-hardware/record status
./dev.sh python3 surveys/symbolic-execution-hardware/record/check.py
```

The first command reports the standing-query state. The second validates the
catalog, log, queries, source notes, claim/evidence bindings, bibliography, and
manuscript citations, then prints the counts copied into `status.md`.

## Record map

Each entry names the content it alone owns:

- `README.md` — local navigation, commands, update ledger, and integration
  checklist.
- `protocol.md` — survey-specific objective, questions, scope, selection
  boundaries, taxonomy, and record qualifications. Shared method stays in the
  `run-survey` skill.
- `status.md` — dated publication and coverage state, derived counts, and work
  deferred to a future update.
- `catalog.tsv` — one current disposition per surfaced work, with metadata,
  exclusion code, taxonomy facets, priority, rationale, and fallback URL.
- `log.tsv` — append-only search, snowball, audit, and exploratory events,
  including key-bearing corrections to earlier events.
- `queries.tsv` — exact standing searches, limits, and `last_reconciled` dates.
- `sources/` — anchored evidence notes for selected and boundary works.
- `syntheses/` — current cross-work interpretation, with `README.md` as its
  thematic map and `current-position.md` as its entry point.
- `claims.md` — stable `Cxx` synthesis propositions, their scope, and prior
  frontier.
- `evidence.md` — stable `Exxx` findings binding source anchors to claims and
  manuscript sections.
- `check.py` — this survey's schema, vocabularies, count assertions, and local
  closure exemptions for the shared validator.

The manuscript bibliography is adjacent state under `../manuscript/`:
`references.tsv` maps citekeys to identifiers, `references-manual.bib` holds
manual or corrected entries, and `references.bib` is generated.

## Update ledger

`Surfaced` is the reconciled catalog denominator; `include-level` combines
`included` and `deep-read`. The Human gate records authority for the batch, not
item-level human screening.

| Coverage through | Surfaced | Include-level | Deep-read | Excluded | Parked | Human gate |
|---|---:|---:|---:|---:|---:|---|
| 2026-08-10 | 1,626 | 87 | 11 | 1,501 | 38 | Pre-authorized 2026-08-10: title, scope, autonomous campaign, commit, and push; no item-level review |
| 2026-08-11 | 1,709 | 31 | 17 | 1,621 | 57 | Pre-authorized scope revision and autonomous completion; no item-level human screening |
| 2026-08-12 | 1,870 | 31 | 17 | 1,780 | 59 | Same pre-authorization; attempted both citation directions for newly promoted critical works |
| 2026-08-12 | 1,917 | 31 | 17 | 1,827 | 59 | User-authorized adversarial review and refinement, commit, and push; no item-level human screening |

## Linked canonical notes

Survey-specific readings live locally in `sources/`. Where broader notes
already exist, their repo-relative location is preserved in the local note's
optional `canonical-note` field:

- `baldoni2016-symbolic` and `yang2026-forbench` link to `library/`.
- `kolbl2001rtl`, `feng2004dynamic`, `ryan2023sylvia`,
  `petersen2015mapping`, and `wohlin2014snowballing` link to the
  dataflow-selection-enumeration survey.

The local notes answer this survey's RQs and record its boundary, taxonomy, and
evidence limits; they do not copy the general note. Four excluded works are
cited only to make the boundary or adjacent survey traditions explicit:
`carter1979symbolic`, `kolbl2001rtl`, and
`feng2004dynamic` are symbolic-simulation context; `debnath2022greycone` lacks
the required source-to-generated-hardware bridge. `yang2026-forbench` is an
excluded current boundary comparator. The secondary works
`camurati1988formal` (formal hardware correctness) and
`jayasena2024directed` (directed hardware test generation) position neighboring
survey traditions. None contributes to the 31-work denominator. Every critical
row now has a local full-text survey note.

## Mapping-depth evidence home

The 14 mapping-depth includes—`bagri2015restrictive`, `lyu2017quebs`,
`pinto2017factored`, `shen2018trojan`, `lin2018ctsc`,
`zhang2018recursive`, `ahmed2018trojan`, `lyu2019multitarget`,
`lin2020selective`, `jayasena2021assertions`, `lyu2021soccar`,
`lyu2021fuce`, `roy2023slec`, and `zheng2024incremental`—use their canonical
`catalog.tsv` rows and key-bearing selection events as their evidence home.
They support only map membership, chronology, and coded facets. Technical
mechanism, comparison, and performance claims in the manuscript are restricted
to the 17 deep-read works with local survey notes. The validator keeps these
two evidence depths distinct.

## Local update operations

Follow the current `run-survey` workflow and the local choices in
`protocol.md`. The survey's no-cutoff window requires
`--initial-from-date 1900-01-01` when fetching a query with no prior
reconciliation date. Retry one such query with:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/symbolic-execution-hardware/record fetch --query-id s25 --initial-from-date 1900-01-01
```

Stage the whole active registry with:

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/symbolic-execution-hardware/record fetch --all --initial-from-date 1900-01-01
```

Local reconciliation touches affected source notes, thematic syntheses,
`claims.md`, `evidence.md`, the manuscript, and the landing-page reading list.
If citations change, regenerate the bibliography and both manuscript formats:

```console
./dev.sh python3 skills/run-survey/scripts/make_references.py --manuscript surveys/symbolic-execution-hardware/manuscript
./dev.sh python3 site/scripts/build-manuscripts.py
```

Finish with `check.py` and copy its derived counts into `status.md` and any
manuscript surfaces that publish them; do not estimate them independently.
