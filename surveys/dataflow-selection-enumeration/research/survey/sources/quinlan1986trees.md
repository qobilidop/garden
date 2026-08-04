# quinlan1986trees — Induction of Decision Trees

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/BF00116251
- **Bibliography key:** `quinlan1986trees`

## Why it matters

The paper's decision-tree semantics is the elementary special case that
prevents dynamic sparsity alone from separating our observer. Leaves are class
names, internal nodes are tests with one branch per outcome, and classification
evaluates only the tests on the selected root-to-leaf path (p. 86).

Hence one execution yields a partial map from reached test occurrences to
outcomes, the path conjunction denotes its input region, and the leaf is the
terminal result. This consequence is our semantic deduction, not a theorem
claimed verbatim by Quinlan. Arbitrary typed shared dataflow, requested roots,
contextual selection identity, and symbolic residuals remain outside the
paper.

## Evidence locations

- Page 86: tree syntax and root-to-leaf classification procedure.
