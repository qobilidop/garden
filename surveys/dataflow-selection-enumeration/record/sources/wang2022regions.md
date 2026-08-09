# wang2022regions — Estimation and Comparison of Linear Regions for ReLU Networks

- **Status:** deep-read
- **Primary source:** https://doi.org/10.24963/ijcai.2022/492
- **Bibliography key:** `wang2022regions`

## Why it matters

The paper distinguishes an activation region's combinatorial `shape` from its
affine `value` and groups connected activation regions with the same value into
one maximal linear region (proceedings p. 3546). This corrects any assumption
that dense activation cells and maximal extensional affine regions are
interchangeable.

Theorem 3.2 makes deciding whether a network has more than (K) regions
NP-hard, followed by an EXPTIME enumeration discussion (p. 3547). Most
activation-pattern enumerators preserve the finer structural partition; Wang
instead performs the extensional merge. Our observer deliberately preserves
equal-valued observed alternatives, so it aligns with neither object without
an explicit observer choice.
