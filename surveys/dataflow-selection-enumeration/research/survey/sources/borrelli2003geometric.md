# borrelli2003geometric — geometric multiparametric-LP enumeration

- **Status:** deep-read; central active-set region baseline; own-seed citation
  chase complete
- **Primary source:** https://doi.org/10.1023/B:JOTA.0000004869.66331.5C
- **Open copy:** https://cse.lab.imtlucca.it/~bemporad/publications/papers/jota-mplp.pdf
- **Version read:** published article
- **Bibliography key:** `borrelli2003geometric`

## Why it matters

Borrelli, Bemporad, and Morari recursively explore parameter space rather than
enumerating simplex tableaux. They exhaustively construct the full-dimensional
critical regions of a multiparametric linear program and recover the affine
optimizer and value on each region. This is an early exact guard-plus-affine
residual construction and a direct predecessor of later degeneracy-safe region
walks.

## Object and algorithm

A critical region is identified by the set of constraints active at the
optimum. For a sample parameter, the algorithm solves the LP, constructs the
polyhedral parameter region on which the active set remains optimal, and
recursively explores the remaining parameter space. The finite search covers
the feasible parameter set, and full-dimensional regions carry an affine
optimizer and value function.

Active-set identity is more semantic than basis identity, but degeneracy still
complicates the representation. Dual-degenerate optimizer recovery can require
overlapping subregions or artificial cuts, while the treatment of
lower-dimensional primal degeneracy uses a numerical random perturbation rather
than a symbolic exact-arithmetic convention.

## Complexity and boundary

The number of possible active sets is exponential. The construction uses
polynomial linear-programming and polyhedral primitives per explored case, but
the paper gives no output-sensitive total-time, delay, auxiliary-space, or bit
complexity theorem.

The output is a dense partition induced by one monolithic optimization
problem. There is no requested result, input-dependent site domain, contextual
graph occurrence, or structural observation that retains equal-valued internal
decisions.

## Evidence locations

- Sections 2--3: multiparametric-LP model and critical regions.
- Main recursive algorithm: direct parameter-space exploration and coverage.
- Degeneracy discussion: primal/dual qualifications and artificial cuts.
- Examples: affine optimizer and value recovery on emitted regions.

## Citation-neighborhood audit

The exact 22-entry printed bibliography was title-screened and reconciled with
the publisher deposit in
`screening/primary-borrelli2003geometric-backward.tsv`. All 179 DOI-linked
OpenCitations records were title-screened in
`screening/opencitations-borrelli2003geometric-forward.tsv`. The forward chase
surfaced the pLCP, unique-selection, projection-interreduction, exact-solver,
and policy-quotient successors recorded separately in the catalog.
