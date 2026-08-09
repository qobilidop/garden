# Living survey protocol

## Objective and study type

Maintain a problem-centered systematic map of exhaustive selection-observation
enumeration in finite pure dataflow graphs. The map identifies established
solution families, translates them into one terminology, and records exactly
when their observers, guarantees, and representations coincide with the target
contract. It does not estimate empirical effect sizes and is therefore a
systematic mapping study rather than a statistical systematic literature
review.

The running formal object is a partial map of selection-site outcomes reached
from requested roots through all declared operands of ordinary nodes and
input-selected case edges. A
monolithic symbolic value or SMT encoding is a baseline, not the target output.

## Research questions

- **RQ1:** What common terminology precisely defines selection-observation
  enumeration and distinguishes it from neighboring tasks?
- **RQ2:** Which established approach traditions or routes can enumerate, compile, or
  specialize the required fibers, and what instrumentation do they require?
- **RQ3:** Which correctness, representation, and complexity guarantees does
  each route provide under its stated assumptions?
- **RQ4:** Where do the approaches coincide, where do they compute a refinement
  or quotient of the target observer, and where do they address only an
  adjacent reduction problem?

## Coverage themes

The comparison is organized around six recurring, non-exclusive routes:

1. guarded symbolic execution;
2. projected model enumeration;
3. compiled decision structures;
4. demand-guided evaluation and search;
5. geometric and parametric enumeration; and
6. compositional guarded summaries.

The map still crosses symbolic execution, dataflow semantics, functional-logic
programming, model enumeration, knowledge compilation, geometry, parametric
programming, concurrency, and state reduction. Those broader communities are
discovery vocabulary, not separate research questions. Partial-order
reduction, unfoldings, Petri-net observation, property-guided exploration, and
state quotienting remain adjacent comparators when they clarify an
observer-relative boundary without implementing the target record contract.

Exact recurring searches are versioned in `updates/queries.tsv`. New vocabulary
discovered during reading is added there in a separate commit rather than
silently changing an executed search.

## Records and authority

| Record | Purpose | Update rule |
|---|---|---|
| `catalog.tsv` | One current disposition per discovered work | Update during screening |
| `log.tsv` | Append-only event log: `search`, `snowball`, and `audit` rows, plus `exploratory` rows retained as non-replayable early history | Append after adjudication |
| `screening/` | Frozen result sets | Commit only after every row is screened |
| `sources/` | Primary-work extraction and pinpoint evidence | Required for deep reads |
| `syntheses/` | Current cross-paper understanding | Revise after each reading batch |
| `evidence-matrix.tsv` | Synthesis/manuscript claim-to-source traceability | Revise with claims or manuscript evidence |
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
locations. Any active synthesis claim must be connected to at least one
evidence row, and any technical manuscript citation must be connected at its
stable section label. Evidence IDs identify literature claims; `Sxx` IDs refer
only to the synthesis claims in `claims.md`.

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

`log.tsv` contains: execution date, kind (`search`, `snowball`,
`audit`, or `exploratory`), event id, source, exact query or seed,
direction, hit count, screened count, included keys, excluded keys,
and notes. Every non-audit row references exactly one committed snapshot.
Approximate counts, unknown result sets, and aggregate seed descriptions belong
in scratch notes rather than the audited log.

Executed rows and their frozen snapshots are append-only. If later primary
reading changes a catalog disposition, append an `audit` reconciliation row
rather than rewriting the executed row. Its notes record `promoted-key:KEY` or
`superseded-key:KEY`; the current catalog gives the resulting disposition while
the earlier row preserves the adjudication made at execution time.

## Novelty discipline

For any proposed contribution, restate it in the notation of the closest work
and test whether its semantic object, theorem, or enumeration method transfers
under straightforward instrumentation. Absence of a matching paper is only a
novelty hypothesis until the closest-work audit is complete. Negative results
belong in `claims.md` and the subsumption-boundary synthesis.
