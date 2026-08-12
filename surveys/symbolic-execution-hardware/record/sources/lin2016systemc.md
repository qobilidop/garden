---
citekey: lin2016systemc
work:
  title: Generating High Coverage Tests for SystemC Designs Using Symbolic Execution
  author: Bin Lin; Zhenkun Yang; Kai Cong; Fei Xie
  venue: Asia and South Pacific Design Automation Conference
  date: 2016
  doi: 10.1109/ASPDAC.2016.7428006
read: full-text
source: https://web.cecs.pdx.edu/~congkai/publications/aspdac16.pdf
facets: "relation: core; artifact: systemc-tlm; execution: classical; goal: test-coverage; evidence: experiment"
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: SESC shows that qualifying SystemC symbolic execution needs scheduler, event, datatype, and clock semantics in addition to an ordinary C++ path engine.
---

# Generating High Coverage Tests for SystemC Designs Using Symbolic Execution

## Evidence

- SESC extends KLEE with a SystemC scheduler and hardware-specific signal, FIFO, arbitrary-width integer, and clock-cycle behavior. A generated harness supplies symbolic inputs and an execution bound (Sections I–III; Figures 1–3).
- Each symbolic state carries a program counter, memory/store, and path condition. Branch feasibility forks executions; completed paths are solved into concrete tests and replayed on the original design for coverage (Sections III–IV).
- The scheduler chooses runnable processes and advances events/signals, so process interleavings and clocks contribute to the path space. The supported SystemC subset and scheduling policy qualify every result (Sections II–III).
- Evaluation covers several SystemC designs, including a RISC CPU above 2 KLOC, and reports path/test counts, branch/statement coverage, time, and memory. The study shows feasibility but not industrial-scale closure (Section V; Tables I–III).

## Bearing on RQs

- **RQ1:** This is classical multi-path symbolic execution extended with SystemC execution semantics.
- **RQ2:** It demonstrates why “C++ plus KLEE” is not enough: the scheduler and SystemC datatypes are explicit semantic obligations.
- **RQ3:** Path growth arises from both ordinary branches and concurrent scheduling; bounds and engine policies limit exploration.
- **RQ4–RQ5:** Replayed tests witness covered behavior. Residual uncovered code is not proved unreachable.

## Evidence limits

- The paper does not prove fidelity to the reference SystemC kernel across all language features.
- Benchmarks and resource reporting are useful but small; there is no randomized variance or maintained artifact package.
