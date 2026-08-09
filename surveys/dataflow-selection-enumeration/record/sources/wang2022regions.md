---
citekey: wang2022regions
work:
  title: "Estimation and Comparison of Linear Regions for ReLU Networks"
  author: "Yuan Wang"
  venue: "IJCAI 2022"
  date: 2022
  doi: 10.24963/ijcai.2022/492
read: abstract-only
source: "IJCAI 2022 proceedings via https://doi.org/10.24963/ijcai.2022/492"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Separates an activation region's combinatorial shape from its affine value, merging same-value connected regions into maximal linear regions — showing dense activation-pattern cells and maximal extensional regions are not interchangeable objects"
---

# Estimation and Comparison of Linear Regions for ReLU Networks

## Evidence

### Why it matters

The paper distinguishes an activation region's combinatorial `shape` from its
affine `value` and groups connected activation regions with the same value into
one maximal linear region (proceedings p. 3546). This corrects any assumption
that dense activation cells and maximal extensional affine regions are
interchangeable.

Theorem 3.2 makes deciding whether a network has more than (K) regions
NP-hard, followed by an EXPTIME enumeration discussion (p. 3547). Most
activation-pattern enumerators preserve the finer structural partition; Wang
instead performs the extensional merge.

## Bearing on RQs

Our observer deliberately preserves equal-valued observed alternatives, so it
aligns with neither object without an explicit observer choice.

## Evidence limits

Read at abstract/metadata level; claims beyond the abstract are not anchored.
