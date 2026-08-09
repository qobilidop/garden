# creignou2019enumeration — A Complexity Theory for Hard Enumeration Problems

- **Status:** deep-read
- **Primary source:** https://arxiv.org/pdf/1610.05493
- **Version read:** author manuscript corresponding to Discrete Applied Mathematics 2019
- **Bibliography key:** `creignou2019enumeration`

## Why it matters

This paper fixes the standard meaning of delay, incremental, output-polynomial,
and oracle-relative enumeration. It is the authority for qualifying the
`K+1` solver-invocation result.

## Definitions

DelayP bounds preprocessing, every inter-output delay, and final exhaustion by
a polynomial in input size. IncP permits the next-output time to depend
polynomially on the output prefix; DelayP is contained in IncP (manuscript p.
1). OutputP bounds total time by a polynomial in combined input and total output
size (p. 23).

Definition 2 gives oracle-relative DelayP and IncP classes. The restricted
`DelayP_p^C` form also bounds oracle-query size by the original input size
(pp. 4–5).

## Accounting consequences

Preprocessing is part of time to first output. Exponential d-DNNF or
decision-diagram compilation followed by constant-delay traversal is therefore
not end-to-end polynomial delay unless the compiled representation is declared
the input.

Cumulative fiber blockers grow with prior output, so any plausible
oracle-relative classification is incremental rather than a DelayP claim.
Even IncP with an NP/model oracle remains unproved until output representation,
model production, exact-guard verification, and query sizes are formalized.

## Relationship to our hypothesis

Exactly `K+1` model-producing invocations is an invocation-count theorem under
a unit-cost oracle, not an OutputP, IncP, or DelayP result. Standard output
complexity charges serialized observations, guards, residuals, and witnesses,
as well as solver and preprocessing work.

## Evidence locations

- Manuscript p. 1: DelayP and IncP overview.
- Definition 2, pp. 4–5: oracle-relative classes.
- Manuscript p. 23: OutputP.
