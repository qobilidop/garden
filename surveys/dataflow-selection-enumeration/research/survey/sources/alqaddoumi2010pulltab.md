# alqaddoumi2010pulltab — The Pull-Tab Transformation

- **Status:** deep-read; critical predecessor
- **Primary source:** https://web.cecs.pdx.edu/~antoy/homepage/publications/gcm10/paper.pdf
- **Bibliographic record:** https://web.cecs.pdx.edu/~antoy/homepage/publications.html
- **Version read:** stable author-hosted GCM 2010 preproceedings PDF
- **Bibliography key:** `alqaddoumi2010pulltab`

## Why it matters

This is the paper that introduced pull-tabbing and the first paper in this
lineage to state the choice-identifier/fingerprint mechanism used to keep
duplicated choices consistent.  Its fingerprint is a sparse record of binary
nondeterministic decisions, so it is an important representational predecessor
for any claim based only on partial maps from stable site identifiers to binary
outcomes.

## Program and semantic model

The setting is functional-logic graph rewriting with call-time choice.  The
worked Curry program shares `coin` between two calls to `flip`; the two uses
must select the same result.  Ordinary backtracking can be incomplete, cloning
copies the entire choice context up front, and bubbling copies the context only
up to a dominator but must find that dominator.  Pull-tabbing instead moves a
choice one predecessor at a time by a local graph replacement, duplicating only
that predecessor node on each step.

The paper assumes deterministic redexes are selected with definitional trees.
It presents pull-tab steps as an additional kind of computation step, not as an
input-domain partitioning algorithm.  A root choice's alternatives can then be
evaluated independently, subject to consistency information accumulated while
the choice was pulled through shared contexts.

## Main definitions

Let `Omega` be a denumerable set of choice identifiers.  The paper defines a
fingerprint as a finite subset of `Omega x {1,2}`.  Every graph node carries a
fingerprint, and a choice node additionally carries a choice identifier.  A
rewrite preserves existing decorations, gives newly introduced nodes empty
fingerprints, and gives each newly introduced choice a fresh identifier.

A pull-tab step at a choice `c` with identifier `alpha` and predecessor `p`
with fingerprint `f` creates a choice with the same identifier and two copies
of `p`.  Their fingerprints are `f union {(alpha,1)}` and
`f union {(alpha,2)}`.  A node whose fingerprint contains both
`(alpha,1)` and `(alpha,2)` roots a semantically impossible graph and is to be
eliminated.

This is set notation rather than the later explicit partial-map presentation.
Restricted to consistent fingerprints, however, it is extensionally a finite
partial function from choice identifiers to `{1,2}`.  It records the history
that reached a graph node; it is not a minimized observation of a result and
does not characterize a fiber of concrete inputs.

## Fingerprint lineage

The paper explicitly says that nondeterministic-step history had already been
used under the name *fingerprint* in its references 3 and 6.  Reference 3,
Antoy and Hanus's 2009 set-functions paper, defines a fingerprint conceptually
as a set of nondeterministic steps, representable in a LOIS implementation by
pairs of a choice-node identifier and the selected choice rule.  The 2010 work
specializes that idea to fresh choice identifiers, binary alternatives, and
per-node propagation during pull-tab graph transformations.

Reference 6, Brassel and Huch 2007, is therefore part of the lineage claimed by
the authors, and it directly concerns sharing computations across
nondeterministic branching.  The exact `Omega x {1,2}` definition is stated in
the 2010 paper itself; the evidence read here does not establish that identical
definition in the 2007 paper.  Accordingly, the safe priority statement is
that the general fingerprint/history idea predates pull-tabbing, while the
particular pull-tab decoration rule is established here.

The later line continues as follows. Antoy's 2011 correctness paper replaces
the preliminary decoration argument with stable choice identifiers,
consistent choice steps, and represented-set preservation. KiCS2 carries
choice identifiers in explicit lazy choice trees and uses consistent decisions
during extraction. Memoized pull-tabbing finally states each **task**
fingerprint directly as a partial map from a choice identifier to `Left` or
`Right`, while a separate task-result map memoizes branch-specific graph
results. Thus the locations differ across the lineage: value leaves in PPDP
2009, graph nodes in GCM 2010, and evaluation tasks in MPT.

## What is enumerated and what is not

Pull-tabbing moves a nondeterministic choice to the root, where its
alternatives can be evaluated independently. The semantic target is the set of
call-time-choice values of the source expression. Per-node fingerprints are
runtime consistency decorations; the paper does not enumerate them as output
objects or associate them with input regions.

The two alternatives of a shared choice can be copied along several incoming
paths. Rejecting a fingerprint that contains both `alpha1` and `alpha2`
removes mixed, impossible branches, but it does not prove that each legal value
or consistent fingerprint is produced only once. Equal values may arise from
different choice identifiers or histories. No nonredundancy result is stated.

