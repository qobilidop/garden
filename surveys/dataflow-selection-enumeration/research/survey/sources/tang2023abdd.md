# tang2023abdd — Boosting-based Construction of BDDs for Linear Threshold Functions

- **Status:** deep-read
- **Primary source:** https://arxiv.org/abs/2306.05211
- **Version read:** arXiv v1, 8 June 2023
- **Bibliography key:** `tang2023abdd`

## Why it matters

Tang, Hatano, and Takimoto construct exact aligned BDDs (ABDDs) for linear
threshold neurons and combine them into an exact Boolean representation of a
binary neural network. The bound exposes when margin, rather than a fixed
variable order, permits compact neuron diagrams.

## Results, algorithm, and guarantees

Algorithms 1--2 apply a boosting-style split/merge procedure. Theorem 4 bounds
the approximate training-error construction. Lemma 5 supplies the weak-learning
condition for a threshold function with margin `rho`; setting the error below
`2^-n` makes the diagram pointwise exact on the entire Boolean cube. Corollary 1
then bounds ABDD size by `O(n^2 rho^-4 log(1/rho))`. Constructing from all
`2^n` labeled inputs costs `O(2^n poly(1/rho))`. Section 5 converts neuron ABDDs
to circuits, composes the network, and optionally compiles it to an SDD.

## Relationship to our hypothesis

This is an exact finite neural compilation result with explicit representation
and construction bounds. The resulting paths omit variables not tested by the
ABDD, but that is Boolean function reduction rather than structural
non-observation of requested internal graph sites.

## Evidence locations

- Section 2, pp. 3--5: BNN, BDD, OBDD, and ABDD definitions.
- Algorithms 1--2, Theorem 4, pp. 6--10: boosting construction.
- Lemma 5 and Corollary 1, pp. 10--11: exact margin-qualified size and time.
- Section 5, pp. 11--12: exact circuit and SDD composition.
- Section 6, pp. 12--14: empirical comparison and robustness queries.

## Questions and possible weaknesses

- The exact construction explicitly enumerates the Boolean cube; the compact
  output-size bound does not make its time output-polynomial.

