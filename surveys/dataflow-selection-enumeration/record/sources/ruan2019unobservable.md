---
citekey: ruan2019unobservable
work:
  title: "Minimum Initial Marking Estimation in Labeled Petri Nets With Unobservable Transitions"
  author: "Keyu Ruan, Lingxi Li, Weimin Wu"
  venue: "IEEE Access"
  date: 2019
  doi: 10.1109/access.2019.2894352
read: full-text
source: "Final open-access journal full text via https://doi.org/10.1109/ACCESS.2019.2894352, pp. 19232–19237"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Recursively computes the complete set of minimum-total-token initial markings consistent with an observed label word under unobservable transitions — an optimization-restricted initial-state inverse set, not a partition of all caller inputs"
---

# Minimum Initial Marking Estimation in Labeled Petri Nets With Unobservable Transitions

## Evidence

### Evidence locations

- Problem statement and Algorithm 1: for a known labeled Petri-net structure
  with contact-free unobservable transitions, recursively compute the complete
  set of minimum-total-token initial markings capable of producing an observed
  label word.
- Complexity analysis: polynomial in observation length with fixed structural
  parameters, but exponential in some net parameters.
- Heuristics: two cheaper variants return only an approximation or partial set
  and are kept separate from the complete algorithm.

## Bearing on RQs

This strictly extends the retained Li--Hadjicostis marking problem to a special
unobservable-transition structure. It returns an optimization-restricted
initial-state inverse set, not a partition of all caller inputs, and it has no
typed program residual.

## Evidence limits

Read at full-text level (final open-access journal full text, pp. 19232–19237);
the note records no evidence-quality caveats beyond the scope boundary above.
