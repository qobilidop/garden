# Survey record

The maintained evidence and reasoning behind the survey — synthetic
and current rather than a chronological notebook. An agent redoing or
updating it needs this directory, the manuscript, and the repo's
build toolchain (AGENTS.md and the run-survey skill). Process history
lives in git.

## Start here

```console
./dev.sh python3 surveys/dataflow-selection-enumeration/record/scripts/update.py status
./dev.sh python3 surveys/dataflow-selection-enumeration/record/check.py
```

`update.py status` reports coverage dates, due searches, and current
record counts. `check.py` validates the evidence graph: catalog,
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
- `terminology.md` — adopted terms and required distinctions.
- `log.tsv` — the append-only event log: audited `search`,
  `snowball`, and `audit` rows, plus non-replayable `exploratory`
  rows retained as history.
- `screening/` — frozen, fully screened result sets.
- `sources/` — one primary-source evidence note per deep-read work.
- `syntheses/` — current cross-paper understanding by theme.
- `formal-synthesis/` — definitions, reductions, and proofs that
  connect the surveyed themes.
- `evidence-matrix.tsv` — binds synthesis claims and manuscript
  section labels to source-note anchors.
- `updates/` — recurring searches (`queries.tsv`), their reconciled
  state (`state.tsv`), and periodic tasks (`tasks.tsv`).
- `check.py` — the record validator.
- `scripts/` — search fetchers and the freshness/update tool.

## Evidence flow

1. Stage new search results and downloaded papers in `.scratch/`
   (survey-local, gitignored; API output is not evidence until every
   result is screened).
2. Give every discovered work a disposition in `catalog.tsv`.
3. Preserve only fully screened result sets and append their audited
   execution rows to `log.tsv`.
4. Create a primary-source note for every deep-read work.
5. Reconcile the relevant thematic files in `syntheses/`.
6. Update `terminology.md`, `claims.md`, and the formal synthesis
   when the cross-paper interpretation changes.
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

Registered queries live in `updates/queries.tsv`; their
last fully reconciled executions in `updates/state.tsv`; periodic
citation maintenance in `updates/tasks.tsv`. Stage due searches with

```console
./dev.sh python3 surveys/dataflow-selection-enumeration/record/scripts/update.py fetch --all
```

Registered runs use an inclusive interval from the last reconciled
date through the batch date, with source-appropriate relevance or
recency ordering. A promoted update commits the frozen result set,
one matching audited-log row, catalog dispositions, and all affected
source notes, syntheses, evidence rows, and manuscript changes; do
not advance `updates/state.tsv` before that reconciliation. Updates
are staged on demand; any plausible close competitor or new
vocabulary theme starts one immediately.

Deferred from the standalone repo: its hardened PDF gate (PDF/A-2b
output, Poppler structural diagnostics, pinned toolchain digests) is
not yet ported to the shared manuscript build.
