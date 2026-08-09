---
citekey: spallitta2025projected
work:
  title: "Disjoint Projected Enumeration for SAT and SMT without Blocking Clauses"
  author: "Giuseppe Spallitta, Roberto Sebastiani, Armin Biere"
  venue: "Artificial Intelligence"
  date: 2025
  doi: 10.1016/j.artint.2025.104346
read: full-text
source: "Author preprint arXiv:2410.18707v2; primary via https://doi.org/10.1016/j.artint.2025.104346"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "The strongest direct solver baseline: disjoint projected AllSAT/AllSMT enumeration without blocking clauses subsumes enumeration after polynomial activation/outcome instrumentation, so an original contribution needs a compositional observation semantics or structural advantage beyond reimplementing this reduction"
---

# Disjoint Projected Enumeration for SAT and SMT without Blocking Clauses

## Evidence

### Why it matters

This is the strongest direct solver baseline found so far. It combines
projection, mutually exclusive partial assignments, SAT and SMT theories, and
an algorithm that avoids accumulating blocking clauses.

### Program and semantic model

The SAT formulation splits variables into relevant variables `Vr` and
irrelevant variables `Vi`. Projected enumeration computes AllSAT of
`exists Vi. F(Vr, Vi)`. The SMT extension replaces propositional consistency
with theory consistency and enumerates assignments to the designated atoms.

### Main definitions

A partial assignment fixes only some variables and denotes every total
extension. A partial model entails the formula. Projected AllSAT discards
`Vi` existentially while preserving satisfiability over `Vr`. The paper
focuses on disjoint enumeration: reported partial models cannot cover the same
total relevant assignment.

### Results and guarantees

The chronological-search discipline and implicant-shrinking procedure produce
a disjoint partial cover. For projection, relevant variables are decided
before irrelevant ones and only relevant literals are printed. The SMT
extension adds theory-consistency checking and is compatible with the theories
supported by MathSAT5.

The experiments validate coverage by model counts and compare runtime and
number of reported partial assignments. The shrinking algorithm does not
guarantee globally minimal partial models.

### Algorithm

`TabularAllSAT` combines CDCL with chronological backtracking and aggressive
implicant shrinking. The projected variant prioritizes relevant variables and
drops irrelevant literals. `TabularAllSMT` interleaves Boolean search with
theory checks and theory conflict learning.

### Complexity

A partial assignment of `m` out of `n` variables represents `2^(n-m)` total
assignments, so output can be exponentially smaller than total-model
enumeration. The paper's main efficiency evidence is empirical, not a
polynomial-delay theorem.

### Terminology

Use *projection* for existential removal of designated irrelevant variables,
and *partial model* or *implicant* for a cube that allows logical don't-cares.
Neither term by itself means structural inactivity.

### Motivating example

The examples show formulas where implicant shrinking removes decisions whose
values are unnecessary to entail the formula, then chronological backtracking
produces the next nonoverlapping cube.

### Evidence locations

- Section 2.2: AllSAT, AllSMT, and projection; Equation (1) defines projected
  enumeration by existential quantification.
- Sections 3–4 and Algorithms 1–8: chronological enumeration and implicant
  shrinking.
- Section 5.1: relevant-first branching and printing only relevant literals.
- Section 6: SMT extension and theory consistency.
- Section 7: scope of claims and experimental conclusions.

## Bearing on RQs

What is directly established by the work: complete disjoint projected
enumeration of compact partial SAT and SMT models without blocking clauses.

Our interpretation or inference: encode each selection occurrence as an
important finite-domain observation with an explicit inactive value. Project
the internal graph equations and unobserved values. This yields the same set
of total observation tuples as the fibers of a deterministic
selection-observation function.

Shrinking those tuples further is not automatically valid for our semantics:
an observed equal-valued selection is still recorded, even when dropping its
literal would preserve the output formula. Logical don't-care and structural
inactivity are different omission criteria.

Could it subsume our proposed contribution: yes, it subsumes enumeration
after a polynomial-size activation/outcome instrumentation. A viable original
contribution must establish a compositional observation semantics or a
structure-directed advantage over this reduction, not merely reimplement
projected AllSMT.

## Evidence limits

- The paper reports partial covers, whereas our observation map first induces
  exact total tuples over the finite `inactive-or-outcome` domains.
- Any claim that our omission is semantically different must be accompanied by
  an observer that can distinguish observed equal-valued selections.
