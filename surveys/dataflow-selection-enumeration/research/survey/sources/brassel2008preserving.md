# brassel2008preserving — From Functional Logic Programs to Purely Functional Programs Preserving Laziness

- **Status:** deep-read; critical direct predecessor
- **Primary source:** https://doi.org/10.1007/978-3-642-24452-0_2
- **Open author version:**
  https://web.archive.org/web/20200322120446id_/https://www-ps.informatik.uni-kiel.de/~sebf/data/pub/ifl08.pdf
- **Author bibliography:** https://sebfisch.github.io/research/
- **Version read:** complete 19-page author PDF corresponding to the revised
  selected IFL 2008 paper
- **Bibliography key:** `brassel2008preserving`
- **Date note:** the conference and DBLP record use 2008; Springer published the
  revised-selected-paper volume in 2011. This repository follows the event year
  and citekey, while recording the publication lag in BibTeX.

## Why it matters

This paper is the compact primary publication of the pure choice-tree
transformation later developed and proved in Braßel's dissertation. It gives an
especially direct finite-partial-map predecessor: `hnf` carries an association
list from stable choice identifiers to Booleans, follows an existing decision,
and forks only when a demanded choice identifier is absent. A second version
reifies the resulting lazy search as `Value`, `Branch`, and `Stub` nodes.

Therefore, the combination of a lazy choice tree with a demand-extended partial
map of stable binary decisions is already explicit here. The paper does not,
however, return or minimize those maps, interpret them as deterministic input
regions, or prove an adequacy theorem. Its own conclusion explicitly says that
correctness is not proved in this paper.

## Program and semantic model

The source language is Curry under call-time choice. Overlapping rules are
nondeterministic, shared actual arguments denote values rather than repeatable
computations, and finite failure is a normal search outcome. Before the main
translation, arbitrary functional-logic programs are assumed transformed to a
uniform form whose only overlapping operation is binary `(?)`; free variables
are replaced by nondeterministic generators.

The target is pure lazy Haskell. Every source datatype is conceptually extended
with a choice constructor carrying a stable identifier and with a failure
constructor:

```text
Choice  :: ID -> a -> a -> a
Failure :: a
```

The paper suppresses the datatype-specific constructor boilerplate in its
formal presentation. Pattern-matching operations get rules that lift an
encountered `Choice` while preserving its identifier and propagate `Failure`.
Only operations that directly or transitively depend on `(?)` receive an
identifier-supply parameter, so deterministic program parts avoid that runtime
argument.

## Stable identifiers and transformation

The abstract `ID` interface provides `initID`, `leftID`, and `rightID`.
`leftID` and `rightID` must be injective, have disjoint images, and never yield
`initID`. The prototype uses positive unbounded integers:

```text
initID   = 1
leftID i = 2*i
rightID i = 2*i+1
```

The paper acknowledges that identifiers grow rapidly and many integers are
unused. It cites a more efficient controlled-effect technique but retains the
integer scheme to keep the translation itself pure.

Section 3 computes the least set `N` of operations depending on choice. The
translation `tr(i,e)` recursively splits an identifier supply with
`fresh_n(i) = leftID(rightID^n(i))` and passes a distinct sub-supply to each
potentially nondeterministic call. Source `(?)` becomes
`Choice(i,x,y)`. Pattern-matching definitions receive a local lifting rule

```text
f(xs, Choice(i,x,y)) = Choice(i, f(xs,x), f(xs,y))
```

plus failure propagation. Unlike the dissertation, the paper gives the
construction but no proposition or proof that the generated call identifiers
remain independent during evaluation.

## The finite partial choice map

Section 3.4 defines the extractor with an initially empty association list:

```text
hnf ct = hnf' [] ct
```

At `Choice i x y`, `lookup i choices` has two cases:

- `Just b`: follow `x` or `y` according to the existing Boolean; or
- `Nothing`: recursively explore both alternatives after consing `(i,True)`
  or `(i,False)` onto the list.

At every finite point in evaluation, `choices` is a finite partial map
`ID ⇀ Bool`, represented as an association list. It is extended precisely when
head-normal-form evaluation exposes a choice with an as-yet unseen identifier.
Repeated occurrences of an already assigned identifier reuse the decision and
do not branch.

The paper calls the value an ordinary list rather than a fingerprint or partial
map. Extension never inserts a second decision for the same identifier, so the
reachable lists are nevertheless extensionally finite partial functions. This
is a runtime search context, not an emitted observable. It may contain decisions
irrelevant to a later equal value, and the paper gives no minimization or
canonicalization procedure.

