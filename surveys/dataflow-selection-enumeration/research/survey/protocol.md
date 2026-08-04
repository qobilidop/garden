# Survey protocol

## Objective

Determine whether exhaustive demand-sensitive symbolic evaluation of finite
pure dataflow graphs is already known, identify the closest established
formalisms and algorithms, and select terminology and theorem obligations that
make the eventual contribution precise.

This is a reproducible systematic mapping and snowballing exercise. It is not,
without further methodological work, claimed to be a standalone systematic
literature review.

## Research questions

- **RQ1:** What mathematical program models are used for symbolic evaluation
  without conventional control-flow paths?
- **RQ2:** What objects are enumerated: paths, traces, cases, configurations,
  models, implicants, cubes, guarded values, or input regions?
- **RQ3:** Which approaches enumerate partial rather than total decisions, and
  how do they treat inactive or irrelevant choices?
- **RQ4:** Which soundness, completeness, uniqueness, coverage, disjointness,
  or minimality properties are defined and proved?
- **RQ5:** How are residual symbolic values, witnesses, and graph sharing
  represented?
- **RQ6:** Which algorithms avoid redundant products of choices, and what
  complexity or output-sensitivity results are known?
- **RQ7:** Which assumptions are made about purity, totality, effects, cycles,
  time, and solver completeness?
- **RQ8:** Which motivating examples best expose the distinction between merged
  symbolic values, global decision assignments, and demanded choices?

## Search clusters

1. Foundational and formal semantics of symbolic execution.
2. Multi-path symbolic execution, state merging, guarded values, variational
   execution, and veritesting.
3. Symbolic simulation, symbolic trajectory evaluation, circuits, mux networks,
   and RTL symbolic execution.
4. Synchronous and dataflow-language verification and test generation,
   including Lustre, SCADE, SIGNAL, GATeL, and Lurette.
5. Dataflow-program example and test generation, including relational and
   MapReduce systems.
6. AllSAT, AllSMT, projected enumeration, disjoint partial models, implicants,
   and cube enumeration.
7. Trace/state partitioning in abstract interpretation.
8. Decision diagrams, conditional values, partial evaluation, residualization,
   program slicing, and demand or cone-of-influence analysis.

## Discovery sources

Search ACM Digital Library, IEEE Xplore, SpringerLink, USENIX proceedings,
conference proceedings, DBLP, author publication pages, and scholarly search
engines. Search engines and indexes are discovery aids; substantive conclusions
must be checked against the primary paper or its author-hosted version.

## Initial search expressions

Queries combine terms from the following groups:

```text
"symbolic execution" AND (denotational semantics OR input partition)
"symbolic evaluation" AND (dataflow graph OR term graph OR expression DAG)
(multipath OR "multi-path") AND "symbolic execution"
(guarded value OR value summary) AND symbolic
(AllSAT OR AllSMT) AND (partial OR projected OR disjoint) AND enumeration
"trace partitioning" AND abstract interpretation
(symbolic simulation OR symbolic execution) AND (circuit OR mux OR RTL)
(Lustre OR SCADE OR SIGNAL) AND (symbolic OR test generation OR coverage)
dataflow AND (symbolic execution OR symbolic test generation)
(demand OR relevance OR cone-of-influence) AND symbolic evaluation
```

Every executed query is recorded in `search-log.tsv`; useful synonyms discovered
during reading are added in later rounds rather than silently changing this
protocol.

## Inclusion criteria

Include a work when it makes a technical contribution to at least one research
question and provides enough detail to compare semantics, guarantees, or
algorithmic behavior. Foundational technical reports and theses may be included
when they are the primary or most complete source of an influential result.

## Exclusion criteria

Exclude, with a recorded reason:

- works using *data-flow testing* solely to mean def-use coverage in an
  otherwise conventional CFG;
- works using *symbolic graph execution* solely to mean staged execution of a
  machine-learning graph;
- secondary summaries when the primary work is available;
- applications that use an off-the-shelf symbolic executor without changing or
  formalizing the relevant semantic object;
- works whose full technical content cannot be obtained after reasonable
  attempts, unless their terminology itself materially affects the survey.

## Screening and deep reading

Title/abstract screening assigns a cluster, priority, and status. Deep reading
uses the source-note template and must inspect definitions, the central
algorithm, theorem statements and assumptions, complexity discussion, examples,
and related work—not only the abstract and introduction.

## Snowballing and saturation

For every closest work, perform backward citation chasing and forward citation
chasing. The initial mapping phase reaches saturation after two consecutive
snowballing rounds add neither a new conceptual cluster nor a plausible close
competitor. Later papers may reopen the survey.

## Novelty test

For each closest work, restate our hypothesis in that work's notation and ask:

1. Is the desired partition already one of its semantic objects?
2. Is demand-sensitive omission merely an existing projection, slice, cube, or
   state-merging operation?
3. Do its theorems imply ours directly under a simple encoding?
4. Would our algorithm be a standard enumeration scheme applied to a new IR?
5. If so, what nontrivial theorem, representation, or complexity result remains?

A negative answer to novelty is a useful survey outcome and must be recorded in
`research/claims.md` rather than softened.

## Survey snapshot

- Protocol established: 2026-08-04
- Working venue standards: CAV primary, PLDI stretch
- Working language: English
