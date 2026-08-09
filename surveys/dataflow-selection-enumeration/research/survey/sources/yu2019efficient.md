# yu2019efficient — verified mixed-numeric parametric LP exploration

- **Status:** deep-read; exact implementation and degeneracy comparator
- **Primary source:** https://doi.org/10.1007/978-3-030-32304-2_11
- **Open copy:** https://arxiv.org/abs/1911.09755
- **Version read:** open author manuscript corresponding to SAS 2019
- **Bibliography key:** `yu2019efficient`

## Contribution

Yu and Monniaux implement an exact parametric linear-programming solver for
polyhedral projection. Floating-point simplex solves propose bases and regions;
exact rational reconstruction and checking validate them. When degeneracy
creates several bases for one optimum, the solver explores same-optimum bases
and uses a unique-basis or lexicographic-perturbation construction to eliminate
overlap.

## Guarantees

The adjacency procedure verifies candidate facets exactly. Theorem 2 shows
that no face is missed when the required adjacencies are found. Theorem 3
excludes overlaps in the absence of degeneracy; the later perturbation section
restores a unique representative when this assumption fails. The resulting
implementation is exact despite using floating-point computation as a
proposal mechanism.

## Boundary

This work strengthens the practical exactness baseline for dense pLP region
enumeration and polyhedral projection. It does not define a requested-root
observer, variable-domain event map, contextual graph identity, or general
typed residual. Its enumeration state is an optimization basis/region, not an
input-relative record of observed dataflow choices.

## Evidence locations

- Abstract and introduction: mixed floating-point and exact-rational design.
- Algorithms 1–3: exploration, reconstruction, and adjacency verification.
- Theorem 2: no missed face under verified adjacency.
- Theorem 3 and the degeneracy discussion: overlap and unique-basis handling.
- Lexicographic-perturbation section: deterministic representative basis.
- Conclusion: exact rational recovery and missing-face safeguards.
