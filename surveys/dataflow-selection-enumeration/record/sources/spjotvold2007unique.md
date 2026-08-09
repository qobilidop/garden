---
citekey: spjotvold2007unique
work:
  title: "Continuous Selection and Unique Polyhedral Representation of Solutions to Convex Parametric Quadratic Programs"
  author: "Jørgen Spjøtvold, Petter Tøndel, Tor Arne Johansen"
  venue: "JOTA 134(2)"
  date: 2007
  doi: 10.1007/s10957-007-9215-z
read: full-text
source: "Published article via https://doi.org/10.1007/s10957-007-9215-z"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Resolves pQP nonuniqueness by selecting the minimum-Euclidean-norm optimizer, giving a unique, continuous, algorithm-independent piecewise-affine selection and polyhedral representation — defeating broad priority claims for canonical or algorithm-independent parametric partitions"
---

# canonical minimum-norm pQP selection

## Evidence

### Why it matters

Spjøtvold, Tøndel, and Johansen resolve nonuniqueness in convex parametric
quadratic programs by selecting the optimizer of minimum Euclidean norm. Under
their assumptions, this gives a unique continuous piecewise-affine selection
and a unique polyhedral representation independent of the exploration
algorithm. This defeats broad priority claims for canonical, unique, or
algorithm-independent parametric partitions.

### Model and results

The primary pQP may have multiple minimizers. Normal-cone optimality and a
secondary minimum-norm construction identify one affine optimizer on each
polyhedral region. Theorem 4 establishes uniqueness of the selected optimal
solution and its region representation. Theorem 5 proves continuity of the
minimum-norm selection under the stated continuity and feasibility
qualifications.

The representation is canonical for the selected optimizer map, not for an
intensional execution history. Two computations that return the same selected
optimizer are deliberately identified; the construction has no requested-root
enabled closure or graph-site event observer.

### Evidence locations

- Abstract and introduction: minimum-norm selection, uniqueness, continuity,
  and algorithm independence.
- Sections 2–3: normal-cone characterization and region construction.
- Theorem 4: unique selected optimizer and unique polyhedral region.
- Theorem 5: continuity of the minimum-norm selection.

## Bearing on RQs

The synthesis must not claim the first unique, canonical, or
algorithm-independent partition. Its narrower distinction is retaining
contextual internal selection events—even when their residual values agree—and
omitting sites outside the requested enabled closure.

## Evidence limits

Theorem 4's uniqueness and Theorem 5's continuity hold only under the paper's
stated continuity and feasibility qualifications; no broader guarantee is
claimed beyond that scope.
