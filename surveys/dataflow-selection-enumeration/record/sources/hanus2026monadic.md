# hanus2026monadic — A Monadic Implementation of Functional Logic Programs

- **Status:** deep-read; high-priority implementation and fingerprint-lineage
  evidence
- **Primary source:** https://doi.org/10.1017/S1471068426100453
- **Open version:** https://arxiv.org/abs/2604.27863
- **Artifact:** https://github.com/Ziharrk/kmcc
- **Version read:** arXiv v1 (30 April 2026); publication metadata and the full
  HTML article checked against the TPLP FirstView record published 25 June
  2026
- **Bibliography key:** `hanus2026monadic`

## Version boundary and catalog recommendation

The TPLP Rapid Communication is explicitly a revised and extended version of
Hanus, Prott, and Teegen's PPDP 2022 paper with the same title. It expands the
conference paper from 15 to 40 pages and completes work that PPDP 2022 left as
future work. In particular, the conference conclusion says that a complete
Curry system still required more work and proposed determinism analysis and a
complete compiler as future work. The journal article presents that compiler,
adds static and dynamic optimization of deterministic computations, and gives
substantially fuller treatments of unification, encapsulated search, fair
search, functional patterns, and evaluation.

The journal article should therefore be the retained record, with catalog
status **deep-read** and priority **high**. The PPDP 2022 record
`hanus2022monadic` should become **excluded / medium /
E7-duplicate-version**, described as the conference precursor superseded for
manuscript claims by this expanded TPLP treatment. It remains useful in the
version history, but keeping both versions as candidates would double-count one
work. No technical claim in the survey needs the shorter version once the
journal text is available.

This work does not warrant critical priority. Its core implementation is an
extension of memoized pull-tabbing, whose partial-map and branch-specific
memoization precedents are already covered by the critical 2007, 2009, 2010,
and 2021 lineage papers. The journal extension strengthens implementation and
evaluation evidence, but it does not add an exact-fiber definition, a new
semantic equivalence theorem, or an output-sensitive enumeration result.

## Why it matters

This is the current and most complete implementation account of translating
Curry into monadic Haskell while preserving demand-driven nondeterminism,
call-time choice, and sharing. It demonstrates that branch-sensitive
memoization and complete search can coexist with a high-level functional
target, and it documents the engineering required to extend the kernel to a
nearly complete functional-logic language.

For our theory, it is mainly a boundary source. Its historical account states
the established fingerprint representation exactly as a partial mapping from
choice identifiers to left/right decisions. Its own MPT kernel then deliberately
uses a different object: fresh branch identifiers and per-node task-result maps.
Neither object is a deterministic observation of graph selection sites or a
partition of concrete inputs.

## Program and semantic model

The source is Flat Curry, a normalized first-order intermediate form with
functions, constructors, applications, `let` sharing, rigid and flexible case,
failure, and nondeterministic choice. Curry's intended operational model is
lazy needed narrowing with call-time choice: an unevaluated nondeterministic
argument is shared, and all duplicated uses must resolve the underlying choice
consistently.

The compiler transforms source types, constructors, functions, applications,
and cases into Haskell computations parameterized by a `MonadPlus`-like
interface and an explicit `share` operation. Constructor fields are themselves
monadic computations, preserving laziness. `share` converts call-by-name
behavior into call-by-need behavior by returning a computation whose result can
be memoized.

The base nondeterminism carrier is a binary tree with `Empty`, `Leaf`, and
`Node`. Alternative tree traversals provide depth-first, breadth-first, iterative
deepening, parallel, or fair result extraction. A bare tree is unsound for
call-time choice when one shared choice is duplicated, motivating either
fingerprints or the paper's branch-specific memoization scheme.

## Fingerprints and the actual MPT state

Section 4.1 summarizes the established fingerprint approach: fresh choice
identifiers are preserved when pull-tabbing copies a choice, and each
computation branch carries a **partial mapping from choice identifiers to
left/right decisions**. A traversal must make the same decision for every copy
with the same identifier. The journal paper attributes this technique to prior
KiCS2 and pull-tabbing work; it does not claim the partial-map representation as
new.

The implementation developed in Section 5 is explicitly a solution *without
fingerprinting*. Every nondeterministic computation branch receives a fresh
branch identifier. The monadic state contains the current identifier, the set
of ancestor identifiers, and a shared fresh-identifier supply. Every shared
operation owns a task-result map, a partial map from branch identifiers to
results. A branch first searches its own and its ancestors' entries; otherwise
it evaluates the operation and records the result.

If evaluation changes the current branch identifier, the result is
nondeterministic and is stored only for the descendant branch. If it does not,
the result is deterministic and can be stored at the branch active when
`share` was created, making it reusable across alternatives. The corrected
implementation also records whether a memoized result depended on
nondeterminism. Reusing such a result advances the branch identifier, preventing
a nested `share` from incorrectly treating a branch-dependent value as global.

These task-result maps are mutable memoization state hidden behind a pure
interface, implemented with `IORef` and `unsafePerformIO`. They are not exposed
observations, minimized histories, input guards, or class representatives.

## Extended language features

The journal version gives the full extension story that the conference paper
could only sketch.

- Free variables are explicit run-time values with unique identifiers.
  Demanding an unbound variable through monadic bind narrows it to a constructor
  whose fields are fresh variables, with bindings stored in a branch-local heap.
- Monadic unification dereferences variable chains, binds two variables without
  enumerating their values, instantiates a single unbound variable when needed,
  and structurally unifies constructor values.
- Encapsulated search normalizes a computation and traverses its lazy result
  tree. The paper explains why strong encapsulation can be strategy-dependent
  under sharing and identifies set functions as the strategy-independent
  alternative when argument nondeterminism must remain outside.
