# Claims ledger

No item in this file is a paper contribution merely because it is listed. Each
claim must survive the closest-work audit and acquire explicit assumptions,
proof obligations, and evidence.

## H01 — Inputs induce unique active-choice configurations

- **Status:** known / not a contribution
- **Provisional statement:** For a fixed finite rooted graph of deterministic,
  total, pure operators with finite choice operators, each concrete input
  induces a unique partial mapping whose domain is exactly the choice nodes
  demanded by the output and whose values are the selected alternatives.
- **Potentially known as:** path, partial path, trace, choice assignment,
  configuration, projected model, cube, or guarded case.
- **Closest existing result:** The exact statement is the fiber partition of a
  deterministic observation function. Voogd et al. already prove a
  trace-to-piece correspondence for symbolic execution; projected AllSMT
  enumerates selected observations after activation/outcome instrumentation.
- **Assessment:** Useful as a definition and supporting lemma, but elementary
  once the observation function is total. It must not be sold as novelty.

## H02 — Exact symbolic enumeration of configurations

- **Status:** computationally reduced to prior work
- **Provisional statement:** A demand-driven symbolic evaluator can enumerate
  every feasible input-induced configuration with an exact guard and a residual
  symbolic output while omitting choices confined to inactive alternatives.
- **Closest existing result:** Phan's AllSMT enumerates important predicates;
  Spallitta et al. enumerate disjoint projected partial SAT/SMT models; MultiSE
  supplies guarded residual symbolic values.
- **Reduction:** Introduce one finite-domain variable per contextual selection
  occurrence with values `inactive` or an outcome. Constrain it by a
  backward-activity encoding and ordinary graph equations, then project onto
  those variables.
- **Assessment:** An original algorithm must demonstrate a compositional or
  structural property not inherited from this polynomial instrumentation.

## H03 — Demand sensitivity avoids irrelevant Cartesian products

- **Status:** supporting result; novelty rejected
- **Provisional statement:** Relative to total assignments over all syntactic
  choice nodes, exact active-choice enumeration can be exponentially smaller;
  when all choices are demanded, exponential output remains unavoidable.
- **Closest existing result:** Partial-model enumeration, decision diagrams,
  guarded value summaries, and mux-guided functional-space partitioning all
  exploit omitted or shared decisions to avoid total Cartesian products.
- **Assessment:** A graph-specific exponential separation can illustrate the
  observation policy, but the broad compactness phenomenon is established.

## H04 — Selection observation is a compositional intensional semantics

- **Status:** candidate contribution; unproved
- **Provisional statement:** For a fixed finite typed pure term graph and an
  explicit selection-observing interface, the map containing exactly the
  result-observed selection-site outcomes is the least compositional refinement
  of ordinary value semantics that preserves those structural events.
- **Required results:** define the observer language; prove adequacy or full
  abstraction relative to it; state the refinement order; prove the universal
  property and congruence under graph substitution.
- **Key risks:** Event/configuration structures may already supply the semantic
  object. Merely declaring hidden events observable makes the theorem
  tautological. Ordinary XLS value contexts cannot distinguish equal-valued
  alternatives.

## H05 — Contextual summaries compose exactly under sharing and calls

- **Status:** candidate contribution; unproved
- **Provisional statement:** A summary computed once for a subgraph can be
  instantiated at contextual call occurrences and composed with a caller to
  yield exactly the same observation guards and residual values as whole-graph
  evaluation, without flattening the graph.
- **Required results:** formal occurrence naming, graph substitution, shared
  demand, invocation, and finite iteration; equality with flattened semantics;
  a complexity or reuse advantage over activation-variable projected AllSMT.
- **Key risk:** Naive tree neededness does not lift to shared term graphs, and a
  summary that exposes all internal outcomes may simply be ordinary relational
  encoding.

## H06 — Full-observation blocking takes one satisfiable query per result

- **Status:** derived baseline; not currently novel
- **Provisional statement:** Repeatedly obtain one input model, replay it to
  compute its full selection observation `tau`, derive the exact fiber formula
  `Gamma_tau`, and block that formula. For `K` feasible observations, the
  procedure makes `K` satisfiable solver queries and one final unsatisfiable
  query.
- **Assessment:** Exact fibers imply no duplicates and coverage. The query
  count is output-sensitive, but the construction is extensionally equivalent
  to projected AllSMT over explicit activation/outcome variables. Formula size,
  incremental solving cost, and comparison to compiled enumeration remain to
  be analyzed.
