= What counts as hardware symbolic execution? <sec-boundary>

== A mechanism-based definition

For this survey, a method belongs to the core when it operationally advances a
digital hardware design model over symbolic values, states, traces, or path
conditions and uses feasibility reasoning to produce verification evidence.
The evidence may be a concrete test, a counterexample, a coverage result, a
flow witness, or a bounded proof result. "Operationally advances" is the
load-bearing phrase. Encoding a transition relation and solving a reachability
formula is not by itself symbolic execution; neither is calling a simulator
with one concrete vector. A qualifying method exposes an execution state and a
rule for advancing or composing it, even when the state represents many
concrete executions at once.

This definition deliberately does not require path forking. Kölbl et al., for
example, split control conditions but merge assignments with ITEs and
accumulate compatible events @kolbl2001rtl. Forbench retains design
alternatives in symbolic expressions and forks only when its procedural
testbench observes a symbolic condition @yang2026-forbench. Both execute a
design symbolically, but their state-space interfaces differ fundamentally
from a whole-path tree.

Concolic execution is a narrower point in the space. It couples a concrete run
to symbolic constraints and uses solver models to choose subsequent inputs.
Hardware concolic systems often exploit fast commercial or open-source RTL
simulation while reserving symbolic work for selected paths or targets.
"Selective symbolic execution" is broader still: a system may alternate modes
by time window, module, signal cone, or search phase. The relevant question is
not which label the paper prefers, but which behaviors the concrete phase can
omit and what the symbolic phase can recover.

== Three neighboring regions

*Selected lineage.* Symbolic simulation and STE form broader neighboring
literatures. We retain only work that defines a mechanism inherited
by core systems, establishes the vocabulary needed to compare representations,
or serves as a direct baseline. Carter et al. connect machine-level symbolic
simulation to program symbolic execution @carter1979symbolic. Kölbl et al.
show how an event-driven RTL simulator can carry guarded values and replay an
error trace @kolbl2001rtl. These are not merely terminological curiosities:
they expose an alternative architecture in which branch products migrate from
executor states into Boolean expressions and the event queue.

*Formal verification without execution.* Bounded model checking, property
checking, equivalence checking, theorem proving, and information-flow analysis
can use the same SMT encodings and may return the same style of counterexample.
They enter only when an operational symbolic executor is load-bearing. The
boundary is architectural, not a judgment of importance. A BMC engine can be a
better verifier while remaining outside this survey.

*Software in a hardware setting.* Executing firmware, a driver, or a binary
symbolically against concrete or emulated peripherals remains software
symbolic execution. Conversely, executing a Verilator-generated C++ model is
in scope when the generated program is the operational representation of RTL.
The semantic obligation then shifts: the result depends on the HDL-to-C++
translation and harness, not only on the software executor.

== Relation to adjacent surveys

The closest survey traditions answer different questions. Software symbolic
execution surveys organize execution modes, search, environments, and solver
techniques, but treat hardware mainly as an application context
@baldoni2016-symbolic. A longstanding survey of formal hardware correctness
spans theorem proving, equivalence, symbolic simulation, and model checking
@camurati1988formal, while a recent directed-test-generation survey organizes
hardware validation around target selection and test production
@jayasena2024directed. This paper does not replace either hardware tradition and
does not claim a census of them. Its narrower contribution is to define the
operational symbolic-execution boundary, map the representations on both sides
of path splitting, and compare the verification contracts those systems
actually license.

== What “hardware” names

Here *hardware* names a digital design artifact before or around synthesis,
not necessarily a physical device. The center is synchronous RTL because that
is where most core work concentrates and where cycle, state update, and HDL
scheduling become explicit. The broader ring includes behavioral HDLs,
SystemC/TLM, HLS source or IR, generated C/C++, gate or netlist models, and
coupled levels. Analog behavior, layout, manufacturing variation, and
post-silicon execution fall outside unless a qualifying digital design model
remains the symbolic participant.

This artifact-centered boundary resolves a recurring naming problem. A C++
program can be "hardware" for this survey when it is an executable hardware
model; a RISC-V firmware binary is not, even though its concrete environment is
a processor. The decision follows the represented object and the claim being
made, not the implementation language.
