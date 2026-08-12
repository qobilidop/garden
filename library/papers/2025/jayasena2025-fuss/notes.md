---
citekey: jayasena2025-fuss
work:
  title: "FuSS: Coverage-Directed Hardware Fuzzing with Selective Symbolic Execution"
  author: Aruna Jayasena, Sai Suprabhanu Nallapaneni, Prabhat Mishra
  venue: "ACM Transactions on Embedded Computing Systems 24(5s), 1–24"
  date: 2025-08-14 # first public appearance in the DOI record; Crossref's published field is 2025-09-26
  doi: 10.1145/3760529
sources:
  pdf: https://www.cise.ufl.edu/research/cad/Publications/tecs25.pdf # author-hosted ACM manuscript; title and authors match the record, but the file retains placeholder volume and DOI fields
  record: https://dl.acm.org/doi/10.1145/3760529
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "FuSS spends fuzzing on broad concrete exploration and symbolic execution only on short suffixes beyond a coverage frontier, producing strong branch and toggle coverage curves without turning coverage into a proof or supporting its unconditional always-faster claim."
---

# FuSS: Coverage-Directed Hardware Fuzzing with Selective Symbolic Execution

FuSS is a hardware-validation systems paper that couples coverage-guided
fuzzing to selective symbolic execution of Verilator-compiled RTL. Its central
idea is unusually crisp: let cheap concrete mutation discover most behavior,
then, when coverage stops growing, preserve the fuzzer's reached hardware state
and symbolically solve only a nearby unexplored suffix. The resulting tool is a
test generator for processor and SoC RTL, not a verifier. Its four-design
evaluation makes a persuasive case that the hybrid can break branch and toggle
coverage plateaus, while the paper's theoretical argument does not justify its
stronger claim that FuSS will always reach a goal faster than competing
methods.

## The concrete prefix pays for a short symbolic suffix

Figure 5 shows the architecture as a feedback loop around one shared test
corpus. A modified DifuzzRTL engine mutates precompiled instruction programs
and runs them against a Verilog design plus clock/reset testbench compiled by
Verilator. A sliding window over cumulative coverage detects a plateau: the
experiments use a ten-iteration window and a minimum average increment of
0.05. Only then does FuSS invoke its symbolic machinery.

Concrete replay maps the current program to the control-flow graph of the
compiled hardware model. Function hooks associate activated basic blocks with
the assembly instructions that reached them. For every explored node, FuSS
selects unexplored destinations within a bounded graph distance—two edges in
the experiments—and forms source/destination pairs for symbolic execution.
This is the decisive scaling restriction: it asks for a path across the local
coverage frontier rather than from reset to the target.

Figures 7 and 8 make the splice concrete. The fuzzer's program is trimmed at a
selected source node; the hardware state at that point becomes the symbolic
initial state; angr solves an instruction suffix to the nearby destination;
and the concatenated program returns to the corpus. Most alternatives
therefore remain concrete programs. Symbolic alternatives exist briefly as
VEX path constraints handled through angr, Claripy, and Z3. FuSS repeats this
loop until a coverage target is met, although the algorithm gives no terminal
policy for an unreachable goal or a frontier whose local queries all fail.

## Translation and snapshot fidelity carry the hardware semantics

FuSS operates on Verilog RTL, but not by directly interpreting HDL processes.
The design and its testbench become a cycle-accurate C++ simulator through
Verilator, and angr lifts that executable representation into VEX. Clocked and
concurrent hardware state is carried operationally in a concrete simulator
snapshot. The symbolic executor inherits that one reached state and explores a
short continuation from it.

This gives software fuzzing and symbolic execution infrastructure practical
access to a hardware implementation, but it also defines the trust boundary.
Successful generated programs are replayed, so their measured coverage does
not depend solely on the symbolic model being correct. Missed behaviors do:
Verilator's RTL semantics, the testbench, CFG hooks, program-to-block mapping,
snapshot completeness, VEX lifting, solver policy, seeds, plateau parameters,
and the two-edge frontier can all prevent a reachable behavior from being
found. The paper evaluates only Verilator despite suggesting that any
cycle-accurate compiled simulator could occupy this role.

