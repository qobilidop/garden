# brassel2011thesis — Implementing Functional Logic Programs by Translation into Purely Functional Programs

- **Status:** deep-read; critical formal and representational predecessor
- **Primary source:** https://d-nb.info/1020245336/34
- **Persistent identifier:** `urn:nbn:de:gbv:8-diss-70568`
- **Bibliographic record:** https://dblp.org/rec/phd/dnb/Brassel11
- **Version read:** 179-page dissertation PDF preserved by the German National
  Library
- **Bibliography key:** `brassel2011thesis`
- **Date note:** the title page says Kiel 2010, while the examination/printing
  approval and German National Library dissertation record date the work to
  2011. This repository follows the primary library record and uses 2011.

## Why it matters

This dissertation is the strongest formal predecessor in the
choice-identifier lineage read so far. Chapter 5 translates lazy
functional-logic programs into purely functional programs whose values contain
explicit `Choice ID a a` nodes. A consistent assignment from choice identifiers
to alternatives drives a lazy `hnf` extractor, and Theorem 3 equates the set of
source values with the set extracted from the transformed program. Chapter 6
then implements the evolving assignment as `Map ID Choice`, branching only
when an encountered identifier is absent.

Consequently, neither stable choice identifiers, consistent binary decisions,
lazy choice extraction, nor a finite partial `ID`-to-decision map can be a
novelty claim of our work in isolation. The remaining distinction is semantic:
Braßel records resolutions of dynamically created *nondeterministic choices*;
our proposed observation records outcomes of deterministic input guards at
static dataflow selections and is intended to denote an exact inverse image of
concrete inputs.

## Program and semantic model

The source is a first-order lazy functional-logic language with call-time
choice. Earlier chapters reduce free variables and narrowing to binary
nondeterministic choice and transform programs to a flat uniform form.
Evaluation is a heap-based natural semantics, so shared variables model
call-by-need update rather than textual substitution.

Chapter 5 classifies as nondeterministic every operation that directly or
transitively depends on `(?)`. Such operations receive an additional identifier
argument. The transformed signature includes `initID`, `leftID`, `rightID`,
`Choice`, and `hnf`. A source choice becomes a constructor-valued term

```text
Choice :: ID -> a -> a -> a
```

instead of immediately selecting an alternative. Rules that demand a value
lift `Choice` through the operation while preserving its identifier. Repeated
occurrences of one source choice therefore remain associated even after lazy
evaluation has exposed them in different positions.

The abstract identifier algebra requires `leftID` and `rightID` to be
injective, to have disjoint images, and never to produce `initID`. The formal
identifier set is freely generated from `initID`. The prototype model uses
positive unbounded integers with `initID = 1`, `leftID i = 2*i`, and
`rightID i = 2*i+1`. Definition 5.2.4 splits an identifier supply with a
`fresh_n` construction; Proposition 5.2.5 and Lemma 5.2.10 establish the
independence and preservation properties needed to keep dynamic calls uniquely
identified.

## The choice assignment: two distinct presentations

The dissertation contains two related but importantly different assignment
objects.

### Formal Chapter 5 object

Section 5.2.1 asks for a representation of a mapping from identifiers to
`{1,2}`. It describes the representation as a subset of
`ID x {1,2}` that is the graph of a function and assumes an abstract
`lookup(i,ch)`. The proof abstracts entirely from its implementation and
assumes that `ch` supplies a decision for every identifier encountered in the
derivation. Thus the theorem-level `ch` should be read as a consistent
assignment sufficient for one finite evaluation, not yet as an algorithm that
discovers a minimal partial assignment.

Definition 5.3.1 makes consistency operational with `choose`: a heap binding
`Choice(i,x1,x2)` is mapped to `x_j` when the evaluated identifier and `j`
occur in `ch`. Proof rules extend a choice set with one pair `(j,i)` as a source
nondeterministic step is reconstructed. Every finite natural-semantics proof
uses finitely many such decisions, but Chapter 5 does not separately define a
finite-map datatype, prove that the domain is minimal, or enumerate the maps as
observable results.

### Concrete Chapter 6 object

Section 6.2 first represents decisions by mutable `IORef Choice` cells, where
`Choice = ChooseLeft | ChooseRight | NoChoice`. For parallel and encapsulated
search, §6.2.4 replaces those cells by the pure definitions

