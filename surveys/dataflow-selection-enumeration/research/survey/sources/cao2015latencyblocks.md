# cao2015latencyblocks — Latency-insensitive dataflow blocks

- **Status:** screened; hardware buffering and composition boundary
- **Primary source:** https://doi.org/10.1109/MEMCOD.2015.7340485
- **Open author copy:** https://www.cs.columbia.edu/~sedwards/papers/cao2015implementing.pdf
- **Version read:** complete author copy
- **Bibliography key:** `cao2015latencyblocks`

## Evidence locations

- Abstract and Section 2: valid/stop channels and backpressure hold tokens until
  consumption without loss or duplication.
- Section 3: the input- and output-buffer correctness argument proves that the
  output token sequence equals the input token sequence.
- Sections 4--6: the buffers compose around unit-rate, general firing-rule, and
  Kahn-network cores without a pipeline-length-dependent combinational path.

## Relationship and evidence limit

The paper proves a local token-sequence-preserving implementation discipline.
It does not enumerate semantic observations or symbolic input fibers, and its
guarantee is scoped to the stated hardware flow-control protocol.
