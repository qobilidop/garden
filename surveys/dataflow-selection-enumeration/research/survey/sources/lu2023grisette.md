# lu2023grisette — Grisette: Symbolic Compilation as a Functional Programming Library

- **Status:** deep-read
- **Primary source:** https://lsrcz.github.io/files/POPL23.pdf
- **Version read:** author-hosted POPL 2023 paper
- **Bibliography key:** `lu2023grisette`

## Why it matters

Grisette supplies a normalized, compositional representation of merged guarded
symbolic values. Instrumenting leaves with selection observations nearly
reduces the representation part of our construction to its existing `Union`
and merging machinery.

## Representation

`Union a` is a binary tree of `Single` values and symbolic conditionals
(Section 3.1, Article 16:10). Its ordered-guards representation gives ordinary
`if`/`else-if` semantics; guards need not be mutually exclusive because later
guards are examined only after earlier ones fail.

A merging strategy is either a symbolic conditional merge or an ordered index
with recursively chosen substrategies. Definitions 3.3–3.11 establish the
closure, partition, depth, and hierarchical merging invariants. “Complete
merging” means normalization under a chosen strategy, not path completeness or
logical canonicity (Article 16:12–14).

## Composition and guarantees

Conditional composition is `mrgIf`; monadic bind performs sequential tree
substitution. `UnionM` and merging combinators cache strategies and preserve
normalization through monad transformers (Section 4.2, 16:21–22).

Lemmas 3.14–3.15 prove merge termination and determinism. Lemma 3.19 bounds
merge derivation size by the strategy depth times the two union sizes. The
proofs are mechanized in Coq (16:17–18). These results concern merging; the
paper does not give a general concrete-language semantic-preservation theorem
for arbitrary user merging functions.

## Motivating example

A conditional list produces the same head value through several alternatives.
Ordered guards avoid the growing negated prefixes of a mutually exclusive
representation while a mergesort-like operation coalesces equal values
(Figure 1, 16:4–5).

## Relationship to our hypothesis

Leaves can contain `(selection observation, residual)`, with a strategy keyed
by the observation. An instrumented graph evaluator can then merge duplicate
observations. Grisette does not define enabled-edge activity, prove that leaves
are exactly observation fibers, make the result independent of strategy, or
bound complete symbolic evaluation in the number of fibers. Extracting flat
disjoint guards from ordered guards may expand prefix negations.

## Evidence locations

- Sections 2.1 and 3.1–3.2, Article 16:4–14: representation and strategies.
- Lemmas 3.14, 3.15, and 3.19, 16:17–18: merge metatheory.
- Section 4.2, 16:21–22: compositional interface.
