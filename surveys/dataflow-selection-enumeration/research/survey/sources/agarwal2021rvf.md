# agarwal2021rvf — Reads-value-from stateless model checking

- **Status:** screened; exact value-observation schedule quotient
- **Primary source:** https://doi.org/10.1007/978-3-030-81685-8_16
- **Version read:** open-access CAV full text
- **Bibliography key:** `agarwal2021rvf`

## Evidence locations

- Definition: reads-value-from equivalence records the value observed by each
  read while abstracting away the identity of same-valued writes.
- Soundness, completeness, and reduction result: the algorithm checks local
  safety and explores at most one maximal trace per RVF class, which can be
  exponentially coarser than reads-from equivalence.

## Relationship and evidence limit

This is an especially direct exact observer quotient. It partitions concurrent
executions, not caller inputs, and carries no symbolic residual per class.
