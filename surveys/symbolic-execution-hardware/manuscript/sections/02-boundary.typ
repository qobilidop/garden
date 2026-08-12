= The operational boundary <sec-boundary>

== Five necessary conditions

We include a work only when all five conditions hold:

1. it steps, replays, or composes executions of a digital hardware design or a
   claimed-faithful executable representation;
2. a hardware input, state element, or environmental value is symbolic;
3. the method constructs path predicates tied to distinguishable control- or
   time-indexed design executions;
4. feasibility over those predicates controls enumeration, selection,
   reconstruction, composition, merging, or generation of another execution;
   and
5. this mechanism is load-bearing and yields a test, witness, coverage result,
   or qualified verification result.

A convenient symbolic state is $(ell, sigma, pi, tau, eta)$: execution
location or frontier $ell$, symbolic store $sigma$, path predicate $pi$,
hardware time and scheduler state $tau$, and environment $eta$. The tuple is
descriptive rather than prescriptive. A direct SystemC executor makes
scheduler choices and waits part of $ell$ and $tau$ @harrath2011wsa; a
Verilator-to-C flow delegates them to the generated transition step and
harness @mukherjee2015software @zhang2016rtltests; a SystemC-aware KLEE
extension implements its own scheduler @lin2016systemc. What cannot disappear
is an execution identity whose feasibility affects what is executed next.

== Three included regimes

*Classical symbolic execution* advances one or more symbolic design paths and
uses their predicates directly. It includes forward, backward, and fragment-
composed execution; those are search or representation choices, not separate
top-level regimes.

*Concolic or dynamic symbolic execution* couples concrete and symbolic views
of a path. A concrete RTL trace supplies branch outcomes; the method maintains
or reconstructs their symbolic predicate, negates or changes a selected
condition, solves it, and re-executes the resulting input
@ahmed2018directed. Concolic execution therefore differs from classical
multi-path exploration but remains symbolic execution: without the symbolic
path predicate and feasibility query, the next execution would not be
generated.

*Selective-hybrid symbolic execution* makes the symbolic executor one phase
or region of a broader search. A concrete trace may be reduced to a selected
cycle before solving @qin2014interleaving, or fuzzing may provide a state
snapshot from which a short symbolic suffix is constructed @jayasena2025fuss.
The symbolic phase must still pass all five conditions. Concrete simulation
plus a genetic algorithm, trace ranking, or coverage feedback alone does not.

== What remains outside

*Symbolic simulation* propagates symbolic values through a circuit and may
merge alternatives into guarded expressions. Historically, Carter et al.
described machine symbolic simulation as similar to program symbolic
execution @carter1979symbolic; later RTL simulators used Boolean guards, ITE
values, and guarded events @kolbl2001rtl, and dynamic functional-space
partitioning split symbolic values when BDDs grew @feng2004dynamic. These
methods are relevant intellectual context. Under the present protocol they
are outside unless distinguishable path predicates guide further execution.

STE, BMC, property checking, equivalence checking, theorem proving, and static
information-flow analysis are likewise outside when they reason over abstract
trajectories or transition formulas without a load-bearing path executor. The
boundary is architectural, not evaluative: a BMC engine may prove a stronger
bounded property while remaining a different technique. General formal-
hardware and directed-test surveys cover those broader neighborhoods
@camurati1988formal @jayasena2024directed.

Two close negative examples show why full-text adjudication matters. GreyConE
does concolically execute compiled SystemC, but the paper does not establish
hardware-specific execution semantics or a relation to generated hardware;
it is excluded at the HLS bridge @debnath2022greycone. Forbench merges symbolic
design values and forks a procedural testbench, but its principal design
mechanism is symbolic simulation rather than path-conditioned design
execution under this definition @yang2026-forbench. Their labels are less
important than the missing condition.

== What “hardware” means

Hardware names the *represented digital design*, not the implementation
language and not necessarily a fabricated device. RTL is the center. Other
HDLs, SystemC/TLM, HLS source or IR, generated C/C++, gate netlists, and
coupled models qualify when hardware-specific semantics are load-bearing or a
validated relation connects the executed artifact to hardware. Firmware
symbolically executed against a concrete processor remains software symbolic
execution. Generic C++ intended for synthesis remains software analysis until
hardware datatypes, streams, timing, or a source-to-generated-design relation
enters the method.
