---
citekey: mukherjee2020coverif
work:
  title: Hardware/Software Co-verification Using Path-based Symbolic Execution
  author: Rajdeep Mukherjee; Saurabh Joshi; John O'Leary; Daniel Kroening; Tom Melham
  venue: CoRR
  date: 2020
  arxiv: 2001.01324
read: full-text
source: https://arxiv.org/abs/2001.01324
facets: "relation: core; artifact: mixed-level; execution: classical; goal: functional; evidence: experiment"
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol (survey deep-read pipeline)
notes-date: 2026-08-10
synthesis: COVERIF replaces a monolithic HW/SW bounded formula with property-sliced, eagerly pruned symbolic paths, gaining speed when firmware exercises a small RTL fragment but relying on bounded, producer-consumer sequentialization.
---

# Hardware/Software Co-verification Using Path-based Symbolic Execution

## Evidence

### Executed artifact and semantics

- COVERIF synthesizes Verilog RTL into a cycle-accurate, bit-precise C "software netlist" following synthesis semantics; the model retains word-level structure and module hierarchy. It then sequentially composes that netlist with ANSI-C firmware into a single co-verification model, `M_seq` (Section 3, Steps 1-2, Figures 2-3, pp. 2-3).
- Sequentialization exploits a producer-consumer interaction pattern: firmware configures memory-mapped registers or polls status, and hardware runs at explicit call sites. It avoids enumerating hardware/software thread interleavings, but is an environmental/modeling restriction rather than a reduction valid for arbitrary concurrent co-designs (Section 3, Step 2, p. 2; Section 7, p. 6).
- All program variables are finite-width bit-vectors. A symbolic state is a quantifier-free predicate over program variables paired with the next statement; statements transform that state. Assumptions restrict reachable states, branches fork feasible successors, and a depth-first worklist explores the resulting paths (Section 3, Algorithm 1 and surrounding text, pp. 3-4).
- Co-design properties and scenarios are written as C `assert` and `assume` conditions. Temporal SVA delays are encoded by calls to the top-level software-netlist function, making clock advance part of the C model/harness (Section 5, Figures 4-5, p. 4).

### Where alternatives live and how growth is controlled

- Alternative behaviors remain separate path-conditioned symbolic states in the worklist. This contrasts with HW-CBMC, which symbolically processes hardware and software separately and joins them in one monolithic CNF formula at the solver (Sections 3-4, Algorithm 1, pp. 3-4).
- Three mechanisms suppress irrelevant work: a syntactic backward slice from the property removes unrelated program fragments; feasibility queries at every `assume` and branch prune infeasible states eagerly; and one incremental SAT instance is extended by only the new path segment while descending a path. A new solver instance is used when exploring a different path (Section 3, Steps 4-5, pp. 3-4).
- The paper attributes the method's advantage to scenarios in which firmware exercises only a fragment of hardware. It states that plain forward symbolic execution without these optimizations timed out on every benchmark, making the combination—not path execution alone—the evaluated scaling mechanism (Section 6.2, p. 6).

### Goal, outputs, and verification contract

- Algorithm 1 returns `Safe`, or `Unsafe` with a counterexample, for assertions in (M_{seq}). A violated assertion is detected by satisfiability of the current path state conjoined with the negated assertion; if every bounded path is discharged, the model is reported safe (Section 3, Algorithm 1, pp. 3-4).
- These are bounded safety results. Firmware loop-unroll bounds range from 20 to 1,300 in the reported experiments, and scenario assumptions restrict the environment. The guarantee is therefore relative to the RTL-to-C synthesis, the sequentialized producer-consumer model, property slice, assumptions, and selected bounds—not an unbounded proof of the original concurrent co-design (Sections 3, 5, and 6, especially Tables 2-3, pp. 2-6).

### Evaluation design and results

