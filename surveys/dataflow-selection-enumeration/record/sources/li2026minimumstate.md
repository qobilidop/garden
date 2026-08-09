# li2026minimumstate — Minimum timed initial-state estimation

- **Status:** screened; direct timed inverse-set extension
- **Primary source:** https://doi.org/10.1016/j.ins.2025.122618
- **Version read:** publisher abstract and introduction
- **Bibliography key:** `li2026minimumstate`

## Evidence locations

- Abstract: a minimum initial state combines a minimum-token initial marking
  with timing constraints for transitions enabled there.
- Algorithm outline: under finitely many silent firings before any observable
  transition, logical consistency yields candidate minimum markings and a
  route-modified state-class graph filters them for time-label consistency.

## Relationship and evidence limit

This is the closest timed extension of the minimum-initial-marking inverse
fiber. It returns an optimization-restricted set for a Petri-net task record,
not all dataflow caller-input fibers or program residuals.
