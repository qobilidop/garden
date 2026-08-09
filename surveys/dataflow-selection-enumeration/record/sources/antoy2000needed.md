---
citekey: antoy2000needed
work:
  title: "A Needed Narrowing Strategy"
  author: "Sergio Antoy, Rachid Echahed, Michael Hanus"
  venue: "Journal of the ACM"
  date: 2000
  doi: 10.1145/347476.347484
read: full-text
source: "Author-hosted JACM version, https://web.cecs.pdx.edu/~antoy/homepage/publications/jacm00/paper.pdf"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Needed narrowing computes complete, disjoint solution substitutions by evaluating only the constructor positions required to expose the next constructor — the strongest conceptual precedent for omitting subterms whose values are not required, though it produces solution substitutions rather than sparse site-outcome traces."
---

# A Needed Narrowing Strategy

## Evidence

### Why it matters

Needed narrowing is the strongest conceptual precedent for omitting subterms
because their values are not required by the current computation. It computes
complete disjoint solution substitutions, but not sparse site-outcome traces.

### Program and semantic model

The setting is many-sorted, first-order, constructor-based rewrite systems.
Inductively sequential functions have definitional trees that identify which
constructor position must be inspected next (Definitions 2 and 12).

Definition 10 calls a narrowing position needed when every extension that
reaches a value must eventually reduce its residual. Strategy `λ` traverses a
term and definitional tree together, evaluating only an operation-rooted
argument needed to expose the next constructor (Definitions 10 and 13,
pp. 784–786).

### Results and guarantees

- Theorem 1: `λ` selects an outermost-needed step or correctly reports failure.
- Theorem 2: successful computed substitutions are solutions.
- Theorem 4: completeness relative to constructor substitutions.
- Definition 15 and Theorem 5: substitutions from distinct successful
  derivations are disjoint.
- Corollary 1: minimum family-cost for derivations computing the same result and
  substitution under the shared-family cost model.

The core results require constructor-based inductively sequential systems and
strict constructor equality. They do not cover arbitrary overlapping,
nondeterministic, higher-order systems.

### Sharing and complexity

Section 5 represents duplicated “blood-related” descendants by shared nodes in
finite acyclic term graphs and narrows one complete family once (pp. 802–804).
There is no polynomial-delay or global runtime theorem. The optimality result
is comparative family cost, not a bound on the complete search tree.

### Motivating example

In `X <= Y + Y`, the second argument is not needed when `X=0` but becomes
needed when `X` has successor form. Examples 3 and 6 show how eager narrowing
can diverge or evaluate a subterm later made irrelevant by substitution.

### Evidence locations

- Definitions 10, 12, and 13, JACM pp. 784–786: neededness and strategy.
- Theorems 1, 2, 4, and 5, pp. 788–801: correctness, completeness, disjointness.
- Section 5 and Corollary 1, pp. 802–804: sharing and cost optimality.

## Bearing on RQs

Definitional-tree branches resemble selector outcomes and unvisited arguments
resemble inactive case cones. Distinct successful derivations retain disjoint
input substitutions. The computed object is nevertheless a solution
substitution modulo a rewrite theory, not a contextual map of observed site
outcomes. The finite total pure-graph setting also removes instantiation,
rewrite recursion, and nontermination.

## Evidence limits

Read at full-text (JACM) level; the source note recorded no dedicated
evidence-limits section beyond the scope caveats already stated in the
Evidence section above (constructor-based inductively sequential systems only;
no polynomial-delay or global runtime theorem).
