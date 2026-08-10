---
citekey: debnath2022greycone
work:
  title: "GreyConE: Greybox fuzzing+Concolic execution guided test generation for high level design"
  author: Mukta Debnath; Animesh Basak Chowdhury; Debasri Saha; Susmita Sur-Kolay
  venue: 2022 IEEE International Test Conference (ITC), 494-498
  date: 2022
  doi: 10.1109/ITC50671.2022.00059
  arxiv: 2205.04047
read: full-text
source: https://arxiv.org/abs/2205.04047v3
facets: "relation: core; artifact: systemc-tlm; execution: hybrid; goal: test-coverage; evidence: experiment"
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol (survey deep-read pipeline)
notes-date: 2026-08-10
synthesis: GreyConE alternates AFL and S2E so fuzzing supplies concrete SystemC paths and concolic solving attacks stalled branch pairs, improving two-hour branch coverage on several small benchmarks while retaining heuristic timeouts and no proof contract.
---

# GreyConE: Greybox fuzzing+Concolic execution guided test generation for high level design

## Evidence

### Executed artifact and semantics

- GreyConE targets high-level SystemC hardware designs. It compiles the design to LLVM bitcode, adds a marker at each IR basic block, and produces an instrumented executable shared by AFL and S2E. The executed object is therefore a compiled software representation of the SystemC design, not RTL or a gate netlist (Sections I and III.A, Figure 2, pp. i, iii).
- The paper characterizes the source SystemC models as cycle-accurate behavioral hardware and emphasizes complex branches, loops, and inherent concurrency. It does not formalize how SystemC scheduling, time, or concurrent processes map through LLVM/QEMU; those semantics are delegated to the compiled executable and its harness (Introduction and Section III.A-C, pp. i-iii).
- S2E combines a QEMU virtual machine with KLEE. Inputs selected through `s2e_make_symbolic()` are symbolic, while concrete seeds execute the instrumented DUT and populate an execution tree. For each uncovered branch pair, S2E constructs the path predicate, forks a state, invokes its solver, and returns a concrete test (Section III.C, Algorithm 2, p. iii).

### Where alternatives live and how growth is controlled

- AFL's alternatives live in a queue of concrete tests. Deterministic/havoc mutation and crossover generate candidates; branch-pair coverage and hit-count novelty decide which inputs are "interesting" and retained. AFL assigns more mutation energy to seeds with faster execution, broader coverage, or deeper penetration (Section II.B and Section III.B, Algorithm 1, pp. i-ii).
- S2E retains separate path-conditioned states in an execution tree and uses depth-first symbolic exploration for uncovered conditions. GreyConE does not merge those states; it limits their use by handing S2E fuzz-generated seeds and by switching engines after periods without progress (Sections III.C-D, Algorithm 2 and Figure 2, p. iii).
- The interleaving loop begins with fuzzing. If AFL has not improved coverage for `time_threshold_f`, GreyConE transfers its retained tests to S2E. If S2E has not generated a test for `time_threshold_c`, its tests return to AFL for mutation. The whole run stops at a target coverage or `time_cutoff` (Section III.D, Figure 2, p. iii).
- In the experiment, `time_threshold_f` is 5 seconds, `time_threshold_c` is 10 seconds, and the overall cutoff is two hours; first-seed generation time is excluded. These timeouts are the principal scaling controls. They bound exposure to path explosion but can also interrupt a symbolic attempt before a difficult satisfiable condition is solved (Section IV.C, p. iv).

### Goal, output, and verification contract

- The goal is a retained set of concrete test cases that increases branch-pair/basic-block coverage of the compiled SystemC design. Table I reports cumulative tests, coverage, and time by fuzz/concolic phase; tests from each engine seed the other (Sections III-IV, Algorithms 1-2 and Table I, pp. ii-iv).
- GreyConE is a coverage-directed test generator, not a safety prover. Reaching a branch provides a concrete witness in the instrumented executable; failing before an engine timeout or the two-hour cutoff provides no unreachability result. The paper reports no assertion oracle or detected defect count (Sections III.D and V, pp. iii-v).
- The authors call the remaining branches in AES, FFT-fixed, Filter-FIR, and UART unreachable and say this was independently validated, but they do not identify the checker, model, bound, or proof artifact. That sentence cannot support a reproducible completeness claim for the achieved "maximum possible coverage" (Section V.1, p. iv).

### Evaluation design and results

