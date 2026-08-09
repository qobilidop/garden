# dussault2025bdifferential — B-differential enumeration

- **Status:** deep-read; critical current arrangement-enumeration baseline
- **Primary source:** https://doi.org/10.1007/s12532-024-00266-8
- **Open copy:** https://optimization-online.org/wp-content/uploads/2023/03/dussault-gilbert-plaqueventjourdain-2023-03-27-2.pdf
- **Version read:** March 2023 author manuscript of the 2025 journal article
- **Bibliography key:** `dussault2025bdifferential`

## Why it matters

Dussault, Gilbert, and Plaquevent-Jourdain reduce enumeration of the
B-differential of a componentwise minimum of two affine vector functions to
enumeration of strict sign cells in a central hyperplane arrangement. They then
give a matroid-circuit algorithm and several explicitly corrected or improved
variants of Rada and Černý's incremental recurrence. This is the most recent
proof-bearing algorithmic baseline in the arrangement lineage currently in the
survey.

## Exact object and reduction

Fix

\[
  H(x)=\min(Ax+a,Bx+b)
\]

componentwise and a point \(x\). Only the \(p\) tied components whose two
affine gradients differ contribute choices. Writing those gradient differences
as the nonzero columns of \(V\in\mathbb R^{n\times p}\), define

\[
  S(V)=\{s\in\{-1,+1\}^p:\exists d,\ s\mathbin{\odot}V^Td>0\}.
\]

Proposition 3.3 proves a bijection between \(S(V)\) and the limiting Jacobians
in \(\partial_BH(x)\). Proposition 3.19 proves a second bijection between
\(S(V)\) and the open cells of the central arrangement
\(\{d:v_i^Td=0\}_{i=1}^p\). The enumerated object is therefore a dense total
sign vector and its corresponding Jacobian at one fixed base point, not an
input-domain partition of the original function.

The structural results include symmetry (Proposition 4.1), completeness iff
\(V\) is injective (Proposition 4.2), sign-flip connectivity iff no two columns
are collinear (Proposition 4.5), and cardinality bounds in Propositions 4.7 and
4.10. The number of outputs can be exponential in \(p\).

## Algorithms and guarantees

Algorithms 5.3--5.4 define the common depth-first sign-prefix tree. At a prefix,
the membership procedure decides which of its two extensions lie in the next
feasible sign set; infeasible prefixes have no feasible descendants. Consequently
the leaves are exactly \(S(V)\), with no duplicate leaf path.

Two families instantiate that tree:

- `stem` uses matroid circuits and Gordan's alternative to recognize infeasible
  sign subvectors without linear optimization; and
- `isf` combines circuit information, precomputed independent columns,
  witness-direction tests, and dual-simplex feasibility checks to improve the
  Rada--Černý recurrence.

The paper proves the underlying membership and circuit propositions but does
not give an OutputP, polynomial-delay, or end-to-end asymptotic bound for the
new implementations. Circuit generation itself may be exponential. The
reported speedups of roughly 7--15 on average, and over 30 on some instances,
are empirical CPU-time ratios against the authors' Rada--Černý implementation,
not universal complexity factors.

## Correction to the incremental baseline

Section 5.2.1 observes that the literal Rada--Černý pseudocode does not fully
handle a stored witness direction satisfying \(v_{k+1}^Td=0\): both strict
successors may be feasible. Dussault et al. replace it by two safe perturbations
and explore both successors. Rada and Černý's proof already says that the
degenerate witness must be perturbed and charges that work, so this is best
reported as a pseudocode/implementation caveat rather than a refutation of
their stated theorem.

## Relationship to our framework

This work further settles exact dense sign enumeration and supplies a current
algorithmic comparison point. A limiting Jacobian is also a local residual
linear map, but the procedure is local to one point and every tied component
receives a sign. It has no requested output, graph-derived enabled closure,
varying observation domain, contextual selection-site identity, or typed
dataflow residual. Its circuit tests may nevertheless inspire feasibility
pruning for special linear selector families.

## Evidence locations

- Proposition 3.3 and Equivalence 3.4: B-differential/sign-system bijection.
- Proposition 3.19 and Equivalence 3.20: central-arrangement-cell bijection.
- Propositions 4.1--4.10: symmetry, completeness, connectivity, and counts.
- Algorithms 5.3--5.8: exact sign-prefix, Rada--Černý, and stem recurrences.
- Proposition 5.9 and Algorithms 5.11--5.12: circuit extraction and `isf`.
- Section 5.2.6 and Tables 5.2--5.3: empirical comparisons and caveats.

## Limitations

- The new algorithms specialize to central arrangements with nonzero normals.
- Floating-point rank, circuit, and near-zero tests affect the implementation;
  the experiments are not exact-arithmetic certificates.
- The paper does not derive a general output-sensitive complexity theorem for
  `stem` or `isf`.
