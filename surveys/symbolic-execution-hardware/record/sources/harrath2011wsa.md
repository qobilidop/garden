---
citekey: harrath2011wsa
work:
  title: Building SystemC waiting state automata
  author: Nesrine Harrath; Bruno Monsuez; Joëlle Delacroix
  venue: Verification and Evaluation of Computer and Communication Systems
  date: 2011
  doi: 10.14236/ewic/VECOS2011.11
read: full-text
source: https://www.scienceopen.com/document_file/013d2888-7cc4-44df-9b4f-a7b19ec0cf35/PubMedCentral/013d2888-7cc4-44df-9b4f-a7b19ec0cf35.pdf
facets: "relation: core; artifact: systemc-tlm; execution: classical; goal: functional; evidence: case-study"
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: Scheduler-aware SystemC symbolic states, path feasibility, and trace composition make this the earliest mechanism-verified include in the bounded corpus, with illustrative rather than scalability evidence.
---

# Building SystemC waiting state automata

## Evidence

- The paper defines a basic symbolic-execution state containing the current statement, symbolic variable values, and a path condition; conditional rules extend that predicate and retain only satisfiable executions (Sections 5–6, especially Tables 2–3).
- Its contribution is hardware-specific rather than a generic C++ front end: the operational semantics covers runnable SystemC processes, signal updates, immediate and delayed notifications, waits, scheduler choices, and delta-cycle advancement. Parallel composition follows the SystemC evaluation/update scheduler (Sections 3 and 5; Table 1).
- Symbolic traces between waits are composed into a SystemC waiting-state automaton. Entry events and predicates guard transitions; output events and updated symbolic state describe their effects (Sections 4 and 6).
- The worked producer/consumer example demonstrates construction but is not a comparative experiment. The model omits portions of SystemC and preserves time only to the delta-cycle granularity (Sections 3, 6, and conclusion).

## Bearing on RQs

- **RQ1:** This is the earliest mechanism-verified included work in the bounded corpus: it has symbolic stores, explicit path conditions, feasibility, and execution-trace composition—not merely symbolic value propagation.
- **RQ2:** SystemC concurrency makes the scheduler part of the executed semantics. A “path” includes process selection, waits, events, signal updates, and delta cycles.
- **RQ3:** Alternatives are explicit symbolic configurations and traces; waiting points provide natural fragment boundaries for automaton composition.
- **RQ4–RQ5:** The output is a verification model derived from a restricted SystemC semantics. Evidence is illustrative, so neither scalability nor complete SystemC coverage is established.

## Evidence limits

- The primary paper does not claim universal historical priority, and older self-labelled hardware “symbolic execution” records remain unresolved or fail the revised operational test.
- No artifact, benchmark suite, solver-cost data, or semantic equivalence proof to a production SystemC kernel is reported.
