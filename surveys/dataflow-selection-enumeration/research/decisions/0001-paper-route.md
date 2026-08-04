# 0001 — Conditional original-paper route with a survey fallback

- **Status:** provisional
- **Date:** 2026-08-04

## Context

The project began with the hypothesis that exhaustive demand-sensitive
symbolic evaluation of pure dataflow graphs might define a new symbolic
execution problem. The initial closest-work audit found that its broad
components are established separately and compose through a direct encoding.
The user requested a survey paper if existing work completely answers the
problem; otherwise the preferred outcome remains an original research paper.

## Alternatives

1. Write an original paper around disjoint guards, completeness, and residual
   values.
2. Pursue a narrower original theory of compositional structural observation.
3. Stop the original route and write a survey or taxonomy of the converging
   literatures.

## Evidence

- Piecewise denotational symbolic execution and MultiSE already provide exact
  guarded partitions and residual symbolic values.
- Pull-tabbing provides term-graph choices, shared identities, exhaustive
  alternatives, and evaluation-strategy independence.
- AllSMT, disjoint projected enumeration, predicate abstraction, and decision
  diagrams enumerate selected logical observations after straightforward
  activation/outcome instrumentation.
- Event and configuration structures weaken novelty claims about sparse sets
  of enabled structural events.
- A deterministic observation map induces a disjoint cover by its fibers; this
  theorem is mathematically useful but elementary.

No single work found so far packages the exact graph-relative API that retains
active equal-valued selections while omitting structurally inactive sites and
returns guards, residuals, and witnesses. That packaging difference alone is
not a sufficient research contribution.

## Decision

Proceed conditionally with the original-paper route only while testing this
stronger thesis:

> Selection observation is a compositional intensional semantics for finite
> shared pure term graphs, characterized by an explicit structural observer
> and realized by reusable exact summaries that agree with whole-graph
> evaluation.

The theory gate requires all of the following:

- an explicit observer language or observation algebra;
- a non-tautological congruence, minimality, full-abstraction, or universal
  characterization;
- exact composition under graph substitution and sharing;
- contextual occurrence semantics for calls and finite iteration;
- a summary construction or complexity result not obtained merely by adding
  activation/outcome variables and invoking projected AllSMT.

If these requirements cannot be met honestly, route the manuscript to a survey
or taxonomy paper. A CAV tool paper would additionally require an implemented
baseline and evidence of a scalability or validation advantage; that evidence
is outside the theory-first draft currently authorized.

## Consequences

- Do not draft the manuscript introduction around broad novelty claims.
- Treat the fiber, partition, soundness, completeness, and `K+1`-query results
  as supporting or baseline facts unless the compositional theory strengthens
  them.
- Continue the survey through a second snowballing round while formalizing and
  attempting to falsify the stronger thesis.
- The route decision is an evidence gate, not a commitment to force an
  original result.

## Revisit when

- the observer and composition theorems have proof sketches and counterexample
  audits;
- the strongest projected-AllSMT reduction has been formalized side by side;
- two independent reviewers have assessed whether the remaining theorem is
  publication-level.
