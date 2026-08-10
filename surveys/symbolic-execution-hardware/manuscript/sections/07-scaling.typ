= Scaling mechanisms and the conservation of difficulty <sec-scaling>

Hardware adds a temporal and concurrent multiplier to familiar path
explosion. In a bounded synchronous model, choices can arise from symbolic
inputs, control branches, scheduling, state-dependent loops, memory indices,
and combinations of concurrent blocks on every cycle. No surveyed technique
removes this product in general. Each controls which part is constructed,
shared, approximated, or postponed.

== Guidance and target selection

Directed concolic testing avoids indiscriminate path enumeration by tracing
back from a target and solving constraints that are expected to change its
reachability @ahmed2018directed. Scalable RTL concolic testing ranks or reuses
branch information and exploits circuit structure @lyu2021scalable. SEIF uses
static information-flow paths as landmarks, divides them at clock boundaries,
and permits bounded stalls while it searches for an executable RTL witness
@ryan2023seif. These methods improve *time to selected evidence*. Unless every
target and alternative is scheduled under an exhaustive bound, they do not by
themselves establish absence.

== Composition and reuse

Block-level fragments prevent repeated exploration of the same local RTL
behavior @ryan2023sylvia. Cross-level methods can reuse component executions or
compare modular observations @rudkowski2026crosslevel. Query caching, repeated
submodule reuse, cone-of-influence reduction, and incremental solving attack
construction and solver redundancy.

Reuse requires a stable interface. A summary must say which state, inputs,
time indices, and assumptions it abstracts. In clocked hardware, two
syntactically identical modules can have different symbolic contexts because
their histories or reset states differ. Composition is sound only when those
contexts are part of the key or are safely generalized.

== Merging and abstraction

ITE merging and event accumulation share suffix work but can grow symbolic
expressions @kolbl2001rtl. Guard/data partitions split only where monolithic
representations become expensive @feng2004dynamic. Abstract-state methods move
detail into an abstraction relation; whether their answers are sound or merely
heuristic depends on semantics that this selective lineage map does not
establish. Testbench-directed forking merges everything the observer does not
need to distinguish @yang2026-forbench.

These mechanisms move complexity between three ledgers:

#figure(
  table(
    columns: (23%, 37%, 40%),
    [*Ledger*], [*Typical growth*], [*Representative controls*],
    [Executor], [active paths, fragments, event contexts], [guidance, composition, concrete runs],
    [Representation], [ITE/BDD DAGs, guarded values, abstract states], [merging, partitioning, abstraction, sweeping],
    [Solver], [query count, formula size, theory difficulty], [caching, incremental solving, slicing, word-level reasoning],
  ),
  caption: [Path explosion is redistributed among executor, representation, and solver.],
) <tab-ledgers>

An evaluation that reports only one ledger can therefore be misleading. Fewer
paths may accompany larger formulas; fewer queries may accompany harder
queries; faster bug discovery may leave most targets unscheduled. End-to-end
time, peak memory, completed bounds, and evidence produced are the common
denominators.

== Hybrid handoffs

GreyConE and FuSS use fuzzing for high-throughput discovery and symbolic
execution for hard conditions @debnath2022greycone @jayasena2025fuss. This
division is attractive because most branches may not need a solver. Its
effectiveness depends on the handoff policy, seed/state reconstruction, and
the semantic fidelity of any localized model. A symbolic query solved from an
unreachable or mismatched state can generate a nonreplayable test; a highly
conservative slice can erase the speed advantage.

The general lesson is a conservation principle, not an impossibility theorem:
practical systems succeed by aligning representation with the verification
observer. They avoid distinguishing behaviors that the current goal cannot
tell apart, reuse local reasoning, and spend solver effort on the remaining
boundaries. Claims should identify the discarded distinctions and the
conditions under which they are irrelevant.
