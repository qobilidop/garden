---
citekey: qin2014interleaving
work:
  title: Scalable Test Generation by Interleaving Concrete and Symbolic Execution
  author: Xiaoke Qin; Prabhat Mishra
  venue: 27th International Conference on VLSI Design
  date: 2014
  doi: 10.1109/VLSID.2014.25
read: full-text
source: https://www.cise.ufl.edu/research/cad/Publications/vlsi14test.pdf
facets: "relation: core; artifact: hdl-other; execution: selective-hybrid; goal: test-coverage; evidence: experiment"
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: Concrete HDL traces are reconstructed as time-indexed path predicates and selectively diverted by SMT, producing bounded coverage tests rather than reachability proofs.
---

# Scalable Test Generation by Interleaving Concrete and Symbolic Execution

## Evidence

- The method flattens and instruments an HDL design, runs it concretely in a simulator for a fixed number of cycles, and records assignments and branch outcomes in a trace (Section III.B–D; Table I).
- It reconstructs a time-indexed path-constraint file, including register-frame constraints, then negates an uncovered branch and uses Yices to solve a new input. The design is re-simulated and the process repeats (Section III.E–G; Algorithm 1; Figure 6).
- Concrete indices from dynamic array accesses specialize each trace, while symbolic reasoning is restricted to the observed path. Unsat-core reuse and removal of irrelevant concrete-only constraints reduce repeated solving (Section III.D–G).
- Experiments compare HYBRO, random testing, and the proposed method on ITC’99 designs and a Zet processor. Results are bounded by chosen cycles; the paper reports coverage and runtime but not proof of unreachable branches (Section IV; Tables II–III).

## Bearing on RQs

- **RQ1:** The mechanism is selective-hybrid: concrete simulation supplies the path and hardware state; symbolic reconstruction and feasibility solving synthesize a diversion.
- **RQ2:** HDL simulator semantics carry clocked behavior and dynamic arrays; the symbolic model is a trace-derived approximation rather than a full concurrent RTL semantics.
- **RQ3:** One path is solved at a time. Trace specialization, unsat cores, and constraint deletion trade completeness for scale.
- **RQ4–RQ5:** Outputs are replayable directed tests and bounded branch coverage, not an exhaustive verification result.

## Evidence limits

- The paper does not prove that trace reordering or its constraint-deletion rules preserve all HDL scheduling semantics.
- Benchmark diversity and repeated-run statistics are limited; randomization seeds and solver-query distributions are absent.