## `hnf`, search trees, and invalid branches

The first `hnf` returns a list of values. Missing decisions use list
concatenation, fixing depth-first search. `Failure` contributes `[]`; a
head-normal-form value contributes a singleton list. On the `selfEq coin`
choice tree the result is `[True,True]`, so even the paper's smallest example
demonstrates that equal result values can arise from distinct consistent
assignments.

The second version returns an explicit lazy search tree:

```text
data SearchTree a = Value a
                  | Branch (SearchTree a) (SearchTree a)
                  | Stub
```

An unassigned choice becomes `Branch`; an assigned choice is followed locally;
failure becomes `Stub`. User-defined traversals then select a search strategy.
The paper supplies DFS and points to prior work for BFS. It does not prove a
fairness property for arbitrary traversals.

An invalid branch is one that resolves two copies of the same nondeterministic
choice differently. Stable identifiers and lookup prune such mixed histories.
This is call-time-choice consistency, not logical infeasibility of a
deterministic input region.

## Laziness and sharing

The key semantic-operational example is `selfEq coin`. A list lifting violates
call-time choice by treating the two uses of the argument independently. A
monadic translation restores call-time choice by evaluating the argument before
the call, but becomes strict. The choice-tree translation instead passes
`coin` unevaluated, lifts a choice only when a consumer demands it, and later
forces only alternatives selected by the choice map.

Permutation sort supplies the larger motivating example. Laziness changes a
generate-and-test program into test-of-generate behavior: an out-of-order prefix
rejects all unevaluated completions of that permutation. Strict monadic
translations eagerly generate those completions.

Because the target is ordinary lazy Haskell, deterministic thunks can be shared
across nondeterministic branches. The transformation uses no side effects, so
GHC can optimize the generated program. These are primary implementation
advantages over the authors' earlier KiCS translation, which used unsafe effects
to generate labels.

## Correctness and enumeration guarantees

There is no correctness theorem in this paper. Section 6 says so explicitly and
only argues that the construction is conceptually similar to the earlier KiCS
transformation whose correctness was established by Braßel and Huch 2007. The
later dissertation supplies the detailed identifier invariants and a two-way
value-set adequacy proof for a revised transformation.

The paper likewise proves no soundness, completeness, fairness, or
nonredundancy theorem for search-tree traversal. The explicit tree makes search
policy programmable, but only DFS code is shown. The transformation of a goal
is parameterized by a strategy `st` as `st (hnf (tr(initID,e)))`; correctness of
an arbitrary `st` is not characterized.

The duplicate `[True,True]` result rules out any implicit nonredundancy claim.
The association lists are not output objects and are not proved to partition a
space. Complete-normal-form evaluation is declared orthogonal and delegated to
the earlier KiCS work.

## Algorithm and complexity

At compile time, normalize the program, compute the transitive
nondeterministic-operation set, thread split identifier supplies through those
operations, replace choice and failure by constructors, and add lifting rules.
At runtime, lazily expose `Choice`, `Failure`, or a constructor; branch and
extend the choice list only for a previously unseen identifier; and traverse the
resulting search tree according to a user-selected strategy.

No asymptotic analysis is given for transformation size, choice-list lookup,
identifier magnitude, number of branches, delay, or total enumeration work.
Association-list lookup is linear in the number of remembered identifiers, but
that observation is ours rather than a bound stated by the paper. The number of
consistent assignments can still be exponential in independent choices.

The single experiment compares permutation sort across two strict monadic
encodings, the old KiCS, PAKCS, MCC, and the new transformed Haskell. On the
reported platform, strict monadic variants take minutes at list length 12 while
lazy systems remain fast; the optimized pure translation is reported about 12
times faster than old KiCS. The plot and prose provide no tabulated raw values
or complexity fit.

Memory is an explicit limitation. Both old KiCS and the new approach exhaust
memory on longer permutation-sort inputs, whereas MCC runs the example in
constant space. The authors identify garbage collection and memory behavior as
future work. The compiler itself is also future work at this point; the
experiment validates a prototype translation, not a completed Curry system.

## Relationship to the dissertation and KiCS2

Braßel's dissertation states that its Chapter 5 §§5.1--5.2 publish the content
of this paper. The dissertation expands the syntax and identifier independence
conditions, changes `hnf` to an abstract assignment-driven calculus, and adds
the correctness/completeness proof culminating in Theorem 3. Its Chapter 6 then
returns to executable search maps and benchmarks a fuller implementation.

