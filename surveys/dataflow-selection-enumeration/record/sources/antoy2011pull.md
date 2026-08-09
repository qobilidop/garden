# antoy2011pull — On the Correctness of Pull-Tabbing

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1017/S1471068411000263
- **Version read:** journal PDF
- **Bibliography key:** `antoy2011pull`

## Why it matters

This work already combines rooted term graphs, explicit choices, sharing,
delayed commitment, exhaustive alternatives, and evaluation-strategy
independence. It prevents us from claiming generic novelty for exhaustive
choice evaluation on graphs.

## Program and semantic model

Programs are limited-overlapping inductively sequential term-graph rewrite
systems. A distinguished binary nondeterministic choice operator has two
rewrite rules. A pull-tab graph transformation moves a choice toward a root
while cloning only one predecessor at a time.

## Main definitions

Definition 1 represents an expression as a rooted graph and decorates choice
nodes with identifiers. Definition 4 requires every step on the same choice
identifier to select the same alternative. Definition 5 maps a graph to its
*represented set*: every graph obtained by consistently resolving all and
only its choices.

## Results and guarantees

The order of distinct choice steps does not affect the represented set.
Lemmas 3 and 4 show invariance under pull-tab and non-choice steps. Corollary 1
lifts this to computations, and Theorem 1 establishes that computations with
pull-tab steps preserve all and only the consistent values. The result is
independent of a particular evaluation strategy.

## Algorithm

Rather than clone an entire context before exploring a choice, pull-tabbing
copies one node on the choice's spine. A strategy may reduce a choice at the
root, pull it in a non-root position, and evaluate choices only when needed.
The paper deliberately does not formalize one particular strategy.

## Complexity

The motivation is to avoid unnecessary context cloning, especially when an
alternative fails before reaching the root. The paper does not give an
output-sensitive enumeration bound.

## Terminology

Established terms include *term graph*, *choice identifier*, *consistent
computation*, *represented set*, *pull-tab*, *soundness*, and *completeness*.

## Motivating example

A shared coin occurs twice inside a pair. Independent resolution of cloned
occurrences would generate mixed results that were absent from the source
graph. Reusing a choice identifier forces both occurrences to make the same
decision.

## Relationship to our hypothesis

### What is directly established by the work?

Choice identities survive graph transformation, shared choices resolve
consistently, and legal evaluation transformations preserve exactly the set of
results.

### What is our interpretation or inference?

Our selection sites are deterministic and input-guarded rather than
nondeterministic. Our sparse observation also distinguishes which structural
sites are demanded by a chosen output observation. Nevertheless, sharing and
schedule independence need real proofs; they are not consequences of treating
the graph as an unshared expression tree.

### Could it subsume our proposed contribution?

It subsumes generic claims about term-graph choices, consistent sharing,
exhaustiveness, and evaluation-order independence. It does not directly yield
input guards, symbolic residual functions, or fibers of a deterministic
structural observation.

## Evidence locations

- Section 2, pp. 714–716: shared-choice counterexample and motivation.
- Definition 1, pp. 717–718: rooted term graphs and choice identifiers.
- Definition 4, p. 721: consistency.
- Definition 5, p. 723: represented sets and order irrelevance.
- Lemmas 3–4, Corollary 1, and Theorem 1, pp. 723–727: invariance and
  correctness.
- Section 6, p. 727: intended needed-choice evaluation strategy.

## Questions and possible weaknesses

- The graph-rewriting setting permits nondeterminism and transformations that
  our fixed deterministic graph calculus may not need.
- A compositional theory for observed deterministic selections still must
  explain contextual occurrence identities when a shared callee is invoked
  more than once.
