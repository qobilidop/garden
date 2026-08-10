= Synthesis and research agenda <sec-synthesis>

== A four-axis map

The field can be located by four questions asked in order:

1. *What artifact is executed?* Source RTL, another HDL, a generated model,
   HLS source, SystemC/TLM, netlist, or a coupled system.
2. *Where are alternatives represented?* Whole paths, fragments, guarded
   expressions, abstract states, or a concrete/symbolic population.
3. *What controls growth?* Guidance, composition, merging, abstraction,
   caching, slicing, or a hybrid handoff.
4. *What is the result contract?* A replayable witness, coverage under a
   budget, bounded completeness, an abstract proof, or cross-level agreement.

The axes are coupled. Translation-based RTL execution makes software path
search available but adds a semantic bridge @zhang2016rtltests. Direct RTL
fragments preserve source structure while postponing a concurrent product
@ryan2023sylvia. Testbench-directed forking merges design paths that the
testbench does not observe @yang2026-forbench. Cross-level SystemC execution
strengthens the oracle while enlarging state and environment obligations
@rudkowski2026crosslevel.

== Finding 1: the name is broad but not empty

"Symbolic execution" can include all surveyed execution models if it is used
as an umbrella for operational symbolic exploration, not as a synonym for
path splitting. The common core is a symbolic design state, a feasibility
relation to concrete executions, and evidence derived from advancing that
state. Symbolic simulation and STE overlap this core but are broader
literatures; selective admission keeps the boundary informative.

The terminology should therefore be two-level. Papers may call the umbrella
hardware symbolic execution, but should name the concrete mechanism:
path-oriented symbolic execution, concolic RTL testing, compositional
fragments, guarded symbolic simulation, STE, or a hybrid. This vocabulary
describes architectures without litigating historical ownership of the word.

== Finding 2: path explosion is a representation problem

The number of active paths is not an invariant measure of difficulty.
Event accumulation can merge paths into ITEs @kolbl2001rtl; fragment execution
can shrink local exploration while leaving a composition product
@ryan2023sylvia; fuzzing can avoid solver calls until coverage stalls
@jayasena2025fuss. A credible scaling claim reports executor, representation,
and solver costs together and states which distinctions the method stops
tracking.

This reframes research opportunities. The target is not universally "fewer
paths" but a representation matched to an observer. A branch-coverage tool
must preserve branch identity. A datapath property may merge equal outcomes.
An interface check may project internal behaviors to transaction observations.
Making that observer explicit could turn many ad hoc optimizations into
comparable semantic choices.

== Finding 3: hardware time belongs in every applicable guarantee

Clock cycles, scheduling, reset, and initial state distinguish hardware
execution from ordinary acyclic program examples. SEIF's bounded stalls and
reset-reachability check change how a negative or positive result is read
@ryan2023seif. Verilator-based execution makes time a harness loop
@zhang2016rtltests. SystemC makes the simulator kernel and wait semantics part
of the model @rudkowski2026crosslevel. A cycle number without reset and
environment semantics is not a reproducible bound.
For combinational designs, clock, scheduling, and reset fields can be marked
not applicable; the obligation is to make that absence explicit rather than
silently importing a sequential model.

== Research agenda

*Semantic validation.* Direct executors need executable conformance suites for
HDL scheduling, widths, four-state behavior, memories, and clocks.
Translation-based systems need differential replay and stated preservation
boundaries. Cross-level systems need explicit observation and timing
relations. The critical deep reads do not empirically isolate semantic-model
errors from search errors, leaving this distinction as an open evaluation need.

*Common evidence benchmarks.* The field needs versioned RTL, HLS, and SystemC
tasks with reset/harness artifacts, reachable and unreachable targets,
temporal depth, expected witnesses, and results under several contracts.
Benchmarking should retain hard negative cases and timeouts, not only designs
on which every tool completes.

*Effort as a metric.* Property authoring, testbench adaptation, target
selection, abstraction predicates, and model debugging should be measured in
time and artifact size. Forbench's testbench-centered interface makes this
question especially visible @yang2026-forbench, but the need applies across
the field.

*Compositional contracts.* Fragments and cross-level components need summaries
that name state, time, assumptions, and observables. Research should separate
locally reusable exploration from the global feasibility product and state
when projection or abstraction is sound.

*HLS and mixed-language breadth.* SystemC and RTL hybrids show that symbolic
assistance can cross representation boundaries @debnath2022greycone, but the
critical set contains no HLS deep read. Chisel, Bluespec, VHDL, HLS IRs, and
generated accelerator ecosystems therefore remain research and survey-update
targets, not evidence-backed extensions of the current HLS findings.

*Qualified absence.* Systems should expose outcomes such as proved infeasible,
boundedly unexplored, abstraction-inconclusive, nonreplayable, and not
scheduled. SEIF's explicit unaccounted class is a useful precedent
@ryan2023seif. This would make partial verification composable instead of
forcing every run into "found" versus "not found."
