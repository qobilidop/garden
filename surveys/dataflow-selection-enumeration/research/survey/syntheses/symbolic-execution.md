# Symbolic execution, guarded values, and trace partitioning

## Established core

Across denotational symbolic execution, multipath execution, and trace
partitioning, the recurring object is a family of guards paired with semantic
states or values.

- Voogd et al. define symbolic denotations as substitutions paired with path
  conditions, prove concrete correspondence, and give exact equations for
  sequential composition, choice, and iteration.
- MultiSE stores pairwise disjoint, exhaustive guarded expressions in value
  summaries and proves agreement with ordinary dynamic symbolic execution when
  approximations are absent.
- Porncharoenwase et al. give a reusable symbolic evaluator with exact merging
  and mechanized correspondence to concrete outcomes.
- Grisette gives a compositional ordered-guard representation and
  strategy-directed complete merging for guarded symbolic values.
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

## Composition is not the missing foundation

Godefroid's SMART composes and reuses exact pre/post path summaries. Anand et
al. lazily expand partial function summaries only when an unexplored path may
be needed to reach a target. Vanoverberghe and Piessens supply a generic
precision and progress discipline for compositional symbolic execution.

These works eliminate “demand-driven summaries compose without losing path
coverage” as a novelty claim. Their demand is target reachability, not the
enabled closure of an output observation. The remaining survey distinction is
therefore the represented quotient and enumeration contract, not ordinary
function-summary composition.

## Terminological consequences

- Avoid *path* for an unordered site-outcome map.
- Avoid *trace partitioning* for an exact concrete observation partition; the
  phrase is occupied by an abstract-interpretation strategy.
- Use *value summary* when comparing directly to MultiSE, but use *guarded
  residual value* for our per-observation result to avoid claiming the object
  is new.
- Qualify every use of *demand*: target-directed exploration, needed reduction,
  partial-value demand, event-enabling input, and enabled-edge observation are
  different notions.

## Remaining comparison obligation

State the erasure map from an observed result to ordinary eager value semantics
and prove adequacy. Any stronger full-abstraction claim must name a context
language capable of observing selection events.
