= Discussion and limitations <sec-discussion>

== What the synthesis establishes

The formal development fixes one observer before choosing an enumerator. For a
finite selective DAG, requested roots and one concrete input determine an
enabled closure and hence a partial map of observed site outcomes. Totalizing
that map exposes an ordinary finite observer; its nonempty inverse images are
the exact semantic records. The exact-local-guard theorem then gives a
graph-specific representation of one inverse image without negative literals
for structurally unobserved sites. Candidate-local residualization and global
reachability instrumentation are two implementations of the same partition,
and contextual prefixing makes the semantics agree with flattened graph
substitution.

This is useful primarily as a specification. It says exactly what an
enumerator must preserve when an unselected cone contains further decisions,
when equal-valued alternatives remain observable events, when several roots
share a site, and when a component appears at more than one occurrence. It
also identifies a concrete validation oracle: records must have satisfiable
guards, pairwise-conflicting observations, exact guard/fiber equivalence,
residual correctness on the entire guard, and coverage certified only by a
decisive final query.

The work does not establish that this observer is preferable for every client.
A client interested only in output value should merge equal residual
functions. A client interested in optimization policy may project away the
solver history. A diagnostic client may instead retain control or causal
events beyond selections. Those are different kernels of different observers,
not approximations ordered by one universal notion of precision.

== Semantic boundaries

The theory assumes a finite, typed, acyclic, deterministic, pure graph.
Ordinary primitives, classifiers, and selected combiners are total. Partial
operations require either a proved precondition in $A$ or an explicit error
outcome; silently ignoring division by zero, invalid indexing, overflow modes,
or assertion failure would invalidate coverage. Cycles, recursion, and
unbounded dynamic occurrences can make the event domain infinite and need a
different observation model, such as bounded unfolding, time-indexed events,
or a regular summary.

Strictness is an observation policy, not an extensional dependence theorem.
The model observes every operand of an ordinary node even if algebraic
simplification makes one operand irrelevant. Changing this policy changes the
fibers. In particular, translating a lazy language or a stable stream-dataflow
semantics requires a proof that its least demanded computation has the same
support; the graph reachability proposition alone is insufficient.

Site identity is similarly intensional. One component occurrence preserves
its internal sharing, while two occurrences receive different prefixes. A
compiler that duplicates, fuses, reassociates, or lowers selections can alter
the observation even when output values are unchanged. Source-level and
lowered-IR observations should therefore be related by an explicit event map,
not assumed equivalent. Multiway lowering also introduces auxiliary decisions
that must be projected back if the intended outcome is the source-level case.

The positive guard theorem depends on each recorded outcome determining the
set of demanded cases and the applicable combiner. If two raw selector values
have different structural consequences, they cannot share one outcome. The
theorem proves exactness, not minimality: a positive literal may be entailed by
the caller domain and the remaining literals. Logical minimization can shorten
a guard but may also erase an observed event from the representation, so it
must be treated as a separate output transformation.

== Solver and representation boundaries

Exhaustion is conditional on exact symbolic encodings and decisive oracle
answers. An `unknown`, timeout, unsupported primitive, incomplete theory
combination, or inexact floating-point abstraction produces an explicitly
incomplete enumeration. A model is only a witness for one fiber, and evaluating
the requested output at that model is not a residual valid throughout the
fiber.

The exact $K+1$ model-producing invocation count is deliberately weak. It does
not charge solver work, formula growth, coefficient bits, projection,
serialization, or the final unsatisfiable proof. The general problem contains
NP-hard feasibility and \#P-hard counting special cases, and $K$ itself may be
exponential. No OutputP, IncP, DelayP, or compact-summary theorem is proved.
Established affine and parametric restrictions have stronger
output-sensitive algorithms, so a practical evaluator should dispatch to or
compare against them where their assumptions hold.

Representation choices can dominate the apparent result. A list of flat
guards, a DAG of shared predicates, a decision diagram, a disjoint partial
cover, and a stream of complete observations can denote the same finite
observer image with exponentially different sizes. Residuals need explicit
DAG sharing as well: recursively printing a shared term as a tree can be
exponential in the source graph. Any implementation evaluation must report
serialized bytes, shared node counts, compilation time, peak memory, and
solver effort rather than only the number of emitted records.

Demand-parametric component summaries have the same caveat. Equality with
flattening does not imply reuse: a component with many outputs can require
$2^{abs(O_H)}$ demand masks, and contextual caller constraints can split its
input fibers differently at each occurrence. Summary construction becomes an
empirical proposition only after a representation and workload distribution
are fixed.

== Evidence limitations and reproducibility

The literature study is a systematic map, not a census or meta-analysis.
Vocabulary spans several communities, database rankings are opaque, and
metadata services omit references, merge versions, and throttle requests. The
protocol therefore records exact queries and frozen result snapshots, uses
primary bibliographies for backward chasing, and treats database indexes only
as discovery instruments. Repeated reopenings are a feature of the method:
new clusters invalidate earlier saturation attempts rather than being folded
quietly into a post hoc query set.

The final two frozen rounds added no conceptual cluster or plausible close
competitor after reconciliation. That result establishes mapping closure only
under the recorded trigger, captured rankings, and access date. It does not
prove that no closer work exists. The final OpenAIRE round had particularly low
capture, while Crossref returned very large hit sets from which only the first
100 relevance-ranked records per query were screened. Citation-network
coverage and a single primary screener remain threats even after an independent
audit of sampled exclusions.

The repository retains the protocol, catalog, search log, source notes,
screening snapshots, claim ledger, and manuscript checks. These artifacts make
the boundary inspectable and make later reopening possible; they do not turn a
bounded map into proof of worldwide completeness.

== Implementation and evaluation agenda

This paper reports no tool or benchmark results. A future implementation should
first validate semantics on small finite graphs by exhaustive concrete input
enumeration, comparing the observed map, guard membership, residual value, and
coverage. It should then compare candidate-local full-fiber blocking against a
global projected encoding, an ADD or MTBDD compilation for finite inputs, and
specialized geometric enumerators on affine cases. Adversarial examples should
include unobserved nested sites, equal-valued observed alternatives, shared
sites reached from multiple roots, multi-case selections, lower-dimensional
fibers, and repeated component occurrences.

Only such measurements could support a claim about practical advantage.
Promising questions are whether local generation avoids enough unobserved
encoding to offset repeated solver calls, whether global compilation shares
enough structure to dominate flat records, and whether demand-parametric
summaries are reusable across real callers. Until then, the formal model should
be read as a conservative semantic contract and cross-literature synthesis.
