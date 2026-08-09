# klai2015tag — Timed aggregate graphs for Time Petri Nets

- **Status:** screened; finite timed-state abstraction
- **Primary source:** https://doi.org/10.1007/978-3-662-48650-4_3
- **Version read:** publisher abstract and chapter metadata
- **Bibliography key:** `klai2015tag`

## Evidence locations

- Construction: the timed aggregate graph is finite for the stated bounded
  strong-semantics Time Petri-net setting.
- Preservation: it retains timed traces and reachable states needed for
  event- and state-based quantitative properties.
- Witnesses: explicit timed runs can be reconstructed from aggregate paths.

## Relationship and evidence limit

This is a full timed-state/trace abstraction rather than a requested-input
observer. It preserves and reconstructs timed executions, but does not emit
exact caller-input fibers or symbolic program residuals.
