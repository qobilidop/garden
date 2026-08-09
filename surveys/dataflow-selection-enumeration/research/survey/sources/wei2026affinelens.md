# wei2026affinelens — AffineLens

- **Status:** deep-read
- **Primary source:** https://arxiv.org/abs/2605.06218
- **Version read:** arXiv version 3
- **Bibliography key:** `wei2026affinelens`

## Result and assumptions

Algorithm 1 and Theorem 1 give the affine realization under a fixed activation
pattern (PDF p. 9). Algorithm 2 enumerates child regions (p. 10); Theorem 2 and
the subsequent results prove cell decomposition, breadth-first completeness,
exhaustive final-leaf traversal, and termination (pp. 12--16).

This is the broadest exact neural successor in the current audit, covering
bounded high-dimensional domains and convolution, pooling, batch
normalization, residual, and MLP structure. It restricts attention to
full-dimensional regions and ignores measure-zero boundaries and degeneracies
(p. 7). Its identification of final activation-pattern leaves with maximal
CPA regions needs Wang's equal-affine-neighbor caveat under degeneracy.

AffineLens still assigns dense activation patterns rather than omitting graph
sites by requested-root-relative enabled closure.
