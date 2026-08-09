---
citekey: bemporad2015multiparametric
work:
  title: "A Multiparametric Quadratic Programming Algorithm With Polyhedral Computations Based on Nonnegative Least Squares"
  author: "Alberto Bemporad"
  venue: "IEEE Transactions on Automatic Control"
  date: 2015
  doi: 10.1109/tac.2015.2417851
read: full-text
source: "Published article via https://doi.org/10.1109/TAC.2015.2417851 (open copy: https://iris.imtlucca.it/handle/20.500.11771/4078)"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Constructs full-dimensional mpQP critical regions via dual-QP nonnegative least squares — a dense critical-region partition of one convex program, not sparse internal observations of a requested result in an arbitrary graph"
---

# A Multiparametric Quadratic Programming Algorithm With Polyhedral Computations Based on Nonnegative Least Squares

## Evidence

### Contribution

Bemporad constructs full-dimensional critical regions of a strictly convex
multiparametric quadratic program using the dual QP and nonnegative least
squares for the polyhedral subproblems. The method detects emptiness and full
dimension, removes redundant inequalities, handles rank-deficient active
constraints by projection, and recovers the unique affine primal optimizer.

The traversal records visited *optimal combinations*.

### Complexity and boundary

With \(q\) constraints there are at most \(2^q\) combinations.

### Evidence locations

- Sections II--III: primal/dual mpQP and critical-region construction.
- Polyhedral-operation results: NNLS feasibility, dimension, and redundancy.
- Main algorithm: optimal-combination traversal and projection under rank
  deficiency.
- Numerical section: NNLS performance evidence and solver qualifications.

## Bearing on RQs

Its target remains the dense critical-region partition of one strict-convex
pQP, not sparse internal observations of a requested result in an arbitrary
graph.

## Evidence limits

Under degeneracy that identifier is not proved to be a canonical one-to-one
quotient of geometric regions or affine behaviors. The default facet-stepping
method also delegates rare non-facet-to-facet cases to more general methods
such as Patrinos--Sarimveis; it should not be cited alone for unrestricted
completeness. The paper gives algorithmic and empirical NNLS comparisons but
no output-sensitive total-time, delay, auxiliary-space, or bit-complexity
theorem.
