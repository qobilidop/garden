# antoy2017irrelevant — Eliminating Irrelevant Non-determinism in Functional Logic Programs

- **Status:** deep-read
- **Primary source:** https://www.michaelhanus.de/papers/PADL17_long.pdf
- **Publisher record:** https://doi.org/10.1007/978-3-319-51676-9_1
- **Version read:** author-hosted 26-page long version of the PADL 2017 paper
- **Bibliography key:** `antoy2017irrelevant`

## Access and version note

The primary text read is the authors' explicitly labeled long version. The
published PADL chapter is pp. 1--18 in LNCS 10137; the long version includes
additional proof material and Agda appendices through p. 26. Metadata was
cross-checked against the publisher record and the authors' BibTeX entry.

## Why it matters

This paper formalizes when operational nondeterminism can be erased because
all complete results are equal. It is therefore the clearest contrast to our
claim that two observed selections can remain distinct observations even when
they yield equal residual values. It also supplies a concrete semantics of
unevaluated subexpressions using bottom and a static analysis for locating
reachable nondeterministic operations.

## Static nondeterminism and relevance

Definition 1 calls an operation **non-deterministically defined (NDD)** when
its defining rules are not inductively sequential or a defining rule contains
free variables. This is a decidable syntactic overapproximation: an unreachable
branch can make an operation NDD even if evaluation never chooses there
(Section 3, pp. 4--5).

Definition 2 gives each operation `f` the smallest set `f^R` of **relevant NDD
operations**:

- if `f` is NDD, `f^R = {f}`;
- if `f` is a set function, `f^R` is empty because its nondeterminism is
  encapsulated;
- otherwise `f^R` contains the relevant sets of operations called by `f`.

The first rule deliberately reports the first NDD operation rather than every
transitively reachable source. A finite-domain fixpoint computes the sets. The
implementation additionally records a bounded call sequence leading to an NDD
operation (Sections 3 and 5.1, pp. 4--5 and 10).

This is static call-graph relevance, not a per-input account of which concrete
choice site is dynamically demanded.

## Semantic model and exact definition

The semantic setting is call-time choice with sharing. Values contain no
defined operations. Partial values may also contain `bottom`, representing an
undefined or unevaluated subexpression. The reduction relation has a rule for
applying a program equation under a partial-constructor substitution and a
rule permitting any expression to reduce to `bottom`. The latter models
non-strict evaluation when a subexpression is not demanded (Section 4,
pp. 5--6).

Definition 3 says an n-ary operation `f` is **deterministic** exactly when, for
every tuple of partial input values, any two reductions of the call to complete
values `r` and `r'` have `r = r'`. Failure is allowed. Nondeterminism inherited
from evaluating the argument is excluded by quantifying over already chosen
partial values; for example, identity remains deterministic although
`id (0 ? 1)` has two results (Section 4, p. 6).

The equality is on complete values, not head-normal or partial values. A result
such as `[0, 0 ? 1]` has one head constructor but two complete values, so its
operation is not deterministic. Consequently, the implementation must compute
one result completely before omitting the alternative choices. Conversely,
allowing partial inputs permits pruning before an infinite argument is fully
evaluated (Section 4, pp. 6--7).

Proposition 1 proves that, for sensible types, it suffices to establish unique
complete results on complete input values. Its proof fills each `bottom` in a
partial input with some value and replays the two derivations. The stated
notion is intentionally restricted to finite result values: nondeterminism in
an infinite output might arise arbitrarily late, leaving no sound finite point
at which to cut the search (Section 4, pp. 7--8).

## Operational transformation

The programmer writes a `DET` result annotation. A preprocessor renames the
original definition to `fND` and replaces `f` by selection of one element from
the set function of `fND`. Set functions encapsulate nondeterminism introduced
by the definition but not nondeterminism of its arguments. Lazy evaluation of
the result set prevents computation of later elements after one complete value
has been selected (Section 5.1, pp. 10--11).

Thus, `DET` is a **don't-care** transformation. It intentionally changes the
standard multiplicity/branching behavior, while preserving the set of distinct
complete values only when Definition 3 holds. For a nondeterministic argument,
the cut is applied separately to each argument value.

## Checking and proof claims

Incorrect annotations lose completeness, and determinism is undecidable in
general. The preprocessor emits a proof obligation rather than pretending to
verify every annotation (Section 6, p. 12).