```text
type ID           = Integer
type SetOfChoices = Map ID Choice
```

with absent keys read as `NoChoice`. `searchMPlus set (Choice i x y)` follows
the recorded branch if `i` is present; otherwise it explores both recursive
calls after inserting `i -> ChooseLeft` or `i -> ChooseRight`. This is genuinely
a lazily extended finite partial map from stable identifiers to binary outcomes.
It is the closest concrete representational precedent for our proposed sparse
selection observation.

The map is still search state, not a canonical result descriptor. It can retain
decisions made earlier in a task even when the eventual value does not depend
on them, and different complete assignments can produce the same value.

## Head-normal-form extraction

Definition 5.2.11 defines `hnf(ch,e)` by two cases:

- on `Choice(i,x1,x2)`, look up `i` in `ch` and recursively evaluate only the
  selected alternative; and
- on a data constructor, return that constructor in head normal form.

A source goal `e` becomes `hnf(ch, tr(initID,e))`. Complete normal forms are
not built directly. The dissertation explains that a datatype-specific `nf`
function can recursively force subcomponents through repeated head-normal-form
evaluation.

This separation of a lazy choice tree from a selectable extractor is central.
The transformed computation can expose only enough tree structure to reach the
next constructor, while the search strategy controls how missing choices are
assigned. It does not, however, make the resulting assignment a weakest or
minimal observation.

## Invalid branches, laziness, and sharing

The motivating `selfEq coin` example evaluates to a tree containing several
occurrences of choice identifier `1`. Mixed paths that take left at one
occurrence and right at another are invalid under call-time choice. A consistent
assignment `{(1,1)}` or `{(1,2)}` extracts `True`; no consistent assignment
extracts `False`.

This notion of *invalid branch* means an inconsistent resolution of one shared
nondeterministic choice. It is not an unsatisfiable region of deterministic
program inputs. The distinction matters for our paper: the dissertation prunes
histories that violate call-time choice, whereas our guards should characterize
which concrete inputs cause deterministic selections to take particular arms.

The laziness claim is stronger than merely delaying a list traversal. `coin`
is passed unevaluated and demanded by its consumer; `hnf` recursively evaluates
only the alternative selected by `ch`; and the computations leading to the
invalid `False` occurrences in the example are never evaluated. Choice lifting
is local, so a whole surrounding context need not be cloned up front.

Sharing across nondeterminism is inherited from the lazy Haskell target. A
deterministic let-bound computation shared by both alternatives remains one
host-language thunk. Section 6.4 illustrates `let x=e1 in x ? x`: the expensive
deterministic `e1` is computed once, and the measured transformed implementation
essentially pays `t(e1)` plus the negligible choice cost. This is an operational
and empirical benefit in addition to the heap-sharing modeled in the proof.

## Theorem 3: exact scope of adequacy

Definition 5.4.1 defines `[[e]]_7` as the set of constructor values obtainable
from a terminating derivation

```text
Gamma_0 : hnf(x_ch, x_e) Downarrow_7 Gamma : c(x_n)
```

for some choice assignment `ch`, after recursively applying `choose_ch` while
extracting the heap value. The original `[[e]]_3` is likewise a value-oriented
set derived from the source natural semantics.

Theorem 3 proves

```text
[[e]]_3^P = [[e]]_7^{dQM(P)}
```

where `dQM(P)` composes the earlier uniform-program transformation, identifier
translation, replacement of source choice by `Choice`, and the `hnf` machinery.
The two inclusions are supplied by the correctness and completeness lemmas of
§5.3. In that precise sense, the transformation is adequate: it yields exactly
the source program's constructor values.

The notation is called a denotation in the dissertation, but both sides are
sets extracted from operational big-step derivations. This is not a
domain-theoretic denotational-semantics theorem, nor is it an equality between
sets of choice maps. It does not say that each value is produced once, that a
particular traversal is fair, or that returned assignments form a disjoint
partition of another input space.

## Search strategies and enumeration guarantees

Section 6.2 instantiates the abstract extractor with depth-first,
breadth-first, iterative-deepening, and parallel searches. Monadic lists expose
values on demand. Depth-first search can remain forever in an infinite branch.
The discussion explicitly contrasts a lazy DFS over natural numbers, which
returns only a subset for the example, with BFS, which eventually returns every
natural number as long as memory suffices. Iterative depth-first search is
described as combining DFS space behavior with BFS completeness.

