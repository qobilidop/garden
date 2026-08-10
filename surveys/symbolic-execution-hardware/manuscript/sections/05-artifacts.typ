= Executed artifacts and semantic bridges <sec-artifacts>

== Direct RTL execution

Direct RTL executors parse or elaborate Verilog/SystemVerilog and define
symbolic rules for expressions, assignments, branching, clocks, and state
updates. Their advantage is a short explanatory path from a reported source
location to the design. Their burden is semantic completeness. Nonblocking
assignments, multiple always blocks, event ordering, four-state values,
memories, asynchronous controls, delays, and testbench constructs are not
minor front-end details; each can change the concrete trace relation.

Sylvia's RTL semantics treats sequential blocks as units that can be explored
separately before composition @ryan2023sylvia. SEIF uses the same direct style
while connecting source lines and clock-separated assignments to a static
information-flow graph @ryan2023seif. Directness does not eliminate modeling
choices: synthesizable subsets, loop bounds, symbolic initial states, and
unsupported scheduling constructs still delimit the result.

== Generated executable models

Translation-based systems compile RTL into C or C++ and reuse a software
symbolic executor. In SE4RDV, Verilator supplies cycle evaluation semantics,
the harness selects symbolic ports and temporal depth, and KLEE explores the
generated paths @zhang2016rtltests. The architecture is attractive because it
inherits industrial-strength compilation and established symbolic-execution
infrastructure. It also creates a three-part trusted chain:

$ "hardware RTL" arrow "generated model" arrow "symbolic executor". $

The first arrow must preserve the relevant HDL behaviors; the second must model
generated data widths, memory, external calls, and undefined behavior
faithfully. Replaying a witness on the source RTL is valuable end-to-end
validation, but replay establishes one trace, not translation equivalence for
all explored states.

== SystemC and transaction-level models

SystemC spans synthesizable descriptions, timed processes, abstract
peripherals, and transaction-level interfaces. A SystemC executor must model
both C++ semantics and the simulation kernel's concurrency. Cross-level work
makes the artifact relation explicit: a peripheral implementation and a
transaction-level reference execute together, and discrepancies become
solver-generated input traces.

The broad comparison by Rudkowski et al. separates two architectures. A
standalone method symbolically executes a low-level SystemC model and checks
its behavior through a harness; a cross-level method coordinates low- and
high-level models and compares their observations @rudkowski2026crosslevel.
The study shows both the appeal and cost of this scope: array models, thread
scheduling, loops, asynchronous waits, simulation bounds, and solver timeouts
all affect which paths complete. Cross-level execution strengthens the oracle
but expands the symbolic state.

== HLS and design-level C/C++

HLS introduces two distinct objects that papers can conflate. One is a C/C++
program intended for synthesis; the other is the generated RTL. A symbolic
execution system may search the source for a security trigger, exercise the
generated circuit, or relate both. It is in this survey only when the claim is
about the hardware design or the source-to-hardware relation, not merely a C
program that happens to be synthesizable.

GreyConE exemplifies a SystemC high-level-design hybrid: greybox fuzzing
explores cheaply, concolic execution solves branch constraints that fuzzing
fails to cross, and generated tests are evaluated on compiled SystemC models
@debnath2022greycone. FuSS applies a related selective architecture to
Verilator-generated RTL models while localizing symbolic execution to
hard-to-cover logic @jayasena2025fuss. HLS remains inside the map boundary,
but its small mapping-depth subset has no critical deep read; HLS-specific
conclusions are therefore provisional.

== Mixed-level systems

Hardware/software co-verification and peripheral checking may execute several
models at once. COVERIF, for example, uses path-based symbolic execution to
coordinate a hardware/software setting and to expose interaction behaviors
that isolated component checks can miss @mukherjee2020coverif. The inclusion
test is whether hardware state is symbolic and behaviorally coupled, not
whether the paper contains a processor diagram.

Mixed-level systems make the environment part of the theorem. Bus protocols,
driver assumptions, transaction abstractions, reset sequences, and scheduling
policies determine feasibility. Their witnesses can be especially useful
because they cross an interface, but negative results are meaningful only
relative to that interface model.
