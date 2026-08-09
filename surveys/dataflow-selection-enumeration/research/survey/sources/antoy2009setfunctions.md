# antoy2009setfunctions — Set Functions for Functional Logic Programming

- **Status:** deep-read; critical predecessor
- **Primary source:** https://doi.org/10.1145/1599410.1599420
- **Open version:** https://www.michaelhanus.de/papers/PPDP09.pdf
- **Version read:** author-hosted PPDP 2009 paper
- **Bibliography key:** `antoy2009setfunctions`

## Why it matters

This paper introduces the term *fingerprint* for a computation history used to
separate different sources of nondeterminism. Its representation is the oldest
identified ancestor of the choice-identifier/outcome maps later used in
pull-tabbing. It therefore blocks any claim that recording sparse
nondeterministic decisions by an identified choice step and selected rule
originated with memoized pull-tabbing or with our work. Stable identity across
pull-tab copies becomes explicit in GCM 2010.

The exact object is nevertheless different from our proposed observation. A
PPDP 2009 fingerprint is a set of nondeterministic *steps inside the argument
of a set function* along one root-to-leaf derivation. It is neither defined as
a partial function nor returned as the enumerated result.

## Program and semantic model

Programs are limited-overlapping inductively sequential (LOIS) term-graph
rewrite systems. Deterministic operations are organized by definitional trees;
the only overlapping operation is binary choice. Graph sharing implements
call-time choice. A fixed strategy gives a finitely branching computation
space `C(e)`. A complete strategy has a derivation to every value, while a
*sensible* strategy does not offer distinct successors originating from the
same nondeterministic step.

The paper distinguishes a step *inside* an argument subgraph from one outside
it by propagating an `in`/`out` origin flag through graph replacement
(Definition 3). Nodes introduced by a rewrite inherit the flag of the replaced
redex root. This dynamic origin relation, rather than present-day syntactic
containment, determines whether a choice belongs to the argument's
nondeterminism.

## Set functions and what is enumerated

For every operation `f`, its set function `f_S` collects nondeterminism caused
by `f` while leaving nondeterminism caused by the arguments external. Thus, for

```text
bigCoin = 2 ? 4
f x = coin + x
```

`f_S bigCoin` has the two set-valued results `{2,3}` and `{4,5}`. The internal
`coin` alternatives are collected in each set; the external `bigCoin`
alternative makes the set-function application itself nondeterministic.

Definition 4 specifies `f_S` relationally:

1. it has the same arguments as `f` and returns sets of values of `f`;
2. every value of `f(t)` belongs to some value of `f_S(t)`, and conversely;
   and
3. two values belong to the same set-function value exactly when they can be
   computed after a common argument reduction with only deterministic steps
   remaining inside that argument.

Corollary 1 observes that `f_S` is deterministic when its arguments are
already values. An application to a nondeterministic argument can still have
several set-valued results, as `bigCoin` demonstrates.

The computation space therefore enumerates ordinary value leaves of `f(t)`.
Fingerprints are internal evidence for assigning those leaves to possibly
several set-valued results of `f_S(t)`. The algorithm does **not** enumerate
fingerprints as an API, nor one input region per fingerprint.

## Exact fingerprint definition

Definition 5 calls the fingerprint of a value leaf `L_v` the **set of
nondeterministic steps inside the argument** on the path from the root of
`C(f(t))` to `L_v`. The formal elements are step occurrences, not identifier
assignments.

The implementation discussion then says that, because a LOIS nondeterministic
step applies one of the two choice rules, a fingerprint can be represented as
a set of pairs `(n,r)`, where `n` is a choice-node identifier and `r` is the
selected rule. The paper mentions a memory location as one possible node
identifier and acknowledges that cloned nodes require a more sophisticated
notion of the same step.

Accordingly:

- the paper uses node/rule-pair **set** notation, not a partial-function
  definition;
- a fingerprint derived from one legal path behaves like a consistent partial
  assignment, because that path cannot select both rules at one choice step;
- subset comparability, not equality or compatible-map union, is the relation
  used by the set-function implementation; and
- the domain records argument-internal nondeterministic history, not precisely
  the selection sites in a requested output's enabled closure.

## Results and guarantees

Lemma 1 recalls deterministic confluence of the program class: steps at
distinct nodes commute up to graph-node renaming. Theorem 1 is the paper's
order-independence result for set functions. If `f(c)` reaches a value using
only deterministic steps inside `c`, then further evaluating `c` cannot remove
that value; a commuting-diagram argument reconstructs the derivation from the
more evaluated argument.

Theorem 2 is the fingerprint correctness result. If two value leaves have
comparable fingerprints—one step set contains the other—then both values
belong to some common value of `f_S(t)`. The paper explicitly warns that the
converse does not hold: the same ordinary value can occur at several leaves
whose fingerprints are comparable or incomparable.

