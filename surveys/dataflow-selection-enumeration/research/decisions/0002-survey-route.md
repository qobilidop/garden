# 0002 — Route the manuscript to a survey with formal synthesis

- **Status:** accepted
- **Date:** 2026-08-04

## Context

Decision 0001 allowed an original theory paper only if a graph-sharing-aware
compositional observation theorem or modular enumeration result survived the
strongest prior-art reductions. The theoretical attempt produced clean
definitions and proofs, but the proposed originality conditions failed.

## Evidence

The broad semantic and algorithmic problem decomposes into established
machinery:

1. Denotational symbolic execution, MultiSE, and hardware control/data
   partitions already provide disjoint guards paired with symbolic residuals.
2. Pull-tabbing and needed evaluation already address choices, graph sharing,
   completeness, and evaluation-order independence.
3. Selective applicative functors provide a free compositional syntax and
   generic interpretation for statically visible computations with dynamically
   skipped effects. Exact site logging is a reader-plus-idempotent-writer
   interpretation.
4. AllSMT, projected disjoint enumeration, and theory decision diagrams
   enumerate the explicit inactive-or-outcome variables introduced by a
   polynomial activation encoding.
5. The exact guard for one observation is the fiber of a deterministic
   observation function. Full-fiber blocking and projected AllSMT enumerate the
   same fibers and share the naive \(K+1\) model-query bound.
6. Demand-parametric component composition is exact, but it is ordinary
   selective/relational composition and gives no compactness or delay guarantee.

No single paper found to date packages the precise API of contextual active
selection maps, exact guards, residual values, and witnesses. That packaging
difference is insufficient for a PLDI-level theory claim and does not defeat
the straightforward reductions.

## Decision

Write a survey paper with a unifying formal framework rather than an original
symbolic-execution paper.

The survey's technical synthesis will:

- distinguish structural inactivity, existential projection, logical
  don't-care, semantic merging, and abstract merging;
- relate path semantics, guarded value summaries, hardware functional-space
  partitions, term-graph choices, selective computations, projected
  enumeration, and decision diagrams;
- formalize selection observation as one common instance;
- prove the equivalence between exact observation fibers, concolic fiber
  generation, and activation-variable projected enumeration;
- state exact composition and sharing laws and their scope boundaries;
- give counterexamples to overbroad terminology and complexity claims; and
- use XLS IR only as a later case study, not as the source of the general
  theory.

The intended stretch outlet is ACM Computing Surveys. That target requires a
substantially more reproducible and comprehensive literature method than the
current mapping snapshot.

## Consequences

- Stop searching for a novelty formulation of the existing observation API.
- Continue deep reading and snowballing until the survey protocol's saturation
  criterion is genuinely met.
- Repair the search log, reconcile every claimed addition with the catalog,
  record exclusions, and add an evidence matrix across research questions.
- Expand the missing compositional symbolic-execution/function-summary cluster.
- Present the formal results as unifying derivations and reductions, not as
  inventions absent from prior work.
- Do not begin polished manuscript prose until the systematic evidence base is
  closed and independently audited.

## Revisit when

Only a new theorem with a demonstrated separation from both free selective
interpretation and projected AllSMT would reopen the original-paper route.
Implementation convenience, stable naming, or an unstandardized API shape is
not enough.
