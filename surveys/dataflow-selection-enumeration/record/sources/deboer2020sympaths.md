# deboer2020sympaths — Symbolic execution meets POR

- **Status:** deep-read; closest concurrent symbolic-state comparator
- **Primary source:** https://doi.org/10.1007/978-3-030-64354-6_13
- **Version read:** author-hosted full text, pp. 313--338
- **Bibliography key:** `deboer2020sympaths`

## Evidence locations

- Definitions 2--3: symbolic paths retain scheduling events, dependencies,
  substitutions, path conditions, and thread pools.
- Theorems 2--3 and POR corollaries: establish correctness and completeness
  against concrete executions, then preserve representative equivalent paths.

## Relationship and evidence limit

SymPaths already couples a recorded choice history with a symbolic residual
state and exact POR pruning. Its records concern thread schedules and mutable
states, not requested-root-relative selection-site maps and caller-input fibers.
