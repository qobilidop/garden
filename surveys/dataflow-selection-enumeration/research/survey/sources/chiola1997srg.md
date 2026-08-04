# chiola1997srg — A Symbolic Reachability Graph for Coloured Petri Nets

- **Status:** primary-abstract screened; symmetry-quotient comparator
- **Primary source:** https://doi.org/10.1016/S0304-3975(96)00010-2
- **Bibliography key:** `chiola1997srg`

## Evidence locations

- Primary abstract: defines a directly constructed reduced reachability graph
  for the syntactically restricted well-formed-net class.
- Primary abstract: the graph exploits color symmetries, can be substantially
  smaller than ordinary reachability, and its analysis gives equivalent
  results.
- Primary abstract: the unrestricted colored-net case may require procedures
  that are not readily implementable.

## Relationship and evidence limit

This is the foundational exact state-space quotient inherited by Capra's
constraint-based extension. The survey uses only the published high-level
guarantee: it does not transfer the result to arbitrary colored nets, partition
caller inputs, retain requested internal events, or attach a typed residual to
each observer fiber.
