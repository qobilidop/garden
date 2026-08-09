---
citekey: creignou2019enumeration
work:
  title: "A Complexity Theory for Hard Enumeration Problems"
  author: "Nadia Creignou, Markus Kröll, Reinhard Pichler, Sebastian Skritek, Heribert Vollmer"
  venue: "Discrete Applied Mathematics"
  date: 2019
  doi: 10.1016/j.dam.2019.02.025
read: full-text
source: "Author manuscript via https://arxiv.org/pdf/1610.05493, corresponding to the 2019 Discrete Applied Mathematics article"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Fixes the standard meaning of delay, incremental, and output-polynomial enumeration complexity — the authority against which any 'K+1 solver invocations' result must be reclassified as an invocation-count theorem rather than DelayP, IncP, or OutputP"
---

# A Complexity Theory for Hard Enumeration Problems

## Evidence

### Why it matters

This paper fixes the standard meaning of delay, incremental, output-polynomial,
and oracle-relative enumeration. It is the authority for qualifying the
`K+1` solver-invocation result.

### Definitions

DelayP bounds preprocessing, every inter-output delay, and final exhaustion by
a polynomial in input size. IncP permits the next-output time to depend
polynomially on the output prefix; DelayP is contained in IncP (manuscript p.
1). OutputP bounds total time by a polynomial in combined input and total output
size (p. 23).

Definition 2 gives oracle-relative DelayP and IncP classes. The restricted
`DelayP_p^C` form also bounds oracle-query size by the original input size
(pp. 4–5).

### Accounting consequences

Preprocessing is part of time to first output. Exponential d-DNNF or
decision-diagram compilation followed by constant-delay traversal is therefore
not end-to-end polynomial delay unless the compiled representation is declared
the input.

Cumulative fiber blockers grow with prior output, so any plausible
oracle-relative classification is incremental rather than a DelayP claim.
Even IncP with an NP/model oracle remains unproved until output representation,
model production, exact-guard verification, and query sizes are formalized.

### Evidence locations

- Manuscript p. 1: DelayP and IncP overview.
- Definition 2, pp. 4–5: oracle-relative classes.
- Manuscript p. 23: OutputP.

## Bearing on RQs

Exactly `K+1` model-producing invocations is an invocation-count theorem under
a unit-cost oracle, not an OutputP, IncP, or DelayP result. Standard output
complexity charges serialized observations, guards, residuals, and witnesses,
as well as solver and preprocessing work.

## Evidence limits

Read at full-text level (author manuscript corresponding to the 2019 Discrete
Applied Mathematics version); the note records no evidence-quality caveats
beyond the scope boundary above.
