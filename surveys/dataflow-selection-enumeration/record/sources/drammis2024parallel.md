---
citekey: drammis2024parallel
work:
  title: "Parallel Algorithms for Exact Enumeration of Deep Neural Network Activation Regions"
  author: "Sabrina Drammis, Bowen Zheng, Karthik Srinivasan, Robert C. Berwick, Nancy A. Lynch, Robert Ajemian"
  date: 2024
  arxiv: 2403.00860
read: full-text
source: "arXiv v1 via https://arxiv.org/abs/2403.00860, February 2024"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Gives the bounded-domain correctness argument and parallel work/span analysis for exact layerwise ReLU activation-region enumeration missing from Balestriero — but only for the dense all-sites-observed special case, not sparse observations or typed residuals"
---

# Parallel Algorithms for Exact Enumeration of Deep Neural Network Activation Regions

## Evidence

### Why it matters

Drammis et al. forward-cite Balestriero and provide the bounded-domain
correctness argument and parameterized parallel analysis missing from that
paper. Their framework exactly enumerates every full-dimensional ReLU
activation region intersecting a bounded convex domain.

### Object and framework

The output is the set of dense layerwise network sign vectors whose cells
intersect the input domain. `LayerWise-NNCE` invokes a bounded hyperplane-cell
enumerator for the first layer and then, for every earlier cell, pulls the next
layer's arrangement back into that cell and enumerates the resulting
subcells. The framework is exact conditional on an exact `Bound-CellEnum`
subroutine.

Algorithm 6 parallelizes first-layer sign-vector tasks across workers and uses
incremental cell enumeration in deeper layers. Section 5.2 proves by induction
that workers return exactly the feasible refinements of their first-layer
cell and that the master union is exactly the network cell set.

### Complexity audit

For the regime \(n_1\le n_0\) and the approximation
\(|C_1|\approx2^{n_1}\), Theorem 1 states expected work

\[
  O(Ln_{\max}\,lp(*)\,|C_L|)
\]

and expected span

\[
  O(\zeta Ln_{\max}\,lp(*)\,|C_L|).
\]

### Evidence locations

- Definitions 2.1--2.7, paper pp. 2--4: network sign cells and bounded problem.
- Algorithm 1 and Section 3, pp. 4--5: layerwise framework.
- Appendix A and Algorithms 2--5: bounded cell-enumeration subroutines.
- Algorithm 6 and Section 5.2, pp. 6--8: master-worker algorithm and
  correctness argument.
- Theorem 1, pp. 7--8: expected work/span result.
- Appendix B, p. 12: empirical derivation of \(\zeta\).

## Bearing on RQs

This work establishes exact parallel layerwise enumeration and an explicit
work model for the all-sites-observed ReLU special case. It does not model
sparse observations, input-relative enabled closures, heterogeneous selectors,
or typed residual values. Its citation of Balestriero as a prior small-scale
enumerator supports Balestriero's antecedence but not an uncontested claim of
origin.

The manuscript should compare its complexity only after naming the different
output: dense full-dimensional activation cells within a bounded real domain
versus sparse graph-relative observation fibers over a finite typed domain.

## Evidence limits

The factor \(\zeta=\exp(-0.6445n_{\max})\) is fitted from experiments and
then assumed across layers; it is not a universal structural theorem. The
\(n_1>n_0\) alternatives are algorithm sketches without the same analysis.
Appendix A uses non-strict LP constraints and does not fully specify ownership
of boundary-only sign assignments in degenerate cases.