## Coverage witnesses are not proofs

FuSS outputs concrete instruction sequences intended to activate previously
uncovered branches or signal toggles. A replayed input witnesses that coverage
under the chosen simulator and harness. Failure, timeout, plateau, or residual
uncovered logic does not prove a target unreachable, establish functional
correctness, or rule out bugs. The tool is best described as solver-assisted
directed testing: symbolic execution changes which tests enter the corpus, and
concrete simulation remains the oracle for the reported result.

That contract also limits what higher coverage means. Branch and toggle
coverage are useful exploration signals but contain no specification of
correct behavior. The paper reports no discovered defects or semantic oracle,
so the experiment establishes improved activation, not improved bug yield.
The VCD analysis plausibly attributes FuSS-only toggles to protocol-heavy AXI,
UART, SPI, and I2C interfaces and to buffers, caches, memories, and register
files—exactly the stateful regions where a constrained suffix can coordinate a
rare handshake—but the attribution is qualitative rather than counted by
component.

## The empirical result is stronger than the theorem

The evaluation runs for 600 minutes on PicoSoC, UeRVSoC, VeeRwolf, and CVA6.
Figure 10 shows FuSS finishing near 96–100% branch coverage, above both
traditional fuzzing and fuzzing assisted by property checking on every design.
Figure 11 shows the larger separation in toggle coverage: FuSS ends around
79–91%, the property-assisted baseline around 58–70%, and traditional fuzzing
around 34–55%. The curves make the recurring plateau breaks visible rather
than reducing the result to one endpoint.

A separate experiment samples 1,000 unexplored nodes after a PicoRV/PicoSoC
plateau. At 15 hours, the reported activation proportions are 0.12 for
fuzzing, 0.43 with property checking, and 0.81 for FuSS. This supports the
paper's assumed ordering of average success probabilities in that
configuration.

It does not prove the abstract's unconditional “always faster” statement. The
analysis applies an Azuma–Hoeffding concentration bound to successful
discoveries across fuzzing iterations and obtains a smaller sufficient
iteration count only when FuSS's average success probability is already
higher. That ordering is empirical, not derived from the algorithm, and the
iteration model omits context mapping, solver costs, failures, and wall time.
The evaluation further omits repeated trials, variance, seeds, exact endpoint
tables, resource use, solver-query distributions, and ablations for plateau
detection, snapshots, context mapping, or frontier depth.

## Assessment

- **Durable:** use an empirically reached state as a checkpoint and purchase
  only a small symbolic continuation; keep a shared concrete corpus as both
  exploration memory and replayable evidence; and treat plateau detection as
  the scheduler between cheap broad search and expensive directed reasoning.
- **Era-bound:** the particular DifuzzRTL, Verilator, angr/VEX, Claripy, Z3,
  and EBMC integrations; absolute ten-hour curves; and coverage endpoints on
  four open RISC-V SoCs will move as tools and designs change.
- **Weaknesses:** no released artifact is identified, no repeated-trial or
  ablation evidence is reported, the termination and solver-failure policies
  are underspecified, and coverage is not connected to defects. The theoretical
  comparison assumes the probability ordering needed for its conclusion and
  does not model end-to-end cost.
- **Against the library:** [[jayasena2023-directed]] supplies the surrounding
  taxonomy of target-directed hardware validation; [[yang2026-forbench]] keeps
  design alternatives inside symbolic expressions and forks at testbench
  decisions, whereas FuSS keeps most alternatives in a concrete corpus and
  invokes path-based execution only at a selected frontier;
  [[baldoni2016-symbolic]] provides the broader software-side architecture;
  and [[symbolic-execution-hardware]] places FuSS in the RTL hybrid lineage.

FuSS's lasting contribution is the placement of the symbolic boundary. It
does not make exhaustive RTL reasoning cheap; it makes symbolic execution a
scarce intervention whose starting state, target, and payoff are chosen by the
fuzzer's accumulated concrete evidence.