These are algorithms and qualitative strategy claims, not one general theorem
that arbitrary `MonadPlus` traversal is fair. Theorem 3 existentially quantifies
over `ch`; it does not prove that every implementation schedule eventually
visits every adequate assignment. The implementation also does not deduplicate
equal values: the `selfEq coin` example has two consistent assignments that
both yield `True`, and §6.6 uses `nub` explicitly in an encapsulated-search
example when duplicate values are unwanted. No nonredundant assignment or
value-enumeration result is stated.

## Algorithm and cost

At transformation time, compute the transitive set of operations depending on
nondeterministic choice, add a split identifier supply to their calls, translate
source choice to `Choice`, and add lifting rules for demanded choices. At
runtime, evaluate lazily to a constructor or exposed `Choice`; consult the
current assignment at an exposed choice; and, when no decision exists, branch
the search and extend the assignment with the two alternatives.

The dissertation gives no asymptotic bound for transformation size, number of
choice assignments, delay between values, or total enumeration work. The
positive-integer identifier implementation is explicitly called wasteful:
identifiers can grow rapidly, although a more efficient unique-name mechanism
could use controlled effects. The pure search map is a Haskell `Data.Map`, but
no map-operation analysis is composed with search-tree size. Search may remain
exponential in the number of independent choices, and equal results may be
reached more than once.

The empirical chapters compare generated Haskell against contemporary Curry
systems and show that reuse of host-language laziness, sharing, and optimization
can be competitive or substantially faster. Section 6.9 also records a serious
space-leak hazard for complex lazy pattern bindings: one small source rewrite
made `queens 8` exceed 4 GB and slowed `queens 7` from 0.16 s to 11.48 s. These
measurements establish practical relevance but are not output-sensitive
complexity guarantees.

## KiCS2 continuation adjudication