The guarantees must not be overstated:

- a complete strategy denotes all values, but the paper does not prove
  fairness of a concrete incremental traversal of an infinite computation
  tree;
- sensibility prevents one local strategy expansion from redundantly offering
  the same nondeterministic step, but does not make value leaves unique;
- Theorem 2 is not a bijection between fingerprints and set-function values;
  and
- there is no pairwise-nonredundant enumeration theorem for fingerprints,
  ordinary values, or set-valued results.

## Algorithm

Lazily traverse `C(f(t))` as far as demanded by the surrounding computation.
For every value leaf, retain the nondeterministic steps originating inside `t`.
The paper forms the family `N` of these step sets, groups it by subset
comparability, and collects the values attached to each group. This avoids
having to decide in advance how far an argument must be evaluated before the
set function starts collecting internal nondeterminism.

## Complexity

No asymptotic time, delay, or space bound is proved. Computation spaces and
their set-valued results may be infinite and are intended to be traversed
lazily. The paper gives neither a bound on fingerprint size nor an output-
sensitive result. Its argument is semantic—order independence and correct
grouping—rather than a performance analysis.

## Terminology

Established terms include *set function*, *computation space*, *complete
strategy*, *sensible strategy*, *inside step*, *outside step*, *fingerprint*,
*deterministic confluence*, and *order independence*. Here a fingerprint is
specifically an argument-internal nondeterministic-step history.

## Motivating examples

The `bigCoin` example cleanly illustrates separation of operation and argument
nondeterminism. The larger `queens` example uses the set function of `unsafe`
to test that no attacking pair exists without forcing the nondeterministic
placement first. The itinerary example uses set functions to compute a shortest
route. These examples motivate encapsulated search, not structural observation
of deterministic dataflow selections.

## Fingerprint lineage

1. **PPDP 2009:** a leaf fingerprint is a set of nondeterministic steps inside
   a set-function argument; the proposed concrete representation is a set of
   choice-node/rule pairs.
2. **GCM 2010:** Alqaddoumi et al. cite this paper, introduce a denumerable
   choice-ID space, decorate every graph node with a finite subset of
   `ChoiceID x {1,2}`, preserve an identifier across pull-tab copies, and
   eliminate a node when both alternatives of one identifier occur.
3. **Pull-tabbing correctness and KiCS2:** later work formalizes consistent
   choice-identifier resolution and extracts values from explicit choice
   structures using those decisions.
4. **Memoized pull-tabbing:** a task fingerprint is stated directly as a
   partial map from choice identifiers to `Left` or `Right`; task-result maps
   add branch-specific memoization.

Thus PPDP 2009 is the terminological and node/rule-set origin, GCM 2010 is the
stable choice-ID propagation step, and MPT is the task-local partial-map and
memoization refinement.

## Relationship to our hypothesis

### What is directly established by the work?

Sets of identified nondeterministic decisions can summarize the relevant part
of a graph-rewrite derivation and can guide order-independent grouping of
values. The paper proves a sufficient comparable-fingerprint criterion for two
ordinary values to belong to the same set-function result.

### What is our interpretation or inference?

A legal node/rule-pair set is extensionally similar to a sparse partial
assignment. That observation is an interpretation; the paper itself defines a
set of steps and never gives the map/fiber semantics proposed for deterministic
selections.

### Could it subsume our proposed contribution?

It subsumes novelty for the general fingerprint idea and for using stable
nondeterministic step histories to group graph-computation results. It does not
define deterministic guard outcomes, root-relative activity, exact inverse
images over concrete inputs, residual symbolic functions, or nonredundant
projected enumeration.

## Evidence locations

- Section 2, pp. 74–75: LOIS graph rewriting, computation spaces, complete and
  sensible strategies, deterministic confluence, and sets of values.
- Definition 3, p. 76: dynamic inside/outside origin tracking.
- Definition 4, Corollary 1, and Theorem 1, p. 77: set-function semantics,
  determinism on value arguments, and order independence.
- Section 4 and Figure 1, pp. 78–79: lazy implementation and grouping by
  argument-internal nondeterministic steps.
- Definition 5 and Theorem 2, p. 79: fingerprint and comparable-fingerprint
  correctness.
- Section 7, p. 81: claimed contributions and scope.

## Questions and possible weaknesses

- The paper calls subset comparability an equivalence relation for the
  fingerprint family used by the construction; subset comparability is not an
  equivalence on arbitrary sets, so the invariant making this valid deserves
  an explicit statement.
- Cloned choice nodes complicate the suggested node-identity representation;
  stable choice identifiers are made explicit only in the 2010 pull-tab work.
- Theorem 2 is one-directional and permits repeated ordinary values at
  incomparable leaves; no canonical or nonredundant fingerprint quotient is
  proved.
