# spallitta2024disjoint — Disjoint Partial Enumeration without Blocking Clauses

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1609/aaai.v38i8.28652
- **Version read:** official AAAI proceedings PDF
- **Bibliography key:** `spallitta2024disjoint`

## Why it matters

The work makes precise how partial assignments compactly cover many total
models without overlap. Its 2025 extension to projection and SMT is an even
closer solver-level baseline for sparse choice observations.

## Program and semantic model

The object is a propositional formula over Boolean variables. A total or partial
assignment is represented as a cube; a partial satisfying assignment is an
implicant of the formula.

## Main definitions

The paper distinguishes ordinary AllSAT, which may repeat total models, from
*disjoint AllSAT*, whose reported assignments cover no total model twice.
Leaving a variable unassigned denotes both of its values and can therefore
cover exponentially many total models.

## Results and guarantees

The algorithm enumerates mutually exclusive partial models covering all total
models of the formula. Its mutual-exclusion argument relies on chronological
backtracking and a compatible shrinking discipline. The experimental audit
checks that the disjoint partial models cover the independently counted number
of total models.

## Algorithm

`TABULARALLSAT` combines CDCL, chronological backtracking, and a posteriori
implicant shrinking. Algorithms 1–3 implement search and model handling;
Algorithms 4–5 remove literals while retaining satisfaction and compatibility
with the chronological search frontier.

## Complexity

For `n` variables, total enumeration may produce `2^n` assignments. A partial
assignment fixing `m` variables represents `2^(n-m)` total assignments. No
algorithm can avoid output proportional to the selected disjoint cover, while
the paper focuses empirically on avoiding blocking-clause degradation.

## Terminology

Established terms include *partial assignment*, *cube*, *implicant*, *disjoint
AllSAT*, *implicant shrinking*, and *chronological backtracking*.

## Motivating example

For `x1 or x2 or x3`, the solver returns the disjoint cover `{x3}`, `{x2 and not
x3}`, `{x1 and not x2 and not x3}` instead of seven total models. Absence here
means logical don't-care, not structural inactivity.

## Relationship to our hypothesis

### What is directly established by the work?

Complete, nonoverlapping enumeration by sparse assignments.

### What is our interpretation or inference?

Introduce for each graph choice `q` an observation variable with values
`inactive` or an alternative index, constrain it to equal the concrete
demand/outcome function, and project enumeration onto these variables. The
returned assignments or their total observation values may encode our desired
regions and provide witnesses.

### Could it subsume our proposed contribution?

The 2024 propositional algorithm is not by itself a term-graph evaluator, but
the reduction is serious. The 2025 projected AllSMT extension must be compared
in full before any enumeration novelty is claimed.

## Evidence locations

- Introduction, pp. 8126–8127: partial models and disjoint AllSAT.
- Algorithms 1–3, pp. 8128–8129: chronological enumeration.
- Algorithms 4–5, pp. 8129–8130: implicant shrinking.
- Evaluation, p. 8133: complete disjoint-cover validation.

## Questions and possible weaknesses

- Structural inactivity is not the same as implicant minimization: an active
  equal-valued choice must remain assigned in our observation.
- Does projected AllSMT enumerate exact total observation tuples or minimized
  partial observation cubes, and which one should our API expose?
