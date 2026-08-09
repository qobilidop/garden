---
citekey: deza2026whitewhale
work:
  title: "Sizing the White Whale"
  author: "Antoine Deza, Mingfei Hao, Lionel Pournin"
  venue: "Fields Institute Communications"
  date: 2026
  doi: 10.1007/978-3-032-03844-9_9
read: full-text
source: "Published book chapter via https://doi.org/10.1007/978-3-032-03844-9_9, cross-checked against the author manuscript"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "The closest forward successor to deza2022linear: layers zonotope vertices by generator-subset cardinality, retains canonical representatives under generator-preserving symmetry, and adds collision and coordinate-order filters before exact LP tests — a concrete reminder that a quotient can be useful even when the requested output is literal exhaustive enumeration"
---

# symmetry-aware zonotope enumeration

## Evidence

### Why it matters

Deza, Hao, and Pournin layer zonotope vertices by generator-subset cardinality,
retain canonical representatives under generator-preserving symmetry, and
allow a sound inexpensive rejection filter before exact LP tests. Their White
Whale specialization adds collision and coordinate-order filters. This is the
closest forward successor to `deza2022linear` and a concrete reminder that a
quotient can be useful even when the requested output is literal exhaustive
enumeration: representatives still need their orbits expanded to recover all
vertices.

### Guarantee and complexity boundary

The exact LP test remains the final vertex oracle, so the filters and symmetry
reduction preserve the enumerated zonotope. The chapter gives no improved
generic bound on LP calls, no compact-space theorem, and no general asymptotic
bound for orbit canonicalization or deduplication. Two adjacent cardinality
layers can remain output-sized.

The dimension-nine computation illustrates scale rather than a generic
complexity improvement: it used 72 threads, 300 GB, and three months while
retaining more than three billion orbit representatives. The displayed
algorithms initialize the zero layer with the empty set where the surrounding
invariant requires the singleton containing the empty subset; this is an
obvious pseudocode repair, not a failure of the layered construction.

## Bearing on RQs

The equivalence is a fixed group action on dense generator subsets, not an
input- and request-relative absence of graph sites. The method neither defines
selection-event identities nor emits typed residual values, so it changes no
claim about the sparse graph observer.

## Evidence limits

Read at full-text level; the chapter's own stated complexity boundary (see
Evidence above) is the note's only limiting content — no separate
weaknesses/limitations section is given, and no further limits are added here.
