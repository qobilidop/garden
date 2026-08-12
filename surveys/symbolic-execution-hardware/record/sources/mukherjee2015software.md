---
citekey: mukherjee2015software
work:
  title: Hardware Verification using Software Analyzers
  author: Rajdeep Mukherjee; Daniel Kroening; Tom Melham
  venue: IEEE Computer Society Annual Symposium on VLSI
  date: 2015
  doi: 10.1109/ISVLSI.2015.107
read: full-text
source: https://www.cprover.org/hardware/HW-SW-Analyzers.pdf
facets: "relation: core; artifact: rtl; execution: classical; goal: functional; evidence: experiment"
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: V2C makes path symbolic execution one explicit analyzer over a synthesis-semantic RTL transition program, distinct from the same flow's BMC and abstract-interpretation modes.
---

# Hardware Verification using Software Analyzers

## Evidence

- V2C translates synthesizable RTL Verilog into a word-level ANSI-C transition-system program under synthesis semantics; assertions encode the hardware property (Sections I and III; Figures 1–2).
- The PATH-SYMEX configuration maintains one symbolic program path at a time, accumulates branch constraints, checks feasibility, and reports an assertion counterexample or bounded safe completion. This is operational path symbolic execution, unlike the paper’s separate BMC and abstract-interpretation configurations (Sections II and IV).
- The harness repeatedly invokes the translated transition relation, so one loop iteration is one hardware clock transition. Initial state, unwind depth, assumptions, and Verilog-to-C translation are therefore part of the contract (Sections III–IV).
- Experiments span SV-COMP-derived sequential circuits and industrial/academic RTL properties and compare software BMC, PATH-SYMEX, abstract interpretation, and conventional hardware flows. Reported speedups are configuration- and benchmark-dependent (Section V; Tables I–II).

## Bearing on RQs

- **RQ1:** This paper cleanly separates path symbolic execution from adjacent solver-backed methods inside one experimental flow.
- **RQ2:** Generated C is admitted because the paper specifies synthesis-semantic equivalence to RTL and evaluates hardware properties through that representation.
- **RQ3:** PATH-SYMEX avoids a monolithic unrolling but can still suffer path explosion; BMC and abstract interpretation move cost elsewhere and are outside the survey denominator.
- **RQ4–RQ5:** A counterexample is a bounded witness. Absence of one is only as strong as the unwind and analyzer completion.

## Evidence limits

- The supported Verilog subset and translation relation do not establish equivalence to every simulator or synthesis tool.
- The paper predates current RTL feature sets; no public end-to-end artifact or independent reproduction is reported.
