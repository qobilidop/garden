# porncharoenwase2022merging — A Formal Foundation for Symbolic Evaluation with Merging

- **Status:** deep-read
- **Primary source:** https://unsat.cs.washington.edu/papers/porncharoenwase-leanette.pdf
- **Version read:** author-hosted POPL 2022 paper
- **Bibliography key:** `porncharoenwase2022merging`

## Why it matters

The paper supplies a mechanized, reusable symbolic evaluator with exact merging.
It occupies the foundation for representing all feasible behavior in guarded
symbolic values; enumeration of a particular observation remains separate.

## Program and semantic model

The concrete language is a Core Scheme-like language with procedures, loops,
assumptions, assertions, and free variables as inputs (Figures 2–3, Article
47:6–47:8). Concrete outcomes are answers, errors, or aborts.

The evaluator is parameterized by a symbolic factory. Symbolic outcomes carry
a symbolic state and value; a guarded choice is a pair of a symbolic Boolean
and a value. The factory's `merge` operation denotes the unique choice whose
guard is true under a model (Figure 4, 47:9–47:10).

## Results and guarantees

- Theorem 2: evaluation preserves legal symbolic states.
- Theorem 3: a reducing factory agrees with concrete evaluation on lifted
  concrete inputs.
- Theorem 4: symbolic evaluation is deterministic.
- Theorem 5: the symbolic outcome exactly represents reachable concrete
  outcomes, via matching over- and under-approximation results.
- Theorem 6: termination for finite programs without procedure calls.
- Theorems 9–10: Leanette and its naive factory implement the semantics.

The exactness result is conditioned on symbolic termination and the factory
laws. The stronger finite termination theorem excludes procedure calls.

## Algorithm and complexity

Symbolic conditionals evaluate feasible branches under complementary
assumptions and merge their results (Figure 6, 47:13). The naive factory can
produce exponentially large unions and formulas. The evaluation reports
polynomially sized states for Rosette's optimized factory, but does not prove an
enumeration-complexity bound (47:19 and 47:22).

## Relationship to our hypothesis

A ghost field carrying stable selection-site outcomes makes active selections
part of the merged value, after which Theorem 5 transfers exactness. Without
tags, equal-valued arms can disappear during merging. The framework neither
defines sparse result-observed selections nor enumerates their exact fibers.

## Evidence locations

- Figures 2–4 and 6, Article 47:6–47:13: languages, factory, and evaluator.
- Theorems 2–6, Article 47:15–47:18: metatheory.
- Article 47:19–47:22: implementations and representation growth.

