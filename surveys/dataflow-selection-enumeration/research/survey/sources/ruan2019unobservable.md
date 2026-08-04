# ruan2019unobservable — Minimum markings with silent transitions

- **Status:** deep-read; exact optimization-relative inverse set
- **Primary source:** https://doi.org/10.1109/ACCESS.2019.2894352
- **Version read:** final open-access journal full text, pp. 19232--19237
- **Bibliography key:** `ruan2019unobservable`

## Evidence locations

- Problem statement and Algorithm 1: for a known labeled Petri-net structure
  with contact-free unobservable transitions, recursively compute the complete
  set of minimum-total-token initial markings capable of producing an observed
  label word.
- Complexity analysis: polynomial in observation length with fixed structural
  parameters, but exponential in some net parameters.
- Heuristics: two cheaper variants return only an approximation or partial set
  and are kept separate from the complete algorithm.

## Relationship and evidence limit

This strictly extends the retained Li--Hadjicostis marking problem to a special
unobservable-transition structure. It returns an optimization-restricted
initial-state inverse set, not a partition of all caller inputs, and it has no
typed program residual.
