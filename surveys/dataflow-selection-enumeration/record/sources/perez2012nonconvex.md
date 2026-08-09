# perez2012nonconvex — exact explicit MPC under nonconvex polyhedral constraints

- **Status:** deep-read; medium-priority construction baseline
- **Primary source:** https://doi.org/10.1016/j.automatica.2011.07.011
- **Version read:** author preprint of the published article
- **Bibliography key:** `perez2012nonconvex`

## Contribution

Pérez, Ariño, Blasco, and Martínez construct an explicit controller for a
linear MPC problem whose admissible set is a union of convex polyhedra. They
solve a convex-hull relaxation, classify and subdivide affected regions,
retain multiple affine optimizer candidates, soundly remove candidates through
sum-of-squares refutations, merge convex unions with identical candidate sets,
and choose the minimum-cost remaining candidate online.

Bounded-degree SOS search is incomplete: failure to find a certificate retains
the candidate. Pruning is therefore sound. Under exact subproblem and
optimization assumptions, the online result remains globally optimal. Because
ties can retain multiple candidates, the output is best viewed as an exact
optimal-controller relation rather than equality to one predetermined PWA map.

The paper's online operation-count comparison is relative to an alternative
tree representation; it is not an offline output-sensitive, delay, space, or
bit-complexity theorem. This exact refinement/pruning construction is prior
art, but it has no requested-root sparse event observer.