## Results and guarantees

The paper explains why unlabelled pull-tabbing is unsound under call-time
choice and why incompatible fingerprints identify impossible mixed branches.
It does not state or prove a numbered soundness, completeness, fairness, or
nonredundancy theorem.  Those obligations are handled formally by Antoy's 2011
`On the Correctness of Pull-Tabbing`; this introduction paper instead ends with
an approximately 1000-line Ruby virtual machine under development.

In particular, the order-independence theorem belongs to the 2009 set-function
setting, not to this workshop paper. GCM 2010 gives no theorem that arbitrary
rewrite/pull-tab scheduling is order independent and no fair-search theorem.

The locality claim is concrete: each pull-tab replacement copies only one
predecessor and neither traverses nor clones a whole context.  Suitability for
parallel multisteps is an expectation, not an evaluated theorem.  The paper
contains no asymptotic total-work, delay, or space bound and no experimental
table.

## Algorithm

For a choice below a non-choice predecessor, replace that predecessor by a
choice whose two alternatives are copies of the predecessor with the original
choice replaced by its left and right alternatives.  Preserve the choice
identifier, extend the copied predecessors' fingerprints with the respective
binary decision, and repeat until a choice reaches the root.  Reject any graph
node whose accumulated fingerprint selects both alternatives of one identifier.

This local step can still duplicate the same choice along multiple incoming
paths.  The fingerprint is what prevents the duplicated occurrences from
being resolved inconsistently; it does not prevent the repeated pull-tab work.
Later demand analysis and memoized pull-tabbing address that cost separately.

## Complexity

The paper's qualitative cost comparison is pay-as-you-go locality.  Backtracking
does little up-front work but may never reach another alternative; cloning can
copy a large context that is soon discarded; bubbling searches for and copies
up to a dominator; pull-tabbing copies one node per step.  There is no bound on
the number of steps until a choice reaches the root, the number of resulting
branches, or fingerprint size.

## Terminology

Established terms include *pull-tab step*, *choice identifier*, *fingerprint*,
*choice spine*, *call-time choice*, *bubbling*, *dominator*, *multistep*, and
*localized graph replacement*.  The paper uses alternatives `1` and `2`; later
work commonly presents the same binary decisions as `Left` and `Right`.

## Relationship to our hypothesis

### What is directly established by the work?

Dynamic choices receive stable identifiers that survive pull-tab copies, and
consistent graph histories are finite sparse identifier-to-binary-decision
records.  Such records are sufficient to reject branches that combine mutually
exclusive resolutions of the same shared nondeterministic choice.

### What is our interpretation or inference?

A deterministic conditional selection could use a similar identifier and
record its actually evaluated guard outcome.  That reuse is only an
implementation analogy: the 2010 identifiers name dynamically created
nondeterministic choices, whereas our proposed identifiers name deterministic
selection sites relative to a fixed graph and concrete input.  The paper gives
neither guard predicates over inputs nor a theorem that the recorded domain is
exactly a root-relative enabled closure.

### Could it subsume our proposed contribution?

It subsumes novelty claims for stable copied choice identifiers, sparse binary
decision histories, or demand-driven local graph branching in isolation. It
does not subsume deterministic local-guard fibers, exact and disjoint input
partitions, residual symbolic functions, full-fiber blocking, or compositional
and output-sensitive enumeration bounds.

## Evidence locations

- Section 1 and Figures 1–2, pp. 127–130: call-time choice and the comparison
  with backtracking, cloning, and bubbling.
- Section 2 and Figure 3, pp. 130–131: pull-tab replacement, fresh choice
  identifiers, the exact fingerprint definition, propagation rule, and
  inconsistency criterion.
- Section 3, p. 131: prototype Ruby VM, multisteps, and the parallelism claim.
- References, p. 132 in the six-page author extract: the complete 18-item
  primary bibliography and the explicit fingerprint-lineage references.

## Forward-citation screen

Semantic Scholar's exact-title match resolves the seed as paper ID
`637115bf8215f2cef172b46ac9cf7121584c5672`, with all four authors and year
2010.  The forward snapshot contains all 11 citing records reported by the
index at capture time.  Direct continuations include the 2011 correctness
paper, KiCS2, 2021 memoized pull-tabbing, later fair implementations, and 2025
determinism types.  This is an index snapshot, not a claim that the index is a
complete census of scholarship.

## Questions and possible weaknesses

- The paper is an introductory workshop contribution and leaves the formal
  semantic theorem to the 2011 continuation.
- Its consistency test explains impossible mixed graphs but no operational
  garbage-collection or canonicalization theorem.
- The prototype and parallel-execution expectations have no reported
  measurements in this paper.
- Bibliographic sources disagree between pages 127--132 and 127--133; this
  repository follows the GCM preproceedings citation requested for the paper.
