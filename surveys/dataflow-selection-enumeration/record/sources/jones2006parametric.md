---
citekey: jones2006parametric
work:
  title: "Reverse Search for Parametric Linear Programming"
  author: "Colin N. Jones, Jan M. Maciejowski"
  venue: "CDC 2006"
  date: 2006
  doi: 10.1109/cdc.2006.377799
read: full-text
source: "Open conference preprint at https://infoscience.epfl.ch/server/api/core/bitstreams/84c29bf6-b53a-4260-a2f1-552dee61efcf/content (DOI https://doi.org/10.1109/cdc.2006.377799)"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Reverse search enumerates every full-dimensional critical region of a multi-parametric LP in duplicate-free, output-sensitive, constant output-relative-space traversal, each basis reconstructing an exact polyhedral guard and affine optimizer — a direct geometric residual-enumeration baseline predating the neural-network guard-plus-affine-map line"
---

# reverse search for parametric linear programming

## Evidence

### Why it matters

Jones and Maciejowski enumerate every full-dimensional critical region of a
multi-parametric linear program by reverse search. The traversal is
duplicate-free, output-sensitive, and constant in output-relative auxiliary
space. Each emitted basis determines an exact polyhedral guard and reconstructs
the affine optimizer. This predates the neural-network guard-plus-affine-map
line and gives a direct geometric residual-enumeration baseline.

### Parametric model and output

The standard form is

\[
  \min_\lambda (Ex)^T\lambda,
  \qquad
  D=\{\lambda:A\lambda=b,\;\lambda\ge0\},
  \qquad x\in X,
\]

where \(A\in\mathbb R^{m\times n}\) has rank \(m\),
\(E\in\mathbb R^{n\times d}\) has rank \(d\), and \(D\) is bounded. The paper
also transforms an affine-offset MPC formulation into this homogeneous form.

Algorithm 1 reports each basis \(B\) defining a full-dimensional critical
region

\[
  R_B=\{x:F^TEx\le0\}\cap X.
\]

Theorem 4 proves that \(B\) defines such a region exactly when
\(E^T\lambda_B\) is a vertex of the projected polytope \(E^TD\). For the
original primal pLP, the basis reconstructs the affine optimizer

\[
  u^\star(x)=A_{\ast,B}^{-T}(E_{B,\ast}x+c_B),
  \qquad x\in R_B.
\]

The pseudocode emits bases rather than serializing these formulas, but the
exact guard and residual are mechanically determined by each output.

### Reverse-search algorithm

The algorithm walks the one-skeleton of \(E^TD\). At basis \(B\), the
`neighbour` operation removes redundant projected tangent rays, coalesces
identical rays by retaining the smallest index, and solves an LP to reach the
adjacent vertex. A generic linear objective \(\rho\) defines a unique parent by
choosing the incident edge of steepest decrease. Depth-first reverse search
then traverses the induced rooted tree without a visited set or stored stack.

Lexicographic perturbation supplies one basis per critical region. Theorem 4
reduces region enumeration to vertex enumeration, and the unique-parent tree
visits each vertex exactly once. The critical regions cover \(X\) and have
disjoint relative interiors. Closed guards can overlap on boundaries, and
lower-dimensional-only regions are not reported.

### Assumptions and printed-contract caveats

The result assumes:

- a full-dimensional parameter domain \(X\);
- a bounded optimum for every \(x\in X\);
- lexicographic right-hand-side perturbation to remove primal degeneracy;
- full rank of \([E\ c]\) for affine homogenization;
- a generic \(\rho\) not parallel to a projected-polytope edge;
- an available root critical-region basis; and
- exact LP decisions under the paper's arithmetic cost model.

Two details are implicit rather than correct in the literal pseudocode. First,
because the parent map descends \(\rho\), the supplied root must be the unique
minimizer of the root LP, or \(\rho\) must be chosen from that root's normal
cone. The stated input contract says only that the root maps to a vertex.
Second, Algorithm 1 lacks an explicit halt after the root has exhausted its
neighbor counter. Standard reverse-search termination is clear from the prose,
but an implementation of the printed loop needs that stop condition.

### Complexity

Let \(e=n-m\) and let \(N_r\) be the number of output regions. Equations
16--20 give

\[
  O\!\left(
    N_r\left(e^2 LP(d,e)+e\,LP(m,n)\right)
  \right)
\]

time. This is linear in output count only after retaining the polynomial LP and
dimension-dependent coefficient. The paper's \(O(1)\)-space statement is
output-relative auxiliary space: the implementation still stores \(E,A,b\),
one basis, and a counter. It proves no coefficient-bit complexity or
polynomial-delay classification. The paper also notes that the hidden
coefficient makes the method slower on small instances despite its better
asymptotic dependence on \(N_r\).

### Evidence locations

- Section II-C--D and equations 8--12: standard form and affine optimizer
  reconstruction.
- Definition 3 and Theorem 4: critical regions as projected-polytope vertices.
- Sections IV--IV-B, Algorithm 1, and Theorem 5: neighbor computation and
  reverse-search traversal.
- Equations 16--20 and Section V: time and space complexity.
- Sections VI--VII: optional memory/parallel extensions and example.

## Bearing on RQs

This work establishes exact, duplicate-free, output-sensitive enumeration of
full-dimensional real-polyhedral guards with reconstructible affine residuals.
It therefore defeats any claim that guard-plus-affine residual enumeration
first arose in neural-network analysis or in our framework.

Its quotient and source model are nevertheless different. A critical region
is determined by an optimizer basis/projected-polytope vertex, not by the
partial outcomes of graph selection sites. Every reported case is
full-dimensional; there is no input-dependent structural absence, requested
output, typed DAG sharing, contextual selection identity, or requirement to
retain two equal optimizer behaviors because they traversed different observed
events.

## Evidence limits

- Only full-dimensional pLP critical regions are enumerated.
- Closed guards need a boundary ownership convention for a literal partition.
- The root/objective linkage and final root halt are omitted from the printed
  algorithm contract.
- The complexity is an arithmetic/LP abstraction, not a coefficient-bit or
  delay theorem.
