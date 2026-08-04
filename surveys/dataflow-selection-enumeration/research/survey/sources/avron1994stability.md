# avron1994stability — Stability, Sequentiality and Demand Driven Evaluation in Dataflow

- **Status:** deep-read
- **Primary source:** https://www.cs.tau.ac.il/~aa/articles/nada.pdf
- **Version read:** full author copy; metadata checked against the version of record
- **Bibliography key:** `avron1994stability`

## Why it matters

This paper formally defines the least demanded computation for a fixed
dataflow program, concrete inputs, and requested output-token positions. It
therefore subsumes the fixed-input semantic part of our enabled-closure story
under its stability assumptions.

## Definitions and results

Definition 3.1 constructs legal valuations by a projected iteration that
excludes guessed intermediate values. Definitions 3.2--3.3 model a demand as
(D:O\to 2^{\mathbb N}), require all demanded output positions to be defined,
and define the (D)-driven evaluation as the least legal output-complete
valuation when it exists (author-copy pp. 11--12).

Definition 3.4 says that a continuous primitive is stable when every output
approximation below (f(x)) has a least enabling input approximation. Theorem
3.1 proves that all program-and-demand solution sets are empty or have a least
element exactly when every primitive is stable (pp. 13--16). Section 4.2
distinguishes sequentiality from effective sequentiality by whether a critical
undefined input position can be algorithmically identified (pp. 21--22).

The `parallel-or` example shows that one fixed input may admit incomparable
sufficient computations and hence no least one (pp. 12--13). The paper does
not range symbolically over inputs, enumerate projected selection records, or
construct exact inverse-image guards.

## Limitation and relationship

The conclusion conjectures, rather than proves, a generic construction of
compatible demand-propagation operators for all effectively sequential
functions. No asymptotic complexity analysis is given.

For the finite acyclic one-cell-stream specialization, our enabled closure
should be related to the support of the paper's least legal valuation by an
explicit specialization theorem. This correspondence is our derivation, not a
theorem stated in the source. The remaining object is the range and exact
fibers of the fixed-computation projection as inputs vary.

## Evidence locations

- Section 3.2, Definition 3.1, p. 11: legal valuations.
- Section 3.3, Definitions 3.2--3.3, pp. 11--12: demand and least evaluation.
- Definition 3.4 and Theorem 3.1, pp. 13--16: stability characterization.
- Section 4.2 and conclusion, pp. 21--22: effective sequentiality and open construction.
