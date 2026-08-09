# colaco2018scadekahn — SCADE to multicore Kahn implementation

- **Status:** screened; synchronous-to-KPN implementation boundary
- **Primary source:** https://doi.org/10.1109/FDL.2018.8524052
- **Open institutional record:** https://hal.science/hal-01960410
- **Version read:** complete author-deposited paper
- **Bibliography key:** `colaco2018scadekahn`

## Evidence locations

- Section II: SCADE 6 has a stream-based Kahn semantics, with static clock and
  causality checks supplying bounded-memory and deadlock-avoidance conditions.
- Section IV-A: task annotations affect generated-code organization but not the
  source model's semantics.
- Section IV-B and conclusion: generated tasks form a Kahn process network that
  computes the same streams while preserving deterministic behavior.

## Relationship and evidence limit

This is a meaning-preserving source-language-to-multicore boundary over whole
streams. It neither exposes a requested sparse internal observer nor enumerates
the exact caller inputs inducing each observation.