- The prototype uses AFL 2.52b and S2E, with lcov 1.13 and gcov 7.5.0 cross-checking coverage, on a 3.20 GHz Intel i5 Linux machine with 16 GB RAM. Eleven open SystemC designs come from SCBench and S2CBench: ADPCM, AES, FFT-fixed, IDCT, MD5C, Filter-FIR, Interpolation, Decimation, Kasumi, UART, and Quick-sort, spanning 160-467 source lines (Section IV.A-B, p. iv).
- Baselines are AFL with default settings and random initial seeds, and S2E with default settings and random concrete seeds. Since SESC and CTSC implementations were unavailable, the authors adapted S2E to SystemC with unspecified "necessary changes." All three methods run up to two hours (Section IV.C and Section V, p. iv).
- Phase results show the intended handoff. ADPCM rises from 93.3% with 5 fuzz tests in 9 seconds to 100% after 6 concolic tests and 39 more seconds. AES rises 79.2% -> 83.3% -> 91.7% over fuzz/concolic/fuzz phases with 3, 4, and 4 tests. MD5C rises 87.5% -> 90.6% -> 100% with 5, 3, and 2 tests. For Interpolation and Quick-sort, the first fuzzing phase reaches 100%, so concolic execution is not invoked (Table I, p. iv).
- Against the two-hour baselines, GreyConE obtains 100% branch coverage on ADPCM, IDCT, MD5C, Interpolation, Decimation, Kasumi, and Quick-sort; 96.9% on FFT-fixed; 93.8% on Filter-FIR; 91.7% on AES; and 88.5% on UART. The authors summarize gains as 3%-25.9% over AFL and 2.8%-30% over S2E on cases with room to improve (Section V.1, Table II and Figures 3-4, pp. iv-v).
- Concrete examples show both wins and tradeoffs. IDCT reaches 100% with 199 GreyConE tests in 229 seconds, versus AFL's 74.1%/110 tests/29 seconds and S2E's 84.2%/146 tests/422 seconds. MD5C reaches 100% with 10 tests in 50 seconds, versus 90.6%/11/1,329 for AFL and 70%/45/1,214 for S2E. UART reaches the best 88.5% with 21 tests but takes 718 seconds, slower than AFL's 334 seconds though faster than S2E's 730 seconds (Table II, p. iv).
- Test-set size is not uniformly smallest: GreyConE retains fewer tests than both baselines on ADPCM, AES, FFT-fixed, MD5C, Kasumi, and equal-to-smallest on Interpolation and Quick-sort, but uses 199 tests on IDCT versus 110 for AFL/146 for S2E and 21 on UART versus AFL's 4. Figure 4 provides coverage-over-time curves, not repeated-run distributions (Table II and Figure 4, pp. iv-v).

## Bearing on RQs

- **RQ1 - Vocabulary and lineage:** The paper explicitly distinguishes full symbolic execution (fork all conditions), concolic execution (concrete path plus symbolic alternatives), and greybox fuzzing. GreyConE is hybrid because fuzzing and concolic execution are co-equal alternating engines rather than one merely initializing the other (Sections II-III, pp. ii-iii).
- **RQ2 - Executed artifact:** SystemC high-level hardware is compiled through LLVM to an instrumented executable and run under AFL/QEMU/S2E. The source's concurrency and cycle accuracy are claimed, but their preservation in the executable is assumed rather than specified (Introduction; Sections III.A-C, pp. i-iii).
- **RQ3 - Alternatives and scaling:** AFL stores concrete corpus variants; S2E stores separate path states and predicates. Coverage-stall timeouts move work between them, letting fuzzing cheaply cover easy paths and reserving symbolic solving for uncovered branch pairs (Figure 2 and Section III.D, p. iii).
- **RQ4 - Verification contract:** The output is a concrete coverage-increasing test set subject to engine-stall and total-time cutoffs. A reached branch is witnessed; an unreached branch is inconclusive. No safety, functional equivalence, or exhaustive coverage guarantee is provided (Sections III.D-V, pp. iii-v).
- **RQ5 - Evidence:** The evaluation includes 11 small open SystemC benchmarks, per-phase tests/time/coverage, two open-engine baselines, and complete two-hour coverage curves for eight designs. It omits repeated runs, seed control, confidence intervals, defects, solver statistics, and enough adaptation detail to reproduce the S2E baseline (Section IV-V, Tables I-II and Figure 4, pp. iv-v).

## Evidence limits

- The full text read is arXiv:2205.04047v3, dated 13 July 2022, whose arXiv record says it was accepted at ITC 2022. The published proceedings DOI is 10.1109/ITC50671.2022.00059; this note's page anchors refer to the five-page arXiv version, not an IEEE-rendered copy.
- Benchmark sizes are 160-467 source lines. Results support behavior on this small SystemC suite, not the conclusion's broader "scalable" characterization for large HLS, RTL, or gate-level designs; extending to RTL/gates is explicitly future work (Sections IV.B and VI, pp. iv-v).
- Fuzzing is randomized, but the paper reports one curve/table per method with no seeds, repetitions, variance, or statistical tests. Default AFL/S2E settings and randomly generated initial seeds do not establish controlled equivalence of search budgets.
- The S2E SystemC adaptation is not described beyond "necessary changes," and no GreyConE source or experimental artifact is linked. First-seed generation time is excluded, and the solver configuration and symbolic-input domains are not reported.
- Higher branch coverage is treated as a proxy for a greater chance of finding bugs, but no bugs or semantic oracles are evaluated. The independent reachability check used to label residual branches unreachable is unspecified.
- The authors' statement that GreyConE needs fewer tests than both baselines has table-level exceptions (notably IDCT and UART) and should be limited to the benchmarks where Table II actually shows that relationship.
