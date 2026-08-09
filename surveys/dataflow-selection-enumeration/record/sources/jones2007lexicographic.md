---
citekey: jones2007lexicographic
work:
  title: "Lexicographic Perturbation for Multiparametric Linear Programming with Applications to Control"
  author: "Colin N. Jones, Eric C. Kerrigan, Jan M. Maciejowski"
  venue: "Automatica"
  date: 2007
  doi: 10.1016/j.automatica.2007.03.008
read: full-text
source: "Published Automatica article via https://doi.org/10.1016/j.automatica.2007.03.008"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Simultaneous primal/dual lexicographic perturbation turns a degenerate multiparametric LP into a continuous, unique, duplicate-free region representation — symbolic tie-breaking and duplicate-free region identity predate the current synthesis, though with no closed enumeration-complexity theorem"
---

# Lexicographic Perturbation for Multiparametric Linear Programming with Applications to Control

## Evidence

### Why it matters

Jones, Kerrigan, and Maciejowski use simultaneous primal and dual
lexicographic perturbation to turn a degenerate multiparametric linear program
into a region representation with one unique optimal basis per parameter-region
interior. The resulting optimizer is continuous, unique, and affine on
polyhedral regions with disjoint interiors. Symbolic tie-breaking and
duplicate-free region identity therefore predate the current synthesis.

### Guarantee and traversal

Every optimum of the perturbed problem is an optimum of the original problem.
The perturbed optimal bases define nonoverlapping full-dimensional regions, and
the paper proves that the facet-adjacency graph is connected. Its adjacent-
region routine handles degeneracy and reduces to one simplex pivot in the
nondegenerate case, yielding a complete enumeration of the chosen perturbed
representation.

The perturbation selects one valid optimizer rather than enumerating a
multivalued solution relation. It can refine a degenerate unperturbed problem
into exponentially many basis regions. Lower-dimensional parameter cases are
covered through region closures rather than emitted as separate objects.

### Complexity

The paper notes the unavoidable exponential worst case and demonstrates
practical improvement, but it gives no closed total-time, delay, space, or bit
complexity theorem. Jones and Maciejowski 2006 remains the stronger source for
an explicit output-linear LP-relative enumeration bound.

### Evidence locations

- Introduction and Section 2: degeneracy problem and lexicographic simplex.
- Main perturbation results: optimality, uniqueness, and continuity.
- Enumeration section: adjacent-basis construction and completeness.
- Final examples: region-count and numerical comparison.

### Citation-neighborhood audit

The exact 23-entry printed bibliography was title-screened and reconciled with
the publisher deposit in
`screening/baseline-2026-08-04/primary-jones2007lexicographic-backward.tsv` (retired to git history).
All 49 DOI-linked OpenCitations records were title-screened in
`screening/baseline-2026-08-04/opencitations-jones2007lexicographic-forward.tsv` (retired to git history).
Retained
successors include projection/pLP interreduction, unrestricted pQP adjacency,
connected-graph enumeration, and mixed floating/rational exact pLP solving.

## Bearing on RQs

The representation has no structurally absent site coordinate: every emitted
region is a dense basis/active-set case of one optimization problem. It does
not define requested-root reachability or contextual identities in a shared
term graph.

## Evidence limits

- No separate limits section in the source note; the boundary is stated in
  ### Complexity above (no closed total-time, delay, space, or bit complexity
  theorem).
