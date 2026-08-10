---
citekey: lyu2021scalable
work:
  title: Scalable Concolic Testing of RTL Models
  author: Yangdi Lyu; Prabhat Mishra
  venue: IEEE Transactions on Computers 70(7), 979-991
  date: 2021
  doi: 10.1109/TC.2020.2997644
read: full-text
source: https://www.cise.ufl.edu/research/cad/Publications/tc20test.pdf
facets: "relation: core; artifact: rtl; execution: concolic; goal: test-coverage; evidence: experiment"
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol (survey deep-read pipeline)
notes-date: 2026-08-10
synthesis: Contribution-aware CFG edges and multi-target reuse turn RTL concolic testing into a bounded directed-search procedure that is much cheaper than the reported EBMC and uniform-search baselines on selected rare branches, but remains heuristic witness generation rather than exhaustive verification.
---

# Scalable Concolic Testing of RTL Models

## Evidence

### Executed artifact and hardware semantics

- The framework accepts an RTL model and a set of hard-to-activate branch targets, flattens hierarchy with `flattenverilog`, parses the result through the Icarus Verilog Target API, and instruments every basic block with a unique print marker. A generated testbench drives candidate inputs; simulation emits the executed block trace, which is reconstructed into a multi-cycle path for symbolic constraint generation (Sections III-IV.A and VI.A, Figures 2-4, pp. 2-5, 9).
- Instrumentation is only a search aid. A generated test is replayed on the original, non-instrumented RTL to confirm that it covers the requested branch. This gives the successful result a concrete RTL-simulation witness even though path guidance is computed on a modified model (Section III.B and Section IV.A, pp. 3-4).
- Hardware concurrency and clocked state appear as multiple RTL CFGs observed over a bounded sequence of cycles. The trace representation groups blocks by clock cycle, and state is modeled as a snapshot of all registers and wires with fresh subscripts when assignments execute. The paper does not give an RTL operational semantics; fidelity depends on flattening, Icarus parsing/simulation, trace reconstruction, and the generated harness (Sections II.B and IV.A-C, especially Definition 4.2, pp. 2-7).

### Contribution-aware target structure

- For a target block with expanded guard `g`, Algorithm 1 considers each block containing an assignment to a variable in `g`. A block contributes when there exists a global state `s` for which `g(s)` is false but executing all assignments in the block makes `g` true. The SMT check is therefore performed at block granularity with all same-block assignments, not assignment-by-assignment (Section IV.B, Definition 4.1 and Algorithm 1, pp. 5-6).
- This contribution condition removes satisfiable-but-counterproductive edges admitted by the 2018 method. In the worked `a > b` example, `a := a+1` and `b := b-1` contribute, whereas `a := a-1`, `b := b+1`, and a reset block assigning both values do not. Table I records the corresponding SAT/UNSAT queries, and Figure 4 contrasts two useful edges with the naive method's five edges (Section IV.B, Figure 4 and Table I, pp. 5-6).
- Edges are recursively realigned from target to contributing blocks. A breadth-first predecessor traversal then assigns block distance to the target. The distance of a complete multi-cycle path is the minimum distance of any block on it, so distance ranks whether a trace has visited a locally contributing region rather than measuring the remaining number of cycles or solver cost (Section IV.C, Definition 4.2 and Figure 5, pp. 6-7).

### Where alternatives live and how growth is controlled

- Concolic alternatives are separate feasible paths. For the current concrete path, the engine enumerates branch alternatives after a locked clock prefix, builds the corresponding constraint vector, filters unsatisfiable choices, sorts valid alternatives by target distance and cycle, randomly selects among the best ties, solves, and simulates the returned test (Section IV.D, Algorithm 2, pp. 7-8).
- Locking the prefix at the chosen branch's clock preserves a promising earlier choice while exploring later cycles. If the locked clock reaches the unroll bound without success, the method resets the lock and increments the distance of every block on the current path. This dynamic update eventually lowers the relative priority of other blocks, balancing exploitation of the static heuristic with exploration after repeated failure (Section IV.D.1, Algorithm 2, pp. 7-8).
- Static target pruning uses dominance: when a deeper target is reachable, a generated path must also cover its target-dominator. Rather than irreversibly delete dominators, targets are topologically ordered deepest first and covered targets are removed dynamically. A round-robin schedule gives a target 20 concolic iterations per round before returning it to the queue, allowing paths for other targets to cover it or produce a better starting path (Section V.A, Figures 6-7, pp. 8-9; Section VI.B, p. 10).
- Target clustering reuses all simulated paths. Each target retains the trace with minimum distance as its closest path; targets sharing a closest path form a dynamic cluster. Later single-target search begins from that retained trace instead of a new random path, reducing repeated traversal of common prefixes and cross-module setup (Section V.B, Figure 7, p. 9).

### Goal, output, and verification contract

- The output is a compact set of directed concrete tests intended to cover selected rare RTL branches. The authors also state that assertions can enter after conversion to equivalent branch targets, but assertion translation is not evaluated in this paper (Section III.A, p. 3).
- A successful test is validated by concrete simulation of the original RTL. The framework does not prove a property or exhaust the bounded state space: Algorithm 2 terminates a target after a search limit, and the experiments select a finite unroll depth. A miss can mean an unreachable target, insufficient depth, unlucky randomized choices, an inaccurate distance heuristic, or an exhausted per-target budget (Sections III.B, IV.D, and VI.B, pp. 3, 7-10).
- The bound is chosen like a BMC bound and can be increased iteratively. The reported contract is therefore target activation under a particular reset/harness, RTL toolchain, cycle depth, and search schedule. Only a replayed successful witness is conclusive (Section VI.B, p. 10).

### Evaluation design and results

