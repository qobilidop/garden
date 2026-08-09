# Survey record

The maintained evidence and reasoning behind the survey — synthetic
and current rather than a chronological notebook. An agent redoing or
updating it needs this directory, the manuscript, and the repo's
build toolchain (AGENTS.md and the run-survey skill). Process history
lives in git.

## Start here

```console
./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record status
./dev.sh python3 surveys/dataflow-selection-enumeration/record/scripts/check.py
```

`update.py status` reports coverage dates and current record
counts. `check.py` validates the evidence graph: catalog,
audited logs, screening snapshots, evidence matrix, bibliography, and
manuscript citation anchors.

## Shape

This record deliberately carries more than the minimal survey-record
shape (README, searches, included/excluded, sources): `catalog.tsv`
is a four-state disposition ledger (candidate/screened/deep-read/
excluded) because a living survey holds candidates the binary
include/exclude split cannot represent; the method lives in
`protocol.md`/`methodology.md` rather than only here because tooling
parses it (`check.py` reads the research questions from
`protocol.md`); and the synthesis layers (`claims.md`,
`evidence-matrix.tsv`, `syntheses/`, `formal-synthesis/`) bind
manuscript claims to evidence at a granularity the minimal shape
does not attempt.

## Information architecture

- `protocol.md` — stable scope, selection rules, exclusion codes, and
  maintenance lifecycle.
- `methodology.md` — mapping methodology and validity record.
- `status.md` — current human-readable coverage and manuscript state.
- `baseline.md` — the first closed mapping snapshot (2026-08-04).
- `catalog.tsv` — disposition ledger for discovered works.
- `claims.md` — contribution and qualification ledger.
- `log.tsv` — the append-only event log: audited `search`,
  `snowball`, and `audit` rows, plus non-replayable `exploratory`
  rows retained as history.
- `sources/` — one primary-source evidence note per deep-read work.
- `syntheses/` — current cross-paper understanding: thematic files,
  the adopted terminology (`terminology.md`), and the unified
  framework's formal workspace (`framework/` — definitions,
  reductions, proofs, counterexamples, reduction audit).
- `evidence-matrix.tsv` — binds synthesis claims and manuscript
  section labels to source-note anchors.
- `queries.tsv` — the standing discovery queries, each row carrying
  its `last_reconciled` date.
- `scripts/check.py` — the record validator; the shared fetchers,
  snowball, and update tools live in `skills/run-survey/scripts/`.

## Evidence flow

1. Stage new search results and downloaded papers in `.scratch/`
   (survey-local, gitignored; API output is not evidence until every
   result is screened).
2. Give every discovered work a disposition in `catalog.tsv`.
3. Screen every returned record, then append one audited execution
   row to `log.tsv`; discard the staged result set after
   reconciliation (the log row is the audit unit; the baseline's
   frozen snapshots were retired from the record on 2026-08-09).
4. Create a primary-source note for every deep-read work.
5. Reconcile the relevant thematic files in `syntheses/`.
6. Update `syntheses/terminology.md`, `claims.md`, and
   `syntheses/framework/` when the cross-paper interpretation
   changes.
7. Add or revise `evidence-matrix.tsv` when a synthesis claim or
   technical manuscript claim changes.
8. Record durable research choices in this README (operating rules)
   — git carries their history, as it does for the pre-move decision
   log.

A discovered paper is integrated only when its disposition is
recorded, any required source note is anchored in the primary work,
affected syntheses and claim entries are updated, and every resulting
manuscript change is reflected in the evidence matrix. Only then may
the relevant update state advance.

## Status vocabulary

- Literature `candidate`: retained discovery-level record, not
  automatically a pending task.
- Literature `screened`: adjudicated from title, abstract, or stable
  metadata.
- Literature `deep-read`: primary technical source read and anchored
  in a structured source note.
- Literature `excluded`: stable exclusion code records why it is out
  of scope, superseded, application-only, unobtainable, or
  duplicative.
- Priority `critical`: bounded closest-work set; each member must be
  deep-read and chased backward and forward.
- Claims: `hypothesis`, `supported`, `needs-qualification`,
  `known-result`, or `rejected`.
- Decisions and terminology: `open`, `provisional`, `adopted`, or
  `superseded`.

## Operating rules

- Do not present a claim as novel merely because no contradicting
  paper has yet been found. Record novelty as a hypothesis until the
  closest-work audit is complete.
- Base literature claims on primary sources. Record a stable URL or
  DOI and pinpoint sections, definitions, theorems, algorithms, or
  pages for important evidence. Keep quotations short and distinguish
  authors' claims from interpretation.
- Keep durable files synthetic and current rather than chronological;
  git carries history — distill scratch notes instead of committing
  research diaries.
- The source-note template is versioned. Historical baseline notes
  are upgraded when revisited; new or modified notes use the current
  template and record a review date, evidence locations, the
  work/interpretation distinction, and update impact.

## To update

The standing queries live in `queries.tsv`, each row carrying its
`last_reconciled` date. Updates are staged on demand; any plausible close competitor or new vocabulary theme
starts one immediately.

1. Stage result sets into `.scratch/` (never committed; the tool
   writes a manifest and spaces consecutive arXiv requests):

   ```console
   ./dev.sh python3 skills/run-survey/scripts/update.py --record surveys/dataflow-selection-enumeration/record fetch --all
   ```

   Each registered search covers the inclusive interval from its
   last reconciled date through the batch date; the repeated
   boundary date catches delayed deposits and is absorbed by
   deduplication.
2. For every staged row: match DOI, stable identifier, and
   normalized title against `catalog.tsv`; assign a disposition;
   read the primary source when title and abstract leave relevance
   plausible; record newly exposed terminology or citation seeds;
   complete any source note the resulting status requires.
3. Append one matching log row per executed query, update the
   catalog, and reconcile syntheses, claims, terminology, formal
   material, the evidence matrix, and affected manuscript text;
   discard the staged result set.
4. Only then advance the rows' `last_reconciled` to the batch date
   and run `scripts/check.py`.
