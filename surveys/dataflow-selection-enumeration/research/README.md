# Research record

This directory contains the maintained evidence and reasoning behind the survey.
It is synthetic and current rather than a chronological notebook.

## Evidence flow

1. Stage new search results and downloaded papers in `.scratch/`.
2. Give every discovered work a disposition in `survey/catalog.tsv`.
3. Preserve only fully screened result sets and append their audited execution
   rows to `survey/logs/searches.tsv`.
4. Create a primary-source note for every deep-read work.
5. Reconcile the relevant thematic files in `survey/syntheses/`.
6. Update `terminology.md`, `claims.md`, and the formal synthesis when the
   cross-paper interpretation changes.
7. Add or revise `survey/evidence-matrix.tsv` when a synthesis claim or
   technical manuscript claim changes.
8. Record durable research choices in `decisions/`.

The operational entry point is [`survey/README.md`](survey/README.md). The
stable selection and maintenance rules are in
[`survey/protocol.md`](survey/protocol.md).

## Durable areas

- `survey/sources/`: evidence records for individual primary works;
- `survey/syntheses/`: current comparisons and cross-paper conclusions;
- `survey/formal-synthesis/`: definitions and derivations that organize the
  surveyed results;
- `claims.md`: current contribution and qualification ledger;
- `terminology.md`: adopted terms and required distinctions; and
- `decisions/`: durable choices and their consequences.

## Status vocabulary

- Literature `candidate`: retained discovery-level record, not automatically a
  pending task.
- Literature `screened`: adjudicated from title, abstract, or stable metadata.
- Literature `deep-read`: primary technical source read and anchored in a
  structured source note.
- Literature `excluded`: stable exclusion code records why it is out of scope,
  superseded, application-only, unobtainable, or duplicative.
- Priority `critical`: bounded closest-work set; each member must be deep-read
  and chased backward and forward.
- Claims: `hypothesis`, `supported`, `needs-qualification`, `known-result`, or
  `rejected`.
- Decisions and terminology: `open`, `provisional`, `adopted`, or
  `superseded`.

Raw downloads, API responses, temporary renderings, and incomplete screening
batches are contributor-local state and must remain under `.scratch/`.
