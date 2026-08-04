# kvasnica2012clipping — exact clipped factorization of a PWA controller

- **Status:** deep-read; high-priority exact-representation baseline
- **Primary source:** https://doi.org/10.1109/TAC.2011.2179428
- **Open copy:** https://uiam.sk/~kvasnica/prof21/16_separaty_a_citacie_komplet.pdf
- **Version read:** published IEEE TAC article
- **Bibliography key:** `kvasnica2012clipping`

## Contribution

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

## Construction and complexity

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

## Relationship to the observer

The construction preserves the controller's output function while erasing
saturated-region descriptions. Our selection observer deliberately preserves
distinct observed outcomes even when their residual values agree. Exact
pointwise factorization, behavior quotienting, and intensional event
observation are therefore different objects.

