# Living survey protocol

## Objective and study type

Maintain a systematic map of how prior work represents and exhaustively
enumerates selection observations of finite pure dataflow graphs. The survey
compares neighboring semantic objects and algorithms; it does not estimate
empirical effect sizes and is therefore a systematic mapping study rather than
a statistical systematic literature review.

The running formal object is a partial map of selection-site outcomes reached
from requested roots through strict operands and input-selected case edges. A
monolithic symbolic value or SMT encoding is a baseline, not the target output.

## Research questions

- **RQ1:** Which mathematical program models support symbolic evaluation
  without conventional control-flow paths?
- **RQ2:** Which objects are enumerated: paths, traces, cases, configurations,
  models, implicants, cubes, guarded values, or input regions?
- **RQ3:** Which approaches retain partial rather than total decisions, and
  how do they treat inactive or irrelevant choices?
- **RQ4:** Which soundness, completeness, uniqueness, coverage, disjointness,
  or minimality properties are defined and proved?
- **RQ5:** How are residual symbolic values, witnesses, and graph sharing
  represented?
- **RQ6:** Which algorithms avoid redundant products of choices, and what
  complexity or output-sensitivity results are known?
- **RQ7:** Which assumptions are made about purity, totality, effects, cycles,
  time, and solver completeness?
- **RQ8:** Which examples expose the distinction between merged values, global
  decision assignments, and dynamically observed choices?

## Coverage themes

The map deliberately crosses research communities. Its stable themes are:

1. symbolic execution, guarded values, path merging, and trace partitioning;
2. circuits, synchronous languages, dataflow demand, and symbolic simulation;
3. AllSAT/AllSMT, projected or partial models, decision diagrams, and finite
   observer partitions;
4. functional-logic choice fingerprints, needed evaluation, demand-driven
   testing, and lazy partial-input refinement;
5. hyperplane cells, neural activation/output regions, CPWL models, hybrid
   modes, and parametric critical regions;
6. partial-order reduction, unfoldings, Petri-net observations, and symbolic
   state quotients;
7. property-, target-, context-, and observer-guided exploration or reduction;
   and
8. compositional semantics, summaries, residualization, graph sharing, and
   contextual identity.

Exact recurring searches are versioned in `updates/queries.tsv`. New vocabulary
discovered during reading is added there in a separate commit rather than
silently changing an executed search.

## Records and authority

| Record | Purpose | Update rule |
|---|---|---|
| `catalog.tsv` | One current disposition per discovered work | Update during screening |
| `logs/searches.tsv` | Audited query and snowball execution log | Append after adjudication |
| `logs/exploratory.tsv` | Non-replayable early discovery record | Baseline evidence only |
| `screening/` | Frozen result sets | Commit only after every row is screened |
| `sources/` | Primary-work extraction and pinpoint evidence | Required for deep reads |
| `syntheses/` | Current cross-paper understanding | Revise after each reading batch |
| `evidence-matrix.tsv` | Manuscript claim-to-source traceability | Revise with manuscript claims |
| `updates/state.tsv` | Completion state of recurring searches | Advance only after reconciliation |
| `updates/tasks.tsv` | Periodic non-query maintenance | Advance only after the task is complete |

Search indexes are discovery aids. Primary papers, official proceedings,
publisher records, or stable author-hosted versions control technical and
bibliographic claims.

## Inclusion and exclusion

Include a work when it makes a technical contribution to at least one research
question and provides enough detail to compare semantics, guarantees, or
algorithmic behavior. Foundational reports and theses may be primary sources
when they contain the most complete result.

Use these stable exclusion codes:

- `E1-def-use-testing`: conventional CFG def-use coverage only;
- `E2-ml-graph-runtime`: ML graph execution or staging only;
- `E3-secondary`: secondary source superseded by an available primary work;
- `E4-application-only`: unchanged application of an existing executor;
- `E5-unobtainable`: insufficient technical content after recorded attempts;
- `E6-out-of-scope-model`: cannot answer a research question under scope; and
- `E7-duplicate-version`: superseded version retained for lineage.

## Screening, reading, and extraction

Screening assigns a catalog status, priority, cluster, and concise rationale
from title, abstract, and stable metadata. Candidate status is a retained
discovery disposition, not automatically a reading queue.

A deep read must inspect the primary work's definitions, central algorithms,
theorem statements and assumptions, complexity discussion, examples, and
related work. Complete the source-note template with stable URLs and pinpoint
locations. Any technical manuscript claim must also have an anchored row in
`evidence-matrix.tsv`.

Priority controls maintenance obligations. Every `critical` work must be
deep-read and must have separate usable backward and forward citation chases.
New critical works receive both chases immediately; existing critical works
receive a forward refresh at the cadence recorded in `updates/README.md`.

## Incremental maintenance

Run the registered Crossref and arXiv searches every 90 days. Run a complete
forward-citation refresh of the critical set at least annually. Also begin an
update immediately when alerts, peer feedback, or reading expose a plausible
close competitor or a new coverage theme.

Scheduled database runs search an inclusive interval from the last fully
reconciled date through the new batch date. Crossref ranks that bounded set by
relevance; arXiv returns recent submissions first. The overlapping boundary
protects against delayed deposits; catalog deduplication absorbs repeats.
Unbounded searches remain useful for deliberate scope expansion but do not
constitute an incremental update.

Each update batch follows this order:

1. inspect `update.py status` and fetch due searches into `.scratch/`;
2. deduplicate against the catalog and screen every returned record;
3. promote only fully adjudicated snapshots and append matching log rows;
4. deep-read and snowball any new critical work;
5. update thematic syntheses, terminology, claims, and formal synthesis;
6. update evidence rows and manuscript text affected by the findings;
7. advance update state only when all impacts are reconciled; and
8. run the full repository check before committing.

An update is incomplete if it only adds bibliography entries or source notes.
The cross-paper synthesis and every affected manuscript claim must also be
reconciled.

## Snapshot closure and reopening

The repository is living; “current” means that no registered maintenance task
is overdue and no promoted finding remains unreconciled. A publication snapshot
may claim bounded mapping closure only when:

1. every discovered work has a catalog disposition;
2. every critical work is deep-read and chased in both directions;
3. all registered searches due for that snapshot have been adjudicated;
4. two prospective, independently checked no-add batches find neither a new
   theme nor a plausible close competitor; and
5. the manuscript, evidence matrix, and syntheses agree on the coverage date.

A later paper, changed result, or new theme reopens the current map. Closure is
always relative to the named sources, exact queries, result depths, and date.

## Audited search-log schema

`logs/searches.tsv` contains: execution date, round ID, phase, source, exact
query or seed, direction, hit count, screened count, included keys, excluded
keys, and notes. Every non-audit row references exactly one committed snapshot.
Approximate counts, unknown result sets, and aggregate seed descriptions belong
in scratch notes rather than the audited log.

## Novelty discipline

For any proposed contribution, restate it in the notation of the closest work
and test whether its semantic object, theorem, or enumeration method transfers
under straightforward instrumentation. Absence of a matching paper is only a
novelty hypothesis until the closest-work audit is complete. Negative results
belong in `research/claims.md` and the subsumption-boundary synthesis.
