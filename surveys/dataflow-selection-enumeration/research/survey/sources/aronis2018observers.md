# aronis2018observers — Optimal DPOR with future observers

- **Status:** deep-read; exact observation-relative schedule quotient
- **Primary source:** https://doi.org/10.1007/978-3-319-89963-3_14
- **Version read:** open-access publisher full text, pp. 229--248
- **Bibliography key:** `aronis2018observers`

## Evidence locations

- Sections 2--3: dependencies between operations are conditional on later
  operations that observe their effects, so unobserved write or delivery order
  can remain independent.
- Theorems 1--2: the algorithm explores a representative of every maximal
  observational-equivalence class and never explores two equivalent maximal
  schedules.

## Relationship and evidence limit

This is a direct exact precedent for observer-relative omission and
duplicate-free enumeration. The projected dimension is concurrent schedule
order and the observer is a later read/receive, not a requested-root caller-
input event map with symbolic residuals.