KiCS2 is the system continuation. It should be used for the later compiler and
benchmark claims; the dissertation should be used for formal adequacy; this
paper should be used for priority of the pure transformation and its explicit
demand-extended association-list map.

## Terminology

Useful established terms are *call-time choice*, *choice identifier*, *choice
tree*, *search tree*, *head normal form*, *uniform program*, *finite failure*,
*sharing across non-determinism*, *generate-and-test*, and *test-of-generate*.

The authors do not name the association list as a fingerprint. In our paper we
can accurately call it a *finite partial choice map*, while noting that this is
an extensional characterization of their executable list representation. We
should reserve *selection observation* for our deterministic graph object and
not suggest that its sparse-map shape is new.

## Motivating-example lesson

The pair of examples is unusually effective. `selfEq coin` isolates semantic
consistency and late demand in a handful of lines. Permutation sort shows why
the distinction matters asymptotically in practice: a consumer can reject a
partially generated candidate without exploring its completions.

Our motivating dataflow example should inherit that two-level structure: one
small shared selection to show stable identity and exact observation, followed
by a graph where a root-specific consumer renders whole subgraphs inactive. The
novel theorem must then move beyond this paper by interpreting deterministic
guard outcomes as exact concrete-input fibers.

## Relationship to our hypothesis

### What is directly established by the work?

A pure lazy target program can reify nondeterministic choices with stable IDs,
carry a finite partial association from IDs to Boolean decisions, extend it only
when evaluation exposes an unseen choice, and produce a lazy explicit search
tree for separately programmable traversal. Host-language sharing can preserve
deterministic work across branches.

### What is our interpretation or inference?

The association list is extensionally a sparse observation of choices demanded
on one search branch. Reusing that implementation pattern for deterministic
dataflow selections is plausible, but it requires a new identity discipline and
proof that actual guard evaluations correspond exactly to the root-relative
enabled closure.

### Could it subsume our proposed contribution?

It subsumes novelty claims for stable binary decision IDs, a demand-extended
finite partial decision map, lazy choice-tree construction, local pruning of
inconsistent shared decisions, or separation of tree production from traversal.

It does not define input predicates, deterministic selection outcomes, exact
inverse-image fibers, residual symbolic functions, full-fiber blocking,
nonredundant observations, or compositional/output-sensitive complexity. It
also supplies no correctness theorem for its own transformation. Our novelty
must be stated in those deterministic semantic and enumeration obligations.

## Forward-citation screen

Semantic Scholar resolves the DOI to paper ID
`9e595813d6af14cdb30f7f6327cf9886c0a5623c` with event year 2008 and reports
nine citing records. The exact forward snapshot includes the dissertation,
KiCS2, the basic and fair compilation schemes, pull-tabbing correctness, demand
analysis, and later Curry verification work. The index reports 30 references,
but the complete primary PDF contains 28; the primary bibliography snapshot
therefore follows the paper rather than the index.

## Evidence locations

- §1, pp. 1--3 of the author PDF: claimed contribution, target-language
  motivation, sharing across nondeterminism, pure labeling, and scope.
- §§2.1--2.2, pp. 3--7: call-time choice, `selfEq coin`, permutation sort,
  strict list/monadic encodings, and laziness.
- §§2.3--2.4, pp. 7--10: `Choice ID`, identifier algebra, invalid branches,
  lifting, and failure.
- §§3.1--3.3, pp. 10--13: uniform programs, nondeterminism closure, identifier
  threading, and the program transformation.
- §3.4, pp. 13--14: association-list choice map, on-demand extension, list
  extractor, explicit search tree, DFS, and goal transformation.
- §4, pp. 14--16: comparison with logic targets, abstract machines, and monadic
  libraries.
- §5, pp. 16--17 and Figure 1: permutation-sort experiment and memory limit.
- §6, pp. 17--18: no-proof disclaimer, implementation status, claimed first
  pure laziness-preserving translation, and future work.
- References, pp. 18--19: complete 28-entry primary bibliography.

## Questions and possible weaknesses

- The paper's central transformation has no direct correctness proof; reliance
  on the earlier side-effecting scheme is only an analogy until the later
  dissertation proof.
- Identifier freshness is specified by algebraic conditions but not proved for
  all transformed evaluations here.
- The association-list lookup cost and potentially rapid integer growth are not
  analyzed.
- Only DFS is defined in the paper and no traversal theorem is stated.
- Duplicate values are retained, and no assignment minimization is attempted.
- The experiment is one benchmark family with a serious unresolved space
  problem and no complete compiler yet.
