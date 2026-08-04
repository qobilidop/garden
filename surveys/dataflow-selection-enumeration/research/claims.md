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

- **Status:** expressible by established machinery; rejected as original
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
- **Resolution:** Translate strict nodes applicatively and selections through a
  free selective computation. Interpret it in a reader of input combined with
  an idempotent writer of site/outcome events. Mokhov et al. already supply the
  free syntax and universal interpreter. The coarsest-partition statement is a
  kernel factorization relative to an explicit observer.

## H05 — Contextual summaries compose exactly under sharing and calls

- **Status:** supporting synthesis; rejected as original
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
- **Resolution:** Output-demand-parametric summaries do compose exactly by
  propagating the caller's boundary-demand mask and unioning namespaced event
  maps. This is selective/relational composition. It has no general compactness
  or output-delay advantage over flat activation instrumentation.

## H06 — Full-observation blocking takes one satisfiable query per result

- **Status:** derived baseline; not currently novel
- **Provisional statement:** Repeatedly obtain one input model, replay it to
  compute its full selection observation `tau`, derive the exact fiber formula
  `Gamma_tau`, and block that formula. For `K` feasible observations, the
  procedure makes `K` satisfiable solver queries and one final unsatisfiable
  query.
- **Assessment:** Exact fibers imply no duplicates and coverage. Under a
  unit-cost model-producing oracle, the invocation count is linear in `K`; this
  is not an OutputP, IncP, polynomial-delay, or wall-clock bound. The
  construction is extensionally equivalent to naive projected AllSMT over
  complete activation/outcome tuples. Formula size, serialized output,
  incremental solving cost, and compiled enumeration remain separate.

## S01 — Taxonomy of omission mechanisms

- **Status:** survey synthesis
- **Statement:** Structural inactivity, existential projection, logical
  don't-care, equal-value coalescing, abstract merging, and heuristic
  functional-space partitioning omit different information and preserve
  different observers.
- **Evidence required:** an extraction matrix covering definitions, observer,
  representation, guarantee, and complexity for every deep-read work.

## S02 — Three equivalent presentations of selection observation

- **Status:** survey synthesis; formal derivation recorded
- **Statement:** For finite total selective term graphs, the same graph-relative
  observation is obtained by enabled-edge reachability, an exact selective
  reader/writer interpretation, and a total inactive-or-outcome activation
  encoding.
- **Presentation rule:** Attribute the component constructions to their
  established literatures; present only the cross-literature equivalence as our
  organizing derivation.

## S03 — Fiber generation equals projected enumeration

- **Status:** survey synthesis; formal derivation recorded
- **Statement:** A concolically generated local guard is the exact input fiber
  of one observation, and it is equivalent to fixing the projected activation
  variables in the global encoding.
- **Consequence:** Model-and-full-fiber-block and naive projected AllSMT both
  require \(K\) satisfying models plus a final unsatisfiable query. Solver time
  and representation size remain separate.
