---
citekey: patrinos2010graphical
work:
  title: "A New Algorithm for Solving Convex Parametric Quadratic Programs Based on Graphical Derivatives of Solution Mappings"
  author: "Panagiotis Patrinos, Haralambos Sarimveis"
  venue: "Automatica"
  date: 2010
  doi: 10.1016/j.automatica.2010.06.008
read: full-text
source: "Published article via https://doi.org/10.1016/j.automatica.2010.06.008, cross-checked against the expanded thesis treatment at https://dspace.lib.ntua.gr/xmlui/handle/123456789/20151"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Enumerates every full-dimensional critical region of a degenerate convex parametric QP via a graphical-derivative facet oracle that needs no LICQ or nondegeneracy assumption — the closest unrestricted optimization-traversal baseline, though with no closed complexity theorem and only full-dimensional regions emitted"
---

# A New Algorithm for Solving Convex Parametric Quadratic Programs Based on Graphical Derivatives of Solution Mappings

## Evidence

### Why it matters

Patrinos and Sarimveis enumerate every full-dimensional critical region of a
convex, possibly non-strict and degenerate parametric quadratic program. Their
graphical-derivative facet oracle can return *all* regions adjacent across one
facet without LICQ, strict complementarity, nondegeneracy, or a facet-to-facet
assumption. This defeats broad claims of first exact degeneracy-safe region
traversal or first multiple-neighbor discovery.

### Object and algorithm

A critical region is identified by the unique optimal active set: the
constraints active for every optimizer at a parameter. Full-dimensional
critical-region closures form a polyhedral subdivision of the solution-map
domain. Each output contains a minimal normalized guard and a selected
optimizer over that guard.

Algorithm 5.12 in the expanded treatment performs breadth-first traversal:

1. find one full-dimensional optimal active set;
2. construct its minimally represented region;
3. invoke the graphical-derivative oracle on every facet;
4. enqueue every previously unseen adjacent active set; and
5. stop when the work list is empty.

Completeness uses connectedness of the full-dimensional critical-region graph
over the convex parameter domain. The facet oracle reduces all-neighbor
discovery to a lower-dimensional parametric LP and, where necessary, smaller
quadratic programs.

### Qualifications and complexity

With LICQ and a locally unique optimizer, the optimizer and multipliers are
affine. Rank-deficient active constraints require projection. For a multivalued
primal solution the paper proposes a strictly convex secondary problem; the
selected solution need not be continuous for a general convex pQP, whereas the
analogous minimum-norm pLP selection is continuous.

The authors call the traversal output-sensitive, but give no closed polynomial
total-time formula, DelayP/IncP classification, auxiliary-space bound, or bit
complexity theorem. Only full-dimensional regions are emitted; lower-
dimensional sets remain shared boundaries.

### Citation-neighborhood audit

The publisher's exact sequential 49-entry bibliography was title-screened in
`screening/baseline-2026-08-04/primary-patrinos2010graphical-backward.tsv` (retired to git history).
Access restrictions
prevented visual comparison with the printed reference section, so the source
of that exact count is stated explicitly. All 45 DOI-linked OpenCitations
records were title-screened in
`screening/baseline-2026-08-04/opencitations-patrinos2010graphical-forward.tsv` (retired to git history).
The chase retained
the sufficient-matrix output-sensitive predecessor and later piecewise-QP,
two-phase pLCP, connected-graph, QCQP, and region-free boundaries.

## Bearing on RQs

This is a dense partition induced by optimal active sets of one optimization
problem. It has no requested-root-relative enabled closure, input-dependent
site domain, shared typed graph, or intentional preservation of equal-valued
selection events. It nevertheless must be foregrounded whenever the survey
discusses exact complete traversal under degeneracy.

## Evidence limits

- No separate limits section in the source note; the boundary is stated in
  ### Qualifications and complexity above — no closed polynomial total-time
  formula, DelayP/IncP classification, auxiliary-space bound, or bit
  complexity theorem, and only full-dimensional regions are emitted.
