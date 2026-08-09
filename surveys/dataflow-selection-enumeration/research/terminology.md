# Terminology ledger

This ledger records the terminology selected after the close-literature survey.
Terms marked *local* are deliberately introduced for the synthesis rather than
presented as inherited terms of art.

| Concept | Terms to investigate | Preferred term | Status | Concern |
|---|---|---|---|---|
| Program representation | dataflow graph, expression DAG, term graph, circuit | finite typed pure term graph; *selective term graph* when selections are explicit | selected (local refinement) | “Dataflow” is heavily overloaded; term graph makes sharing central. |
| Finite value-selecting operator | selection, choice, conditional, mux, ITE | selection operator; selection site | selected | “Choice” suggests nondeterminism in functional-logic work. |
| Selection sites reached from the requested result for one input | demanded choice, enabled event, relevant decision, fingerprint domain | observed *for* \((x,R)\) | selected | “Active selection” is not established and can mean the selected arm rather than the consulted site. “Observed” is explicitly local membership in the enabled closure. |
| Outcomes of observed selections for one input | fingerprint, path, trace, partial assignment, configuration, event set | selection observation; sparse selection-outcome map | selected (local) | The object is unordered and graph-intensional, so “path” and “trace” mislead. “Configuration” is established in event structures; “fingerprint” is established for nondeterministic functional-logic choices. |
| Inputs sharing one observation | path region, equivalence class, cell, case, fiber | observation fiber; observation region | selected | *Fiber* is mathematically exact; *region* is friendlier prose. |
| Formula denoting a region | path condition, activation condition, guard | fiber guard; *observed-outcome guard* for the local construction | selected (local refinement) | It is not necessarily a CFG path condition. “Positive” would misleadingly suggest negation-free syntax. |
| Symbolic result valid in a region | symbolic store, value summary, residual | residual; guarded residual value | selected | A residual is a symbolic function for the requested roots, valid for every input in its fiber. MultiSE already uses *value summary* for disjoint guarded expressions. |
| Exhaustive disjoint output | partition, cover, disjoint enumeration | exact observation partition | selected (local) | “Complete” must name caller domain, graph, observation policy, and solver assumptions. |
| Overall computational task | symbolic evaluation, path enumeration, configuration enumeration, projected model enumeration | exact enumeration of selection observations | selected (local description) | “Symbolic evaluation” alone does not imply enumeration and may mean one monolithic SMT encoding. “Exact enumeration” names the externally visible task. |
| Semantics being enumerated | observation, abstraction, quotient, projection | observer; observer fiber; observer refinement | selected | An observer determines the input partition. Refinement means kernel inclusion, equivalently factorization through the finer observer. |
| Complete emitted item | case, region, path result, projected model | observation record `(observation, guard, residual, witness)` | selected (local contract) | The four fields carry distinct coverage, exactness, value, and feasibility obligations. |
| How fibers are found | exploration, solving, compilation, traversal | enumeration mechanism | selected | Keep separate from the observer and output representation. |
| How results are stored | cases, cubes, tree, diagram, regions | output representation | selected | A shared compiled object and a flat record stream can denote the same observer with different size measures. |
| Relevance policy | demand, activity, liveness, cone of influence | enabled closure; all-operands observation policy for ordinary nodes | selected (local) | “Demand” remains useful when discussing prior work, but the formal object is enabled-edge reachability. “Strict” has different established PL meanings. |
| Stable representation | canonical, normalized, deterministic | graph-relative unique | selected | *Canonical* is reserved for a stated equivalence and representation conditions. |
| Requested interface | requested outputs, results, roots, demand | requested root set \(R\) | selected | Reserve “demanded input ports” for the component-boundary set \(\delta\). |
| Admissible inputs | caller constraint, precondition, input domain | caller-domain predicate \(A\); admissible domain \(\mathcal X_A\) | selected | Keep the predicate distinct from the set it defines. |
| Whole-graph mathematical values | eager values, denotation, total valuation | total graph value; whole-graph value semantics | selected (local refinement) | The construction is operationally neutral; “eager” suggests an evaluation strategy. |
| Totalization tag | inactive, absent, bottom, unobserved | \(\mathsf{unobs}_q\); unobserved sentinel | selected (local) | Reserve \(\bot_v\) for an undefined node value in the least partial valuation. |
| Feasibility evidence | model, sample, witness | witness | selected | A witness is one sample input satisfying the fiber guard; it is not a residual valid across the fiber. |

## Required distinctions

- **Observer vs. mechanism vs. representation:** the observer fixes which
  inputs are equivalent, the mechanism discovers its nonempty fibers, and the
  representation stores them. Changing a solver or data structure need not
  change the observer; projecting or coalescing coordinates can.

- **Observation vs. operational demand:** a selection site is *observed for*
  \((x,R)\) exactly when it belongs to the enabled closure reached from the
  requested roots through every declared operand of an ordinary node and the
  cases selected by the concrete input. This is an observation judgment over
  whole-graph mathematical values, not a claim that execution is lazy.

- **Structural non-observation vs. logical don't-care:** a site is unobserved
  because the observation policy does not reach its cone for that input. An
  unassigned literal in a partial implicant may vary without falsifying a
  formula.
- **Selection observation vs. output value:** observed equal-valued alternatives
  have the same ordinary value but different structural observations.
- **Requested-root observation vs. requested-output projection:** both are
  relative to a requested result, but they retain different information.
  Output projection merges internal histories that yield the same requested
  value, as in same-first-action MPC regions. Selection observation records the
  contextual outcomes of exactly the selection sites reached while computing
  that result, including equal-valued outcomes.
- **Enabled closure vs. lazy evaluation:** the base graph has total,
  deterministic whole-graph value semantics. A separate judgment selects structural events
  exposed by an instrumented observer.
- **Observed site vs. forced value:** delayed-choice execution *forces* a
  suspension when a non-copy use needs a concrete value. Our judgment observes
  a selection site when it lies in the enabled closure. A forced value can split
  into many executions that share one selection outcome.
- **Static occurrence vs. dynamic choice identifier:** pull-tabbing and the
  Fair Scheme correlate runtime copies with computation-local choice IDs. Our
  component semantics uses graph-relative, context-qualified occurrence names;
  relating them requires a renaming theorem.
- **Exact guard vs. literal-minimal guard:** the conjunction of observed
  outcome predicates denotes exactly one fiber without unobserved-site
  literals. Some observed predicates may still be logically redundant.
- **Graph-relative uniqueness vs. logical canonicity:** renaming, rewriting, or
  duplicating graph sites can change the observation while preserving the
  extensional function.