CurryCheck tests whether the result set has fewer than two values while
systematically enumerating inputs. This is exhaustive only for finite domains.
Proposition 2 gives a sufficient rewriting criterion: if every pair of standard
rewrite derivations from a complete input reaches the same complete value, the
operation satisfies Definition 3. The converse fails because ordinary rewriting
overapproximates the call-time-choice reduction. Confluence, and syntactically
weak orthogonality, are sufficient special cases. The paper also gives direct
semantic arguments and Agda proofs for particular operations (Section 6 and
Appendices B--C, pp. 12--26).

## Evaluation claims

The CASS analysis precisely rediscovered reintroduced NDD problems in four
applications of 52--110 modules and 14,357--26,634 source lines. Initial whole-
application analyses took 5.33--15.27 seconds; incremental reanalysis took
1.80--7.42 seconds on the reported system (Figure 1, pp. 11--12).

Seven small examples compare computing all solutions with and without `DET`.
Most annotated cases fall below 10 ms versus 0.48--53.96 seconds unannotated;
`last [1..20000]` instead slows from 0.05 to 0.24 seconds because search
encapsulation has overhead. The authors explicitly note that arbitrarily large
speedups can be manufactured by increasing inputs and that the comparison is
partly artificial because top-level nondeterminism would normally need
encapsulation for I/O (Figure 2 and discussion, p. 12).

## Relationship to our hypothesis

### What is directly established by the work?

An operation may branch operationally yet denote at most one complete result
for every fixed partial input. With a correct annotation, later equal-result
branches can be omitted after one complete value is found. The program's
reachable syntactic sources of nondeterminism can be overapproximated by a
finite static fixpoint analysis.

### What is our interpretation or inference?

Their deterministic operation is **result-deterministic despite operational
nondeterminism**. It is deliberately extensional: active branches producing
equal values are redundant and collapsed. Our observation is graph-intensional:
if a selection site is demanded, choosing its left or right arm can remain two
distinct observations even when the residual result values are equal.

The paper's `bottom` distinguishes an unevaluated subexpression inside the
semantic proof model, but the transformation does not emit an inactivity marker
or a map of demanded sites. Definition 2's relevant NDD set is also not this
map: it is a static operation-level reachability summary, independent of a
particular input and evaluation.

### Could it subsume our proposed contribution?

No. It supplies a close semantic contrast and a safe extensional quotient, not
exact enumeration of graph-relative observations or their input fibers. Any
manuscript claim that equal-valued choices have not previously been discussed
would be false; the defensible distinction is that we retain their active
selection identity for an explicitly intensional observation.

## Terminology distinctions for the manuscript

- Qualify the paper's term **deterministic operation** as
  **result-deterministic** or **single-valued despite operational
  nondeterminism** when comparing it with our semantics.
- Use **semantically irrelevant nondeterminism** for their extensional equality
  of complete results. Do not use it for an unobserved selection site.
- Use **observed equal-valued selections** for our intentionally distinct
  graph-site outcomes. Their transformation collapses precisely this kind of
  distinction when it has no effect on complete values.
- Use **relevant NDD operation** only for their static call-dependency analysis;
  use **demanded selection site** for our dynamic observation coordinate.
- Their `bottom` is an unevaluated partial value in a semantic derivation; our
  inactive marker records that a particular site was structurally unvisited.

## Evidence locations

- Definitions 1--2, Sections 3, pp. 4--5: NDD operations and static relevance.
- Definition 3 and Proposition 1, Section 4, pp. 5--8: partial values,
  result-determinism, and finite-value restriction.
- Section 5.1, pp. 10--11: `DET` preprocessing through lazy set functions.
- Figures 1--2 and Section 5.2, pp. 11--12: analysis and runtime measurements.
- Propositions and proof methods, Section 6, pp. 12--15: testing, rewriting,
  confluence, and proof assistants.
- Sections 7--8, pp. 15--17: distinction from dynamic cuts and completeness
  claims.
- Appendices B--C, pp. 19--26: Agda proofs for `last` and `min`.

## Questions and possible weaknesses

- Correctness of annotations is generally undecidable and remains a programmer
  proof obligation; testing gives confidence but not completeness on infinite
  domains.
- Search is cut only after one complete finite result, so the method does not
  directly handle productive infinite result structures.
- The static NDD analysis intentionally overapproximates and ordinarily reports
  only the first reachable NDD operation.
- The runtime experiments are small examples, and the paper acknowledges both
  arbitrarily scalable speedups and encapsulation overhead.
