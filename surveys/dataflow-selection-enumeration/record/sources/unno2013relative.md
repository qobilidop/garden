# unno2013relative — Relatively complete higher-order verification

- **Status:** deep-read; higher-order verification boundary
- **Primary source:** https://doi.org/10.1145/2429069.2429081
- **Version read:** author-hosted POPL 2013 full text, pp. 75--86 plus appendices
- **Bibliography key:** `unno2013relative`

## Evidence locations

- Sections 3.1--3.2, Theorems 3.6--3.7: a universally quantified refinement
  type system is sound and relatively complete for safety of the stated
  higher-order functional language, relative to first-order reasoning and the
  permitted pure instantiation expressions.
- Section 4 and Section 5: automated constraint generation and parameter
  inference realize a sound prototype, but practical restrictions on formula
  shape, instantiations, integer reasoning, and CEGAR make the implementation
  incomplete; two reported safe benchmarks remain unverified.

## Relationship and evidence limit

This predates the counterexample-complete and canonical-input works already in
the map and blocks a broad priority claim for relatively complete automated
higher-order safety verification. It proves or refutes one safety property; it
does not enumerate every exact first-order observation fiber.
