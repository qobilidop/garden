# vijayaraghavan2009bounded — Bounded dataflow and latency-insensitive circuits

- **Status:** screened; modular dataflow-to-circuit refinement
- **Primary source:** https://doi.org/10.1109/MEMCOD.2009.5185393
- **Open author copy:** https://people.csail.mit.edu/vmurali/papers/libdns.pdf
- **Version read:** complete author copy
- **Bibliography key:** `vijayaraghavan2009bounded`

## Evidence locations

- Model: synchronous sequential machines are refined to bounded dataflow
  networks connected by latency-insensitive channels.
- Composition result: correct component refinements compose across arbitrary
  circuit cuts.
- Preservation result: the bounded network preserves cycle-accurate behavior
  under the paper's refinement assumptions.

## Relationship and evidence limit

The work supplies an older modular hardware/dataflow refinement guarantee and
compositional latency-insensitivity boundary. Its object is whole circuit
behavior, not exact caller-input fibers under a requested internal event map.