The WFLP 2011 paper *KiCS2: A New Compiler from Curry to Haskell*
(https://doi.org/10.1007/978-3-642-22531-4_1) is an implementation continuation,
not a replacement for this source note. Its four authors present the new Curry
compiler and benchmark the representation of nondeterministic results as
datatype values under several extraction strategies. It operationalizes the
same choice-tree and stable-identifier approach in the compiler lineage.

For claims about the `ID -> {1,2}` formal object, `hnf`, uniqueness conditions,
or Theorem 3, the dissertation is the authoritative and substantially more
complete source. For claims about the concrete KiCS2 compiler architecture and
its performance, the WFLP paper should be cited separately. The current survey
catalog therefore correctly keeps `brassel2011kics2` as a distinct candidate;
a second deep-read note was not needed to adjudicate the formal priority issue
assigned here.

## Terminology

Established terms worth retaining are *call-time choice*, *choice identifier*,
*identifier supply*, *set of choices*, *choice tree*, *head normal form*,
*search operation*, *sharing across non-determinism*, *depth-first search*,
*breadth-first search*, and *iterative depth-first search*.

The historical term *set of choices* covers both a graph-of-a-function
presentation and concrete mutable or immutable implementations. When comparing
with our theory, the more precise phrase *finite partial choice map* should be
reserved for the Chapter 6 `Map ID Choice` representation. We should not call
that map a fiber, path condition, or minimal observation; the dissertation does
not give it those semantics.

## Motivating-example lesson

`selfEq coin` is an excellent compact demonstration of why stable identities
matter: naive lifting computes illegal mixed results, while a strict monadic
encoding loses laziness. The transformed tree plus consistent choice map
preserves both call-time choice and late demand.

Our motivating example can reuse the *shape* of that lesson but should expose
the semantic contrast. A deterministic dataflow selection whose guard depends
on input can be shared and encountered lazily. Recording its stable site ID and
actual arm resembles Braßel's choice map. Our new obligation is to prove that
the conjunction of those deterministic local guards describes exactly the
input fiber and exactly the root-relative enabled closure, rather than merely
enforcing consistency among copies of an arbitrary nondeterministic decision.

## Relationship to our hypothesis

### What is directly established by the work?

A lazy shared computation with nondeterministic choices can be compiled into a
pure functional choice tree. Stable identifiers associate copied occurrences,
and a consistent identifier-to-branch assignment extracts exactly the source
constructor values. A concrete search can discover decisions on demand in a
finite immutable map and can be instantiated by multiple traversal strategies.

### What is our interpretation or inference?

The same engineering pattern can instrument deterministic dataflow selections:
give each selection a stable site identity, record its concrete guard outcome
when evaluation reaches it, and preserve that fact under sharing. This is an
analogy, not an immediate corollary. Dynamic choice-call identity and static
graph-site identity have different contextual and invocation obligations.

### Could it subsume our proposed contribution?

It subsumes any broad claim for a sparse map from stable decision identifiers
to binary outcomes, lazy population of such a map, consistent decisions across
shared occurrences, or exact recovery of functional-logic values by quantified
choice assignments.

It does not define deterministic guard formulas over concrete inputs,
root-relative enabled closure, an exact inverse-image partition, residual
symbolic functions, full-fiber blocking, or compositional/output-sensitive
bounds. Its assignments are not proved minimal or nonredundant, and its search
space is semantic nondeterminism rather than a partition of deterministic
inputs. The defensible novelty boundary is therefore our deterministic
guard-induced observation and its fiber/composition theory, not the map
representation or lazy extraction mechanism.

## Forward-citation screen

Semantic Scholar's exact-title search resolves the dissertation to paper ID
`dc996ed9c17b643d2ce8444350ebf50e672743eb` (DBLP
`phd/dnb/Brassel11`, Corpus ID 2605797). The index dates that record to 2012,
which conflicts with the primary library record's 2011 date and is not used for
bibliographic metadata. The forward snapshot contains all 17 citing records
returned by the API at capture time. It finds direct continuations including
KiCS2, correctness of pull-tabbing, the basic and fair compilation schemes,
demand analysis, weakly encapsulated search, and later bubbling work. The
snapshot is discovery evidence, not a completeness claim about scholarship.

## Primary-bibliography screen

The dissertation's pp. 171--179 contain 121 bibliography entries, all
transcribed in the primary backward snapshot. The snapshot deliberately keeps
the source's duplicate records for the APLAS 2007 paper, the 1999 rewriting-
logic paper, the 1997 Evaluation Dependence Tree paper, and the PLILP 1997
redex-trail paper. It also repairs only a PDF extraction line break that splits
“Java” in the 1997 concurrent-Curry citation across nonadjacent text blocks;
the underlying bibliographic entry is otherwise preserved. This is the
complete primary reference list, not an index reconstruction.

## Evidence locations

- Chapter 5 introduction and §5.1, pp. 91--96: translation goal, `Choice ID`,
  free identifier algebra, `selfEq coin`, invalid mixed branches, laziness, and
  call-time choice.
- §5.2, pp. 96--103: nondeterministic-operation closure, identifier
  transformation, independence, and unique-identification preservation.
- §5.2.1, pp. 103--105: graph-of-a-function choice assignment, `lookup`,
  Definition 5.2.11 `hnf`, and transformed goals.
- §5.3, pp. 105--114: `choose`, correctness, and completeness simulations.
- §5.4, pp. 115--116: Definition 5.4.1 and Theorem 3 value-set equality.
- §6.2, pp. 122--130: `NoChoice`, on-demand monadic lists, DFS, BFS, IDFS,
  parallel search, pure `Map ID Choice`, and `searchMPlus`.
- §6.4, pp. 132--133: definition, benchmark, and host-language mechanism for
  sharing across nondeterminism.
- §6.6, pp. 138--141: encapsulated lazy search, `searchMPlus`, explicit search
  trees, BFS versus DFS on an infinite result set, and explicit use of `nub`.
- §6.9, pp. 157--158: space-leak limitation.
- Chapter 7, pp. 169--170: claimed theoretic and practical contributions.

## Questions and possible weaknesses

- Chapter 5 leaves `lookup` abstract and does not state a precise finite-map
  invariant for the quantified choice sets; the immutable partial map arrives
  only with the implementation in §6.2.4.
- Theorem 3 is extensional in constructor values and therefore does not expose
  how many assignments yield one value or whether any assignment is minimal.
- Search fairness depends on the selected strategy; DFS is explicitly
  incomplete on an infinite branch and no schedule-parametric theorem is given.
- There is no asymptotic or output-sensitive enumeration analysis.
- Identifier uniqueness is semantic but the prototype integer encoding can
  produce rapidly growing identifiers.
- The published date varies across metadata sources; primary-library evidence
  supports 2011, while the title page records the 2010 submission year.
