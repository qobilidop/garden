---
citekey: deboer2020sympaths
work:
  title: "SymPaths: Symbolic Execution Meets Partial Order Reduction"
  author: "Frank S. de Boer, Marcello M. Bonsangue, Einar Broch Johnsen, Violet Ka I Pun, S. Lizeth Tapia Tarifa, Lars Tveito"
  venue: "Deductive Software Verification: Future Perspectives"
  date: 2020
  doi: 10.1007/978-3-030-64354-6_13
read: full-text
source: "Author-hosted full text via https://doi.org/10.1007/978-3-030-64354-6_13, pp. 313--338"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "SymPaths couples a recorded symbolic-path choice history with partial-order-reduction pruning over thread schedules and mutable state — the closest concurrent symbolic-state comparator, though not indexed by requested-root selection sites and caller-input fibers"
---

# SymPaths: Symbolic Execution Meets Partial Order Reduction

## Evidence

### Evidence locations

- Definitions 2--3: symbolic paths retain scheduling events, dependencies,
  substitutions, path conditions, and thread pools.
- Theorems 2--3 and POR corollaries: establish correctness and completeness
  against concrete executions, then preserve representative equivalent paths.

## Bearing on RQs

SymPaths already couples a recorded choice history with a symbolic residual
state and exact POR pruning.

## Evidence limits

Its records concern thread schedules and mutable states, not requested-root-relative
selection-site maps and caller-input fibers.
