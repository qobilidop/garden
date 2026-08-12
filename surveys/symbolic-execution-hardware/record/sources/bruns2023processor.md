---
citekey: bruns2023processor
work:
  title: "Processor Verification using Symbolic Execution: A RISC-V Case-Study"
  author: Niklas Bruns; Vladimir Herdt; Rolf Drechsler
  venue: Design, Automation & Test in Europe Conference
  date: 2023
  doi: 10.23919/DATE56975.2023.10137202
read: full-text
source: https://uww.revlib.org/doc/konf/2023_DATE_NB.pdf
facets: "relation: core; artifact: mixed-level; execution: classical; goal: equivalence; evidence: case-study"
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: KLEE co-executes Verilated RISC-V RTL and an ISS to emit mismatch witnesses, while instruction bounds, slicing, and very long runs expose the contract and scaling limits.
---

# Processor Verification using Symbolic Execution: A RISC-V Case-Study

## Evidence

- The flow translates a SpinalHDL/Verilog processor to C++ with Verilator, links it to a C++ instruction-set simulator, and runs the combined co-simulation in KLEE (Sections III–IV; Figure 1).
- Instructions, data memory, and selected registers are symbolic. `klee_assume` adds architectural restrictions to the current path condition; KLEE forks processor/ISS paths and produces mismatch tests (Section IV).
- The voter compares the RTL and ISS at retired-instruction boundaries. Symbolic register slicing and instruction-count limits reduce state space, while bus timing remains modeled in the RTL side (Sections IV–V).
- On MicroRV32 the study reports ten RTL errors, two ISS errors, and nineteen implementation mismatches. One long exploration ran 586,905 seconds, completed 848 paths, partially explored 408, and emitted 1,256 tests; injected-error runs use a 24-hour limit (Section V; Tables I–II).

## Bearing on RQs

- **RQ1:** The engine is classical symbolic execution, although the validation oracle is differential co-simulation.
- **RQ2:** This is a mixed-level semantic contract: Verilated RTL and an abstract ISS must agree at a selected observation boundary despite different timing detail.
- **RQ3:** Symbolic slicing and short instruction horizons control growth; they also constrain the behaviors checked.
- **RQ4–RQ5:** Mismatch traces are witnesses. Agreement is not an unbounded processor proof, and the very long case-study run exposes serious scaling limits.

## Evidence limits

- Results depend on Verilator translation, RVFI observation, ISS correctness/configuration, symbolic-register selection, instruction bounds, and assumptions.
- The paper evaluates one principal processor pair; error counts include specification-permitted mismatches and cannot be compared directly with coverage studies.
