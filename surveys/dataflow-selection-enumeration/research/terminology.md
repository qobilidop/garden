# Terminology ledger

All terminology remains provisional until the survey establishes how the
closest communities use each term.

| Concept | Terms to investigate | Provisional preference | Status | Concern |
|---|---|---|---|---|
| Program representation | dataflow graph, expression DAG, term graph, circuit | finite typed pure term graph; *selective term graph* when selections are explicit | provisional | “Dataflow” is heavily overloaded; term graph makes sharing central. |
| Finite value-selecting operator | selection, choice, conditional, mux, ITE | selection operator; selection site | provisional | “Choice” suggests nondeterminism in functional-logic work. |
| Decisions relevant to one input | path, trace, partial assignment, configuration, event set | selection observation; sparse selection-outcome map | provisional | The object is unordered and graph-intensional, so “path” and “trace” mislead. “Configuration” is established in event structures. |
| Inputs sharing one observation | path region, equivalence class, cell, case, fiber | observation fiber; observation region | provisional | *Fiber* is mathematically exact; *region* is friendlier prose. |
| Formula denoting a region | path condition, activation condition, guard | observation guard | provisional | It is not necessarily a CFG path condition. |
| Symbolic result valid in a region | symbolic store, value summary, residual | guarded residual value | provisional | MultiSE already uses *value summary* for disjoint guarded expressions. |
| Exhaustive disjoint output | partition, cover, disjoint enumeration | exact observation partition | provisional | “Complete” must name caller domain, graph, observation policy, and solver assumptions. |
| Relevance policy | demand, activity, liveness, cone of influence | result observation; result-observed site | provisional | Avoid implying lazy operational evaluation in an eager pure language. |
| Stable representation | canonical, normalized, deterministic | graph-relative unique | provisional | *Canonical* is reserved for a stated equivalence and representation conditions. |

## Required distinctions

- **Structural inactivity vs. logical don't-care:** a site is inactive because
  the observation policy does not reach its cone for that input. An unassigned
  literal in a partial implicant may vary without falsifying a formula.
- **Selection observation vs. output value:** active equal-valued alternatives
  have the same ordinary value but different structural observations.
- **Result observation vs. lazy evaluation:** the base graph has eager,
  deterministic value semantics. A separate judgment selects structural events
  exposed by an instrumented observer.
- **Graph-relative uniqueness vs. logical canonicity:** renaming, rewriting, or
  duplicating graph sites can change the observation while preserving the
  extensional function.
