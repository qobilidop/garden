---
citekey: ahmed2018directed
work:
  title: Directed Test Generation using Concolic Testing on RTL models
  author: Alif Ahmed; Farimah Farahmandi; Prabhat Mishra
  venue: 2018 Design, Automation & Test in Europe Conference & Exhibition (DATE)
  date: 2018
  doi: 10.23919/DATE.2018.8342260
read: full-text
source: https://www.cise.ufl.edu/research/cad/Publications/date18.pdf
facets: "relation: core; artifact: rtl; execution: concolic; goal: test-coverage; evidence: experiment"
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol (survey deep-read pipeline)
notes-date: 2026-08-10
synthesis: Target-aware CFG realignment guides one-path-at-a-time RTL concolic execution toward a requested branch, reducing search iterations and bounded-model-checking memory on the reported targets without turning the generated witness into a proof of reachability or unreachability.
---

# Directed Test Generation using Concolic Testing on RTL models

## Evidence

### Executed artifact and hardware semantics

- The input is a Verilog RTL model and a target line or branch. The implementation parses the RTL through the Icarus Verilog Target API, uses Icarus Verilog for concrete execution, and uses Yices for symbolic constraints. The output is an input test vector intended to execute the target (Section II overview and Section IV.A, Figure 1, pp. 1, 5).
- The method constructs a separate CFG for every concurrent RTL process (`always` block in Verilog or process in VHDL). Execution inside one process is treated sequentially. To represent repeated clock cycles without statically copying the CFG, the exit block is connected back to the entry block; the same process structure is thus traversed again at each cycle (Section II.A, Figure 2, pp. 2-3).
- Cross-process data dependence is approximated by edge realignment. The paper defines a *strict variable* as one assigned only concrete values. For the expanded guard of the current target block, Algorithm 1 removes its existing predecessors and uses the solver to find assignments to strict variables that are jointly satisfiable with the guard; the blocks containing those assignments become new predecessors and are recursively analyzed. If no strict variable appears, analysis recurs through the immediate dominator (Section II.B, Algorithm 1 and Figure 3, p. 3).
- Guard expressions are expanded through intermediate assignments before realignment. The authors explicitly decline complete data-flow analysis because that would require state unrolling; the resulting graph is therefore a static, target-specific dependency heuristic rather than a cycle-accurate reachable-state graph (Section III.C, p. 5).

### Where alternatives live and how growth is controlled

- Alternatives remain separate concolic executions. A random input produces one concrete multi-cycle trace. The engine collects branches adjacent to that trace, orders them by the realigned-CFG distance to the target, negates a selected branch, solves the path constraints through that point, and resimulates the returned input. It stops when the target appears in a concrete trace or when no selectable satisfiable alternative remains (Section II.D, Algorithm 3, pp. 3-4).
- Static distance is a breadth-first predecessor distance from the target on the realigned CFG: target distance is zero, unreachable-in-that-graph blocks remain infinity, and lower values receive priority. Equal-distance alternatives earlier in the execution trace are preferred. Each selected branch has its priority decreased so that a greedy search does not exhaust the same low-distance choice at every cycle (Section II.C-D, Algorithms 2-3, Figure 3, pp. 3-4).
- Two dynamic filters reduce redundant solver work. A hash of branch sequences prevents selection of an already traversed path. `is_selectable` also requires that an assignment identified as a precondition has occurred in the appropriate time frame: a blocking assignment may occur in the same or an earlier cycle, while a nonblocking assignment must occur in an earlier cycle (Section III.A and III.D, pp. 4-5).
- The simulator serializes concurrent processes, which can introduce false same-cycle constraint conflicts. Before negating a branch, the method discards clauses from other processes in the same concurrent group and time frame, retaining the selected branch's parent-process clauses. This is an operational scheduling repair used by the generator, not a formal proof that all relevant concurrent constraints are preserved (Section III.B, p. 4-5).
- The central scaling choice is asymmetrical: static target-distance analysis avoids full time-frame unrolling, while each concrete/symbolic attempt contains only the constraints of one chosen execution path. A user still supplies an execution depth (`Unroll Cycles` in the experiments), so temporal reachability beyond that depth remains outside a run (Sections II.A, II.D, and IV, pp. 2-6).

### Goal, output, and verification contract

- The stated problem is line/branch reachability: find a vector that covers one specified RTL statement, for debugging or hard-corner activation, rather than maximize global coverage. A successful result is a concrete witness produced by Yices and observed during Icarus simulation (Introduction and Section II.D, pp. 1, 3-4).
- The algorithm may return `invalid` after exhausting its currently selectable alternatives, and the experiments call a target failed after 2,000 concolic iterations. Neither outcome proves the target unreachable. Success is relative to the RTL parser/simulator semantics, reset and input harness, selected cycle depth, branch-selection heuristic, solver theory, and treatment of concurrent-process clauses (Algorithm 3, p. 4; Section IV.C, p. 6).
- No safety property is discharged and no completeness argument is given. Even the EBMC comparison is bounded at the same chosen unroll depth; the paper supports a test-generation contract, not an unbounded correctness or exhaustive-coverage contract (Sections IV.B-C, Tables I-II, pp. 5-6).

