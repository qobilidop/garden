# Terminology ledger

All terminology remains provisional until the survey establishes how the
closest communities use each term.

| Concept | Terms to investigate | Provisional preference | Status | Concern |
|---|---|---|---|---|
| Program representation | dataflow graph, expression DAG, term graph, circuit | finite typed pure dataflow graph | open | “Dataflow” is heavily overloaded. |
| Finite value-selecting operator | selection, choice, conditional, mux, ITE | choice operator | open | Must distinguish semantic choice from operational branching. |
| Decisions relevant to one input | path, trace, partial assignment, configuration | active-choice configuration | open | A map is not inherently sequential, so “trace” may mislead. |
| Inputs sharing one configuration | path region, equivalence class, cell, case | configuration region | open | Must compare symbolic-execution and AllSMT usage. |
| Formula denoting a region | path condition, activation condition, guard | configuration guard | open | Established “path condition” may still be preferable. |
| Symbolic result valid in a region | symbolic store, value summary, residual | guarded residual value | open | Could already be exactly a value-summary element. |
| Exhaustive disjoint output | partition, cover, disjoint enumeration | exact input partition | open | “Complete” must name the universe and solver assumptions. |
| Relevance policy | demand, activity, liveness, cone of influence | demand | open | Eager graph semantics complicates operational wording. |
