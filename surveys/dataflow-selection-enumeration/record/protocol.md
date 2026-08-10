# Survey protocol

This file records only choices specific to this survey. The current
`run-survey` skill is canonical for the shared search, screening, snowballing,
logging, evidence, update, and bounded-closure workflow. Local commands and
file ownership are in `README.md`; current state is in `status.md`; event
history is in `log.tsv`; current interpretation is in `syntheses/`.

## Objective and study type

Maintain a problem-centered scoping survey of exhaustive selection-observation
enumeration in finite pure dataflow graphs. The survey identifies established
solution routes, translates them into one terminology, and records when their
observers, guarantees, and representations coincide with the target contract.
It is not a statistical systematic literature review.

The formal target is canonical in `syntheses/unified-framework/model.md` and
summarized in `syntheses/current-position.md`; this protocol uses that target
as its inclusion boundary rather than restating it.

## Research questions

- **RQ1:** What consistent terminology precisely defines selection-observation
  enumeration and distinguishes it from neighboring tasks?
- **RQ2:** Which established approach traditions or routes can enumerate, compile, or
  specialize the required fibers, and what instrumentation do they require?
- **RQ3:** Which correctness, representation, and complexity guarantees does
  each route provide under its stated assumptions?
- **RQ4:** Where do the approaches coincide, where do they compute a refinement
  or quotient of the target observer, and where do they address only an
  adjacent reduction problem?

## Scope and comparison routes

The comparison uses six overlapping routes:

1. guarded symbolic execution;
2. projected model enumeration;
3. compiled decision structures;
4. demand-guided evaluation and search;
5. geometric and parametric enumeration; and
6. compositional guarded summaries.

Symbolic execution, dataflow semantics, functional-logic programming, model
enumeration, knowledge compilation, geometry, parametric programming,
concurrency, and state reduction are discovery communities, not additional
research questions. Partial-order reduction, unfoldings, Petri-net
observation, property-guided exploration, and state quotienting are adjacent
comparators only when they clarify an observer-relative boundary.

`queries.tsv` is the sole record of exact recurring searches, sources, limits,
and reconciliation dates. New discovery vocabulary changes that file rather
than this narrative scope statement.

## Selection boundaries

Include a work when it makes a technical contribution to a research question
and exposes enough semantics, guarantees, or algorithmic detail for
comparison. Foundational reports and theses may serve as primary sources when
they contain the most complete result.

This survey declares these exclusion codes:

- `E1-def-use-testing`: conventional CFG def-use coverage only;
- `E2-ml-graph-runtime`: ML graph execution or staging only;
- `E3-secondary`: secondary source superseded by an available primary work;
- `E4-application-only`: unchanged application of an existing executor;
- `E5-unobtainable`: insufficient technical content after recorded attempts;
- `E6-out-of-scope-model`: cannot answer a research question under scope;
- `E7-duplicate-version`: superseded version retained for lineage; and
- `E8-retracted`: formally retracted or withdrawn.

`E6-out-of-scope-model` carries the main local judgment:

- Abstract program-analysis facts are out of scope even when described as
  dataflow; concrete-input partitions by selection outcomes are in scope.
- Process-transition or schedule observers are out of scope as target
  implementations, though they may be adjacent observer comparators.
- Vocabulary overlap, such as “enumerating expression trees” over a different
  program model, is insufficient without overlap in the semantic object.

The catalog rationale records the adjudication for each individual boundary
case; this protocol does not duplicate those examples.

## Survey-specific record choices

- `check.py` declares the five shared statuses used here: `candidate`,
  `screened`, `deep-read`, `excluded`, and `parked`. This survey gives them no
  semantics beyond the `run-survey` definitions.
- `cluster` is an open, one-value-per-work discovery facet. `priority=critical`
  marks the closest-work set and activates the shared critical-work duties.
- In migrated source notes, `retrieved: "-"` means that the acquisition date
  was not recorded. `notes-date` is the last recorded review date, not an
  inferred retrieval date.
- Historical `notes-by` values from the initial campaign name `Codex` without
  a recoverable exact model. Preserve those values as legacy provenance rather
  than guessing a model; future material revisions append the revising agent
  and model under the current shared contract.

## Publication and novelty qualifications

This survey may publish a dated scoping snapshot while candidates remain, as
long as `status.md` reports the backlog and the manuscript draws no literature-
absence or mapping-closure inference from it. A bounded mapping-closure claim
requires the unmodified closure criteria in the `run-survey` skill.

For the proposed semantic contract and algorithms, correspondence must be
tested against the closest works in `syntheses/closest-work-audit.md`. The
absence of an exact published match remains a bounded search finding, not a
novelty theorem. Survey-authored derivations remain identified as such in the
claim ledger and manuscript.
