# Survey record

The maintained evidence and reasoning behind the survey — synthetic
and current rather than a chronological notebook. An agent redoing or
updating it needs this directory, the manuscript, the repository's
`AGENTS.md`, and the current `run-survey` skill. The rules live in
`protocol.md`; this README is the map and the operating procedure.
Process history lives in git.

The original campaign was run by Codex in a standalone repository and
merged here; on 2026-08-09 the record was migrated to the shared
survey-record shape (identifier catalog/log keys, unified source-note
template, generated bibliography, shared validator engine), 83
referenced-nowhere deep reads were demoted to `screened`, and their
notes — plus the unreferenced notes on merely-screened works — were
retired to git history. The migration is recorded as an audit log row
and described in the protocol's Keys section.

## Start here

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record status
./dev.sh python3 surveys/dataflow-selection-enumeration/record/check.py
```

`update.py status` reports coverage dates and current record counts.
`check.py` declares this survey's vocabularies and runs the shared
validator engine (`skills/run-survey/scripts/survey_check.py`), which
validates the catalog, log, queries, source notes, claims, evidence
bindings, bibliography, and manuscript citation anchors, and prints
the derived counts for cross-surface reconciliation. Both commands
are pure-stdlib Python and run under plain `python3`; `./dev.sh` is
needed only for the Typst/site builds. The TSVs quote embedded
newlines RFC4180-style — read them with a CSV-aware tool, not bare
`awk`/`cut`.

## Shape

This record deliberately carries more than the minimal survey-record
shape: `catalog.tsv` is a five-state disposition ledger
(`candidate`/`screened`/`deep-read`/`excluded`/`parked`) because
discovery outran adjudication. Candidates are the unresolved screening backlog,
retained without a promise to deep-read every row; the protocol is a separate document rather
than README sections because tooling parses it (`check.py` reads the
research questions there); and the evidence ledger plus the
unified-framework workspace bind manuscript claims to evidence at a
granularity the minimal shape does not attempt (Theory mode in the
`run-survey` skill). Historical source notes carry
`retrieved: "-"` because per-note acquisition dates were not
recorded; their `notes-date` is the note's last recorded review
(the campaign-close backstop 2026-08-04 where none was recorded,
2026-08-05 on the four notes reviewed after close).

## Files

Purpose and update rule for every record file; the governing rules
for each are in `protocol.md`.

- `protocol.md` — scope, research questions, key grammar, selection
  rules with boundary examples, screening and extraction rules,
  update and closure rules. Material method changes are described
  here in plain language, never applied silently.
- `status.md` — current coverage and manuscript state, plus deferred
  work; its counts must be copied from `check.py`/`update.py status`
  output, never hand-computed or estimated.
- `catalog.tsv` — one current disposition per discovered work:
  `key` (`doi:`/`arxiv:`/`t:`/`legacy:` per the protocol's grammar),
  `status`, `code` (exclusion code), `year`, `title`, `cluster`
  (open facet vocabulary), `priority` (`critical` marking the
  closest-work set), `relevance` (the adjudicated one-line reason),
  and `url` (only when the key does not encode the location).
- `log.tsv` — the append-only event log (schema and append-only
  rules in the protocol); one row appended per adjudicated
  execution.
- `queries.tsv` — the standing discovery queries, each row carrying
  its `last_reconciled` date; vocabulary edits in their own commit,
  `last_reconciled` advanced only after full reconciliation.
- `sources/` — an evidence note per deep-read work, plus abstract-only
  evidence-anchored sources (methodology guidance and
  scope/chronology-only technical works); the note contract is the
  `run-survey` skill's `assets/source-note-template.md`.
- `syntheses/` — the understanding layer, revised after each reading
  batch: thematic files, `current-position.md` as entry point, the
  adopted terminology (`terminology.md`), and the manuscript's formal
  workspace (`unified-framework/`).
- `claims.md` — the synthesis claims ledger (`Cxx` ids cited by
  `evidence.md`); statuses declared in its preamble; every claim
  carries explicit Scope and its closest established result.
- `evidence.md` — one record per evidence item (`Exxx`), binding
  synthesis claims and manuscript section labels to source-note
  anchors; revised whenever claims or manuscript evidence change.
- `check.py` — this survey's validator declaration over the shared
  engine; the shared search, fetch, update, and bibliography tools
  live in `skills/run-survey/scripts/`.

## Update ledger

One row per reconciled update batch; this table plus the audited log
is the provenance for funnel changes.

| Date | Prior cutoff | New cutoff | Qids succeeded / failed | Raw results | Unique new | Screened | Parked | Excluded | Included | Human gate |
|---|---|---|---|---:|---:|---:|---:|---:|---:|---|
| 2026-08-09 | 2026-08-04 | 2026-08-09 | 22 / 0 | 1108 | 872 | 872 | 0 | 20 | 4 | approved 2026-08-09 (dual-pass + adjudication; 4 candidates, 20 excluded-with-memory, 848 dropped) |

Column semantics: *Screened* counts rows that completed the batch's automated
screening pass (not rows at catalog status `screened`); the historical
*Included* column counts rows retained in the catalog, including unresolved
`candidate` rows, and must not be read as evidence inclusion. Dropped rows are
Screened minus Parked, Excluded, and Included. The row is appended in To-update step 5 and its Human
gate cell records the approval already obtained in step 2.

## Bibliography and build

`references.bib` is generated: add the citekey and identifier to
`references.tsv` (or the full entry to `references-manual.bib` when
no registrar identifier exists or the registrar record is defective),
then run from the repository root:

```console
./dev.sh python3 skills/run-survey/scripts/make_references.py --manuscript surveys/dataflow-selection-enumeration/manuscript
./dev.sh python3 site/scripts/build-manuscripts.py
```

`make_references.py` validates duplicate keys/identifiers and
replaces `references.bib` atomically only after every entry resolves.
The build writes
`site/public/surveys/dataflow-selection-enumeration/manuscript.html`
and `.pdf`.

## To update

Updates are staged on demand; any plausible close competitor or new
vocabulary theme starts one immediately (rules and closure
conditions in `protocol.md`).

1. Stage result sets into `.scratch/` (never committed; the tool
   writes a manifest, spaces consecutive arXiv requests, and covers
   the inclusive interval since each query's `last_reconciled`):

   ```console
   ./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record fetch --all
   ```

2. Deduplicate every staged row against `catalog.tsv` through the
   protocol's key grammar; screen per the protocol's dual-pass
   structure; use `candidate` only for an unresolved abstract-level judgment
   and `parked` only when the required metadata/text is unavailable; a
   human gates the batch before any state advances.
3. Deep-read and snowball any new `critical` work, both directions;
   forward-refresh the existing critical set in any substantial
   batch; complete any source note the resulting status requires.
4. Append one matching log row per executed query (log rows are
   hand-appended to the TSV — no scripted writer exists), update the
   catalog, and reconcile syntheses, claims, terminology, the
   unified framework, the evidence ledger, and affected manuscript
   text; discard the staged result set.
5. Regenerate the bibliography if citations changed; rebuild both
   manuscript renders; reconcile every quantity in the manuscript,
   `status.md`, and the landing page against `check.py`'s derived
   counts; append the update-ledger row.
6. Only then advance the rows' `last_reconciled` to the batch date
   and run `check.py` clean; record the step-2 gate approval in the
   ledger row's Human gate cell (one gate, recorded retrospectively —
   never a second approval pass).
