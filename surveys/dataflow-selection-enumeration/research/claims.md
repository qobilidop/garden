# Claims ledger

No item in this file is a paper contribution merely because it is listed. Each
claim must survive the closest-work audit and acquire explicit assumptions,
proof obligations, and evidence.

## H01 — Inputs induce unique active-choice configurations

- **Status:** hypothesis
- **Provisional statement:** For a fixed finite rooted graph of deterministic,
  total, pure operators with finite choice operators, each concrete input
  induces a unique partial mapping whose domain is exactly the choice nodes
  demanded by the output and whose values are the selected alternatives.
- **Potentially known as:** path, partial path, trace, choice assignment,
  configuration, projected model, cube, or guarded case.
- **Closest existing result:** unresolved.
- **Key risk:** This may be a direct reformulation of ordinary symbolic
  execution, structural operational semantics for conditional expressions, or
  projected model enumeration.
- **Evidence required:** formal comparison against symbolic-execution
  partitions, guarded value summaries, trace partitioning, and projected
  AllSMT.

## H02 — Exact symbolic enumeration of configurations

- **Status:** hypothesis
- **Provisional statement:** A demand-driven symbolic evaluator can enumerate
  every feasible input-induced configuration with an exact guard and a residual
  symbolic output while omitting choices confined to inactive alternatives.
- **Closest existing result:** unresolved.
- **Key risk:** The algorithm may reduce to standard path splitting plus slicing
  or AllSMT projection.

## H03 — Demand sensitivity avoids irrelevant Cartesian products

- **Status:** hypothesis
- **Provisional statement:** Relative to total assignments over all syntactic
  choice nodes, exact active-choice enumeration can be exponentially smaller;
  when all choices are demanded, exponential output remains unavoidable.
- **Closest existing result:** unresolved.
- **Evidence required:** parameterized upper and lower bounds and comparison to
  prior demand, slicing, decision-diagram, and enumeration results.
