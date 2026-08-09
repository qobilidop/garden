# pick2023psym — Canonical symbolic distributed exploration

- **Status:** screened; symbolic state-and-interleaving reduction
- **Primary source:** https://doi.org/10.1145/3591247
- **Version read:** open-access PACMPL full text
- **Bibliography key:** `pick2023psym`

## Evidence locations

- Design and semantics: fine-grained symbolic configurations canonically group
  sets of distributed executions, avoiding repeated states, interleavings, and
  symbolic computation while retaining safety-bug coverage.

## Relationship and evidence limit

PSym establishes that canonical symbolic configurations can quotient both
state and schedule dimensions. Its object is a distributed transition system,
not a duplicate-free image of a requested dataflow selection observer.