- Fair search evaluates nondeterministic branches in concurrent Haskell threads
  and streams leaves through a channel. A semaphore-like protocol signals
  completion; finalizers terminate residual workers when a lazy result list is
  abandoned.
- Functional patterns are implemented through non-strict unification. The
  complete compiler integrates this and the other extensions, though the paper
  omits some implementation details.

## Determinism optimization

A fixed-point analysis identifies deterministic operations. The compiler keeps
ordinary Haskell versions of deterministic functions and data types and
converts their results into monadic representations only at nondeterministic
boundaries. Static classification alone is conservative because higher-order
values can hide functions and a deterministic operation can force a
nondeterministic argument.

The dynamic refinement adds a constructor marking an already deterministic
value. Transformed functions inspect this marker and switch back to ordinary
Haskell implementations when safe. This combines static whole-program facts
with run-time knowledge without generating an exponential family of specialized
variants.

This optimization is relevant engineering evidence for residual execution but
does not compute a semantic support, enabled closure, or exact input region.

## Results and guarantees

The article relies on established Curry, needed-narrowing, call-time-choice,
and pull-tabbing results. It explains why several naive implementations are
unsound and shows how the corrected nested-sharing design avoids a concrete
wrong result. It does not state a numbered soundness or completeness theorem
for the monadic transformation, task-result maps, the complete compiler, or the
fair traversal.

The conclusion calls the resulting search strategy operationally complete and
fair. The concurrent traversal is constructed so a terminating result branch
can publish its leaf despite diverging siblings. This is an implementation
argument, not a theorem about every scheduling environment or every user-chosen
tree traversal.

No uniqueness, minimality, or nonredundancy guarantee is given for branch
identifiers, fingerprints, search-tree leaves, or output values. Equal values
may arise through distinct nondeterministic decisions.

## Evaluation and complexity

The evaluation compares the complete monadic compiler with KiCS2, PAKCS, and
Curry2Go on 11 benchmarks. Memoization is especially effective when a demanded
choice is used repeatedly: for `select150`, optimized monadic MPT takes 0.09 s
versus 28.43 s for KiCS2. Sharing deterministic work across alternatives is
visible in `yesSharingND` (1.33 s) versus `noSharingND` (2.58 s). The
determinism optimization makes ordinary functional programs competitive with
KiCS2 and is decisive on `sortPrimes`, `naiveReverse`, and `queens10`.

These measurements are small-benchmark evidence, not asymptotic results. The
paper gives no bound on search-tree size, number or size of task-result maps,
live threads, time between results, or total enumeration time. The usual
exponential nondeterministic search space remains.

## Relationship to our hypothesis

### What is directly established by the work?

The work provides a complete compiler architecture in which lazy shared
computations have branch-specific partial result maps, deterministic work can
be reused across nondeterministic branches, and different traversals can expose
results without committing the compiler to backtracking. It also accurately
records the earlier fingerprint representation as a partial map from stable
choice identifiers to branch outcomes.

### What is our interpretation or inference?

A deterministic selection evaluator could reuse `share` and branch-sensitive
memoization as implementation techniques. That analogy would require replacing
nondeterministic alternatives and dynamic branch IDs with stable graph-relative
selection sites and deterministic guard outcomes. The paper does not make that
translation.

### Could it subsume our proposed contribution?

It subsumes neither the observer nor the theory. It has no local guard formulas
over concrete program inputs, root-relative enabled closure, inverse-image
fibers, exact and pairwise-disjoint coverage, residual symbolic DAG, full-fiber
blocking rule, compositional summary theorem, or output-sensitive bound. It
does constrain any implementation claim that branch-specific memoization of
lazy shared computations in a functional target is novel.

## Evidence locations

- TPLP metadata: Rapid Communication, FirstView, pp. 1--40, DOI, and online
  publication date.
- Footnote to Section 1, p. 1: explicit revised-and-extended relationship to
  PPDP 2022.
- Sections 1--3, pp. 1--11: Curry model, call-time choice problem, monadic
  transformation, and explicit sharing.
- Sections 4--5, pp. 11--18: fingerprint history, branch identifiers,
  task-result maps, nested-sharing counterexample, and corrected MPT monad.
- Section 6, pp. 18--26: free variables, unification, encapsulated search, fair
  search, and functional patterns.
- Section 7, pp. 26--29: static and dynamic determinism optimization.
- Section 8 and Figure 7, pp. 29--31: compiler comparison and 11 benchmark
  results.
- Sections 9--10, pp. 32--33: related compilers, scope, conclusions, and future
  work.
- PPDP 2022 Section 9, p. 15: the complete compiler and determinism optimization
  were still future work in the conference version.

## Forward-citation boundary

OpenAlex merges the PPDP and journal versions into work `W4297858853`, dates
the merged record to 2022, and attaches the 2026 TPLP DOI. Its four reported
citing works therefore cite the work lineage, not necessarily the newly
published journal text. A journal-only forward snapshot would misrepresent
those citations as post-publication citations and is not required for this
high-priority, non-critical record.

## Questions and possible weaknesses

- The article's primary contribution is implementation; central correctness
  and completeness claims are explained operationally or inherited from cited
  work rather than proved for the complete compiler.
- `unsafePerformIO` and mutable global memo tables are hidden by an intended
  safe interface, but the article gives no formal observational-purity proof.
- Fair search depends on Haskell threads, channels, finalizers, and scheduling;
  no quantitative fairness or resource bound is stated.
- The benchmark suite is small, mixes several implementation languages and
  run-time systems, and does not establish a general performance ordering.
- OpenAlex conflates the conference and journal versions, so its current
  citation count cannot be interpreted as citations to the FirstView article
  alone.
