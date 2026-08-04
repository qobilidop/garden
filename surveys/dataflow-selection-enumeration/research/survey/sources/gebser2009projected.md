# gebser2009projected — Solution Enumeration for Projected Boolean Search Problems

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-642-01929-6_7
- **Version read:** Springer LNCS 5547 proceedings text, pp. 71–86
- **Bibliography key:** `gebser2009projected`

## Why it matters

This paper gives an early exact treatment of duplicate-free projected solution
enumeration. Its second CDNL procedure avoids permanently accumulating one
blocking constraint per output and uses only polynomial space. It is therefore
a direct algorithmic baseline for enumerating a finite observation tuple after
irrelevant variables have been existentially projected away.

## Problem and output model

For a Boolean search problem `Delta` with solution set `S(Delta)` and a set
`P` of projection variables, the projective solutions are the distinct sets
`S intersect P` for `S` in `S(Delta)`. The paper formulates the algorithms in a
nogood-based CDNL framework that covers SAT and answer-set solving (Sections
1–2, pp. 71–73).

The running ASP example has five answer sets but only three projections onto
`{p,q,r}`: `{p,q}`, `{p,q,r}`, and `{p,r}`. This separates enumeration of
distinct visible assignments from enumeration of all hidden witnesses
(Section 2, p. 72).

An emitted representative may be partial over `P`. If `S` leaves
`|P|-|S|` projection atoms unassigned, it denotes all
`2^(|P|-|S|)` completions. Thus the output is a disjoint logical cover of the
projective solution set, not necessarily a list of total projected tuples.

## Algorithms and guarantees

Algorithm 1, `CDNL-RECORDING`, searches by conflict-driven nogood learning.
When it finds a projective solution representative `S`, it prints `S` and
permanently records a solution-excluding nogood. Theorems 1–4 establish:

- termination;
- soundness: every completion of a printed representative over `P` is a
  projective solution;
- completeness: every projective solution is covered by a printed
  representative; and
- redundancy-freedom: no projective solution is covered more than once.

Permanent solution recording can require exponential space because the solver
retains a nogood for every emitted representative (Sections 3–4, pp. 73–76).

Algorithm 2, `CDNL-PROJECTION`, replaces the persistent output blocks with
temporary solution-excluding nogoods tied to systematic backtracking levels.
After an output it flips a selected projection literal and keeps the temporary
nogood only while its systematic level is active; the nogood disappears when
search retracts that level. The soundness, completeness, termination, and
nonredundancy theorems carry over. At most a linear number of temporary
solution-excluding and solution-asserting nogoods coexist, giving polynomial
space in the input/trail representation (Section 5, pp. 78–81).

## Search-order limitations and complexity

Facts 1 and 2 explain why ordinary backtracking is insufficient: flipping a
nonprojected decision can rediscover the same projection, whereas flipping a
projected decision can skip projections whose only witnesses lie below the
discarded hidden branch. The systematic levels in Algorithm 2 preserve the
needed hidden search while eventually splitting projection space (Section 4,
pp. 76–77).

Fact 3 shows that the seemingly simpler policy of always deciding all
projection variables before hidden variables can make the shortest proof or
computation super-polynomially longer on some input families. The proposed
algorithm instead introduces its special projected backtracking structure
adaptively after solutions are obtained (Section 4, pp. 76–78).

The polynomial guarantee is a *space* bound. The paper does not prove
polynomial delay, incremental polynomial time, or output-polynomial total
time. The number of distinct projected solutions can itself be exponential,
and the restricted systematic levels trade away some opportunities for
backjumping and restarting.

## Empirical scope

The implementation variants in `clasp` are evaluated on pigeonhole and queens
families and on application instances. Projected enumeration can finish when
enumerating all unprojected answer sets is infeasible, particularly when many
hidden witnesses share each projection. It provides little benefit and can be
slower when the number of projected and unprojected solutions is similar
(Sections 6–7, pp. 81–85). These are empirical observations, not delay bounds.

## Relationship to our hypothesis

### What is directly established by the work?

Distinct assignments on a chosen Boolean interface can be enumerated exactly
without duplicate hidden witnesses and without retaining one permanent block
per prior output. The polynomial-space result makes projected CDNL a stronger
baseline than a naive loop that accumulates projected blocking clauses.

### What is our interpretation or inference?

If every site of a graph-relative selection observation is represented by an
explicit finite coordinate, including an inactivity value, then this work can
enumerate the resulting *totalized observation tuples* after hiding program
and encoding variables. It does not say how to identify output-demanded sites
or construct those coordinates from a program.

Its partial representatives have logical don't-care semantics: one printed
cube can cover many total projections. Unless every observation coordinate is
fixed before output, one representative can therefore cover several distinct
selection observations. This differs from our exact-fiber contract, where one
record names one complete graph-intensional observation and its exact input
preimage.

### Could it subsume our proposed contribution?

It subsumes any novelty claim for duplicate-free projected enumeration itself,
including polynomial-space enumeration without permanent per-output blocks.
It does not define structural activity, distinguish active equal-valued arms,
derive exact observation guards from program semantics, retain residual
program values, or establish composition across program graphs.

## Evidence locations

- Sections 1–2, pp. 71–73: projective-solution definition and running example.
- Algorithm 1 and Theorems 1–4, pp. 73–76: recording-based enumeration and
  its termination, soundness, completeness, and nonredundancy guarantees.
- Facts 1–3, pp. 76–78: incorrect naive flips and the lower-bound consequence
  of deciding projection variables first.
- Algorithm 2, pp. 78–81: systematic levels, temporary nogoods, and the
  polynomial-space argument.
- Sections 6–7, pp. 81–85: implementation results and search tradeoffs.

## Questions and possible weaknesses

- The Boolean projection interface is supplied as input; no semantics explains
  which program events belong in it.
- A partial printed representative is exact only as a logical cover element,
  not as one total projected observation.
- Polynomial space does not imply output-sensitive runtime or polynomial delay.
- The implementation is propositional/ASP-specific; theory consistency and
  residual symbolic values require additional machinery.
