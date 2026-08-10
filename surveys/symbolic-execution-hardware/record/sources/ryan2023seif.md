---
citekey: ryan2023seif
work:
  title: Augmented Symbolic Execution for Information Flow in Hardware Designs
  author: Kaki Ryan; Matthew Gregoire; Cynthia Sturton
  venue: Hardware and Architectural Support for Security and Privacy (HASP 2023)
  date: 2023
  doi: 10.1145/3623652.3623666
  arxiv: 2307.11884
read: full-text
source: https://arxiv.org/abs/2307.11884
facets: "relation: core; artifact: rtl; execution: path; goal: security; evidence: experiment"
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol (survey deep-read pipeline)
notes-date: 2026-08-10
synthesis: SEIF uses a static information-flow overapproximation as landmarks for bounded RTL path search, producing replayable flow witnesses and qualified negative classifications while leaving some graph paths unaccounted for.
---

# Augmented Symbolic Execution for Information Flow in Hardware Designs

## Evidence

### Executed artifact and semantic layers

- SEIF relates three representations: a clocked state-transition model of the Verilog RTL, a static Information Flow (IF) graph, and Sylvia's symbolic-execution tree. The IF graph's nodes are RTL wires/registers and its labeled edges are possible explicit assignment flows or implicit control flows; it overapproximates multi-hop information flow and has no intrinsic notion of time (Sections 3-4.4, Figures 2-4, pp. 2-4).
- Sylvia executes RTL Verilog directly using IEEE 1364-2005 semantics implemented with pyVerilog and Z3, rather than translating the design to a software model or gate netlist. At a symbolic branch it explores both design paths, attaching branch constraints to the path condition; each clock edge supplies new inputs and updates state-holding variables (Sections 4.2, 4.4, and 6, pp. 2-4, 8).
- An IF path is divided at explicit nonblocking assignments into segments corresponding to clock boundaries. SEIF requires the RTL lines associated with the current segment to execute, so the static graph supplies landmarks while the symbolic state and path condition establish whether the landmarks can co-occur over time (Sections 5.1-5.3.1, pp. 4-5).
- For inter-module paths, the implementation explores partial IF paths within modules and asks the solver whether fragments can be stitched into a valid source-to-sink flow. This divide-and-conquer step reduces repeated intra-module work (Section 6, p. 8).

### Alternative behaviors and scaling

- Alternatives live at two levels: the static graph enumerates candidate source-to-sink flow paths, and each candidate can correspond to many separate clock-by-clock symbolic-execution paths. A returned witness is one symbolic path plus satisfying input values; unexplored alternatives remain explicitly "unaccounted for" rather than being classified as non-flows (Sections 4.3-5.1, pp. 3-4).
- Phase 1 cheaply removes globally unrealizable graph paths by checking co-satisfiability of each same-cycle segment's conditions. Restricting this query to state-holding and input signals makes the pruning sound because their values do not change within a cycle (Section 5.2, Figures 5-6, pp. 4-5).
- Phase 2 prunes at each clock boundary using the current symbolic state, constrains execution to the lines needed for the current segment, and can "stall": advance one machine cycle without advancing the IF path while forbidding writes that would destroy already-carried information. Self-updates are allowed; unconditional constant overwrites prevent stalling (Sections 5.3.1-5.3.3, Figures 7-8, pp. 5-6).
- Four search strategies compare continue/stall enumeration, backtracking alone, stalling plus backtracking, and an UNSAT-core heuristic that prioritizes stall paths according to whether they reduce the constraints blocking the next segment. Stalls are bounded empirically; the main experiments use bounds of 5, 5, and 4 cycles per segment for the three stalling strategies (Section 5.3.4, pp. 6-7; Section 7.3.1 and Appendix 11.1, pp. 9, 13).
- Phase 3 performs a semantic dependence check so that executable textual flows such as `y = x xor x` can be rejected as non-flows. Explicit flows are handled, but implicit textual false positives cannot be removed; reconvergent fan-out can also yield an incorrect classification unless exploration is exhaustive (Section 5.4, Figure 9, pp. 7-8).

### Goal, outputs, and verification contract

- Given RTL and source signals, SEIF aims to enumerate realizable information flows and return, for each found flow, an input sequence that drives it. Each candidate has one of three outcomes: rejected as globally or boundedly unrealizable/non-semantic, returned with a design path and inputs, or left unaccounted for (Introduction and Sections 3, 5.1, pp. 1-2, 4).
- Global contradictory-segment pruning is unbounded and sound under its stated same-cycle signal restriction. Failure to find a symbolic path is otherwise only a bounded negative result. A found positive path may start at reset or at a symbolic intermediate state; the post-pass checks reset compatibility, but an intermediate starting state is not guaranteed reachable (Introduction; Sections 5.2 and 5.3.5, pp. 1, 4-5, 7).
- In the security-property mode, SEIF constrains graph paths by the undesired source/sink relation and returns multiple violating traces, checking that reported candidate violations replay from reset. This is witness enumeration and flow explication, not a complete noninterference proof (Section 7.5, Tables 1-2, p. 10).

