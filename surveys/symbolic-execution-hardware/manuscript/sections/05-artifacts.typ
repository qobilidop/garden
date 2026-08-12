= Executed artifacts and semantic bridges <sec-artifacts>

The catalog's design-target facet names what the paper claims about; the
operational artifact names what the symbolic engine interprets. Both matter.
Language labels alone are insufficient: a C++ program can be the operational
representation of RTL, while another C++ program is merely source intended for
synthesis.

== Direct HDL execution

Direct executors parse or elaborate an HDL and define steps for expressions,
assignments, branches, state updates, and scheduling. Harrath et al. make the
SystemC scheduler, runnable processes, signal updates, notifications, waits,
and delta cycles part of symbolic transition construction @harrath2011wsa.
SESC similarly extends KLEE with a SystemC scheduler, signals, FIFOs,
arbitrary-width integers, and clocks @lin2016systemc. Direct RTL systems make
source locations and path predicates easy to relate, but inherit a substantial
conformance obligation: nonblocking assignment, event ordering, memories,
four-state values, multiple clocks, and unsupported testbench constructs can
all change the concrete trace relation.

== Generated executable representations

Translation-based systems reuse software symbolic executors. V2C lowers
synthesizable Verilog to a word-level C transition program and then selects a
path-symbolic-execution analyzer distinct from its BMC and abstract
interpretation configurations @mukherjee2015software. SE4RDV uses Verilator,
an arbitrary-bit-width KLEE variant, and a harness whose `eval()` loop defines
the cycle horizon @zhang2016rtltests. Their trusted chain is

$ "design" arrow "generated program" arrow "symbolic executor". $

Translation removes the need to reimplement all HDL scheduling, but does not
remove semantics. Widths, undefined behavior, generated control flow, memory,
clock sequencing, and harness assumptions must preserve the behavior relevant
to the claim. Replaying a generated test on the source design validates that
one witness; it is not a proof that all translated paths correspond.

== SystemC/TLM and mixed levels

SystemC combines C++ with a simulation kernel, process scheduling, events, and
time. A method that merely compiles a SystemC-looking function is therefore
not equivalent to a SystemC executor. Cross-level peripheral checking makes
the issue explicit: one symbolic run may combine a low-level implementation
with a transaction-level reference, and the solver observes their disagreement
@rudkowski2026crosslevel. Unsupported asynchronous waits or context-switch
approximations limit the explored behaviors.

Other mixed-level systems couple different semantic objects. COVERIF explores
hardware/software interaction paths @mukherjee2020coverif. The RISC-V case
study co-executes Verilated processor RTL and an instruction-set simulator,
comparing them at retired-instruction boundaries @bruns2023processor. Such
oracles can expose interface or implementation discrepancies, but agreement is
only relative to input restrictions, timing alignment, observation points, and
the reference model.

== Netlists and HLS

EISec translates a sequential gate-level netlist into a C representation for
KLEE, making state initialization and netlist-to-C fidelity central to its
information-flow results @fowze2022eisec. Its under-constrained state model can
surface possible flows that are not reset-reachable; that is useful exploration
but a weaker deployment claim.

The single included HLS study is deliberately qualified. Hu extends KLEE for
Vitis `ap_uint`, `hls::stream`, concurrent stream behavior, and clock-linked
state in a hardware TCP stack @hu2024tcp. Hardware semantics are therefore
load-bearing, so the thesis passes the boundary. It does not validate the
generated RTL, so its tests and bugs establish properties of the HLS source
model, not automatically the synthesized circuit. Intended synthesis alone
would not have been enough for inclusion.
