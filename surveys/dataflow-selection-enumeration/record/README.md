# Living survey workspace

This directory is organized around the lifecycle of a maintained survey, not
the chronology of its first literature search.

## Start here

```console
./dev.sh python3 scripts/survey/update.py status
./dev.sh ./scripts/check.sh
```

The first command reports coverage dates, due searches, and current record
counts. The second validates the evidence graph and builds the manuscript.

## Information architecture

- `protocol.md` defines the stable scope, selection rules, and maintenance
  lifecycle.
- `status.md` states the current human-readable coverage and manuscript state.
- `baseline.md` summarizes the first closed mapping snapshot.
- `catalog.tsv` is the disposition ledger for discovered works.
- `logs/` records audited and exploratory search executions.
- `screening/` stores frozen, fully screened result sets.
- `sources/` stores one primary-source evidence note per deep-read work.
- `syntheses/` stores the current cross-paper understanding by theme.
- `formal-synthesis/` stores the definitions, reductions, and proofs used to
  connect the surveyed themes.
- `evidence-matrix.tsv` connects stable synthesis claims and manuscript section
  labels to source-note anchors.
- `updates/` contains recurring searches and their completion state.

## Definition of done for a new paper

A discovered paper is not integrated merely because it appears in the catalog.
Integration is complete when its disposition is recorded, any required source
note is anchored in the primary work, affected syntheses and claim entries are
updated, and every resulting manuscript change is reflected in the evidence
matrix. Only then may the relevant update state advance.

Raw API responses, downloaded papers, and unfinished screening batches stay in
`.scratch/`.

The source-note template is versioned. Historical baseline notes are upgraded
when revisited; new or modified notes use the current template and must record a
review date, evidence locations, the work/interpretation distinction, and update
impact.
