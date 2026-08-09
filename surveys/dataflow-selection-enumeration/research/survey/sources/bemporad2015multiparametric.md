# bemporad2015multiparametric — mpQP regions using NNLS polyhedral operations

- **Status:** deep-read; high-priority computational baseline
- **Primary source:** https://doi.org/10.1109/TAC.2015.2417851
- **Open copy:** https://iris.imtlucca.it/handle/20.500.11771/4078
- **Version read:** published article
- **Bibliography key:** `bemporad2015multiparametric`

## Contribution

Bemporad constructs full-dimensional critical regions of a strictly convex
multiparametric quadratic program using the dual QP and nonnegative least
squares for the polyhedral subproblems. The method detects emptiness and full
dimension, removes redundant inequalities, handles rank-deficient active
constraints by projection, and recovers the unique affine primal optimizer.

The traversal records visited *optimal combinations*. Under degeneracy that
identifier is not proved to be a canonical one-to-one quotient of geometric
regions or affine behaviors. The default facet-stepping method also delegates
rare non-facet-to-facet cases to more general methods such as Patrinos--
Sarimveis; it should not be cited alone for unrestricted completeness.

## Complexity and boundary

With \(q\) constraints there are at most \(2^q\) combinations. The paper gives
algorithmic and empirical NNLS comparisons but no output-sensitive total-time,
delay, auxiliary-space, or bit-complexity theorem. Its target remains the
dense critical-region partition of one strict-convex pQP, not sparse internal
observations of a requested result in an arbitrary graph.

## Evidence locations

- Sections II--III: primal/dual mpQP and critical-region construction.
- Polyhedral-operation results: NNLS feasibility, dimension, and redundancy.
- Main algorithm: optimal-combination traversal and projection under rank
  deficiency.
- Numerical section: NNLS performance evidence and solver qualifications.

