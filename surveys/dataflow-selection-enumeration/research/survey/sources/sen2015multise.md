# sen2015multise — MultiSE: Multi-Path Symbolic Execution Using Value Summaries

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1145/2786805.2786830
- **Version read:** UCB/EECS-2014-173 technical report
- **Bibliography key:** `sen2015multise`

## Why it matters

MultiSE already represents many executions by disjoint, collectively exhaustive
guards paired with symbolic expressions. This is the most direct warning
against claiming guarded residual results or exact input covers as new.

## Program and semantic model

The formal language is assembly-like, with variables, memory, a program
counter, assignments, indirect loads/stores, conditionals, and computed jumps.
A state maps every variable, address, and the program counter to a value
summary.

## Main definitions

A *guarded symbolic expression* is a pair `(phi,v)`. A *value summary* is a set
of such pairs whose guards are pairwise disjoint and whose disjunction is true.
The union operator may merge equal expressions by disjoining their guards.
Disabling that coalescing recovers conventional path-separated DSE.

## Results and guarantees

Theorem 1 gives soundness with respect to concrete execution: every concrete
state denoted by a reachable MultiSE state is concretely reachable. The paper
also argues that, absent optional approximations, MultiSE and conventional DSE
produce logically equivalent final value summaries; approximations may lose
completeness but preserve soundness.

## Algorithm

Operations lift pointwise across guarded expressions. State updates affect only
the current program-counter guard and preserve the complement. Conditional
execution creates guarded program-counter values. BDDs represent guards and
SMT checks prune infeasible program-counter alternatives.

## Complexity

The paper emphasizes empirical sharing and avoided repeated operations rather
than a worst-case bound. A value summary can itself grow with the number of
distinct path-dependent values. Reported sharing factors range from 3 to 45 in
the evaluated programs.

## Terminology

*Guarded symbolic expression* and *value summary* are established terms. The
paper reserves *path constraint* for each guard even after guards from multiple
paths have been merged.

## Motivating example

A small imperative program produces several paths but fewer distinct symbolic
values. The transposed, per-variable representation exposes sharing and shows
how a later conditional is evaluated fewer times.

## Relationship to our hypothesis

### What is directly established by the work?

Disjoint, exhaustive guarded symbolic values; incremental multi-path execution;
concrete soundness; and equivalence with ordinary DSE.

### What is our interpretation or inference?

An output summary alone coalesces equal expressions, while our proposed
observation deliberately distinguishes equal-valued alternatives when their
choice site is active. A MultiSE state could nevertheless carry an explicit
instrumentation variable for every choice outcome, potentially reproducing our
observation.

### Could it subsume our proposed contribution?

Yes, after instrumenting each choice site with an observation variable and
projecting away ordinary control-flow detail. We need either a representation or
algorithmic theorem showing that structure-directed demanded-site enumeration
does more than this encoding.

## Evidence locations

- Section 2.3: definition and disjoint/exhaustive invariant of value summaries.
- Section 3 and Figure 3: operational rules and value-summary union.
- Section 3.4: conventional DSE as a special case.
- Section 4, Theorem 1: concrete-execution soundness and DSE correspondence.

## Questions and possible weaknesses

- Does instrumentation preserve MultiSE's sharing, or does recording site
  outcomes force exactly our desired partition?
- Is a choice-configuration summary just a value summary for one ghost variable?
