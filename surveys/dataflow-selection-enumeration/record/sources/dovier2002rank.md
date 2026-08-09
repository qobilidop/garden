# dovier2002rank — Rank-based symbolic bisimulation

- **Status:** deep-read; exact symbolic-quotient comparator
- **Primary source:** https://doi.org/10.1016/S1571-0661(04)80547-4
- **Version read:** primary full text
- **Bibliography key:** `dovier2002rank`

## Evidence locations

- Algorithm: use rank information and decision-diagram operations to compute
  the maximum bisimulation relation fully symbolically.
- Correctness development: relates the fixed-point result to the largest
  bisimulation on the represented transition system.

## Relationship and evidence limit

The method is an exact symbolic behavior quotient, but its objects are
transition-system states rather than caller-input fibers and typed residuals.
