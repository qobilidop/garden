---
citekey: li2013sedge
work:
  title: "SEDGE: Symbolic Example Data Generation for Dataflow Programs"
  author: "Kaituo Li, Christoph Reichenbach, Yannis Smaragdakis, Yanlei Diao, Christoph Csallner"
  venue: "ASE 2013"
  date: 2013
  doi: 10.1109/ASE.2013.6693083
read: abstract-only
source: "Abstract and introduction of the author-hosted accepted paper, https://doi.org/10.1109/ASE.2013.6693083"
retrieved: 2026-08-09
notes-by: Codex (publication-review revision)
notes-date: 2026-08-09
synthesis: "Adapts concolic SMT input generation to high-level Pig dataflow programs and operator-case coverage; its example dataset is not a duplicate-free exact observer partition with residuals."
---

# SEDGE: Symbolic Example Data Generation for Dataflow Programs

## Evidence

### Evidence locations

- Abstract: transforms Pig dataflow programs into symbolic constraints and
  combines an SMT solver with concrete input data to target passing and failing
  operator cases.
- Introduction: presents the goal as representative example-data generation
  and coverage of dataflow operators rather than enumeration of semantic input
  equivalence classes.

## Bearing on RQs

SEDGE is an important dataflow-specific concolic comparator. It generates a
joint example dataset intended to cover operator cases; it does not expose one
exact inverse-fiber guard, residual, and witness record for each requested-root
selection observation.

## Evidence limits

Screened from the abstract and introduction. No completeness or performance
claim beyond that scope is used in the manuscript.
