---
citekey: nguyen2015counterexamples
work:
  title: "Relatively Complete Counterexamples for Higher-Order Programs"
  author: "Phúc C. Nguyễn, David Van Horn"
  venue: "PLDI 2015"
  date: 2015
  doi: 10.1145/2737924.2737971
read: full-text
source: "Primary PLDI full text, https://doi.org/10.1145/2737924.2737971 (also arXiv:1411.3967)"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Establishes relatively complete canonical symbolic search for higher-order functional inputs via progressive decomposition of unknown functions, reconstructing concrete higher-order counterexamples — but it seeks a single counterexample rather than enumerating every first-order observation fiber without duplication."
---

# Relatively Complete Counterexamples for Higher-Order Programs

## Evidence

### Evidence locations

- Symbolic semantics: unknown higher-order functions are progressively
  decomposed into lower-order unknowns while first-order path conditions are
  retained for solver reasoning.
- Metatheory: evaluation is sound and counterexample generation is relatively
  complete modulo the base solver; successful symbolic results reconstruct
  concrete higher-order inputs.

## Bearing on RQs

This establishes relatively complete canonical symbolic search for functional
inputs.

## Evidence limits

It seeks a counterexample rather than enumerating every first-order
observation fiber without duplication.
