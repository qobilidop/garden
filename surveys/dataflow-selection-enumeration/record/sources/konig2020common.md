---
citekey: konig2020common
work:
  title: "Accelerating MPC by Online Detection of State Space Sets With Common Optimal Feedback Laws"
  author: "Kai König, Martin Mönnigmann"
  date: 2020
  arxiv: 2009.08764
read: full-text
source: "arXiv v1 (18 September 2020): https://arxiv.org/abs/2009.08764"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Proves that different explicit-MPC active-set regions can share the first control action requested by receding-horizon execution even when later-horizon actions differ — an exact but algorithmically incomplete output-projection grouping that defeats a broad claim of first requested-output-relative projection"
---

# requested-first-action grouping in explicit MPC

## Evidence

### Why it matters

König and Mönnigmann prove that different explicit-MPC active-set regions can
share the first control action requested by receding-horizon execution even
when their later-horizon actions differ. This defeats a broad claim of first
requested-output-relative projection or first grouping of distinct internal
decision histories by the externally used result.

### Exact result

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

### Algorithmic qualification

The online method does not enumerate every \(\Gamma(A)\). Starting from one
active set \(A\), it considers only candidates
\(\widetilde A\subseteq A'\subseteq A\), producing sound but incomplete
coverage. Candidate count can be exponential in the non-first-stage portion of
\(A\), and no general output-sensitive bound is given.

### Forward-citation audit

Semantic Scholar exposes exactly three citing records and no continuation;
Google Scholar independently reports three. All three citation edges were
checked in primary sources. `mitze2021common` generalizes a sufficient
same-first-action criterion to nonlinear MPC but implements only sound inner
coverage. `konig2020simulation` caps and empirically evaluates the seed's own
incomplete polytope enumeration. A withdrawn DNN approximation paper cites the
seed only as background and does not meet the frozen trigger.

No citing work proves that the active-subset classes are the maximal kernel of
the first-action function, enumerates every such class without duplication, or
gives an output-sensitive or asymptotic enumeration bound. The forward audit
therefore closes the seed without changing its role as the exact projection
baseline.

## Bearing on RQs

Requested-root relativity alone is not a separator. This paper intentionally
forgets internal optimization choices once they yield the same requested
first action. Our observer instead records the sparse selection sites reached
from a requested root and retains their outcome identities even when residual
values agree. The coordinate domain also varies by enabled graph reachability,
not merely by projection of a dense optimization history.

## Evidence limits

Read at full-text level (arXiv v1); the paper itself proves only sound-but-
incomplete online coverage and states no output-sensitive enumeration bound
(see Algorithmic qualification above) — no separate weaknesses section is
given, and no further limits are added here.
