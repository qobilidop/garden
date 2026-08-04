# Terminology ledger

All terminology remains provisional until the survey establishes how the
closest communities use each term.

| Concept | Terms to investigate | Provisional preference | Status | Concern |
|---|---|---|---|---|
| Program representation | dataflow graph, expression DAG, term graph, circuit | finite typed pure term graph; *selective term graph* when selections are explicit | provisional | “Dataflow” is heavily overloaded; term graph makes sharing central. |
| Finite value-selecting operator | selection, choice, conditional, mux, ITE | selection operator; selection site | provisional | “Choice” suggests nondeterminism in functional-logic work. |
| Selection sites reached from the requested result for one input | demanded choice, enabled event, relevant decision, fingerprint domain | observed *for* \((x,R)\) | selected | “Active selection” is not established and can mean the selected arm rather than the consulted site. “Observed” is explicitly local membership in the enabled closure. |
| Outcomes of observed selections for one input | fingerprint, path, trace, partial assignment, configuration, event set | selection observation; sparse selection-outcome map | provisional | The object is unordered and graph-intensional, so “path” and “trace” mislead. “Configuration” is established in event structures; “fingerprint” is established for nondeterministic functional-logic choices. |
| Inputs sharing one observation | path region, equivalence class, cell, case, fiber | observation fiber; observation region | provisional | *Fiber* is mathematically exact; *region* is friendlier prose. |
| Formula denoting a region | path condition, activation condition, guard | observation guard | provisional | It is not necessarily a CFG path condition. |
| Symbolic result valid in a region | symbolic store, value summary, residual | guarded residual value | provisional | MultiSE already uses *value summary* for disjoint guarded expressions. |
| Exhaustive disjoint output | partition, cover, disjoint enumeration | exact observation partition | provisional | “Complete” must name caller domain, graph, observation policy, and solver assumptions. |
| Relevance policy | demand, activity, liveness, cone of influence | enabled closure; result observation | provisional | “Demand” remains useful when discussing prior work, but the formal object is enabled-edge reachability. |
| Stable representation | canonical, normalized, deterministic | graph-relative unique | provisional | *Canonical* is reserved for a stated equivalence and representation conditions. |

## Required distinctions

- **Observation vs. operational demand:** a selection site is *observed for*
  \((x,R)\) exactly when it belongs to the enabled closure reached from the
  requested roots through strict operands and the cases selected by the
  concrete input. This is an observation judgment over an eagerly defined pure
  graph, not a claim that execution is lazy.

- **Structural non-observation vs. logical don't-care:** a site is unobserved
  because the observation policy does not reach its cone for that input. An
  unassigned literal in a partial implicant may vary without falsifying a
  formula.
- **Selection observation vs. output value:** observed equal-valued alternatives
  have the same ordinary value but different structural observations.
- **Result observation vs. lazy evaluation:** the base graph has eager,
  deterministic value semantics. A separate judgment selects structural events
  exposed by an instrumented observer.
- **Graph-relative uniqueness vs. logical canonicity:** renaming, rewriting, or
  duplicating graph sites can change the observation while preserving the
  extensional function.
