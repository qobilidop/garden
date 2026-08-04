# sleumer1998output — Output-Sensitive Cell Enumeration in Hyperplane Arrangements

- **Status:** deep-read; critical fixed-dimensional predecessor
- **Primary source:** https://doi.org/10.1007/BFb0054377
- **Publisher preview:** https://page-one.springer.com/pdf/preview/10.1007/BFb0054377
- **Expanded primary treatment:** https://doi.org/10.3929/ethz-a-003889994
- **Version read:** SWAT 1998 pp. 300--301 for the published model and headline
  result; same-author 2000 dissertation, Chapter 3, for detailed pseudocode,
  perturbation treatment, and theorem statements
- **Bibliography key:** `sleumer1998output`

## Why it matters

Sleumer improves the fixed-dimensional reverse-search enumeration of affine
arrangement cells from Avis--Fukuda's \(O(m^2|C|)\) arithmetic time to
\(O(m|C|)\). The algorithm enumerates bounded and unbounded full-dimensional
cells exactly once, under no geometric assumption beyond distinct
hyperplanes. It is therefore the strongest early output-sensitive baseline
for the strict-affine special case.

## Model and enumerated object

The published conference text takes \(m\) distinct affine hyperplanes in fixed
dimension \(d\). Every output is the total sign vector of a nonempty
full-dimensional cell. Parallelism, degeneracy, and unbounded cells are
allowed; the local symbolic perturbation used for deterministic tie-breaking
does not change the arrangement or introduce empty outputs.

The publisher preview exposed conference pp. 300--301, including this model,
its assumptions, the sign-vector representation, and the headline
fixed-dimensional bound. The detailed statements below were checked against
Sleumer's expanded same-author dissertation, Chapter 3; theorem numbering
refers to that treatment rather than to unseen conference pages.

## Algorithm and guarantee

`ParentSearch` chooses a deterministic neighboring cell that flips a negative
sign toward the reoriented all-positive root. `AllAdj` identifies all
hyperplanes supporting facets of the current cell. A reverse traversal of the
resulting parent tree emits every cell exactly once, with depth at most \(m\).
The perturbation scheme makes parent and adjacency decisions locally
deterministic in degenerate arrangements without assuming general position.

The theoretical model has no "cell must contain a vertex" restriction. That
condition appears only in the dissertation's evaluated implementation and
must not be promoted to an algorithmic assumption.

## Complexity

For fixed \(d\), Sleumer proves

\[
  O(m|C|)
\]

total arithmetic time and \(O(m^2)\) space. The first \(k\) cells appear within
\(O(m\ell k)\), where \(\ell\) is maximum cell degree, giving a polynomial-rate
output guarantee. The expanded bound is

\[
O\!\left(
  \bigl(d\,\operatorname{lptime}(m,d)+md^2
  +m\,\operatorname{lptime}(\ell,d)\bigr)|C|
\right)
\]

time and
\(O(m^2+md+\operatorname{lpspace}(m,d))\) space. The analysis counts arithmetic/LP
operations. The dissertation conjectures, rather than proves, a matching
exact-implementation bit bound.

## Relationship to later work and our hypothesis

Rada and Černý explicitly distinguish a reverse-search variant using all
constraints from the Sleumer variant using discovered tight facets. Their
black-box comparison restates a looser maximum-\(\ell\) bound, while their own
incremental algorithm has a different LP profile. Sleumer nevertheless
settles the earlier priority for output-sensitive fixed-dimensional cell
enumeration.

As with Avis--Fukuda, the output is dense: every hyperplane receives a sign.
It does not define graph-derived observation, omit an unselected case cone,
retain a typed symbolic residual, or compose summaries across a dataflow
boundary.

## Evidence locations

- Conference p. 300: full-dimensional cell model, fixed \(d\)
  \(O(m|C|)\), and factor-\(m\) improvement.
- Conference p. 301: distinct-only assumption, sign-vector output, adjacency,
  and parent definitions.
- Dissertation pp. 13--16: reverse tree and `CellEnum`.
- Dissertation pp. 17--19: canonical interior point and `ParentSearch`.
- Dissertation pp. 19--21: `AllAdj`.
- Dissertation pp. 21--23, Theorems 3.2.1--3.2.2: general and fixed-dimension
  complexity and polynomial-rate guarantees.
- Dissertation pp. 23--24: perturbation treatment for degeneracy.
- Dissertation p. 40: implementation-only vertex restriction.

## Questions and limitations

- The output contains only full-dimensional open cells, not the full face
  lattice.
- Detailed conference theorem text was unavailable from the publisher; the
  expanded dissertation is explicitly identified wherever it supplies detail.
- The bit complexity of exact arithmetic is not proved.
