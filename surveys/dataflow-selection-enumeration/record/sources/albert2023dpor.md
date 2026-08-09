---
citekey: albert2023dpor
work:
  title: "Optimal Dynamic Partial Order Reduction with Context-Sensitive Independence and Observers"
  author: "Elvira Albert, Maria Garcia de la Banda, Miguel Gómez-Zamalloa, Miguel Isabel, Peter Stuckey"
  venue: "Journal of Systems and Software"
  date: 2023
  doi: 10.1016/j.jss.2023.111730
read: full-text
source: "Open-access author full text and publisher record via https://doi.org/10.1016/j.jss.2023.111730"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Reinforces exact requested-observer-relative omission as established prior art for concurrent schedule quotients, without producing exact input guards or typed residual values"
---

# Optimal Dynamic Partial Order Reduction with Context-Sensitive Independence and Observers

## Evidence

### Evidence locations

- Algorithm: combines state-relative commutation with future-event observers,
  constructing dependencies lazily and exploiting their interaction.
- Correctness and optimality results: the retained executions cover all
  maximal equivalence classes without duplicate representatives under the
  defined conditional independence.
- Evaluation: reported cases obtain exponential reductions over either
  context-sensitive or observer-only DPOR.

## Bearing on RQs

The journal extension reinforces exact requested-observer-relative omission
as established prior art.

## Evidence limits

- It quotients concurrent schedules, not caller inputs, and emits neither
  exact input guards nor typed residual values.
