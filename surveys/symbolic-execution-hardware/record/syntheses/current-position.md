# Current position

The survey should remain narrowly about path-conditioned symbolic execution of
digital hardware designs. A work belongs only when it executes a hardware
design or claimed-faithful representation, carries symbolic hardware values,
constructs path predicates for distinguishable control/time executions, uses
their feasibility to choose or reconstruct execution, and makes that mechanism
load-bearing in its result. Symbolic simulation, STE, BMC, trace-only search,
and generic HLS-source analysis are boundary context rather than denominator.

Within that boundary, three regimes are useful. Classical execution maintains
one or more symbolic paths directly. Concolic execution follows a concrete run
while maintaining or reconstructing its symbolic predicate and solves a
diversion. Selective-hybrid systems invoke that capability only in chosen
phases, cones, or frontiers. Concolic belongs because the symbolic path
predicate remains causally necessary; it stays separately labeled because the
concrete trace and search schedule constrain what is explored.

The bounded map contains 31 full-text-qualified works from 2011 through 2026:
14 classical, 11 concolic, and 6 selective-hybrid. RTL dominates, while four
SystemC/TLM, four mixed-level, and one each of another HDL, HLS, and netlist
show that the real boundary is semantic rather than linguistic. The corpus is
large enough for a coherent survey but too small and heterogeneous to present
as a mature standalone field. Its size is a finding, not a reason to pad the
scope with symbolic simulation.

The main synthesis is that hardware makes the path predicate temporal and
representational. Clock cycles, scheduling, reset, concurrency, translation,
and environmental transactions decide what a path means. Guidance, backward
search, fragments, caching, symbolic packet gaps, and fuzzing handoffs move
cost among path construction, summaries, solvers, and concrete corpora; they
do not generally remove the product of inputs, branches, processes, and time.

Results should therefore be read as `(artifact, initial state, time,
environment, exactness, result, completion)`. A replayed witness establishes
one behavior. Bounded completion establishes the explored model to a horizon.
A timeout, coverage plateau, or exhausted heuristic establishes neither
absence nor unbounded correctness. This contract, plus structural scale,
solver/end-to-end resources, replay, and setup effort, is the survey's central
reporting proposal.
