# Survey record

This directory is the minimal resumable state for *Symbolic Execution of
Digital Hardware Designs*. `protocol.md` owns scope and method;
`queries.tsv` owns standing searches; `catalog.tsv` owns dispositions and
facets; `log.tsv` is append-only event history; `sources/` contains local
evidence notes; `claims.md` and `evidence.md` bind synthesis to the manuscript;
`status.md` states only dated current state and future-update work.

## Commands

Run from the repository root:

```sh
python3 surveys/symbolic-execution-hardware/record/check.py
python3 skills/run-survey/scripts/update.py --record surveys/symbolic-execution-hardware/record status
python3 skills/run-survey/scripts/update.py --record surveys/symbolic-execution-hardware/record fetch --all
./dev.sh python3 skills/run-survey/scripts/make_references.py --manuscript surveys/symbolic-execution-hardware/manuscript
./dev.sh python3 site/scripts/build-manuscripts.py
```

Search/update scratch is ignored under
`surveys/symbolic-execution-hardware/.scratch/`; it is disposable after the
catalog and log have been reconciled. A future update begins from
`queries.tsv`, the coverage date in `status.md`, and `update.py status`. Fetch
stages every active query without advancing state. In scratch, deduplicate the
batch against `catalog.tsv`, re-screen both new and `parked` records with two
blinded passes, adjudicate disagreements, draft one key-bearing log row per
query, and refresh both citation directions for every critical work. Present
that staged reconciliation at the authority gate declared for the update.
Only after the gate append the log rows, catalog changes, query dates, status,
and ledger row together; an
update that adds catalog rows also appends one audit row whose notes contain
`catalog-additions:<count>`. Update evidence and synthesis when a decision
changes, then run the validator, regenerate references, and build both
manuscript forms.

`s24` remains inactive after four HTTP 429 responses. The strict replacement
query `s25` also received HTTP 429 on 2026-08-11 and remains unreconciled. A
future update should retry `s25`; `s24` may be retried only by deliberately
reactivating the retired lineage query.

## Update ledger

`Surfaced` is the reconciled catalog denominator; `include-level` combines
`included` and `deep-read`. The Human gate records authority for the batch, not
item-level human screening.

| Coverage through | Surfaced | Include-level | Deep-read | Excluded | Parked | Human gate |
|---|---:|---:|---:|---:|---:|---|
| 2026-08-10 | 1,626 | 87 | 11 | 1,501 | 38 | Pre-authorized 2026-08-10: title, scope, autonomous campaign, commit, and push; no item-level review |
| 2026-08-11 | 1,709 | 31 | 17 | 1,621 | 57 | Pre-authorized scope revision and autonomous completion; no item-level human screening |
| 2026-08-12 | 1,870 | 31 | 17 | 1,780 | 59 | Same pre-authorization; completed both citation directions for newly promoted critical works |

## External evidence homes

The following canonical notes already existed in the public repository and
are intentionally not copied here:

- `baldoni2016-symbolic` — `library/papers/2016/baldoni2016-symbolic/notes.md`
- `kolbl2001rtl` — `surveys/dataflow-selection-enumeration/record/sources/kolbl2001rtl.md`
- `feng2004dynamic` — `surveys/dataflow-selection-enumeration/record/sources/feng2004dynamic.md`
- `ryan2023sylvia` — `surveys/dataflow-selection-enumeration/record/sources/ryan2023sylvia.md`
- `yang2026-forbench` — `library/papers/2026/yang2026-forbench/notes.md`
- `petersen2015mapping` and `wohlin2014snowballing` —
  `surveys/dataflow-selection-enumeration/record/sources/`

Four excluded works are cited only to make the boundary or adjacent survey
traditions explicit: `carter1979symbolic`, `kolbl2001rtl`, and
`feng2004dynamic` are symbolic-simulation context; `debnath2022greycone` lacks
the required source-to-generated-hardware bridge. `yang2026-forbench` is an
excluded current boundary comparator. The secondary works
`camurati1988formal` (formal hardware correctness) and
`jayasena2024directed` (directed hardware test generation) position neighboring
survey traditions. None contributes to the 31-work denominator.

These citekeys are explicit citation-closure exemptions in `check.py`.
Critical catalog rows backed by an external home use `deep-read` without a
duplicate local note; every other critical row has a local full-text or
declared abstract-only note.

## Resumability and interpretation

Counts are always derived from `catalog.tsv`; no prose file is a second data
home. `included` and `deep-read` together form the include-level map.
`candidate` and `parked` are unresolved records, not included evidence.
Technical manuscript claims must be backed by `evidence.md` or an explicitly
named external evidence home. Abstract-only material supports chronology and
scope only.
