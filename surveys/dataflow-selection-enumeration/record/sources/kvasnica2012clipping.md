---
citekey: kvasnica2012clipping
work:
  title: "Clipping-Based Complexity Reduction in Explicit MPC"
  author: "Michal Kvasnica, Miroslav Fikar"
  venue: "IEEE Transactions on Automatic Control"
  date: 2012
  doi: 10.1109/tac.2011.2179428
read: full-text
source: "Published IEEE TAC article via https://doi.org/10.1109/TAC.2011.2179428 (open copy https://uiam.sk/~kvasnica/prof21/16_separaty_a_citacie_komplet.pdf)"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Clipping-based PWA controller factorization removes saturated-region descriptions and applies a componentwise clipping filter that is proved pointwise identical to the original controller — an exact factorization that erases distinct observed outcomes, unlike a selection observer that preserves them"
---

# Clipping-Based Complexity Reduction in Explicit MPC

## Evidence

### Contribution

Kvasnica and Fikar remove descriptions of regions on which a continuous PWA
controller is saturated, extend the remaining unsaturated affine pieces, and
apply a componentwise clipping filter. Theorem 4.12 proves the composite
replacement is pointwise identical to the original controller:

\[
  \phi(\widetilde\kappa(x))=\kappa(x).
\]

This is an exact filtered factorization, not an approximation and not merely a
closed-loop-performance equivalence. The unclipped augmented function alone
may be discontinuous and unequal to the original.

### Construction and complexity

Algorithm 1 removes facets facing weakly adjacent saturated regions, subtracts
overlaps with other unsaturated regions, restores uncovered saturated pieces,
and falls back to the original representation when the transformation would
increase region count. Consequently

\[
  |I_{\mathrm{unsat}}|\leq \widetilde R\leq R.
\]

Set difference can create exponentially many regions offline. Online clipping
adds \(2n_u\) comparisons. The paper proves neither minimality, uniqueness,
canonicity, output-polynomial construction, nor a delay bound.

## Bearing on RQs

The construction preserves the controller's output function while erasing
saturated-region descriptions. Our selection observer deliberately preserves
distinct observed outcomes even when their residual values agree. Exact
pointwise factorization, behavior quotienting, and intensional event
observation are therefore different objects.

## Evidence limits

Read at full-text level from the published IEEE TAC article; the note records
no limitations beyond the scope distinction already given in Bearing on RQs
above.
