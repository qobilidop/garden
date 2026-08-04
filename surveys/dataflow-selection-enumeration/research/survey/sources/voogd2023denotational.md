# voogd2023denotational — Denotational Semantics for Symbolic Execution

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-031-47963-2_22
- **Version read:** author preprint from https://ebjohnsen.org/publication/23-ictac/
- **Bibliography key:** `voogd2023denotational`

## Why it matters

This is the closest formal precedent for describing symbolic execution as a
piecewise function over a partition of the initial state space. It makes generic
claims about exact guards, residual behaviors, soundness, completeness, and
trace correspondence unavailable as novel contributions.

## Program and semantic model

The language is an imperative while-language over a set of program variables.
Concrete semantics is a partial state transformer; nontermination makes it
undefined. Symbolic execution maintains a substitution and path condition.

## Main definitions

Section 3 inductively defines a set of *pieces* `(F,B)`: a behavior function and
its precondition. Sequencing composes functions and pulls later preconditions
back through earlier behavior. Conditionals intersect branch pieces with the
guard or its complement. Loops take a countable union over iteration counts.

Definition 1 interprets the pieces as a partial function by selecting the unique
piece whose precondition contains an input. Section 4 separately defines
branch-free traces, their substitutions, and their path conditions.

## Results and guarantees

- Lemma 1: piece preconditions are pairwise disjoint; nontermination means they
  may cover only a subpartition.
- Theorem 1: the piecewise symbolic semantics equals concrete semantics.
- Theorem 2: feasible traces correspond bijectively to nonempty pieces.
- Corollaries 1 and 2 state ordinary symbolic-execution correctness and
  completeness, including uniqueness of the matching path condition.
- The principal results are mechanized in Coq.

## Algorithm

The paper gives a direct transition semantics that updates symbolic
substitutions and path conditions. Its contribution is semantic and
compositional rather than a new practical path-search strategy.

## Complexity

No output-sensitive complexity analysis is central to the paper. Loop semantics
may have infinitely many pieces.

## Terminology

Established terms include *piece behavior*, *piece precondition*, *path
condition*, *feasible trace*, *partition of the input space*, *correctness*, and
*completeness*.

## Motivating example

The absolute-value program yields two pieces, one for negative and one for
nonnegative inputs. It is mathematically clean but does not expose graph sharing
or structurally inactive nested choices.

## Relationship to our hypothesis

### What is directly established by the work?

The work directly establishes disjoint input regions paired with exact residual
state transformers and a bijection to feasible traces.

### What is our interpretation or inference?

Our desired triples `(guard, configuration, residual)` specialize its
`(precondition, trace, behavior)` pattern unless the graph-specific notion of a
sparse demanded observation has additional structure.

### Could it subsume our proposed contribution?

It subsumes the broad semantic partition theorem. It does not directly define
an unordered partial map of demanded sites in a strict pure term graph, nor
preserve an active choice whose alternatives have the same behavior.

## Evidence locations

- Section 3, Lemma 1 and Definition 1: pairwise-disjoint pieces and piecewise
  semantics.
- Section 3, Theorem 1: concrete correspondence.
- Section 4.2, Definition 3: path conditions.
- Section 4, Theorem 2 and Corollaries 1–2: trace correspondence, correctness,
  and completeness.

## Questions and possible weaknesses

- Is our graph observation merely a trace instrumentation followed by erasure?
- Can its denotational construction be instantiated directly on a term language
  with strict choice expressions, making our partition result immediate?
