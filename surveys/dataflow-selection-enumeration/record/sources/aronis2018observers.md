---
citekey: aronis2018observers
work:
  title: "Optimal Dynamic Partial Order Reduction with Observers"
  author: "Stavros Aronis, Bengt Jonsson, Magnus Lång, Konstantinos Sagonas"
  venue: "TACAS 2018"
  date: 2018
  doi: 10.1007/978-3-319-89963-3_14
read: full-text
source: "Open-access publisher full text via https://doi.org/10.1007/978-3-319-89963-3_14, pp. 229–248"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Optimal DPOR with future observers explores exactly one representative per maximal observation-equivalence class of concurrent schedules — a direct exact precedent for observer-relative omission and duplicate-free enumeration, scoped to schedule order rather than caller-input event maps"
---

# Optimal Dynamic Partial Order Reduction with Observers

## Evidence

### Evidence locations

- Sections 2--3: dependencies between operations are conditional on later
  operations that observe their effects, so unobserved write or delivery order
  can remain independent.
- Theorems 1--2: the algorithm explores a representative of every maximal
  observational-equivalence class and never explores two equivalent maximal
  schedules.

## Bearing on RQs

This is a direct exact precedent for observer-relative omission and
duplicate-free enumeration. The projected dimension is concurrent schedule
order and the observer is a later read/receive, not a requested-root caller-
input event map with symbolic residuals.

## Evidence limits

Read at full-text level (open-access publisher full text, pp. 229–248); the
note records no evidence-quality caveats beyond the scope boundary above.
