# madalinski2009modularprefix — Modular finite complete prefixes

- **Status:** screened; modular complete-prefix boundary
- **Primary source:** https://doi.org/10.3233/FI-2009-148
- **Primary open record and full text:**
  https://inria.hal.science/inria-00204548
- **Version read:** full journal treatment, cross-checked against the INRIA
  research-report version and Crossref metadata
- **Bibliography key:** `madalinski2009modularprefix`

## Evidence locations

- Sections 2--3 model a distributed system as labelled Petri-net components
  composed through interface nets. The global unfolding factorizes into
  compatible component unfoldings; projecting it gives minimal factors that
  retain exactly the component behavior feasible in the composed system.
- Section 4 defines modular prefix factors for a finite complete prefix rather
  than first constructing and then projecting a global prefix. Interface
  summaries restrict a component to behavior compatible with its neighbor,
  and the resulting factors can be recomposed to cover a global finite
  complete prefix.
- The exact construction assumes automaton interfaces so that projection does
  not introduce fake concurrency. For more complex distributed systems, the
  exact message-passing construction is restricted to a tree interaction
  structure; the paper describes non-tree use as approximate.
- Section 5's propagation and merge rules recursively compute summaries and
  modular prefix factors along such a tree. Proposition 5.1 proves the
  propagation rule: the factor obtained using the recursively summarized
  neighboring subsystem equals the factor obtained from that subsystem
  directly. The merge rule combines the information arriving through several
  interfaces.
- Section 6 concludes that the global net need never be built. Each component
  repeatedly unfolds locally with received summary nets and sends new
  summaries to its neighbors. Factorization can be more compact because a
  component does not reproduce conflicts local to other components.

## Relationship and evidence limit

This strengthens the existing product-factorization comparator from full
symbolic unfoldings to a distributed, factorized finite-complete-prefix
construction. Its summaries range over component behavior at Petri-net
interfaces, and its completeness is for global net runs represented by the
recomposed factors. It does not enumerate the image of a requested internal
program observer, its exact caller-input inverse fibers, or a typed residual
function on each fiber.
