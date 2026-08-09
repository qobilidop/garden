---
citekey: chatterjee2019valuecentric
work:
  title: "Value-Centric Dynamic Partial Order Reduction"
  author: "Krishnendu Chatterjee, Andreas Pavlogiannis, Viktor Toman"
  venue: "OOPSLA 2019"
  date: 2019
  doi: 10.1145/3360550
read: full-text
source: "Open-access PACMPL full text via https://doi.org/10.1145/3360550; also arXiv:1909.00989"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Value-happens-before groups concurrent schedules by observed write values rather than happens-before order, a direct observer-relative quotient enumerated in polynomial time per equivalence class for a bounded number of threads"
---

# Value-Centric Dynamic Partial Order Reduction

## Evidence

### Evidence locations

- Equivalence: value-happens-before groups maximal traces according to observed
  values and is always at least as coarse as happens-before, sometimes
  exponentially coarser.
- Algorithm and bound: for a bounded number of threads, VCDPOR explores the
  partition in polynomial time per equivalence class.

## Bearing on RQs

Same-valued writes are intentionally indistinguishable, making this a direct
observer-relative quotient.

## Evidence limits

It enumerates concurrent schedules rather than caller-input fibers and carries
no symbolic residual per class.
