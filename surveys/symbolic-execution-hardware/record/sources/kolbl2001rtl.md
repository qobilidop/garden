---
citekey: kolbl2001rtl
work:
  title: "Symbolic RTL Simulation"
  author: "Alfred Kölbl, James H. Kukula, Robert F. Damiano"
  venue: "38th Design Automation Conference (DAC)"
  date: 2001
  doi: 10.1145/378239.378278
read: full-text
source: "Version of record, https://doi.org/10.1145/378239.378278"
canonical-note: surveys/dataflow-selection-enumeration/record/sources/kolbl2001rtl.md
retrieved: "-"
notes-by: Codex GPT-5.6 Sol (survey adversarial revision)
notes-date: 2026-08-12
synthesis: "Kölbl et al. directly execute full Verilog with symbolic controls, ITE values, event accumulation, and replay, but merge design alternatives instead of maintaining design-path identities whose feasibility selects another execution; it is the load-bearing E3 boundary comparator."
---

# Symbolic RTL Simulation

## Evidence

- Section 3.2 (pp. 48–49) evaluates both arms of a conditional under disjoint
  Boolean controls and represents controlled assignments with ITE expressions.
- Section 4 (pp. 49–51) accumulates compatible event-queue entries at the same
  statement and simulation time by disjoining their controls; the paper retains
  an exponential worst case despite average reductions.
- Section 5 (pp. 51–52) records context-dependent `$random` occurrences so a
  satisfying error model can be replayed concretely.

## Bearing on RQs

- **RQ1 / boundary:** this is symbolic RTL simulation, not an included
  path-conditioned executor. Feasibility recovers an error valuation, but
  accumulated design alternatives are guarded values rather than persistent
  design-path identities that control generation of another execution.
- **RQ2:** it is direct Verilog execution with event and time semantics, making
  it a useful semantic comparator for later translated or language-aware
  executors.
- **RQ3:** event accumulation is a clear example of moving alternatives from
  scheduled executions into Boolean controls and ITE data.
- **RQ4:** the concrete replay is positive evidence for one error behavior; it
  does not turn the merged simulation into the survey's path-execution regime.

## Evidence limits

The paper gives no numbered end-to-end correctness theorem and no general
complexity improvement. Its broader Verilog support and replay mechanism are
not evidence that it satisfies the survey's third and fourth inclusion
conditions.
