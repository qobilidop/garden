---
citekey: rudkowski2026crosslevel
work:
  title: Comparing Methods for the Cross-Level Verification of SystemC Peripherals with Symbolic Execution
  author: Karl Aaron Rudkowski; Sallar Ahmadi-Pour; Rolf Drechsler
  venue: IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems
  date: 2026
  doi: 10.1109/TCAD.2025.3641038
  arxiv: 2509.05504
read: full-text
source: https://arxiv.org/abs/2509.05504
facets: "relation: core; artifact: mixed-level; execution: path; goal: equivalence; evidence: experiment"
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol (survey deep-read pipeline)
notes-date: 2026-08-10
synthesis: CrosSym and SEFOS expose the trade between modifying SystemC and modifying KLEE for RTL/TLM peripheral checking, but broad timeouts show that cross-level symbolic execution remains bounded by harnesses, solver cost, and state explosion.
---

# Comparing Methods for the Cross-Level Verification of SystemC Peripherals with Symbolic Execution

## Evidence

### Executed artifacts and semantics

- The workflow accepts SystemC TLM peripherals and SystemC RTL, typically generated from Verilog by Verilator. A C++ testbench declares symbolic inputs, concrete environment values, assumptions, timing, and assertions; it is compiled with the peripheral(s) and SystemC kernel into LLVM IR for symbolic execution. The same framework supports standalone TLM, standalone RTL, and RTL-to-TLM cross-level comparisons (Section IV.A, Figure 1, pp. 3-4).
- CrosSym keeps KLEE unmodified but replaces the SystemC kernel and transforms `SC_THREAD` code. Its kernel implements a selected TLM/RTL subset, including events, static sensitivity, signals/ports, clocks, and evaluation-update-delta cycles. The smaller kernel reduces irrelevant branches and object size, but the kernel and thread transformation differ from the original DUV execution environment (Sections IV.C and V, Table I, pp. 4-5).
- SEFOS instead uses the original SystemC kernel and unmodified peripheral while extending KLEE 3.1. It intercepts the three relevant pthread calls, represents each cooperative SystemC process with its own stack/program counter, and switches saved contexts without creating real parallel threads. On a symbolic fork, each state inherits all process contexts (Section VI.A-B, Figures 2-4, pp. 5-6).
- This concurrency model relies on the SystemC standard's cooperative scheduling: processes run sequentially without interruption until explicit synchronization points. It does not explore arbitrary native-thread interleavings, and the paper does not target concurrency bugs (Section VI, pp. 5-6; Sections VIII.G-IX, p. 13).

### Where alternatives live and how growth is controlled

- Both tools use KLEE-style dynamic symbolic execution: concrete-only instructions run normally, symbolic branches fork path-conditioned execution states, and solver-produced assignments witness assertion or runtime failures. Expert-selected symbolic variables and concrete environment values restrict exploration to relevant paths (Section II and Section IV.A, pp. 2, 4).
- The testbench bounds simulation time and DUV loops. For peripheral functionality, the authors bypass bus logic and make registers symbolic; bus interfaces are verified in separate tests. The reason is semantic as well as practical: repeated writes to a SystemC signal fork on equality with its previous value, so two symbolic writes can already yield four interface paths before peripheral functionality is explored (Sections IV.A and VII, Figure 5, pp. 4, 7).
- CrosSym scales by including only application-relevant kernel features and reducing class-object size. SEFOS retains original objects but minimizes the arrays presented to the solver: it finds minimum/maximum feasible symbolic addresses for the concrete state array and retains every symbolic update that might alias the access. The approximation guarantees that no possible addressed value is removed, though impossible intermediate addresses may remain (Sections IV.B, V, and VI.C, pp. 4-7).
- Array minimization processes an (n)-byte object with (m) symbolic updates in (O(nm)) value/update checks, plus solver queries whose worst case remains exponential. It trades additional numerical alias queries and memory for smaller array formulas, avoiding the extra path forks of object splitting (Section VI.C, pp. 6-7).
- Evaluations use breadth-first state selection, STP, a 24-hour run limit, 4,000 MiB memory cap, and 120-second solver-query limit. The 120-second cap is removed only for the S2C scalability experiment (Section VIII, p. 7; Section VIII.F, p. 12).

### Goal, outputs, and verification contract

- Standalone tests assert a peripheral result against a reference function or check post-transaction register state; cross-level tests assert agreement between TLM and RTL implementations. KLEE also reports generic errors such as division by zero, memory faults, overshifts, unreachable instructions, and failed assertions, with concrete symbolic assignments (Sections II, IV.A, and VIII.A-C, pp. 2, 4, 8-10).
- A completed exploration can check all paths induced by the selected symbolic inputs under the testbench's time/loop bounds and supported semantics. Most larger runs do not complete, so their discovered errors are witnesses but absence of an error is not a proof of full peripheral equivalence. Cross-level results also depend on the chosen TLM model being an adequate reference (Sections IV.A, VIII.A, and VIII.G, pp. 4, 8-13).
- CrosSym's contract additionally depends on the unproved equivalence of its replacement kernel/transformed DUV to original SystemC. SEFOS keeps those originals, but trusts its KLEE context-switch approximation and excludes asynchronous waiting. Both are designed for isolated single peripherals rather than whole systems or multiple interacting peripherals (Sections III-IV, VI.B, and VIII.G, pp. 3-6, 13).

### Evaluation design and results

