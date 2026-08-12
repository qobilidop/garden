---
citekey: feng2004dynamic
work:
  title: "Improved Symbolic Simulation by Dynamic Functional Space Partitioning"
  author: "Tao Feng, Li-C. Wang, Kwang-Ting Cheng, Andy C.-C. Lin"
  venue: "DATE 2004"
  date: 2004
  doi: 10.1109/DATE.2004.1268825
read: full-text
source: "Version of record, https://doi.org/10.1109/DATE.2004.1268825"
canonical-note: surveys/dataflow-selection-enumeration/record/sources/feng2004dynamic.md
retrieved: "-"
notes-by: Codex GPT-5.6 Sol (survey adversarial revision)
notes-date: 2026-08-12
synthesis: "Dynamic functional-space partitioning selectively splits mux control regions to manage OBDD growth while remaining merged combinational symbolic simulation, so it informs cost accounting but fails the design-path execution boundary."
---

# Improved Symbolic Simulation by Dynamic Functional Space Partitioning

## Evidence

- Section 3, Definitions 1–3 represent a node by mutually exclusive `(C,D)`
  tuples whose controls cover the functional space.
- Section 3, Theorem 1 and Construction Rules 1–2 give tuple merging and mux
  propagation; Section 3.2 checks control coverage and agreement across
  intersecting regions.
- Section 4 chooses static or dynamic mux partitions to trade the number of
  subspaces against per-subspace OBDD size. The claimed benefit is empirical,
  not a general output-sensitive bound.

## Bearing on RQs

- **RQ1 / boundary:** the method propagates and selectively partitions symbolic
  values in a combinational circuit. It does not construct temporally indexed
  design paths whose feasibility selects or reconstructs another execution, so
  it is E3.
- **RQ3:** it is strong adjacent evidence that fewer explicit partitions can
  mean larger symbolic functions, and that splitting decisions are themselves
  a cost-bearing heuristic.
- **RQ5:** the evaluation supports improved symbolic-simulation capacity for
  selected circuits, not comparative evidence about path-conditioned hardware
  execution.

## Evidence limits

The design is combinational and OBDD-based. Its tuple controls should not be
renamed path conditions without also establishing the execution-selection
role required by this survey.
