# Symbolic execution, guarded values, and trace partitioning

## Established core

Across denotational symbolic execution, multipath execution, and trace
partitioning, the recurring object is a family of guards paired with semantic
states or values.

- Voogd et al. define semantic pieces over disjoint input sets and prove both
  concrete correspondence and a trace-to-piece correspondence.
- MultiSE stores pairwise disjoint, exhaustive guarded expressions in value
  summaries and proves agreement with ordinary dynamic symbolic execution when
  approximations are absent.
- Trace partitioning retains selected branch or value histories as abstract
  tokens, with explicit create and merge operations.

Therefore, “symbolic evaluation yields disjoint exhaustive guards and residual
values” is established. Neither purity nor a graph presentation changes that
fact by itself.

## Distinction under investigation

Our candidate semantics chooses an intensional observation before forming the
partition: outcomes of exactly the selection sites exposed by a result
observer. This observation can distinguish equal-valued alternatives that
MultiSE coalescing or ordinary output semantics may merge. It can omit a site
because its cone is structurally unobserved, not because its predicate is a
logical don't-care.

That distinction is descriptive until an explicit observer and a
compositional characterization make it mathematically consequential.

## Terminological consequences

- Avoid *path* for an unordered site-outcome map.
- Avoid *trace partitioning* for an exact concrete observation partition; the
  phrase is occupied by an abstract-interpretation strategy.
- Use *value summary* when comparing directly to MultiSE, but use *guarded
  residual value* for our per-observation result to avoid claiming the object
  is new.

## Remaining comparison obligation

State the erasure map from an observed result to ordinary eager value semantics
and prove adequacy. Any stronger full-abstraction claim must name a context
language capable of observing selection events.
