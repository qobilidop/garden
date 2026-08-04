= Introduction <sec-introduction>

Consider a pure expression graph containing nested conditionals, multiplexers,
priority selectors, or other finite choice operators. A conventional symbolic
evaluator can translate the requested output to one term containing nested
`ite` expressions. That translation is useful, but it does not answer the
enumeration question:

#align(center)[
  _Which distinct selection observations can the requested result expose, and
  what exact inputs and residual value belong to each one?_
]

The distinction matters whenever a decision is inside an unselected case cone.
Such a site is not merely an unconstrained Boolean coordinate. It is absent
from the structural observation for that input and request. Conversely, two
selected alternatives may compute equal values while remaining different
observed events. An output-value quotient, a logical implicant, a path, and a
sparse selection observation therefore preserve different information.

This paper studies the exact finite partition induced by that observer. The
base program is a finite, typed, acyclic, pure term graph with sharing. Ordinary
operators are total and structurally strict: observing their result observes
all operands. A selection first observes its selector and then only the case
roots determined by the selector outcome. Starting from a requested root set,
these rules define an input-indexed enabled closure. The selection sites in
that closure, mapped to their outcomes, form the _selection observation_. Its
inverse image under the input-to-observation map is an _observation fiber_.

The adjective _exact_ carries four obligations. The enumerator must cover every
feasible observation relative to a stated caller domain, emit none twice,
describe each fiber by an equivalent guard, and return a residual value valid
throughout that fiber. Solver `unknown`, unsupported primitives, partial
operations, cycles, and unbounded dynamic occurrences cannot be hidden behind
a completeness claim.

At first sight, this appears to be a new form of demand-sensitive symbolic
execution. The systematic map in this paper rejects that broad novelty claim.
Projected AllSMT already enumerates finite observer coordinates
@phan2015allsmtr, including disjoint partial models
@spallitta2024disjoint @spallitta2025projected. Multi-path symbolic execution
already represents guarded residual values @sen2015multise. Functional-logic
search uses demand-populated maps with stable choice identifiers
@brassel2007tighter @brassel2011thesis. Lazy SmallCheck refines only the input
fragments forced by a Boolean observer @runciman2008smallcheck. Exact input
equivalence partitions and decision diagrams compile finite observer functions
@krafczyk2017effective @huang2024exhaustive. Hyperplane and neural methods
enumerate exact geometric cells, often with affine residual maps
@avis1996reverse @serra2018bounding @vincent2021reachable. Classical dataflow
work gives least-demanded or reverse-demand computation for fixed inputs
@avron1994stability @pingali1985efficient. These are not terminological
near-misses; several are direct reductions or strict special cases.

The contribution is consequently a survey and formal synthesis:

- A reproducible cross-community map distinguishes structural
  non-observation, existential projection, logical don't-care, equal-value
  coalescing, abstract merging, and heuristic partitioning.
- A graph-relative observer gives precise meaning to an input-dependent sparse
  map without calling it a path or claiming that the source language is lazy.
- The _exact-local-guard theorem_ shows that the conjunction of predicates for
  observed outcomes alone defines one complete fiber. Explicit literals for
  structurally unobserved sites are unnecessary because enabled reachability
  fixes their absence.
- A local concolic generator and a global reachability-variable projected
  encoding are proved to enumerate the same partition. Full-fiber blocking
  uses one successful model query per observation, but this is explicitly not
  an OutputP or polynomial-delay theorem.
- Demand-parametric component summaries compose exactly with flattened graph
  substitution when site identities are contextual and sharing is preserved.
  The guard-substitution algebra itself is attributed to established
  relational and piecewise-affine composition.
- Reductions to decision trees, selective functors, projected enumeration,
  activation regions, and parametric partitions delimit what the synthesis
  does _not_ establish.

The strongest claim is therefore deliberately narrow. For the stated graph
model, enabled-edge reachability, sparse event logging, local exact guards,
and global finite-coordinate projection are equivalent presentations of one
observer. This correspondence is useful as a specification for symbolic
evaluators, but it is not a new generic enumeration skeleton.
