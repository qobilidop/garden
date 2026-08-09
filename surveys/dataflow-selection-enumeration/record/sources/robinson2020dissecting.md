---
citekey: robinson2020dissecting
work:
  title: "Dissecting Deep Neural Networks"
  author: "Haakon Robinson, Adil Rasheed, Omer San"
  date: 2020
  arxiv: "1910.03879"
read: full-text
source: "arXiv version 2 at https://arxiv.org/abs/1910.03879"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-05
synthesis: "An explicit guard-plus-affine-residual conversion of fully connected ReLU networks to piecewise-affine form, predating RPM but restricted to dense networks and without a numbered correctness theorem or enumeration bound"
---

# Dissecting Deep Neural Networks

## Evidence

### Result

The paper states an exact conversion of fully connected ReLU networks to
piecewise-affine form (PDF p. 4). Algorithm 1 constructs hyperplane regions and
stores working tuples ((R_i,P_i)); Algorithm 2 returns the complete list of
regions and affine transformations (pp. 7--8).

### Evidence locations

- Exact-conversion statement, PDF p. 4.
- Algorithms 1--2, PDF pp. 7--8: construction and returned region/affine-map
  list.

## Bearing on RQs

This is an explicit guard-plus-residual output before RPM.

What is directly established by the work: the paper presents an exact fully
connected ReLU-to-PWA conversion whose algorithm returns regions with affine
transformations.

Our interpretation or inference: those regions instantiate guard-plus-affine-
residual output for a dense network but do not establish contextual
structural non-observation.

Could it subsume our proposed contribution: it is an affine restricted
comparator, without the general graph observer or a separate
output-sensitive theorem.

## Evidence limits

- The paper gives no numbered end-to-end correctness theorem or asymptotic
  enumeration bound, and its demonstrated scope is fully connected ReLU
  networks.
