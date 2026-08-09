# rakow2012safetyslicing — Safety slicing for Petri nets

- **Status:** screened; safety-property-preserving reduction boundary
- **Primary source:** https://doi.org/10.1007/978-3-642-31131-4_15
- **Version read:** complete proceedings paper
- **Bibliography key:** `rakow2012safetyslicing`

## Evidence locations

- Abstract and Section 3: a safety slice is a subnet relative to interesting
  places and has a state space no larger than the original net's.
- Section 3, Proposition 9: equality of unstuttered finite traces preserves
  every stutter-invariant linear-time safety property.
- Safety-preservation result: when the property mentions only criterion places,
  the original net satisfies it exactly when the safety slice does; liveness is
  explicitly outside this guarantee.

## Relationship and evidence limit

This is a strong property-relative subnet construction with a bidirectional
safety guarantee. It returns one reduced transition system, not all observation
values and their exact caller-input fibers or typed residuals.
