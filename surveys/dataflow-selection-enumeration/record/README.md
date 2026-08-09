# Survey record

The maintained evidence and reasoning behind the survey — synthetic
and current rather than a chronological notebook. An agent redoing or
updating it needs this directory, the manuscript, and the repo's
build toolchain (AGENTS.md and the run-survey skill). The rules live
in `protocol.md`; this README is the map and the operating
procedure. Process history lives in git.

## Start here

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record status
./dev.sh python3 surveys/dataflow-selection-enumeration/record/scripts/check.py
```

`update.py status` reports coverage dates and current record counts.
`check.py` validates the evidence graph: catalog, log, queries,
evidence matrix, bibliography, and manuscript citation anchors.

## Shape

This record deliberately carries more than the minimal survey-record
shape: `catalog.tsv` is a four-state disposition ledger because
discovery outran adjudication and candidates are retained without a
promise to read them; the protocol is a separate document rather
than README sections because tooling parses it (`check.py` reads the
research questions there); and the evidence matrix plus the
unified-theory workspace bind manuscript claims to evidence at a
granularity the minimal shape does not attempt.

## Files

Purpose and update rule for every record file; the governing rules
for each are in `protocol.md`.

- `protocol.md` — scope, research questions, selection rules,
  screening and extraction rules, update and closure rules. Material
  method changes are described here in plain language, never applied
  silently.
- `status.md` — current coverage and manuscript state, plus deferred
  work; counts are regenerated, not hand-edited.
- `catalog.tsv` — one current disposition per discovered work
  (statuses `candidate`/`screened`/`deep-read`/`excluded`, priority
  `critical` marking the closest-work set); updated during
  screening.
- `log.tsv` — the append-only event log (schema and append-only
  rules in the protocol); one row appended per adjudicated
  execution.
- `queries.tsv` — the standing discovery queries, each row carrying
  its `last_reconciled` date; vocabulary edits in their own commit,
  `last_reconciled` advanced only after full reconciliation.
- `sources/` — one evidence note per deep-read work; `_template.md`
  is the note contract (versioned; historical notes migrate when
  revisited, per `status.md`).
- `syntheses/` — the understanding layer, revised after each reading
  batch: thematic files, `current-position.md` as entry point, the
  adopted terminology (`terminology.md`), and the unified theory's
  formal workspace (`unified-theory/`).
- `claims.md` — the synthesis claims ledger (`Sxx` ids cited by the
  evidence matrix); statuses declared in its preamble.
- `evidence-matrix.tsv` — binds synthesis claims and manuscript
  section labels to source-note anchors; revised whenever claims or
  manuscript evidence change.
- `scripts/check.py` — the record validator; the shared search,
  fetch, and update tools live in `skills/run-survey/scripts/`.

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

2. For every staged row: match DOI, stable identifier, and
   normalized title against `catalog.tsv`; assign a disposition;
   read the primary source when title and abstract leave relevance
   plausible; record newly exposed terminology or citation seeds;
   complete any source note the resulting status requires.
3. Deep-read and snowball any new `critical` work, both directions.
4. Append one matching log row per executed query, update the
   catalog, and reconcile syntheses, claims, terminology, the
   unified theory, the evidence matrix, and affected manuscript
   text; discard the staged result set.
5. Only then advance the rows' `last_reconciled` to the batch date,
   sync `status.md` and the landing page, and run
   `scripts/check.py`.
