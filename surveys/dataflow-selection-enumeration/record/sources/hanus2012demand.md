# hanus2012demand — Improving Lazy Non-Deterministic Computations by Demand Analysis

- **Status:** deep-read
- **Primary source:** https://doi.org/10.4230/LIPIcs.ICLP.2012.130
- **Version read:** official LIPIcs conference PDF
- **Bibliography key:** `hanus2012demand`

## Why it matters

This paper is the closest demand-analysis predecessor to our proposal. It
combines a lazy graph-like representation of all nondeterministic results,
stable choice identifiers, and an analysis that exposes a demanded choice
before a consumer duplicates it. It therefore blocks a broad novelty claim for
using demand information to avoid exploring or duplicating unobserved choice
structure.

## Program and semantic model

The source language is Curry with non-strict, nondeterministic operations and
call-time choice. The semantic account uses CRWL-style reduction over partial
values containing `bottom`. A rule may fire at a partial constructor instance,
and an unevaluated defined operation may reduce to `bottom`; the latter models
a subexpression whose value is not demanded.

The compilation target is a lazy functional language. Every source datatype is
extended with `Choice ID a a`. A splittable identifier supply gives each
dynamically created choice a unique identifier. Pull-tab rules propagate a
choice through a demanding operation. Because copied occurrences retain the
same identifier, result extraction must make the same left/right decision for
every occurrence of that choice. Lazy evaluation interleaves construction of a
choice tree with a separately selectable traversal strategy.

## Main definitions

- A partial value is a constructor value that may contain `bottom`; `[P]_bottom`
  is the set of program rules instantiated by partial constructor
  substitutions.
- A unary operation `f` *demands* its argument exactly when `bottom` is the only
  normal form of `f bottom`. This is functional-logic demand, not ordinary
  functional strictness: all overlapping nondeterministic rules contribute
  possible results.
- An interpretation is a set of equations `f t_1 ... t_n = t` over partial
  values. For an initial-call set `M`, the continuous transformer `T_M` adds
  bottom results, improved right-hand sides, and calls reached in right-hand
  sides. Its least fixpoint is `C_M = T_M up-arrow omega`.
- Proposition 2 gives the usable demand test: if `f bottom = bottom` is maximal
  in `C_M`, then `f` demands its argument.
- A finite depth-`k` abstraction replaces deeper subterms by a top element.
  The paper notes that this domain grows quickly and mainly uses `k = 1` in
  practice.

The analysis computes a static property of operation arguments. It does **not**
compute a runtime partial map from active choice identifiers to outcomes.

## Results and guarantees

Theorem 1, imported from the author's earlier call-pattern analysis, relates
the concrete fixpoint to partial CRWL reductions in both directions for calls
in `M`. Proposition 2 then soundly infers demand from a maximal bottom result.
The optimization inserts strict application only where that demand fact is
established. An imprecise abstraction can miss an optimization; it should not
make an undemanded argument strict.

The paper does not state a new end-to-end preservation theorem for the source
transformation. Nor does it prove fairness, completeness, or nonredundancy for
a particular tree traversal. It motivates explicit choice trees as supporting
complete search strategies and relies on the underlying call-time-choice and
pull-tabbing literature for their semantic correctness.

## Algorithm

First compute demanded argument positions with the abstract fixpoint. Separately
mark an operation nondeterministic if a defining rule contains choice or a free
variable, or if the operation transitively depends on such an operation. Replace
an application `f e` by strict application `f $! e` when the argument position
is proven demanded and `e` is classified nondeterministic. Strict evaluation
then exposes and pulls the choice outside `f` before `f` can duplicate the
argument.

## Complexity

There is no asymptotic bound for the analysis, transformed evaluation, or
complete enumeration. The depth-bounded abstract domain is finite but grows
quickly with `k`. In the reported small programs, analysis took less than 10 ms.
The transformation produced large empirical improvements on duplicated
nondeterminism: KiCS2 `addNum5` fell from 8.58 s to 0.01 s and `dupList5` from
52.49 s to 0.11 s. `psort` changed only from 4.98 s to 4.78 s because the
complete permutation could not safely be forced.

## Terminology

Useful established terms are *call-time choice*, *partial value*, *demanded
argument*, *strict application*, *choice identifier*, *identifier supply*,
*choice tree*, *pull-tab step*, and *depth-k abstraction*. Here “demand” is a
semantic strictness property of an operation position, whereas our active
selection set is input- and root-relative.

## Motivating example

`xorSelf x = xor x x` is applied to `aBool = True ? False`. Lazy substitution
duplicates the shared nondeterministic argument before its choice is exposed,
creating several `Choice` nodes with one identifier; consistent extraction
still removes invalid mixed decisions, but it pays for duplicated structure.
The analysis proves the argument of `xorSelf` demanded, so strict application
exposes the single choice before duplication. This is a strong template for a
motivating example, although ours should replace nondeterministic choice by a
deterministic, input-guarded selection and emphasize exact fibers rather than
only avoided work.

## Relationship to our hypothesis

### What is directly established by the work?

Demand can be defined semantically for lazy nondeterministic programs,
soundly approximated by abstract interpretation, and used to expose a demanded
nondeterministic subcomputation before sharing would duplicate it. Stable
choice identifiers preserve call-time decisions across copied choice nodes.

### What is our interpretation or inference?

Static demand is complementary to our dynamic enabled closure: it identifies
positions that are definitely strict across executions, while our observation
records which deterministic selections are actually reached for a particular
input and root set. The dramatic benchmark gains support the importance of
representing demanded structure accurately, but they do not establish our
fiber or output-sensitive complexity claims.

### Could it subsume our proposed contribution?

It subsumes a generic claim that demand analysis can improve lazy exploration
of shared choices. It does not define deterministic guard outcomes, an
input-indexed sparse observation, exact inverse-image guards, residual symbolic
functions, or compositional bounds. Our theory should cite it as a direct
predecessor and avoid presenting demand-driven pruning itself as novel.

## Evidence locations

- Sections 2–3, pp. 132–135: partial CRWL values, call-time choice,
  `Choice ID`, pull-tabbing, consistent extraction, and lazy choice trees.
- Section 4, pp. 135–138: duplicated-choice problem, strict application,
  functional-logic demand, `T_M`, Theorem 1, Proposition 2, and the depth-`k`
  abstraction.
- Section 5, pp. 138–139: nondeterminism analysis and the transformation rule.
- Section 6 and Table 1, pp. 139–140: prototype and timings.
- Section 7, p. 140: stated scope and limitations.

## Questions and possible weaknesses

- The soundness chain for the optimized program is not packaged as a single
  transformation theorem in this paper.
- “Complete strategy” is a capability of the explicit choice representation,
  not a proved property of every traversal.
- The static depth-bounded analysis cannot express the exact per-input active
  selection domain that our theorem requires.