### Evaluation design and results

- The dataset has four open-source Verilog designs: OR1200, openMSP430, the AKER access-control wrapper, and a TrustHub AES implementation. Runs use a 2.40 GHz Intel Xeon E5-2620 V3 server with 62 GB RAM (Section 7.1, p. 8).
- For accounting/search experiments, the authors select 20 security-critical sources in OR1200, 10 analogous sources in openMSP430, and 20 property-linked internal sources in AKER, then randomly sample 300 IF paths per source. Across these three designs, SEIF accounts for 86-90% of sampled paths; 58-77% are returned as true design paths (Section 7.2, Figure 10, pp. 8-9).
- The UNSAT-core heuristic finds 26% more design paths than the two baselines on average and 11% more than bounded stalling with backtracking, with average successful searches completing in 3-6 seconds. The paper summarizes the explored depth as 10-12 clock cycles in 4-6 seconds on average (Section 7.3, Figures 11-14, p. 9; Conclusion, p. 10).
- A full openMSP430 program-counter run covers 19,060 IF paths: 89.93% receive corresponding design paths by 16 cycles, most within eight cycles, and the run takes 3.5 days (Section 7.3, Figure 15, p. 9). Separate falsification analysis on sampled OR1200 paths reports that semantic analysis removes a nontrivial 5-7% as executable paths that do not carry true information flow (Section 7.4, Figure 17, p. 9).
- For the openMSP430 security property, the IF graph has 19,060 source paths and 41 reachable sinks; 58 paths violate the graph-level property, of which 46 are realizable from reset. Counterexamples average 0.678 seconds and 8.13 cycles. For AES, 61,639 source paths reach 39 sinks; 57 graph paths violate the property and 25 are realizable, averaging 0.505 seconds and 4.102 cycles (Section 7.5, Tables 1-2, p. 10).

## Bearing on RQs

- **RQ1 — Vocabulary and lineage:** SEIF is explicitly "augmented" symbolic execution: static flow analysis supplies an overapproximate map, while path-conditioned RTL execution decides timing feasibility and value dependence. This makes it neither static IFT alone nor symbolic simulation over a single merged expression (Introduction; Sections 4-5, pp. 1-7).
- **RQ2 — Executed artifact:** The executed artifact is Verilog RTL with clocked registers, per-cycle input strings, and direct IEEE-2005 operational semantics. Hardware concurrency is reflected in RTL scheduling/nonblocking updates, while the IF graph abstracts away timing until symbolic execution restores it (Sections 4.2-4.4 and 6, pp. 2-4, 8).
- **RQ3 — Alternatives and scaling:** Candidate alternatives first live as IF-graph paths, then as separate symbolic design paths. Segment pruning, landmark guidance, stalling, backtracking, UNSAT-core prioritization, and module-local fragments attack different parts of the explosion; empirical stall bounds keep the search finite (Section 5, pp. 4-8).
- **RQ4 — Verification contract:** Positive outputs are input traces, preferably replayable from reset. Negative results divide into globally sound contradiction, bounded failure, and semantic non-flow with explicit caveats; unresolved candidates remain unaccounted. This unusually explicit outcome taxonomy is important when interpreting the reported 86-90% (Introduction and Sections 5.1-5.4, pp. 1, 4-8).
- **RQ5 — Evidence:** The evaluation measures accounted fractions, true-path fractions, search-strategy efficacy, cycles, wall time, and property-specific witness counts on four designs. It combines sampled-path experiments with two exhaustive source-signal case studies, but not a tool-to-tool baseline (Section 7, pp. 8-10).

## Evidence limits

- The supplied text is arXiv v2 (31 July 2023), titled *Augmented Symbolic Execution for Information Flow in Hardware Designs*. The published HASP version registered under DOI 10.1145/3623652.3623666 adds `SEIF:` to the title; claims here are anchored to the supplied arXiv version.
- The hyperflow-graph implementation was available to the authors only as a closed-box service, and Sylvia only through source access granted by its authors (Section 6 footnote, p. 8). The paper therefore does not establish a fully public end-to-end artifact from its own text.
- The 86-90%, 58-77%, and search-strategy results are based on 300 randomly selected paths per chosen source signal, with no repeated-sampling variance reported. The security case studies use all paths from their selected sources but do not imply all sources or all security properties were checked.
- Stall limits are chosen empirically from five OR1200 source signals and make most negative symbolic-search results bounded. Intermediate-state witnesses may not be reachable from reset.
- Semantic pruning has acknowledged blind spots for implicit flows and reconvergent fan-out, and the method targets RTL design-time errors, not synthesis, manufacturing, supply-chain, physical, or post-validation flaws (Sections 2 and 5.4, pp. 2, 7-8).
