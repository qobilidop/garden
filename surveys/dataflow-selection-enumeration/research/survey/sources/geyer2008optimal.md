# geyer2008optimal — optimal reduction of polyhedral piecewise systems

- **Status:** deep-read; critical behavior-quotient baseline
- **Primary source:** https://doi.org/10.1016/j.automatica.2007.11.027
- **Open copy:** https://www.tobiasgeyer.org/GeTM08_OptRed.pdf
- **Logic-minimizer reference:** https://digicoll.lib.berkeley.edu/record/135029/files/ERL-86-65.pdf
- **Version read:** author manuscript of the 2008 journal article
- **Bibliography key:** `geyer2008optimal`

## Why it matters

Geyer, Torrisi, and Morari compute smaller exact representations of
polyhedral piecewise systems by merging cells that carry the same behavior.
They treat both disjoint partitions and overlapping covers and formulate
minimum-cardinality problems. This is a stronger and earlier baseline than
later neural-network work for globally coalescing equal-affine regions. It is
also the precise counterpoint to our observer: selection observations
deliberately retain distinct observed outcomes even when their residual
functions are equal.

## Input and guard representation

The input is a polyhedral piecewise system on a domain \(R\), normally a PWA
system with regions \(P_j\) and behaviors \(y=f_j(x)\). The exact core
algorithms assume that the regions are cells of a known hyperplane arrangement
and have total sign-vector markings. Cells with the same behavior are assigned
one color. The construction can also apply to non-affine piecewise functions
when equality of the behavior on the proposed merged union is established.

A marking lies in \(\{-,+\}^n\). Replacing selected coordinates by `*` deletes
their hyperplane literals; the resulting cube denotes a polyhedron that is the
union of the covered cells. In the logic formulation, a product term of a DNF
therefore becomes one polyhedral guard and each retained literal becomes one
facet.

The displayed simplified signs use both \(a_i^Tx\le b_i\) and
\(a_i^Tx\ge b_i\), so boundary points satisfy both sides. Remark 4 and a
footnote say that the original disambiguating inequalities can be retained by
trivial modifications, but the modified algorithms are not printed. Exact
deterministic partition claims are therefore safest on cell interiors or with
an explicit inherited tie rule.

## Disjoint reduction

Algorithm 1 recursively splits an envelope containing same-color cells along
arrangement hyperplanes. A branch is accepted when its envelope contains no
cell of another color and rejected when it contains no target cell; the
\(z,\bar z\) bookkeeping supplies branch-and-bound pruning. Lemma 17 proves
that the output preserves exactly the target union, has only lower-dimensional
pairwise intersections, and has minimum cardinality among the representations
allowed by Problem 6.

That minimum is representation-relative. Every output polyhedron must be a
union of original cells and its cuts must come from the supplied arrangement.
Section 8 gives an example where adding a new hyperplane produces a smaller
partition. The theorem is not unrestricted minimum convex partitioning.

## Overlapping reduction

Algorithm 2 builds a Boolean truth table for each color: target cells are
`1`, other-color cells are `0`, and empty arrangement sign vectors are
don't-cares. Logic minimization returns an exact possibly overlapping cover;
every overlap has the same behavior. Lemma 19 states lexicographic optimality:
first minimum polyhedron count and then minimum total facet count. Algorithm 3
first constructs the full arrangement when the original partition was not
already arrangement-marked, and Lemma 21 lifts the reduction to that case.

The optimality statement is conditional on an exact lexicographic logic
minimizer. The experiments name ESPRESSO-II but describe its heuristics and do
not document an exact invocation. Berkeley's ESPRESSO exact-mode report states
that exact mode guarantees a minimum number of product terms while literal
minimization remains heuristic. Consequently, minimum polyhedron count is
defensible when exact cover mode is used; the secondary minimum-facet claim is
not established by that implementation alone, and a default heuristic run
establishes neither global optimum.

## Preservation, noncanonicity, and complexity

Every accepted guard retains the unchanged function/color of its source cells,
so the exact algorithms preserve state update, output, or controller action at
every input under the boundary convention. Approximate Algorithm 4 is separate:
it averages similar hyperplanes and deliberately permits behavior error.

The algorithm returns one optimum, not all optimum covers. Example 16 notes
multiple equally sized solutions. No canonicality or uniqueness theorem is
given; branch order and logic-minimizer tie breaking can choose different
optima.

The optimization problems are NP-hard. Algorithm 1 is exhaustive
branch-and-bound and has no sharper closed asymptotic guarantee. Algorithm 2
materializes logic-minimization data exponential in the number of arrangement
hyperplanes in the worst case. When markings already exist, neither algorithm
needs new LP calls; Algorithm 3 adds LP-based arrangement construction and can
greatly increase the number of cells. The reported scale and reduction ratios
are empirical, not output-sensitive or delay bounds.

## Relationship to selection observations

After exact observation fibers and their residuals have been computed, this
paper's color reduction can merge fibers whose residual behavior is equal. That
is a different quotient from ours. If two alternatives of an observed
selection site both compute \(x+1\), Geyer's behavior quotient may merge them;
our selection observation must keep the two site outcomes distinct. Conversely,
an unobserved site is structurally absent from our partial map rather than a
don't-care literal introduced while covering dense arrangement cells.

The work defeats novelty for:

- behavior-preserving merging of equal-affine polyhedral cells;
- minimum-cardinality disjoint reduction within a fixed arrangement;
- minimum-product overlapping guard covers under an exact Boolean minimizer;
  and
- Boolean implementation of arrangement-marked PWA controllers.

It does not define a requested-root-relative sparse site observer, contextual
graph identities, typed shared residual DAGs, or preservation of distinct
observed outcomes with equal residuals.

## Evidence locations

- Sections 2.2--3 and Assumption 1: input model, colors, and optimization
  problems.
- Section 5.1, Algorithm 1, and Lemma 17: exact minimum disjoint reduction.
- Sections 6--7, Algorithms 2--3, and Lemmas 19 and 21: overlapping and general
  reductions.
- Section 8: a new cutting hyperplane can improve the restricted disjoint
  optimum.
- Sections 7.2 and 9.1: approximate reduction versus exact behavior
  preservation.
- Sections 9--11: empirical scale, implementation, and limitations.

## Limitations

- Minimum cardinality is relative to the stated representation class.
- The non-disjoint theorem depends on a genuinely exact logic minimizer.
- The printed boundary treatment needs an explicit tie convention.
- No OutputP, IncP, DelayP, coefficient-bit, or canonical-output result is
  proved.
