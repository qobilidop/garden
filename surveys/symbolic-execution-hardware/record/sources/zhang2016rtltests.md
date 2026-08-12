---
citekey: zhang2016rtltests
work:
  title: Automatic Generation of High-Coverage Tests for RTL Designs using Software Techniques and Tools
  author: Yu Zhang; Wenlong Feng; Mengxing Huang
  venue: 2016 IEEE 11th Conference on Industrial Electronics and Applications (ICIEA)
  date: 2016
  doi: 10.1109/ICIEA.2016.7603701
  arxiv: 1602.06038
read: full-text
source: https://arxiv.org/abs/1602.06038
facets: "relation: core; artifact: rtl; execution: classical; goal: test-coverage; evidence: case-study"
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol (survey deep-read pipeline)
notes-date: 2026-08-10
synthesis: SE4RDV reuses Verilator and a bit-width-aware KLEE variant to generate bounded-cycle RTL tests, but its evidence is a single coverage case study rather than a proof or comparative evaluation.
---

# Automatic Generation of High-Coverage Tests for RTL Designs using Software Techniques and Tools

## Evidence

### Executed artifact and semantics

- SE4RDV translates a Verilog RTL design into C++ with Verilator, then symbolically executes the generated program rather than the source RTL directly. The paper identifies the generated model's ports and `eval()` function as the relevant interface; the harness assigns inputs and invokes `eval()`, which the generated code describes as being called once per cycle (Section III.C-D, Figures 4-5, pp. 3-4).
- A generated C++ harness plays the role of an RTL testbench: it chooses which inputs are symbolic and how many design evaluations occur. The symbolic test cases are subsequently applied to the original RTL in ModelSim, so reported coverage comes from concrete RTL simulation rather than from the translated C++ model (Section III.A and III.D, Figure 3, p. 3; Section IV.B, p. 5).
- KLEE is modified to handle C++ features and arbitrary bit-width symbolic variables. The motivating one-bit `sel` example shows why byte-level symbolic input is not a faithful substitute: unmodified handling produces `0x00` and `0xff`, whereas the added bit-width argument produces the RTL-domain values 0 and 1 (Section III.E, Figure 5, p. 4).

### Alternatives and scaling mechanism

- Alternatives live as separate paths and path conditions in the generated C++ program. The paper's software example illustrates the standard fork-at-branch account: four combinations of two conditions become four paths and yield a satisfying concrete input for each path (Section II.B, Figures 1-2, p. 2).
- Temporal growth is controlled by bounding the number of cycles encoded by the harness. The bound is presented as guidance for test generation, not as a completeness threshold, and the paper gives no path-merging, compositional, caching, or hardware-specific search algorithm beyond the bound and the bit-level KLEE extension (Introduction, pp. 1-2; Section III.D, pp. 3-4). Eliminating redundant generated tests is explicitly left to future work (Section V, p. 5).
- Clocked state and concurrency are inherited from Verilator's generated `eval()` semantics and the harness's sequence of calls. The paper does not formalize the translation or explain scheduling of concurrent RTL processes; its worked MUX example is combinational (Section III.B-E, Figures 4-5, pp. 3-4).

### Goal, output, and verification contract

- The goal is automatic high-coverage validation input generation. Outputs are concrete tests (and, for sequential use, test-vector sequences) obtained from satisfying symbolic paths, then replayed against RTL for statement and branch coverage (Section III.A, p. 3; Section IV.B, p. 5).
- The result is not a safety proof. It establishes only the measured RTL simulation coverage of generated tests for the selected harness and cycle limit. Any connection between a C++ path and an RTL behavior depends on Verilator's translation, the modified KLEE semantics, and the harness; no translation-equivalence theorem, coverage-completeness theorem, or bug-finding claim is supplied (Sections III-IV, pp. 3-5).

### Evaluation

- The only evaluated design is an OpenCores double-precision FPU with six named modules, two 64-bit operands, operation and rounding controls, and a 64-bit result. It supports add, subtract, multiply, and divide and targets IEEE 754 (Section IV.A, Figure 6, p. 4).
- On a 2.5 GHz Intel i5 with 4 GB RAM, repeated runs are said to produce nearly the same counts, but the number of repetitions and dispersion are not reported. Table 1 reports approximately 4,010 tests, 12,060 test vectors, and 17 minutes. Table 2 reports 627 MB (15.3% of memory) and 40% CPU (Section IV.B, Tables 1-2, p. 5).
- RTL replay in ModelSim reports 98.4% statement coverage and 96.8% branch coverage (Section IV.B, Figures 7-8, p. 5). There is no random-testing, directed-testing, prior symbolic RTL, or unmodified-KLEE baseline, and no defect count or analysis of the remaining uncovered code.

## Bearing on RQs

- **RQ1 — Vocabulary and lineage:** This is a clear software-style symbolic-execution transfer: RTL is compiled into C++, and standard path exploration generates concrete tests. It distinguishes this approach from STAR's hybrid symbolic/concrete simulation, HYBRO's solver-guided unrolling, and Qin and Mishra's interleaved concrete/symbolic execution only in related-work prose (Section II.A-B, pp. 2-3).
- **RQ2 — Executed artifact:** The design of interest is Verilog RTL, but the operational artifact is Verilator-generated C++ plus a generated harness. Clock cycles are explicit harness iterations around `eval()`; the treatment of RTL concurrency is delegated to generated-model semantics rather than defined by SE4RDV (Section III, pp. 3-4).
- **RQ3 — Alternatives and scaling:** Alternatives are whole C++ paths with path conditions. A user-selected cycle bound limits temporal explosion; bit-level symbolic inputs align solver domains with arbitrary-width RTL signals. The work offers no more general path-growth control (Sections II.B and III.D-E, pp. 2-4).
- **RQ4 — Verification contract:** The witness is a concrete test/vector sequence replayable in RTL simulation. The reported contract is coverage under a particular harness and cycle bound, not exhaustive reachability or functional correctness (Sections III.A and IV.B, pp. 3, 5).
- **RQ5 — Evidence:** The paper provides wall time, approximate test/vector counts, resource percentages, and two coverage metrics for one FPU. The absence of comparative baselines, multiple designs, exact repetition statistics, defect results, and released prototype details makes the evidence preliminary (Section IV, pp. 4-5).

## Evidence limits

- The supplied full text is the six-page arXiv version corresponding to the 2016 ICIEA paper. The primary text and registrar metadata name Yu Zhang, Wenlong Feng, and Mengxing Huang.
- All performance and coverage numbers are from one OpenCores FPU and are approximate where the paper uses `~`. They cannot support a claim of scalability across RTL designs or superiority to another method.
- The cycle limit, FPU harness, KLEE configuration/search strategy, number of repeated runs, and causes of uncovered statements/branches are not reported in enough detail to reconstruct the experiment from the paper alone.
- RTL replay validates measured coverage, but the paper neither proves the Verilog-to-C++ translation and bit-width modification sound nor establishes that every generated C++ behavior corresponds to an RTL behavior.
