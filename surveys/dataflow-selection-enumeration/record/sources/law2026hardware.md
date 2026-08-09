# law2026hardware — From dataflow semantics to hardware semantics

- **Status:** screened; expanded mechanized program-model boundary
- **Primary source:** https://doi.org/10.70675/33859AF0Z9C09Z423DZB345Z62AE1EC51D10
- **Version read:** university thesis abstract and institutional metadata
- **Bibliography key:** `law2026hardware`

## Evidence locations

- University abstract: the Rocq development is a first step toward a verified
  dynamically scheduled HLS compiler and formalizes dataflow circuits at two
  levels: a dataflow-level specification and a hardware-level implementation.
- Thesis relationship: the 2025 PACMPL article supplies the dataflow-level
  operational semantics, determinacy conditions, and graph/calculus equivalence;
  the dissertation extends the boundary toward hardware implementation.

## Relationship and evidence limit

This expanded mechanization is a close pure-dataflow-to-hardware refinement
boundary. Its semantics relates whole circuit levels and observable channel
behavior. It does not enumerate a requested sparse internal selection map or
its exact caller-input fibers with general residual values.
