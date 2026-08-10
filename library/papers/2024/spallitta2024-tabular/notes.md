---
citekey: spallitta2024-tabular
work:
  title: "Disjoint projected enumeration for SAT and SMT without blocking clauses"
  author: Giuseppe Spallitta, Roberto Sebastiani, Armin Biere
  venue: "Artificial Intelligence 345, 104346"
  date: "2025-04-29"
  doi: 10.1016/j.artint.2025.104346
  arxiv: 2410.18707v2 (v1 first appeared 2024-10-22; v2 author preprint of the 2025 journal article)
sources:
  pdf: https://arxiv.org/pdf/2410.18707v2  # arXiv v2 author preprint; title and authors match the journal record
retrieved: 2026-08-09
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-09
synthesis: "TabularAllSAT and TabularAllSMT combine CDCL, chronological backtracking, and implicant shrinking to enumerate a disjoint projected cover without accumulating blocking clauses, trading complete tuples for compact partial models."
---

# Disjoint projected enumeration for SAT and SMT without blocking clauses

A solver-algorithm paper that advances [[model-enumeration]] along three axes:
disjoint partial models, existential projection, and SMT theory consistency.
Spallitta, Sebastiani, and Biere combine CDCL's conflict learning with
chronological backtracking's systematic coverage, then shrink satisfying
trails into mutually exclusive implicants. The resulting TabularAllSAT and
TabularAllSMT avoid the growing blocker database used by classic enumeration.
The algorithmic presentation is detailed and the experiments are extensive;
the guarantees are coverage and disjointness, not minimal cubes or polynomial
delay.

## The output is a cover, not a list of complete models

A total satisfying assignment fixes every variable. A partial model fixes only
enough literals that every extension satisfies the formula. One partial model
can therefore represent exponentially many total assignments. Requiring the
reported partial models to be disjoint turns them into a nonoverlapping cover
of the satisfying space.

Projection splits variables into relevant `Vr` and irrelevant `Vi` and asks
for models of `exists Vi. F(Vr, Vi)`. Irrelevant variables support
satisfiability but disappear from the printed result. This is a different
operation from implicant shrinking: projection removes a declared coordinate,
whereas shrinking removes a relevant literal that is logically unnecessary
for the cube to entail the projected formula.

That output distinction matters for observer enumeration. A complete
assignment to instrumented event coordinates can identify one observation; a
short cube that omits an observed coordinate can cover several observations.
Compactness is real, but it may come from changing the record granularity.

## Chronological structure replaces accumulated blockers

Ordinary CDCL can jump nonchronologically out of conflicts but needs blocking
clauses to prevent previously emitted solutions from returning. Pure
chronological backtracking scans the search space without repetition but can
spend too long in unsatisfiable regions. The paper combines them: conflict
analysis learns clauses, while chronological traversal preserves a systematic
frontier for enumeration.

When a satisfying trail is found, an implicit solution reason and watched
literal structures identify which literals remain necessary. The aggressive
shrinker attempts to delete more of the trail while respecting a `limit` that
preserves mutual exclusivity with earlier outputs. The paper's cycling example
is instructive: allowing deletion below that limit can make a blocker-free
enumerator revisit the same partial models forever. Disjointness is therefore
not just an output check; it is part of the termination mechanism.

For projection, the solver decides relevant variables before irrelevant ones,
so irrelevant decisions cannot become part of the chronological boundary that
must be retained. Only relevant literals are printed. For SMT, Boolean unit
propagation is augmented with theory propagation and consistency checks;
theory-generated atoms are marked nonrelevant.

## The evaluation supports a strong implementation result

On the principal 1,910-instance AllSAT collection, TabularAllSAT and the
D4+ModelGraph pipeline solve all instances within the 1,200-second timeout;
the remaining compared solvers solve fewer. On the 350 projected-AllSAT
instances, TabularAllSAT and D4+ModelGraph again solve all instances, while
Dualiza and MathSAT5 solve fewer. On 400 AllSMT instances, TabularAllSMT solves
287 and MathSAT5 243 under the reported setup.

The detailed scatter plots show a more qualified story than the paper's broad
conclusion. Knowledge compilation can win on favorable structured benchmarks;
implicant shrinking often cannot remove any atom; and MathSAT5 sometimes
produces slightly shorter cubes even when it is slower. The results establish
a capable implementation across the selected datasets, not universal
dominance of chronological enumeration.

TabularAllSAT's source and benchmarks are public. TabularAllSMT uses the
proprietary MathSAT5 theory solver, so the paper provides an executable and
benchmarks rather than the full source. That limits independent modification
of the SMT implementation even though the experiments are described in useful
detail.

## Assessment

- **Durable:** integrating CDCL conflict learning with chronological
  duplicate avoidance; treating disjointness as a search invariant; ordering
  relevant variables before projected-away variables; and exposing partial
  models as a different output object from complete assignments.
- **Era-bound:** the exact solver versions, benchmark suites, hardware,
  1,200-second cutoff, and performance ranking. Later preprocessors, theory
  solvers, and compilation systems can change the comparison.
- **Weaknesses:** shrinking is not guaranteed to find minimal partial models;
  the paper gives no OutputP, IncP, or DelayP theorem; and the SMT source is
  constrained by the proprietary backend. Empirical model-count validation
  supports coverage but is not a substitute for a standalone formal proof of
  every implementation layer.
- **Against the library:** [[phan2015-all-smt]]
  establishes the classic important-variable projection and blocking/DFS
  baselines. This paper modernizes the search and compresses its results.
  [[avis1996-reverse-search]] supplies the contrasting classic
  in which a unique parent map, rather than chronological SAT search, removes
  the visited set and yields an explicit output-sensitive bound.

The paper's central lesson is that enumeration architecture and output
semantics cannot be separated. Avoiding blockers works because the traversal
and the disjoint partial-model contract are designed together.
