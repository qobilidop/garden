= Execution regimes and path meaning <sec-execution-models>

== Classical paths

A classical executor advances states such as $(ell, sigma, pi, tau, eta)$.
At a symbolic guard $g$, successor predicates are $pi and g$ and $pi and not
g$; infeasible successors are removed. In clocked hardware, $tau$ includes
cycle or scheduler state, so the same source branch reached on two cycles can
belong to different paths. In concurrent SystemC, process selection, event
notification, and wait boundaries can also distinguish executions
@harrath2011wsa @lin2016systemc.

Generated-code systems expose the paths selected by a compiler or simulator
rather than the HDL syntax directly @mukherjee2015software
@zhang2016rtltests. This can be entirely adequate for test generation if
witnesses replay, but source branch coverage and generated C++ branch coverage
need not have the same denominator.

Classical does not require forward whole-path enumeration. Coppelia reasons
backward from an architectural security condition and stitches cycle-level
predecessors into a replayed program @zhang2018coppelia. Sylvia explores
sequential RTL blocks independently and asks whether fragment combinations
form a feasible design execution @ryan2023sylvia. Both retain path identity and
feasibility; direction and fragmentation are scaling choices within the
regime.

== Concolic paths

Concolic execution represents the active path twice: a concrete trace fixes
the branch sequence and hardware state, while symbolic constraints explain
which inputs could reproduce or divert it. Directed RTL testing selects a
branch related to a target, negates its predicate, solves the prefix, and
re-simulates the returned vector @ahmed2018directed. Scalable variants add
hardware-aware ranking, caching, and reuse @lyu2021scalable.

This is narrower than classical multi-path execution but not outside symbolic
execution. The solver operates on a predicate tied to an executed path, and
its model causes the next hardware execution. The distinction matters for
claims: only traces selected by the concrete schedule and diversion policy are
considered, so exhausting the currently selectable alternatives is not a
general reachability proof.

AutoVeriFix+ demonstrates that the same mechanism can be nested in a larger
application. Concrete simulation records cycle-indexed branch and state
traces; the concolic phase changes an uncovered branch; differential checking
and an LLM use the new trace for repair @tan2026autoverifix. The generated
Python oracle and repair loop qualify the correctness claim, but they do not
change the concolic classification.

== Selective-hybrid paths

Selective hybrids distribute execution state across components. Qin and
Mishra's concrete simulator supplies a time-indexed trace, then symbolic
reconstruction specializes arrays and solves one uncovered branch
@qin2014interleaving. FuSS holds a concrete program corpus and coverage map,
snapshots the Verilated design state at a selected frontier, and symbolically
solves only a short suffix @jayasena2025fuss. The path is a composite of
concrete prefix and symbolic diversion.

A hybrid result is the union of its phases, not the strongest property of the
symbolic phase. Target selection, slicing, state reconstruction, and
concretized choices determine which behaviors can be missed. A complete
description therefore names the handoff trigger, the state transferred, and
whether an earlier concrete choice can later become symbolic.

== Concurrency and time

Hardware paths have at least three axes: control choices within a process,
scheduling or interaction among processes, and repeated state transitions over
time. Some tools serialize concurrent logic through a simulator; others model
the scheduler; others operate under synthesis semantics where a cycle is one
transition. These choices can be observationally equivalent for a supported
subset and divergent elsewhere. Path count has meaning only after the
concurrency, clock, reset, and environment models are stated.
