# zhang2015relaxeddpor — DPOR for relaxed memory

- **Status:** screened; weak-memory schedule quotient
- **Primary source:** https://doi.org/10.1145/2737924.2737956
- **Version read:** author-hosted PLDI full text
- **Bibliography key:** `zhang2015relaxeddpor`

## Evidence locations

- Model and algorithm: thread scheduling and store-buffer nondeterminism are
  represented in one transition framework so dynamic POR can soundly check
  reachability properties under TSO and PSO.
- Qualification: a separate finite buffer bound reduces exploration more
  aggressively but intentionally gives up complete weak-memory coverage.

## Relationship and evidence limit

This broadens exact schedule reduction across memory models and makes the
exact-versus-bounded boundary explicit. Its representatives are traces, not
caller-input observer fibers, and they carry no graph residual.
