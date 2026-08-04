# mokhov2019selective — Selective Applicative Functors

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1145/3341694
- **Version read:** author accepted manuscript
- **Bibliography key:** `mokhov2019selective`

## Why it matters

Selective functors give an established compositional abstraction for a static
computation graph whose effects are selected dynamically. Their algebraic laws,
free construction, and interpreters directly threaten a proposed novelty claim
based on compositional selection observation.

## Program and semantic model

An applicative computation exposes all independent effects statically. A monad
can choose arbitrary future effects from a preceding value. A selective functor
sits between them: all possible effects remain statically visible, while
`select` may skip a statically present computation according to a value from
another computation.

The central type is:

```text
select : f (Either a b) -> f (a -> b) -> f b
```

When the first computation yields `Left a`, the second computation is needed;
when it yields `Right b`, its effects may be skipped.

## Main definitions

The `Selective` interface extends `Applicative` with `select`. Derived
combinators include conditional execution, binary branching, short-circuiting
Boolean operations, and finite selection over enumerable types. Section 2.3
gives laws relating identity, distributivity, associativity, applicative
composition, and monadic interpretation.

The `Over` interpretation collects every statically possible effect. `Under`
collects only effects visible without resolving opaque conditions. The
`Validation` instance demonstrates actual omission of errors in inactive
branches.

## Results and guarantees

The laws characterize lawful composition. Section 5 gives a free construction
for rigid selective functors and an interpreter `runSelect`: any natural
transformation from base commands to a target selective functor extends to the
whole computation. This is a reusable compositional semantics, not merely an
execution technique.

## Algorithm

The free construction represents a computation as a type-aligned sequence of
selective steps. An interpreter recursively maps base commands and composes
them with the target functor's `select`. Static analyses reinterpret the same
program in effect-collecting functors; execution reinterprets it in a monadic
or other dynamic instance.

## Complexity

The paper focuses on expressiveness, laws, and industrial applications rather
than exhaustive input partitioning. It demonstrates static dependency analysis
for Dune and speculative execution for Haxl.

## Terminology

Established terms include *selective functor*, *conditional effects*, *static
visibility*, *dynamic selection*, *free construction*, *interpretation*, and
*rigid selective functor*.

## Motivating example

The opening example reads a string and prints `pong` only when the value is
`ping`. Both effects are statically visible, but the write is dynamically
skipped. The validation example reports only errors from the selected shape
branch, closely matching omission of inactive graph cones.

## Relationship to our hypothesis

### What is directly established by the work?

Conditional static computations have a compositional algebra, laws, a free
syntax, and reusable interpretations. Statically present effects can be skipped
according to computed selectors.

### What is our interpretation or inference?

A fixed selective term graph can log its selection-site event before using
`select` to evaluate selected cases. Interpreting the free computation in a
reader of concrete inputs combined with a writer of site events yields the
per-input structural observation. Thus, plain compositionality and an explicit
observer are likely standard instances of this abstraction.

### Could it subsume our proposed contribution?

It strongly subsumes a generic claim that static conditional graphs need a new
compositional semantics. It does not enumerate exact input fibers, construct
SMT guards, model shared term-graph node identity directly, or return residual
symbolic functions. Those operations can nevertheless be layered on its free
interpretation, so a new paper needs more than a selective-functor restatement.

## Evidence locations

- Sections 1–2, pp. 1–11: abstraction, `select`, derived conditionals, examples,
  and laws.
- Section 2.2, pp. 7–9: `Over`, `Under`, and inactive-branch validation.
- Sections 3–4, pp. 11–16: static dependency analysis and speculative
  execution case studies.
- Section 5.1, pp. 16–18: normal form, free construction, and `runSelect`.
- Sections 5.2–5.3, pp. 18–21: reusable DSL interpretations and instruction
  dependency analysis.

## Questions and possible weaknesses

- The free construction is sequence-shaped; graph sharing and identity require
  either explicit commands, memoization, or a separate term-graph syntax.
- The paper computes static over/under approximations and executes individual
  inputs, but does not derive the exact symbolic partition of inputs by
  executed structural events.
- Is exact fiber enumeration merely a standard symbolic interpretation of a
  free selective program, or can graph sharing make the summary theory
  genuinely stronger?