### Evaluation design and results

- Experiments run on an Intel Core i7-6700K with 16 GB RAM. Designs come from ITC'99, OpenCores, and TrustHub. The comparison uses EBMC for bounded model checking, QUEBS for uniform-coverage concolic testing, and a `CFG-Directed` baseline described as a naive RTL extension of a software directed-search heuristic (Section IV.A-C, pp. 5-6).
- Scalability is tested with a custom family of sequentially cascaded OpenCores AES rounds. The final activation condition depends on all intermediate rounds; the cycle bound is at least the number of rounds plus any reset. From `cb_aes_01` to `cb_aes_35`, flattened code grows from 33k to 1,169k lines. EBMC grows from 179.4 MB at 5 cycles to 13,202.8 MB at 25 cycles and then fails on the 16 GB machine; the proposed method grows from 55.3 MB to 2,112.7 MB through 40 cycles (Section IV.B, Table I, p. 5).
- Holding `cb_aes_10` at 334k flattened lines while increasing the bound from 15 to 40 cycles raises EBMC time from 33.17 to 84.57 seconds and memory from 4,130.6 to 10,361.3 MB. The concolic method rises from 14.47 to 19.36 seconds and from 502.4 to 608.0 MB. The paper summarizes these changes as 155%/150.8% for EBMC versus 33.8%/21% for the proposed method (Section IV.B, Table I, p. 5).
- Target-search evaluation uses ITC'99 `b06`, `b10`, and `b14`; OpenCores I2C and OR1200 ICache; and four TrustHub Trojan designs. For the first five designs, a random target is an average over five reachable branches, while a rare target is the least-covered branch after one million random cycles. Trojan triggers are the TrustHub targets (Section IV.C, p. 6).
- Table II reports that the proposed method covers all listed targets within the 2,000-iteration limit, including the two `wb_conmax` Trojan targets where both QUEBS and naive CFG-Directed fail. On cases completed by both directed methods, the authors report a 16.8x average reduction in iterations versus CFG-Directed, excluding failed `wb_conmax` cases. Illustrative entries include `b14` rare at 1 iteration versus 21 for CFG-Directed and 814 for QUEBS, and I2C rare at 40 iterations versus 1,123 for CFG-Directed while QUEBS fails (Section IV.C, Table II, p. 6).

## Bearing on RQs

- **RQ1 - Vocabulary and lineage:** The paper uses the standard concolic account: concrete simulation supplies a trace and symbolic constraint solving negates a branch to obtain the next test. Its novelty claim is directed, target-specific hardware concolic testing, as distinct from prior RTL methods designed for uniform coverage (Introduction; Section V, pp. 1, 6).
- **RQ2 - Executed artifact:** Verilog RTL is directly parsed and simulated. Each RTL process has a CFG, clocked repetition is a loop from exit to entry, and cross-process effects are represented by target-specific realigned edges plus same-cycle clause filtering (Section II.A-B and Section III.B, pp. 2-5).
- **RQ3 - Alternatives and scaling:** Alternative behaviors are whole path-conditioned executions, not merged symbolic states. Static distance, greedy branch selection with priority decay, visited-path hashing, precondition checks, and one-path-at-a-time solving control growth; the cycle bound still limits temporal depth (Algorithms 1-3, pp. 3-5).
- **RQ4 - Verification contract:** The result is a directed concrete input witness observed to hit a line or branch. Failure under 2,000 iterations or a chosen cycle bound is inconclusive, and the method makes no proof claim (Section II.D; Section IV.C, pp. 3-4, 6).
- **RQ5 - Evidence:** The paper reports wall time, memory, iteration count, cycle bounds, and flattened-line counts against three approaches. The AES scalability series is synthetic, random targets average only five selections, and no defect yield, repeated-run variance, solver-query count, or released artifact is reported (Section IV, Tables I-II, pp. 5-6).

## Evidence limits

- The six-page author-hosted version corresponds to the DATE 2018 proceedings paper at DOI 10.23919/DATE.2018.8342260.
- The method's graph realignment is based on satisfiability of a guard with an assignment and a restricted class of strict variables; it is not a complete reachable-state dependency analysis. The later Lyu-Mishra paper explicitly motivates a stronger block-level contribution test, so this note does not treat every realigned edge as semantically necessary or useful.
- The same-cycle removal of constraints from other concurrent processes is presented through one simulator-ordering example. The paper supplies no equivalence proof or systematic evaluation of that rule across event schedules, multiple clocks, or general Verilog features.
- Bounds are chosen so the selected targets can be reached, and a target missed after 2,000 iterations is only an experimental failure. The experiments therefore cannot establish completeness, unreachability, or a generally sufficient cycle bound.
- The AES scale study grows a custom cascade and reports flattened line counts; it does not establish the same trend on structurally diverse million-line RTL designs. EBMC's out-of-memory results are specific to the 16 GB host and the chosen encodings.
- Randomized initial vectors and target selections are not accompanied by trial counts, seeds, confidence intervals, or dispersion. The paper reports no independently replayed artifact package, defect discoveries, or comparison of generated-test semantic validity outside the Icarus-based workflow.
