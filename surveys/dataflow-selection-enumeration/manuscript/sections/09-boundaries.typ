= Boundaries and open problems <sec-boundaries>

== Applicability of selection observations

Selection observations are appropriate for event-aware specifications such as
checking that graph rewriting, lowering, or component substitution preserves a
declared map of source selection events. They are not preferable for every
client. A value-only client should merge behaviorally equal records, as
explicit-control methods do when they group regions that share the requested
first action @konig2020common; an
optimization client may retain active constraints rather than source events;
and a diagnostic client may record causal events beyond selections. The
framework makes these choices explicit rather than ranking them by a universal
notion of precision.

== Semantic scope

The theory assumes a finite, typed, acyclic, deterministic, pure graph.
Ordinary primitives, classifiers, and selected combiners are total. Partial
operations require a proved caller precondition or an explicit error outcome;
silently ignoring division by zero, invalid indexing, assertion failure, or
language-specific overflow would invalidate coverage. Cycles, recursion, and
unbounded dynamic occurrences can make the event domain infinite and require a
bounded, time-indexed, regular, or coinductive observer instead.

The all-operands rule is an observation policy, not an extensional dependence
theorem. Every operand of an ordinary node is observed even if algebraic simplification
makes it irrelevant. Translating a lazy language or stream-dataflow semantics
therefore requires a separate correspondence proof. Likewise, an outcome must
determine its demanded cases and combiner; two raw selector values with
different structural consequences cannot be silently grouped as one outcome.

Site identity is structural and occurrence-sensitive. Sharing within one graph or component occurrence
records a site once, whereas distinct contextual occurrences receive distinct
names. A compiler that duplicates, fuses, or lowers selections can change the
observer while preserving values. Source and lowered observations need an
explicit event map. The exact observed-outcome guard is not necessarily a
literal-minimal formula: logical minimization is a later representation
transformation and may erase the event whose outcome the record is intended to
expose.

== Solver, output, and composition boundaries

Exhaustion depends on exact symbolic encodings and decisive oracle answers. An
`unknown`, timeout, unsupported primitive, incomplete theory combination, or
inexact floating-point abstraction yields an explicitly incomplete result. A
model is a witness for one fiber, not a residual valid throughout it.

The exact $K+1$ model-producing invocation count is deliberately weak. It does
not charge solver work, formula growth, coefficient bits, projection,
serialization, or final unsatisfiability. The number of fibers can be
exponential, and feasibility and counting contain familiar hard special cases.
No general OutputP, IncP, DelayP, compact-summary, or practical-speedup theorem
is established. The negative precedent is explicit: BDD bisimulation
minimization can cost more than the symbolic invariant check it was meant to
accelerate @fisler2002bisimulation.

Representation can dominate the comparison. Flat guards, trees, diagrams,
compiled circuits, polyhedral complexes, and residual DAGs may denote the same
observer with exponentially different sizes. Exact guarded-summary composition
has the same caveat: equality with flattening does not imply reuse. A component
with many outputs can require exponentially many demand masks, and different
caller predicates can split its fibers differently at each occurrence.

== Open theoretical questions

The framework suggests a focused research agenda:

- Which observer languages make selection events, value behavior, active
  constraints, and diagnostic causality explicit, and which refinement or
  full-abstraction results relate them?
- Which classes of partial operations, cycles, or recurring component
  occurrences retain a finite or finitely representable observation image?
- When can a shared decision structure, disjoint cover, or guarded-summary DAG
  be constructed with output-sensitive delay or polynomial auxiliary space?
- Which structural restrictions make demanded local generation asymptotically
  preferable to whole-graph reachability projection, rather than merely smaller on one
  candidate?
- Under what interface and workload conditions do demand-parametric summaries
  provide reusable compression instead of an exponential family of exact
  fibers?

These questions keep the observer, enumerator, and representation separate.
Improving one does not automatically strengthen the other two.

== Reference implementation and evaluation agenda

This paper reports no implementation or benchmark result. A reference
implementation should first validate small finite graphs by exhaustive concrete
input enumeration, checking observation identity, guard membership, residual
values, witnesses, and coverage. It should then compare local full-fiber
blocking, global projected enumeration, finite-input ADD or MTBDD compilation,
and specialized geometric traversal on inputs that expose nested unobserved
sites, equal-valued observed alternatives, sharing, multiple roots, multiway
choices, lower-dimensional fibers, and repeated components. Measurements
should report serialized and shared output size, compilation cost, solver
effort, peak memory, and final-exhaustion cost—not only record count.