- Four peripherals are implemented at both RTL and TLM: a 52-source, priority-7 PLIC; subtraction-based GCD; two-input hash; and an eight-value mapping device. Runs use Ubuntu 22.04 on a 2.6 GHz Intel Xeon Gold 6240 (Section VIII and VIII.A, pp. 7-8).
- Fourteen functionality/cross-level tests reveal an inverted PLIC priority-threshold relation, a disagreement for out-of-range priorities, and a GCD unsigned/signed conversion error. A known GCD infinite-loop bug is missed because its path remains incomplete at timeout. Map is the only peripheral whose functionality tests reliably complete; several PLIC and all GCD tests hit the 24-hour limit, while complex cross-level hash expressions hit the 120-second solver limit (Section VIII.A, Table II, pp. 8-9).
- Table II illustrates the range: Map's 256-path RTL runs finish in 148.13 seconds (CrosSym) and 130.02 seconds (SEFOS), and its 256-path cross-level runs in 150.33 and 153.50 seconds. By contrast, PLIC priority/cross-level and all GCD functionality cases time out. The trivial one-path TLM Hash/Map cases finish in 0.44-0.51 seconds with CrosSym and 1.34-1.37 seconds with SEFOS because SEFOS pays the original kernel's startup cost (Table II, p. 8).
- Sixteen interface tests make address, length, and write data symbolic and check registers after each transaction. All RTL interfaces complete without detected errors; TLM tests rediscover known address/length failures and find a new out-of-bounds Map error. Most complete in under roughly 15 minutes, but PLIC TLM write exceeds 24 hours; SEFOS is usually slower and uses more memory (Section VIII.B, Table III, pp. 9-10).
- Mutation analysis selects 357 behavior-changing operator mutants across the eight RTL/TLM implementations and caps each test at 15 minutes. Kill rates vary sharply by peripheral and scenario: Map is 100% for both tools, Hash is 18-44%, PLIC ranges from 0% to 97.33%, and GCD from 31.81% to 98%. State-tree order, timeout, scenario count, and solver-hard hash comparisons all affect whether a mutant is reached; path count alone does not predict bug-finding success (Section VIII.C, Table IV, pp. 10-11).
- On five PLIC tests, array minimization reduces SEFOS's 24-hour timeouts from four to two: tests 1 and 2 fall from timeout to 3,744.13 and 32,022.28 seconds, while test 4 becomes modestly slower and test 5 explores fewer paths. Memory generally increases (Section VIII.D, Table V, p. 11).
- Against SymSysC on the same TLM PLIC study, CrosSym stays within 10% runtime and 30% memory on completed cases. SEFOS is 53-55% faster on two long completed functional tests but 145% slower on the completed read test and uses more memory; combining both modified components can be much faster but loses the practical assurance benefit of modifying only one side (Section VIII.E, Table VI, pp. 11-12).
- All five S2C benchmark modules time out at 24 hours and nearly all reach the memory cap. SEFOS completes more paths but discovers fewer total paths; the authors conclude that neither tool yet scales well to larger established modules (Section VIII.F, Table VII, p. 12).

## Bearing on RQs

- **RQ1 — Vocabulary and lineage:** The paper draws a mechanism boundary: symbolic simulation emphasizes data flow, whereas its KLEE-based symbolic execution follows control flow and can mix concrete and symbolic values. It positions CrosSym/SEFOS against direct RTL engines, Verilator-to-C++ methods, custom SystemC engines, and SymSysC's TLM-only replacement kernel (Sections II-III, pp. 2-3).
- **RQ2 — Executed artifact:** This is genuinely cross-level: TLM SystemC and RTL SystemC/Verilated Verilog can execute separately or together. SystemC's event scheduler, delta cycles, clocks, ports, and cooperative processes are load-bearing semantics, implemented approximately by either a replacement kernel or a modified KLEE scheduler (Sections IV-VI, pp. 3-7).
- **RQ3 — Alternatives and scaling:** Alternatives remain separate KLEE states. Concrete environmental choices, explicit loop/time bounds, separation of bus from function, reduced-kernel objects, and array minimization constrain growth; timeouts show that none eliminates path or solver explosion (Sections IV, VI.C, VII, and VIII, pp. 3-13).
- **RQ4 — Verification contract:** Outputs are assertion/runtime-error witnesses and bounded completed-path results for standalone or cross-level tests. The harness, TLM reference, SystemC feature subset/thread model, loop/simulation limits, solver timeout, and whether exploration completed must accompany any verification claim (Sections IV and VIII.G, pp. 3-4, 13).
- **RQ5 — Evidence:** The study is unusually broad in scenarios and metrics: two independent implementations, four dual-level peripherals, functionality and interface tests, 357 mutants, array-minimization ablation, SymSysC comparison, and five S2C modules, with paths, time, solver fraction, memory, query counts, errors, and kill rates (Section VIII, Tables II-VII, pp. 7-12). Its negative scalability results are as informative as its completed cases.

## Evidence limits

- The supplied PDF is arXiv v2 dated 12 December 2025 and says it was accepted 29 November 2025. Crossref assigns the journal article to volume 45, issue 8, August 2026; the DOI itself contains 2025. This note uses the 2026 print date while anchoring technical claims to the supplied pre-publication text.
- Many headline "verification" experiments terminate by 24-hour, 4,000 MiB, or 120-second query limits. Path counts at timeout are progress measures, not coverage proofs, and BFS order materially affects early bug discovery.
- The mutation set is a selected subset of behavior-changing operator replacements, not a random sample or complete mutant population. Kill rates measure this harness and 15-minute budget, not real-defect detection probability.
- CrosSym and SEFOS share KLEE/STP foundations and testbenches, so their comparison is not independent replication. No conventional formal-equivalence or industrial SystemC tool baseline covers the same cross-level feature set.
- Neither approach supports asynchronous waiting, multiple interacting peripherals, or concurrency-bug detection in the evaluated form. The S2C results show that larger modules remain outside practical exhaustive reach.
