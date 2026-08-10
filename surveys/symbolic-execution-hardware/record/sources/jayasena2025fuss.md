---
citekey: jayasena2025fuss
work:
  title: "FuSS: Coverage-Directed Hardware Fuzzing with Selective Symbolic Execution"
  author: Aruna Jayasena; Sai Suprabhanu Nallapaneni; Prabhat Mishra
  venue: ACM Transactions on Embedded Computing Systems 24(5s), 1-24
  date: 2025
  doi: 10.1145/3760529
read: full-text
source: https://www.cise.ufl.edu/research/cad/Publications/tecs25.pdf
facets: "relation: core; artifact: rtl; execution: hybrid; goal: test-coverage; evidence: experiment"
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol (survey deep-read pipeline)
notes-date: 2026-08-10
synthesis: FuSS snapshots the concrete state at a fuzzing frontier and symbolically solves only a nearby RTL-CFG suffix, producing strong branch/toggle coverage curves on four RISC-V SoCs but no exhaustive guarantee and less theoretical support than its claimed always-faster result suggests.
---

# FuSS: Coverage-Directed Hardware Fuzzing with Selective Symbolic Execution

## Evidence

### Executed artifact and hardware semantics

- FuSS targets Verilog processor/SoC RTL. A testbench instantiates the design and controls clock and reset; a fuzz input is a byte array segmented into assembly instructions and operands. The design plus testbench is compiled by Verilator into a cycle-accurate software model, allowing software fuzzing and symbolic-execution tooling to act on a hardware implementation (Section 3.1, Figures 5-6, pp. 7-8; Section 5.1, p. 15).
- `angr` lifts the compiled implementation into VEX for control-flow-graph construction, address decoding, symbolic execution, and path constraints; Claripy invokes Z3. Function hooks in hardware basic blocks record which program instruction activates each block, giving a hardware-program context map between the assembly corpus and the CFG (Sections 3.3 and 5.1, pp. 9-10, 15).
- Clocked hardware state is supplied operationally by concrete Verilator simulation. When a selected CFG source is reached, FuSS snapshots the design's internal state and initializes symbolic execution from that state instead of reset/entry. Hardware concurrency is therefore embodied in the compiled simulator state, not represented as explicitly interleaved symbolic processes (Section 3.5, Figure 7, pp. 10-11).

### Where alternatives live and how growth is controlled

- Fuzzing alternatives live in a shared concrete corpus mutated by a modified DifuzzRTL engine. FuSS begins from precompiled benchmark programs, not random instruction streams, and continuously measures cumulative design coverage. Fuzzing remains active until a sliding-window test declares a plateau (Sections 3.1-3.2 and 5.1, Figures 5-6, pp. 7-9, 15).
- With cumulative coverage `C(t)`, window `W`, and threshold `theta`, a plateau is detected when `(C(t)-C(t-W))/W < theta`. The experiments fix `W=10` and `theta=0.05`. The paper calls these iterations but does not define their wall-clock work or normalize them across engines (Section 3.2, Equations 1-3, pp. 8-9; Section 5.1, p. 17).
- At a plateau, FuSS performs concrete replay to associate explored CFG nodes with the current program. Each unexplored node within `N` CFG edges of an explored node becomes a destination paired with that explored source; experiments use `N=2`. This bounds each symbolic request to a local frontier rather than asking for a trace from reset (Sections 3.3-3.4, Equation 4 and Figure 8, pp. 9-10; Section 5.1, p. 17).
- For each source-destination pair, concrete execution supplies the prefix and start-state snapshot; symbolic execution solves a suffix of instructions from source to destination. The final program concatenates the fuzzer-generated prefix through the source instruction with the symbolic suffix, adds it to the shared corpus, and resumes fuzzing (Section 3.5, Equation 5 and Figures 7-8, pp. 10-11).
- Algorithm 1 repeats fuzzing, plateau detection, context mapping, source/destination extraction, and local symbolic solving until a coverage goal is reached. These choices reduce symbolic state space, but the pseudocode supplies no global time limit, termination rule for an unattainable goal, or fallback when every local destination is unsatisfiable (Section 3.6, Algorithm 1, p. 12).

### Goal, output, and verification contract

