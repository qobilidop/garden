# jones2008projection — polyhedral projection and pLP interreduction

- **Status:** deep-read; reduction baseline
- **Primary source:** https://doi.org/10.1007/s10957-008-9384-4
- **Open author copy:**
  https://citeseerx.ist.psu.edu/document?doi=76e7717dac526cc8ec5dd744f0ff4784c67bd9e6&repid=rep1&type=pdf
- **Version read:** author manuscript, cross-checked against the published
  article metadata
- **Bibliography key:** `jones2008projection`

## Contribution

Jones, Kerrigan, and Maciejowski prove polynomial input and output conversions
in both directions between solving a parametric linear program and projecting
a polyhedron described by halfspaces. A pLP solution can be obtained as a
projection, and an appropriately constructed pLP returns a requested
polyhedral projection. Algorithms for either problem class therefore transfer
to the other with polynomial conversion overhead.

## Relevance and boundary

This interreduction closes an easy route to novelty based on presenting
polyhedral projection as a fundamentally different exact partition mechanism.
It also explains why projection-oriented and pLP enumeration algorithms share
the same geometric frontier.

The result concerns extensional polyhedral sets and pLP solutions. It does not
encode which internal graph selections were structurally observed, retain
equal-valued events, or derive a typed symbolic residual from a general shared
dataflow graph.

## Evidence locations

- Abstract and Section 1: two-way reduction and polynomial conversions.
- Sections 2–3: construction of a projection from a pLP solution.
- Sections 4–5: construction of a pLP for polyhedral projection and conversion
  of its solution back to the projected representation.