- The comparison holds the backend constant: both COVERIF and the monolithic HW-CBMC use MiniSAT 2.2.0 on a 3.0 GHz Intel Xeon with 48 GB RAM and a two-hour timeout. The authors report only bit-level HW-CBMC because its word- and bit-level performance were similar (Section 6, p. 4).
- The UART comprises 1,200 Verilog lines, 356 latches/flip-flops, 413 gates, and 528 firmware lines; the SoC comprises 3,567 Verilog lines, 840 latches/flip-flops, 945 gates, and 734 firmware lines (Table 1, p. 5). The experiments cover transmission, interrupt, and loopback scenarios for the UART and data transfer, AES feedback, XRAM write, and DMA scenarios for the SoC (Sections 6.1-6.2, pp. 5-6).
- For ten representative UART checks, HW-CBMC takes 14.86-443.15 seconds and COVERIF 1.05-62.34 seconds. From 247,104 syntactic paths per scenario, only 224-2,566 are feasible, corresponding to 98.96-99.90% pruning. The paper reports 39 UART properties in total and describes an average 8x speedup for the representative safe and unsafe cases (Table 2 and Section 6.1, p. 5).
- Four representative SoC checks take 86.18, 102.92, 92.63, and 128.63 seconds in HW-CBMC versus 17.42, 56.29, 14.78, and 68.19 seconds in COVERIF. The authors summarize this as about 2x for proving safety and 6x for the unsafe case. They report 19 SoC properties total and one critical control bug in the memory arbiter (Table 3 and Section 6.2, pp. 5-6).
- Across the two designs, the paper summarizes the measured advantage as 5x on average for safe and unsafe checks. The comparison baseline is only HW-CBMC, because the authors found no other automated tool accepting C/C++ and Verilog RTL directly (Sections 6 and 9, pp. 4, 6).

## Bearing on RQs

- **RQ1 — Vocabulary and lineage:** The authors call the operational mechanism "path-based symbolic simulation" and the algorithm "path-based symbolic execution." It is software-style path execution over a C co-verification model, coupled to SAT-based bounded checking; the terminology shows how symbolic execution and BMC overlap without being identical (Abstract; Sections 3-4, pp. 1, 3-4).
- **RQ2 — Executed artifact:** Both firmware and RTL participate symbolically. RTL is compiled into a bit-precise, cycle-accurate C software netlist and sequentially composed with C firmware. Hardware concurrency is represented only through the restricted producer-consumer schedule and explicit top-module calls (Section 3, Figures 2-3, pp. 2-3).
- **RQ3 — Alternatives and scaling:** Alternatives are separate feasible paths. Property slicing limits the code, eager SAT checks remove infeasible forks, and incremental solving reuses path prefixes; the observed pruning ratios directly connect these mechanisms to reduced solver formulas (Section 3, Algorithm 1; Table 2, pp. 3, 5).
- **RQ4 — Verification contract:** Outputs are bounded `Safe` results or concrete counterexamples for C assertions. Bounds, assumptions, translation, and sequentialization qualify every result. True HW/SW concurrency lies outside the method's stated applicability (Sections 5-7, pp. 4-6).
- **RQ5 — Evidence:** The evaluation compares against a same-solver monolithic baseline on two co-designs, publishes design sizes, bounds, path/pruning counts, runtimes, property totals, and safe/unsafe outcomes, and supplies a benchmark link. It does not isolate the three optimizations in an ablation or report solver-query/memory distributions (Section 6, Tables 1-3, pp. 4-6).

## Evidence limits

- The supplied version is arXiv v1 and appears in DBLP as a 2020 CoRR publication; no peer-reviewed venue or DOI is identified in the primary version.
- Safety is bounded by firmware loop unrolling and constrained by `assume` scenarios. The paper does not provide a completeness bound connecting those loop bounds to the original co-design.
- Sequentialization is explicitly inapplicable when hardware and software exhibit true concurrency rather than a producer-consumer relationship (Section 7, p. 6).
- Only two design families and one baseline are evaluated. The reported 5x, 8x, 2x, and 6x summaries apply to different subsets and should not be merged into a universal speedup claim.
- The paper says several UART bugs were found but does not enumerate them all; only the SoC's one critical control bug is counted explicitly. The public benchmark link is a Google Drive URL in the paper, and this reading did not independently execute the artifacts.