- The output is a concrete program/test set intended to meet a requested branch or toggle coverage goal. Symbolic execution is used only as a test generator; coverage is evaluated on concrete hardware simulation. The authors argue that an incorrect or unhelpful symbolic result can at worst add no coverage, which separates measured coverage validity from the correctness of the symbolic encoding (Section 5.1, p. 15).
- That safeguard does not make FuSS a verifier. A successfully replayed sequence witnesses a covered branch or toggled signal under the chosen testbench and simulator. Failure, timeout, a plateau, or residual uncovered logic cannot prove unreachability, absence of bugs, or functional correctness (Sections 3.6 and 5, pp. 12, 15-20).
- The contract depends on Verilator's supported synthesizable-Verilog semantics, the testbench, precompiled seed programs, CFG/context-map fidelity, snapshot completeness, `W`, `theta`, `N`, solver/time policies inherited from angr/Z3, and the selected coverage metric. The paper claims compatibility with any cycle-accurate compiled simulator but evaluates only Verilator (Section 5.1, pp. 15-17).

### Theoretical claim and its bounds

- Section 4 defines success as activating a hard-to-activate case after a plateau and introduces average per-iteration probabilities for traditional fuzzing (`P_f`), fuzzing plus property checking (`P_f+p`), and FuSS (`P_f+s`). It models total successful discoveries `X` over `T` iterations with a Doob martingale and applies Azuma-Hoeffding under a unit bounded-difference assumption (Section 4.1-4.2, Equations 6-8, pp. 14-15).
- Substituting `E[X]=T P_i` yields the stated sufficient iteration bound `T >= 2 ln(1/epsilon)/(delta^2 P_i^2)`. FuSS needs fewer iterations only conditional on `P_f+s > P_f+p > P_f`; that ordering is assumed in the comparison and then estimated in one benchmark experiment rather than proved from the algorithm (Section 4.2, Equation 8, p. 15).
- The empirical check samples 1,000 unexplored PicoRV/PicoSoC nodes after a plateau. At 1/2/5/10/15 hours, reported activation proportions are 0.01/0.09/0.12/0.12/0.12 for fuzzing, 0.14/0.19/0.24/0.31/0.43 with property checking, and 0.42/0.51/0.67/0.73/0.81 for FuSS (Section 5.2, Table 1, p. 17).
- The analysis is a concentration bound in a count of fuzzing iterations, not an end-to-end wall-time bound including context mapping, symbolic execution, or solver failures. It does not establish the abstract and conclusion's unconditional claim that FuSS will "always" reach a coverage goal faster across designs (Abstract; Sections 4.2, 5.2, and 6, pp. 1, 15, 17, 21).

### Evaluation design and results

- The experimental systems are four open RISC-V Verilog SoCs: PicoSoC, UeRVSoC, VeeRwolf, and CVA6. FuSS uses Verilator, angr/VEX/Claripy/Z3, a modified DifuzzRTL fuzzer, and EBMC to reproduce fuzzing with property checking. Runs use Ubuntu 22.04 on an Intel i7-9700 at 3.0 GHz with 32 GiB RAM and an RTX 3090 (Section 5.1, pp. 15, 17).
- Figure 10 compares branch-coverage trajectories over 600 minutes. Traditional fuzzing plateaus around 70%-85% depending on the SoC, property-assisted fuzzing around 88%-93%, and FuSS reaches approximately 96%-100%; the prose summarizes the result as close to 100% within ten hours (Section 5.3, Figure 10, pp. 16-17).
- Figure 11 gives toggle-coverage trajectories over the same 600 minutes. Traditional fuzzing ends around 40%-55%, property-assisted fuzzing around 58%-70%, and FuSS around 79%-91%. The prose summarizes traditional fuzzing near a 40% plateau, property checking below 70%, and FuSS up to 90% (Section 5.4, Figure 11, pp. 18-19).
- VCD inspection attributes FuSS-only toggle gains to protocol-heavy interfaces (AXI4 variants, UART, SPI, I2C) and to buffers/memory structures (FIFO, caches, register files, CVA6 physical-memory protection, and a VeeRwolf AXI-connected memory). The explanation is qualitative: these regions require initialization sequences, handshakes, timing, and state dependencies that local symbolic suffixes can solve (Section 5.5, Figures 12-13, pp. 19-20).
- The paper reports coverage curves and one probability table, but no exact final coverage table by design, per-run test/solver counts, resource use, failures/timeouts, defect discoveries, repetition count, random seeds, error bands, or statistical tests. No ablation isolates plateau detection, context mapping, snapshots, or the `N=2` frontier (Section 5, pp. 15-20).

