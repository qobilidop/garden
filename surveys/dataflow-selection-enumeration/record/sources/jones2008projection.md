---
citekey: jones2008projection
work:
  title: "On Polyhedral Projection and Parametric Programming"
  author: "Colin N. Jones, Eric C. Kerrigan, Jan M. Maciejowski"
  venue: "JOTA 138(2)"
  date: 2008
  doi: 10.1007/s10957-008-9384-4
read: full-text
source: "Author manuscript via https://citeseerx.ist.psu.edu/document?doi=76e7717dac526cc8ec5dd744f0ff4784c67bd9e6&repid=rep1&type=pdf, cross-checked against https://doi.org/10.1007/s10957-008-9384-4"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Proves polynomial two-way input and output conversions between solving a parametric linear program and polyhedral projection, closing an easy novelty route based on presenting projection as a fundamentally different exact partition mechanism"
---

# polyhedral projection and pLP interreduction

## Evidence

### Contribution

Jones, Kerrigan, and Maciejowski prove polynomial input and output conversions
in both directions between solving a parametric linear program and projecting
a polyhedron described by halfspaces. A pLP solution can be obtained as a
projection, and an appropriately constructed pLP returns a requested
polyhedral projection. Algorithms for either problem class therefore transfer
to the other with polynomial conversion overhead.

### Evidence locations

- Abstract and Section 1: two-way reduction and polynomial conversions.
- Sections 2–3: construction of a projection from a pLP solution.
- Sections 4–5: construction of a pLP for polyhedral projection and conversion
  of its solution back to the projected representation.

## Bearing on RQs

This interreduction closes an easy route to novelty based on presenting
polyhedral projection as a fundamentally different exact partition mechanism.
It also explains why projection-oriented and pLP enumeration algorithms share
the same geometric frontier.

## Evidence limits

- The result concerns extensional polyhedral sets and pLP solutions. It does
  not encode which internal graph selections were structurally observed,
  retain equal-valued events, or derive a typed symbolic residual from a
  general shared dataflow graph.