- Experiments use an Intel Xeon E5-2698 at 2.20 GHz, Icarus tooling, `flattenverilog`, and Yices. Eight benchmarks cover ITC'99 (`b10`, `b14`), OpenCores (`ICache`, `DCache`, `Exception`, `usb_phy`), and TrustHub AES Trojans (`T1100`, `T2000`) (Section VI.A-B, pp. 9-10).
- Each benchmark is first run with one million random tests; the 20 rarest branches become targets. Each Trojan design's set includes five Trojan-area branches. One AES-T2000 branch that needs 2^127 cycles is deliberately omitted. Cycle bounds are selected so the retained hard branches can be covered and are also used as EBMC bounds (Section VI.B, p. 10).
- Table II compares accumulated coverage, time, and peak memory with EBMC and QUEBS. The proposed method covers all 20 targets on all eight benchmarks. EBMC covers 20 where it finishes but errors on T2000; QUEBS covers only 12 on `usb_phy` and does not finish T1100/T2000 within one week. On the six commonly completed rows, the method averages 33 seconds and 327 MB versus EBMC's 381 seconds and 1,264 MB; the paper reports 69x average/205x maximum time improvement and 7x average/31x maximum memory improvement, omitting failed benchmarks from averages (Section VI.B, Table II, p. 10).
- Results are not uniformly favorable. On `usb_phy`, the method takes 134 seconds and 138 MB, versus EBMC at 3.1 seconds/26 MB and QUEBS at 8.2 seconds/34 MB, although QUEBS reaches only 12 targets. On `b10`, `DCache`, and `Exception`, the proposed memory use slightly exceeds QUEBS. The very large ICache speedup (0.15 seconds versus QUEBS's 4,371 seconds) substantially influences the QUEBS average (Table II, p. 10).
- Temporal scaling on `or1200_ICache` increases the bound from 50 to 250 cycles. EBMC memory rises 48 to 218 MB, while the method varies from 18 to 30 MB; average reduction is 5.3x. Design-size scaling uses custom AES designs with 15-40 rounds, 544k-1,693k flattened lines, and one inserted Trojan target. EBMC rises from 6.4 to 34.3 GB; the method rises 0.9 to 3.0 GB, for 7.1x-11.4x reductions and a 10x reported average (Section VI.C, Tables III-IV and Figures 8-9, p. 11).
- Figure 10 shows that both EBMC and the framework incidentally prune over half the 20 targets on most designs, with the concolic framework consistently pruning at least as many. A worked ablation on the small Listing 1 example shows the naive 2018 realignment selecting five useful or useless blocks 80 times without reaching the target, while contribution-aware realignment selects only the two contributing blocks 11 times and reaches it (Section VI.D-E, Figure 10 and Table V, p. 12).

## Bearing on RQs

- **RQ1 - Vocabulary and lineage:** The authors define concolic testing as interleaved concrete simulation and symbolic execution over one path at a time. The work is a direct refinement of the 2018 target-distance method and a contrast to QUEBS's uniform branch coverage and EBMC's all-path bounded encoding (Sections I-II and IV.B, pp. 1-6).
- **RQ2 - Executed artifact:** The target is flattened RTL parsed with Icarus tooling, instrumented, and exercised through a generated testbench; successful tests are replayed on original RTL. Multi-cycle traces group basic blocks by cycle, while concrete simulator behavior supplies concurrency semantics (Sections III-IV and VI.A, pp. 3-9).
- **RQ3 - Alternatives and scaling:** Alternatives are whole, independently solved concolic paths. Contribution-aware realignment, target distance, prefix locking, dynamic distance updates, round-robin budgets, target pruning, and closest-path clustering reduce bad paths and overlapping work rather than merging symbolic states (Sections IV-V, Algorithms 1-2, pp. 5-9).
- **RQ4 - Verification contract:** The witness is a concrete test that covers a branch in original-RTL simulation. Cycle and search limits bound the attempt; no failed attempt proves unreachability, and no coverage result is an exhaustive safety proof (Sections III.B, IV.D, VI.B, pp. 3, 7-10).
- **RQ5 - Evidence:** The paper provides target counts, selected bounds, flattened sizes, time, memory, coverage, synthetic scaling series, a target-pruning comparison, and a small edge-realignment ablation. It omits randomized-run dispersion, solver-query distributions, defect yield, and a released replication package (Section VI, Tables II-V and Figures 8-10, pp. 9-12).

## Evidence limits

- The supplied author-hosted text is the 13-page IEEE Transactions on Computers article, volume 70 issue 7, DOI 10.1109/TC.2020.2997644.
- Target selection and bound selection are retrospective: 20 rare branches are chosen after one million random tests, bounds are chosen so retained targets can be covered, and a known 2^127-cycle Trojan branch is omitted. Results do not establish a general procedure for sufficient bounds or all rare behaviors.
- The contribution predicate is existential over an unconstrained global state and checks one block locally. It ranks potentially useful assignments but does not prove that the state is reachable or that a sequence of contributing blocks can be composed into a target-reaching trace; dynamic updates compensate heuristically.
- Random choice among equally ranked branches is acknowledged as a source of memory variation, yet the paper gives no seeds, repetition count, variance, or confidence intervals. The one-week QUEBS timeout and EBMC error affect which systems enter the reported averages.
- Flattened line counts in the custom AES series reflect repeated synthesized structure rather than independent real-world design diversity. The 29,140x QUEBS speedup is a single ICache point and should not be generalized independently of its 50-cycle bound and baseline behavior.
- The target-pruning and edge-realignment analyses do not isolate clustering, prefix locking, dynamic distance updates, or preprocessing costs on the full benchmark suite. No bugs are reported, and the public paper does not identify a code/data artifact sufficient to reproduce the runs.