## Bearing on RQs

- **RQ1 - Vocabulary and lineage:** FuSS calls its formal component *selective symbolic execution* because it starts from a fuzzer-reached internal state and solves only a nearby suffix. It is a hybrid method: coverage-guided fuzzing supplies most behaviors and symbolic execution is invoked at plateaus, in explicit contrast to property-checking assistance from reset (Sections 1.1-1.2 and 3, Figures 2 and 5, pp. 2-3, 7-12).
- **RQ2 - Executed artifact:** The design is Verilog RTL compiled with its clock/reset testbench to a cycle-accurate Verilator model, then lifted into VEX by angr. Concrete simulator snapshots carry the clocked concurrent state into symbolic execution (Sections 3.1, 3.3, 3.5, and 5.1, pp. 7-15).
- **RQ3 - Alternatives and scaling:** Concrete alternatives live in the fuzzing corpus; symbolic alternatives are local path constraints between selected CFG source/destination pairs. Plateau-triggered invocation, reuse of the fuzzing prefix/state, and `N=2` destinations limit symbolic growth and return new suffixes to the corpus (Sections 3.2-3.6, pp. 8-12).
- **RQ4 - Verification contract:** Outputs are replayed concrete instruction sequences and measured branch/toggle coverage. There is no property proof or exhaustive result; all claims are conditioned on the compiled model, harness, snapshot/context mapping, local frontier, and runtime/search parameters (Sections 3.6 and 5.1, pp. 12, 15-17).
- **RQ5 - Evidence:** Four substantial RISC-V SoCs, two coverage metrics, 10-hour trajectories, an EBMC-assisted baseline, and a 1,000-node probability experiment provide broader scale than the earlier RTL/SystemC studies. Missing exact tables, repeated trials, costs, defects, ablations, and artifacts sharply limit quantitative reproducibility (Section 5, Figures 10-13 and Table 1, pp. 15-20).

## Evidence limits

- The version read is the author-hosted 24-page ACM manuscript dated 2025. Its internal citation still says volume/article `00/000` and carries a placeholder DOI `000000.0000000`. Canonical publisher metadata assigns DOI 10.1145/3760529 and ACM Transactions on Embedded Computing Systems 24(5s), pages 1-24; page anchors here refer to the author-hosted manuscript.
- The paper says it inherits angr/Z3 soundness because those components are unmodified, but it does not prove Verilog-to-Verilator/VEX equivalence, CFG-hook fidelity, or completeness of the internal-state snapshot. Concrete replay validates coverage of successful tests, not the soundness or completeness of missed symbolic paths.
- The Doob/Azuma argument assumes a unit martingale difference and substitutes a single average success probability despite feedback-dependent iterations. More importantly, the ordering of method probabilities is empirical and design-specific, and an iteration bound omits symbolic-solver and mapping time. The unconditional "always faster" language is therefore not supported as a general theorem.
- The 1,000-node probability experiment names PicoRV SoC, whereas the four-design setup names PicoSoC; the version read does not resolve whether these labels denote the same configuration. Sampling, independence, repeated runs, and uncertainty are not described.
- Figures 10-11 visually support approximate coverage trends but do not publish exact design-level endpoints or variability. The baselines use a modified DifuzzRTL and an EBMC construction whose configuration and integration are insufficiently specified for independent reconstruction.
- Coverage is the only outcome: no bugs, false positives, semantic oracles, solver-query/time distributions, or memory costs are reported. Claims that unexplored areas correspond to interfaces and memory are based on VCD inspection without counts by region.
- Algorithm 1 has no explicit total timeout or rule for an unreachable coverage goal. The paper does not evaluate sensitivity to `W=10`, `theta=0.05`, or `N=2`, so both termination and scaling remain tied to unexamined parameter choices.
