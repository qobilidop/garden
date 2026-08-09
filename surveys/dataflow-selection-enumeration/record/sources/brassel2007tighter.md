---
citekey: brassel2007tighter
work:
  title: "On a Tighter Integration of Functional and Logic Programming"
  author: "Bernd Braßel, Frank Huch"
  venue: "APLAS 2007"
  date: 2007
  doi: 10.1007/978-3-540-76637-7_9
read: full-text
source: "APLAS 2007 conference paper via https://doi.org/10.1007/978-3-540-76637-7_9 (open copy: https://citeseerx.ist.psu.edu/document?doi=9b44c5ccc322eda41cf03f347f0a8a29dcad11d7&repid=rep1&type=pdf); metadata checked against the Springer chapter record"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Predates pull-tabbing with an explicit partial-function 'branching information' map from stable dynamic OR references to branch positions, lazily extended at exposed choice frontiers — the earliest fingerprint-shaped representation in this lineage, though for nondeterministic program search rather than deterministic selection-site observation"
---

# On a Tighter Integration of Functional and Logic Programming

## Evidence

### Why it matters

This paper predates pull-tabbing and already defines *branching information*
`rho` as a partial function from stable dynamic OR references to branch
positions. It starts that function empty, extends it only when an OR frontier
is exposed by lazy head-normal-form evaluation, and uses the same reference at
every occurrence of one shared choice. It is therefore the earliest explicit
partial-map representation found in this lineage and blocks any novelty claim
for that representation by itself.

The setting and observable remain different from ours. OR references name
dynamically created nondeterministic choices, while our proposed identifiers
name deterministic selection sites in a fixed graph. The search tree represents
possible results; it does not partition concrete program inputs into exact
guard fibers.

### Program and semantic model

The source language is normalized first-order Flat Curry with constructor and
function calls, rigid and flexible cases, disjunction, and explicit `let`
sharing. The baseline natural semantics updates a heap to implement laziness
and call-time choice. The paper first eliminates free variables with typed
generator functions and simplifies the baseline semantics before adding its
main extension.

The extended semantics treats nondeterminism as a lazy data structure. A source
disjunction evaluates deterministically to an internal constructor
`OR r [x1,...,xn]`, where `r` is fresh. `Lift` pushes a case into every OR branch
but preserves `r`. The heap can consequently share deterministic expressions
below and across nondeterministic branches just as it shares data below an
ordinary constructor.

An internal `FAIL` constructor represents failed pattern selection. A separate
`SearchTree a = Value a | Or [SearchTree a] | Fail` exposes the resulting lazy
search structure to source-level depth-first, breadth-first, or other traversal
functions.

### The exact `rho` object

Section 4.2 states that branching information `rho` is a **partial function
from OR references to branching positions**, i.e. natural numbers and, for
binary ORs, values in `{1,2}`. `hnf rho e` evaluates `e` to a head normal form:

- if it reaches `OR r [x1,...,xn]` and `r` is in `Dom(rho)`, `Hnf-Choose`
  continues with `x_(rho(r))`;
- if `r` is absent, the later `Hnf-Stop` rule returns that OR frontier; and
- a non-OR constructor is returned directly.

Thus `rho` is not merely extensionally map-like notation: the paper explicitly
types it as a partial function and looks decisions up by reference. The value
is persistent functional state rather than a mutable global table.

### Stable identity, lazy extension, and sharing

The `OR` rule allocates a fresh reference for each dynamically evaluated source
disjunction. `Lift` retains that reference when a choice is propagated through
a case, and repeated uses of a heap-shared OR structure see the same reference.
This stability is dynamic and computation-local: the paper does not assign one
static identifier to a source selection across calls or concrete inputs.

The search transformer `st` begins as `st empty e`. When `hnf rho x` exposes
`OR r [x1,...,xn]`, rule `St-Or` creates lazy child computations
`st (rho union {(r,i)}) xi`. The map is therefore extended at the first exposed
unresolved OR and independently for each alternative. Because the resulting
`SearchTree` is lazy, deeper choices and map entries are produced only when a
consumer traverses the corresponding branch.

This is a demand-prefix partial assignment, but not a minimized result
observation. A traversed branch retains earlier decisions even if later output
does not semantically depend on them. Nor does the paper prove that two equal
results carry the same or a minimal `rho`.

Sharing is visible in Example 4. Two branch-specific `hnf` computations use the
same heap variable whose expensive deterministic expression evaluates to `T`.
The first computation updates that heap entry; the second looks up `T` rather
than repeating the work. This is sharing **across** nondeterministic branches,
not only call-time consistency of the nondeterministic decision itself.

### Theorem 3 and its boundary

Theorem 3 is titled *Completeness of the extended semantics*. If the simplified
baseline semantics derives `Gamma : e downarrow Delta : v`, then there exist an
extended heap `Delta'` and a sequence of branching updates `s` such that
`Gamma : hnf rho e Downarrow Delta' : v`, with `rho` obtained by applying `s`
to the empty map and `Delta = cut(rho, Delta')`.

The proof construction adds `[r -> i]` whenever the baseline derivation selects
branch `i`. Heap pruning `cut` follows those recorded OR branches to relate the
extended heap to the original one. The paper explicitly notes that `cut` is not
defined for arbitrary `(rho,heap)` pairs; it is used only existentially on the
constructed corresponding derivation.

This theorem is a one-way existence result: every old-semantics value has a
matching extended derivation and a suitable branch map. It does not, by itself,
prove that every arbitrary `rho` or every extended derivation corresponds to a
baseline value, that maps are unique or minimal, or that an incremental
traversal is fair. The chapter sketches proof ideas and sends complete proofs to
technical report 0710.

