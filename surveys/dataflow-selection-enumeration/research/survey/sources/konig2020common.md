# konig2020common — requested-first-action grouping in explicit MPC

- **Status:** deep-read; closest output-projection baseline; forward citation
  chase pending before critical freeze
- **Primary source:** https://arxiv.org/abs/2009.08764
- **Version read:** arXiv v1, 18 September 2020
- **Bibliography key:** `konig2020common`

## Why it matters

König and Mönnigmann prove that different explicit-MPC active-set regions can
share the first control action requested by receding-horizon execution even
when their later-horizon actions differ. This defeats a broad claim of first
requested-output-relative projection or first grouping of distinct internal
decision histories by the externally used result.

## Exact result

Proposition 1 partitions the constraints so that a first-stage active subset
\(\widetilde A\) determines

\[
  u_0(x)=(G^{11}_{\widetilde A})^{-1}E_{\widetilde A}x
         +(G^{11}_{\widetilde A})^{-1}w_{\widetilde A}.
\]

Every realized active set sharing \(\widetilde A\) has exactly this first
action, although \(u_1,\ldots,u_{N-1}\) may differ. Their union
\(\Gamma(A)\) can be disconnected and nonconvex.

This is an exact output-projection grouping, but not necessarily the maximal
kernel quotient: distinct first-stage active subsets can accidentally induce
the same affine law.

## Algorithmic qualification

The online method does not enumerate every \(\Gamma(A)\). Starting from one
active set \(A\), it considers only candidates
\(\widetilde A\subseteq A'\subseteq A\), producing sound but incomplete
coverage. Candidate count can be exponential in the non-first-stage portion of
\(A\), and no general output-sensitive bound is given.

## Relationship to selection observations

Requested-root relativity alone is not a separator. This paper intentionally
forgets internal optimization choices once they yield the same requested
first action. Our observer instead records the sparse selection sites reached
from a requested root and retains their outcome identities even when residual
values agree. The coordinate domain also varies by enabled graph reachability,
not merely by projection of a dense optimization history.
