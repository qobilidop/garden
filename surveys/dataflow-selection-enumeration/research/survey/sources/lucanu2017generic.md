# lucanu2017generic — A Generic Framework for Symbolic Execution: A Coinductive Approach

- **Status:** deep-read
- **Primary source:** https://inria.hal.science/hal-01238696v2
- **Version read:** HAL/Inria author deposit
- **Bibliography key:** `lucanu2017generic`

## Why it matters

The work establishes language-independent coverage and precision for symbolic
execution defined from a language's rewriting semantics. Generic exact
symbolic-path correspondence is therefore established prior art.

## Program and semantic model

A language definition consists of a Matching Logic signature and model plus
Reachability Logic formulas giving the rewrite semantics (Section 3,
manuscript pp. 16–17). A symbolic state is a Matching Logic formula denoting a
set of configurations. Definition 3.14 derives successor formulas by matching
against rule left-hand sides and conjoining the corresponding right-hand sides.
A symbolic path is a finite or infinite coinductive sequence of satisfiable
derivable formulas (Definition 4.1, p. 22).

## Results and guarantees

- Lemma 4.1 and Theorem 4.1: coverage of concrete paths by symbolic paths.
- Lemma 4.2 and Theorem 4.2: precision of finite symbolic paths with respect to
  concrete paths.
- Theorem 6.1: under additional matching and unification assumptions,
  derivatives can be computed by rewriting in a transformed symbolic language.

The implementation theorem requires a distinguished data subsignature,
restricted configuration patterns and rule left sides, and a finite complete
unification procedure reducible to matchers (Assumptions 6.1–6.2).

## Complexity

No asymptotic complexity result is given.

## Relationship to our hypothesis

A pure dataflow semantics and ghost selection observations could be encoded as
configuration cells, transferring coverage and precision. The framework does
not define a modular summary or enumerate an observational quotient, so it is
foundational rather than the closest algorithmic comparator.

## Evidence locations

- Definition 3.14, manuscript p. 19: symbolic derivatives.
- Definition 4.1 and Theorems 4.1–4.2, pp. 22–24: paths and correspondence.
- Assumptions 6.1–6.2 and Theorem 6.1, pp. 29–31: rewriting implementation.

