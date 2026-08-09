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

Exact recurring searches are versioned in `queries.tsv`. New vocabulary
discovered during reading is added there in a separate commit rather than
silently changing an executed search.

## Records and authority

The file map, with each record's purpose and update rule, is the
README's Files section. Search indexes are discovery aids. Primary
papers, official proceedings, publisher records, or stable
author-hosted versions control technical and bibliographic claims.

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
stable section label. Evidence IDs identify literature claims; `Cxx` IDs refer
only to the synthesis claims in `claims.md`.

Priority controls maintenance obligations. Every `critical` work must be
deep-read and must have separate usable backward and forward citation chases.
New critical works receive both chases immediately; existing critical works
receive a forward refresh as part of any update batch.

## Incremental maintenance

Updates are staged on demand — there is no maintenance schedule. The
registered searches and the update tool make staging one command
(`update.py fetch --all`). Begin an update immediately when alerts,
peer feedback, or reading expose a plausible close competitor or a
new coverage theme, and otherwise whenever fresher coverage is
wanted; a complete forward-citation refresh of the critical set
belongs in any substantial update batch.

Scheduled database runs search an inclusive interval from the last fully
reconciled date through the new batch date. Crossref ranks that bounded set by
relevance; arXiv returns recent submissions first. The overlapping boundary
protects against delayed deposits; catalog deduplication absorbs repeats.
Unbounded searches remain useful for deliberate scope expansion but do not
constitute an incremental update.

The numbered procedure is the README's To update section. An update
is incomplete if it only adds bibliography entries or source notes.
The cross-paper synthesis and every affected manuscript claim must also be
reconciled.

## Snapshot closure and reopening

The survey is an updatable systematic map; “current” means that no
promoted finding remains unreconciled, and freshness is stated as the
last reconciled coverage date. A publication snapshot
may claim bounded mapping closure only when:

1. every discovered work has a catalog disposition;
2. every critical work is deep-read and chased in both directions;
3. every registered search has an adjudicated execution covering the
   snapshot's coverage date;
4. two prospective, independently checked no-add batches find neither a new
   theme nor a plausible close competitor; and
5. the manuscript, evidence matrix, and syntheses agree on the coverage date.

A later paper, changed result, or new theme reopens the current map. Closure is
always relative to the named sources, exact queries, result depths, and date.

## Audited search-log schema

`log.tsv` contains: execution date, kind (`search`, `snowball`,
`audit`, or `exploratory`), event id, source, exact query or seed,
direction, hit count, screened count, included keys, excluded keys,
and notes. Result sets are staged in `.scratch/` during screening and
discarded after reconciliation — the log row is the audit unit.
Approximate counts, unknown result sets, and aggregate seed descriptions belong
in scratch notes rather than the audited log.

Executed rows are append-only. If later primary reading changes a
catalog disposition, append an `audit` reconciliation row rather than
rewriting the executed row. Its notes record `promoted-key:KEY` or
`superseded-key:KEY`; the current catalog gives the resulting disposition while
the earlier row preserves the adjudication made at execution time.

## Novelty discipline

For any proposed contribution, restate it in the notation of the closest work
and test whether its semantic object, theorem, or enumeration method transfers
under straightforward instrumentation. Absence of a matching paper is only a
novelty hypothesis until the closest-work audit is complete. Negative results
belong in `claims.md` and the subsumption-boundary synthesis.