Theorem 5 adds representation completeness: every baseline value can be
selected from the lazy search-tree representation constructed by `st empty`.
It is again one-directional. Theorem 4 establishes mutual exclusion between
failure and a non-failure result for the deterministic extended evaluation, but
there is no nonredundant enumeration or canonical-fingerprint theorem.

### Encapsulated search

`st` translates internal ordinary values, failures, and OR frontiers to the
typed `SearchTree`. Because it extends `rho` under each `Or` child, a consumer
can implement pure depth-first or breadth-first search by ordinary pattern
matching. Complete encapsulation additionally requires forcing results to
normal form so `Value` fields contain no hidden `OR` or `FAIL` constructors.

The paper calls a thread-forking fair search an I/O action because result order
then embodies committed choice and loses the purity of the deterministic lazy
search-tree interface. It presents how such a fair traversal could be
implemented, not a theorem that every source-level traversal is fair.

### Complexity and evaluation

No asymptotic time, delay, space, or map-size bound is stated. The central cost
claim is qualitative and supported by the palindrome example: existing Curry
systems recompute expensive input elements across parser branches, whereas the
new heap representation can share them. The paper reports existing-system
measurements motivating the problem but no controlled performance table for
KiCS in this chapter.

The implementation evidence consists of a direct interpreter and the Kiel
Curry System compiler, which translates Curry to Haskell with extended data
constructors for OR and FAIL. The conclusion reports practical feasibility,
not an output-sensitive enumeration result.

### Terminology

Established terms include *OR reference*, *branching information*, *branching
position*, *heap pruning*, *sharing across non-determinism*, *head normal form*,
*encapsulated search*, *complete encapsulation*, and *search tree*. The paper
does not use *fingerprint* for `rho`, but Alqaddoumi et al. 2010 cite this work
as part of the history later called fingerprints.

### Fingerprint lineage

1. **Braßel and Huch 2007:** `rho` is explicitly a partial function from fresh,
   dynamically stable OR references to branch positions; `st` lazily extends it.
2. **Braßel and Fischer 2008:** `hnf` uses a list-backed choice-ID assignment,
   following recorded decisions and branching with an extended assignment when
   an encountered identifier is absent.
3. **Antoy and Hanus 2009:** a *fingerprint* is formally a set of
   argument-internal nondeterministic steps; its suggested representation is a
   set of choice-node/rule pairs, used for grouping set-function results.
4. **Alqaddoumi et al. 2010:** every graph node carries a finite subset of
   `ChoiceID x {1,2}`; a pull-tab copy retains the choice identifier, and
   incompatible decisions mark an impossible graph.
5. **Braßel 2011:** the dissertation proves adequacy of the choice-tree
   translation for constructor-value sets and instantiates demand-extended
   search with `Map ID Choice`.
6. **Memoized pull-tabbing 2021:** task fingerprints are again stated directly
   as partial maps from choice identifiers to Left/Right, with per-task result
   maps adding branch-specific memoization.

The 2007 paper therefore establishes the explicit partial-function shape and
lazy frontier extension before the term *fingerprint* was introduced in the
2009 paper. The 2010 contribution is stable propagation through pull-tab graph
copies, not the first partial identifier-to-branch map.

### Evidence locations

- Sections 1–2, pp. 122–128: motivating examples, normalized Flat Curry,
  baseline heaps, and call-time choice.
- Sections 3.1–3.3, pp. 128–131: generator elimination and equivalence of the
  simplified semantics.
- Sections 4.1–4.2, pp. 131–134: OR constructors, fresh references, `rho`,
  `Hnf-Choose`, heap pruning, Theorem 3, and the sharing example.
- Section 4.3, pp. 134–137: `FAIL`, `Hnf-Stop`, lazy `st` extension,
  Theorems 4–5, complete encapsulation, and traversal strategies.
- Sections 5–6, pp. 137–138: relationship to bubbling, implementation, and
  scope.

## Bearing on RQs

What is directly established by the work: fresh OR references preserve
consistent choice identity through sharing and lifting. A sparse partial map
records branch positions only as lazy search exposes OR frontiers.
Deterministic heap updates can be shared across nondeterministic branches, and
every baseline result has a corresponding map and extended derivation.

What is our interpretation or inference: the map's lazily grown domain
resembles a demand observation. Reusing the mechanism for deterministic guard
outcomes is an implementation analogy, not a result of this source: its
decisions choose nondeterministic alternatives and its domain follows a
search-tree traversal.

Could it subsume our proposed contribution: it subsumes a claim for sparse
partial maps from stable dynamic choice IDs to branch outcomes, lazy extension
at demand frontiers, and sharing deterministic work across branches. It does
not define deterministic selection-site observation, local guard predicates
over concrete inputs, exact inverse-image fibers, residual symbolic functions,
full-fiber blocking, or compositional and output-sensitive enumeration bounds.

## Evidence limits

Semantic Scholar resolves the DOI to exact paper
`9b44c5ccc322eda41cf03f347f0a8a29dcad11d7`, with the exact title and both
authors. The frozen forward snapshot contains all 46 citing records reported
by the index at capture time. It is discovery evidence, not a completeness
claim about the scholarly literature.

- The formal relation highlighted in Theorems 3 and 5 is one-directional
  completeness; the chapter does not state a matching converse theorem.
- `cut` is intentionally partial and only existentially justified for matched
  derivations.
- Dynamic OR references are stable inside one computation, not static site IDs
  across calls and inputs.
- A lazy search tree may repeat equal values and need not expose them fairly
  under an arbitrary consumer traversal.
- Complete proofs are deferred to a technical report, and performance claims
  are not accompanied by a controlled KiCS evaluation in this paper.
