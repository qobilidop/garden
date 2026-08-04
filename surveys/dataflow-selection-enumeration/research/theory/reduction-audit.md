# Adversarial reduction audit

## Verdict

The current selection-observation enumerator is not an independent new
enumeration paradigm. Under the finite, total, deterministic, acyclic graph
assumptions, it is a structure-directed implementation of the following
standard construction:

1. instrument every contextual selection occurrence with an
   unobserved-or-outcome ghost value;
2. interpret conditional graph structure with ordinary selective evaluation;
3. project a graph formula onto the ghost values; and
4. enumerate the resulting projected assignments with AllSMT or an equivalent
   disjoint-enumeration procedure.

Functional-logic implementations supply an especially close runtime
representation. Braßel and Huch 2007 already define branching information as
a partial function from stable shared `OR` references to branch positions and
extend it only when lazy search reaches an unrecorded choice. Antoy and Hanus
2009 call executed nondeterministic-step histories *fingerprints*.
Alqaddoumi, Antoy, Fischer, and Reck's 2010 pull-tab transformation then
defines a fingerprint as a finite subset of `ChoiceID` times `{1,2}`, decorates
graph nodes with it, propagates it through pull-tabs, and rejects contradictory
decisions for one identifier. Later memoized pull-tabbing makes fingerprints
task-local and adds branch-specific result memoization.
The Fair Scheme combines needed graph reduction, a fair queue of live
expressions, and the same finite fingerprint shape; its value-set theorem is
per-state existential preservation, not duplicate-free projected enumeration.
Independently, delayed-choice execution uses shared suspensions to omit finite
nondeterministic values that never reach a non-copy use and proves exact
visible-state preservation together with an `N^K` path reduction when `K`
`N`-way forces disappear.
This lineage is not a literal subsumption theorem, because its choices are
nondeterministic search decisions rather than deterministic functions of
program inputs. A guarded-choice meta-encoding appears to close that gap, but
it supplies no inherited theorem until a semantics-preserving elaboration is
proved. Subject to that proof, selection observations are projections of
feasible fingerprints rather than a new kind of search object.

The strongest presently defensible formal target is a correspondence theorem:
enabled-edge reachability, guarded pull-tab fingerprints, selective ghost
logging, concolic local guards, and the activation-variable encoding compute
the same graph-relative observer. The graph-specific proof must handle
sharing, contextual identity, nested selectors, multi-case demand, and
non-observation. This is useful synthesis, but the hard-nosed assessment is that it
is a short semantic reconciliation, not yet a PLDI-level original theorem.

## Audit model and criterion

Fix a selective term graph \(G\), requested roots \(R\), and caller predicate
\(A\). For input \(x\), write

- \(e_v(x)\) for the eager symbolic value of node \(v\);
- \(a_v(x,R)\) for membership of \(v\) in the enabled closure;
- \(p_{q,\omega}(x)\) for the predicate that site \(q\) has outcome
  \(\omega\); and
- \(T_G(x,R)\) for the partial map from observed sites to their outcomes.

The audit calls a result **inherited** only when an existing theorem applies
after a semantics-preserving encoding and supplies the claimed property. A
result is **elementary** when it is an immediate property of functions,
reachability, inverse images, or finite blocking. A result **requires a new
proof** when the cited framework does not cover an essential feature of this
graph semantics. Requiring a new proof does not by itself make the result
deep or publishably novel.

## Reduction to decision trees and ADDs

A deterministic decision tree provides an even more elementary reduction than
projected enumeration. Label each internal node by an input predicate and each
branch by its outcome. For one input, the root-to-leaf path is a partial map
from encountered test occurrences to outcomes. Its predicate conjunction is a
guard; reachable leaf guards are pairwise disjoint and exhaustive; and the
leaf can store a result or residual. Tests in untaken subtrees are absent from
the record. Thus the sparse input-relative output shape itself is classical.

When the whole input domain has a finite Boolean encoding, first assign a
fresh \(\mathsf{outside}_A\) terminal to inputs that violate \(A\), and compile
the finite-range observer function

\[
  x\mapsto
  \begin{cases}
    \mathsf{outside}_A & \neg A(x),\\
    \overline T_G(x,R) & A(x).
  \end{cases}
\]

as an MTBDD or ADD. Every reachable non-outside observation terminal denotes a feasible
totalized observation, and its preimage is exactly the corresponding fiber.
This classical reduction does not apply unchanged to an infinite input domain;
theory-predicate decision structures may represent such functions, but they do
not inherit Bryant/Bahar canonicity without additional assumptions.

Compiling the concrete pair
\((\overline T_G(x,R),\operatorname{val}_x|_R)\) does **not** by itself attach
one symbolic residual to each observation fiber. For example, a selection-free
identity graph has one observation fiber but a concrete result for every
input. A pair-valued ADD refines that fiber into concrete result terminals.
Residual expressions require separate partial evaluation or a richer
residual-labeled decision structure with a stated equality/reduction theory.
Bryant's reduction shares equal Boolean residual functions, and ADDs permit a
finite non-Boolean terminal carrier; neither fact supplies symbolic residual
generation for free.

This reduction does not erase the conceptual distinction between skipped
diagram variables and unobserved graph sites. The former are absent because
the compiled terminal function is extensionally independent of them in a
residual context; the latter are assigned an explicit unobserved sentinel by
the graph observer. But after totalization that distinction is data inside an
ordinary finite-range observer function, not a representability barrier.

What remains untransferred is a graph-structural construction that avoids
generic input-variable compilation, the conjunction-only local fiber theorem,
contextual graph identities, and reusable graph composition. Those require
proofs, but no novelty follows unless they yield a nontrivial semantic,
representation, or complexity separation. Decision diagrams can be
exponential and order-sensitive; flat fiber guards can also be exponentially
larger than a shared diagram.

## Relationship to least demanded dataflow evaluation

Pingali and Arvind already transform stream dataflow graphs with reverse
demand edges and prove correctness, liveness, and parsimony under composition.
Avron and Sasson define the least legal output-complete valuation for fixed
inputs and output-position demands and characterize its uniform existence by
stability. Thus fixed-input least-demand computation is established, but
identifying our syntactic enabled closure with that semantic object requires a
translation proof.

For the finite acyclic one-cell-stream specialization, define
\(\kappa_{G,R}(x)\) as that least legal valuation. The intended bridge is

\[
  T_G(x,R)=\pi_{\mathrm{sel}}(\kappa_{G,R}(x)).
\]

The support of \(\kappa_{G,R}(x)\) should coincide with the enabled closure,
but this is a specialization proof obligation rather than a cited theorem.
Conditional on that bridge, the remaining change is the outer quantification:
range over symbolic inputs, enumerate the image of the projection, and
construct its exact
inverse-image fibers. No inherited dataflow theorem supplies that enumeration,
but it prevents any claim to novelty for demand, backwards propagation,
critical inputs, or the least demanded computation.

## Reduction to memoized pull-tabbing

The representation predates memoized pull-tabbing and pull-tabbing itself:
Braßel and Huch's 2007 branching information is already the exact partial-map
shape and drives a lazy result representation with one-way completeness.
Braßel and Fischer 2008 then implement missing-choice branching by extending a
list-backed ID-to-Boolean assignment, and Braßel's dissertation proves
value-set adequacy for the choice-tree translation while implementing search
with `Map ID Choice`. The 2010 pull-tab transformation carries finite
choice-ID/outcome fingerprints through graph transformation and discards
contradictory combinations. MPT improves repeated shared choices; it is not the
origin of the partial-map object. This makes the encoding below routine at the
data-structure and search level. The remaining gap is semantic: deterministic
guarded input regions versus nondeterministic resolutions.

### Candidate guarded-choice meta-encoding

The following translation is a proof obligation, not a theorem inherited from
the functional-logic sources. Its elaboration must preserve strict ordinary
operators, selective case edges, requested roots, DAG sharing, contextual
occurrence identity, deterministic guards, and residual symbolic values.

Translate ordinary graph nodes to deterministic shared thunks. Translate a
selection site \(q\) to the generalized nondeterministic expression

\[
\mathop{?}_{\omega\in\Omega_q}^{\operatorname{id}(q,c)}
\bigl(
  \operatorname{assume}(p_{q,\omega});
  \operatorname{emit}(\operatorname{id}(q,c),\omega);
  \operatorname{combine}_{q,\omega}
      (c_{q,j})_{j\in C_q(\omega)}
\bigr),
\]

where \(c\) is the static call or iteration context. The guard makes exactly
one alternative feasible for each concrete input. Evaluation starts from
\(R\), so a selection inside an unselected case is never demanded and its
identifier is absent from the task fingerprint. Sharing uses one thunk and
one identifier per graph occurrence. Two contextual calls receive distinct
qualified identifiers.

Memoized pull-tabbing is binary. A finite \(m\)-way outcome can be lowered to
a binary choice tree with auxiliary identifiers and then projected back to
one \(q\mapsto\omega\) observation, or the runtime can be generalized to an
\(m\)-way choice carrying one identifier. The first lowering shows that the
encoding is routine, but it also means an unmodified binary fingerprint is not
literally the same map as \(T_G\), especially for one-hot masks.

For symbolic inputs, each task must also carry its accumulated
`assume` constraints. Free-variable generators or narrowing choices used to
construct inputs introduce additional fingerprint coordinates. Project those
input-generation coordinates away. The remaining feasible guarded-choice
coordinates decode to \(T_G(x,R)\).

### What transfers

- Lazy, demand-populated partial functions from stable shared choice references
  to outcomes and one-way result-representation completeness transfer from
  Braßel and Huch 2007.
- List- and map-backed demand extension, plus exact recovery of the source
  constructor-value set under existential choice assignments, transfer from
  Braßel and Fischer 2008 and Braßel 2011. Neither source makes the assignments
  unique observable results.
- Finite consistent choice-ID/outcome fingerprints and their propagation
  through pull-tabs transfer from Alqaddoumi et al. 2010. Consistency turns the
  finite relation into a partial function.
- Stable choice identifiers and consistent reuse across copied occurrences
  transfer from pull-tabbing.
- Demand-driven absence of an unforced choice has the same operational shape
  as a partial selection observation.
- MPT's per-task result maps provide a standard implementation technique for
  reusing a selected shared subcomputation without globally corrupting other
  tasks.
- Pull-tabbing correctness can justify preservation of the represented set for
  the nondeterministic encoded program only after the elaboration theorem and
  subject to that theory's rewrite-system assumptions.

### What does not transfer

MPT does not prove that its fingerprint domain equals this paper's
graph-relative enabled closure. Its identifiers are dynamically created choice
identities, not automatically stable source-graph occurrence names across all
enumerated inputs. It emits search results, not one exact input formula and
one residual function per projected fingerprint. Its search can retain input
generator decisions and can produce multiple tasks whose projections are the
same observation. Fairness and nonredundant *projected* enumeration therefore
need another mechanism.

The guarded-choice translation also adds semantic machinery absent from the
MPT theorem: input predicates, infeasible-branch pruning, outcome projection,
and residual symbolic values. Consequently the claim
“selection observations are MPT fingerprints” is false literally. The hostile
but accurate claim is:

> Selection observations are the projection of feasible, demanded
> fingerprints of a straightforward guarded-choice encoding.

Proving this statement requires a graph-specific induction. It is not a
novel enumeration algorithm.

The Fair Scheme does not strengthen that claim to nonredundant enumeration.
Its fingerprints belong to dynamic computations, and its dispatcher emits
values rather than fingerprints. For example, `False ?_i False` has two
consistent fingerprint branches that emit the same value. Its needed-step
optimality says every selected reduction step is needed; it is not a shortest
derivation, output-sensitive, or polynomial-delay theorem. The extended paper
also labels eventual production of all values as a conjectural strong
completeness property.

## Reduction to delayed-choice execution

Gligoric et al. replace an eager bounded choice by a shared `Susp(a,b)` cell
and force it only at a non-copy use. Their theorem equates the sets of reachable
control/visible-state projections in eager and delayed computation trees. A
delayed leaf with concrete cells and remaining suspensions implicitly denotes a
cylinder over unforced choices, so it would be wrong to claim that the work has
no fiber-like representation.

The cylinders are generally finer than selection-observation fibers. For
`x` in `0..99` used only by `x < 50`, delayed choice forces and explores 100
concrete values, whereas the selection observer has two outcome fibers. For
the residual result `x + 1` with no selection site, delayed choice again forces
all values, whereas the selection observer has one empty observation and keeps
`x + 1` symbolic. The remaining distinction is therefore outcome-based
quotienting with symbolic residuals, not merely omission of unused dimensions.

Delayed choice supplies neither a stable static site map, an exact or maximal
fiber theorem, nor duplicate-free enumeration. It nevertheless eliminates
novelty claims for first-use postponement, copy-propagated shared decisions,
omission of never-used choices, visible-state preservation, and exponential
savings from removing independent unused choices.

## Reduction to demand-driven bounded testing

Lindblad's property-directed generator starts from an unknown algebraic input,
partially reduces a Boolean predicate, and refines one blocking metavariable by
each constructor. When the predicate becomes true it emits a partial
constructor term whose remaining metavariables explicitly denote every total
ground refinement. Lazy SmallCheck implements the same core pattern on
depth-bounded Haskell inputs with tagged holes. Its result is `Known True`,
`Known False`, or `Unknown pos`; an unknown result causes exactly the demanded
hole at `pos` to be refined. Korat supplies the heap/object analogue by
backtracking only on fields read by an executable Boolean predicate.

These are already the semantic representation and operational skeleton of
demand-guided observation search. Lindblad's proposed soundness/completeness
conditions are not proved, while Korat's deterministic-predicate guarantee
enumerates concrete satisfying inputs rather than partial cylinders.

To adapt it, replace the Boolean property with an evaluator that attempts to
return the complete selection observation. A demanded input hole raises its
position; a returned observation certifies that every total completion of the
partial term has that observation. Collecting successful terms by observation
therefore yields a sound cylinder cover of the corresponding fiber on a
depth-bounded algebraic domain.

What does not transfer is the exact-record contract. The published refuter
stops at the first `Known False`; it does not enumerate every known answer.
More importantly, its partial-term leaves may fragment one observation fiber
according to constructor prefixes and operational demand order. It has no
merge/maximality theorem, exact symbolic formula for the union of all fragments,
stable graph-site map, or symbolic residual. The adaptation also needs a new
termination argument when the graph input is represented by SMT variables over
an infinite theory rather than a constructor-depth-bounded finite domain.

Thus this lineage defeats novelty for “refine only what the observer demands,”
“represent solutions by partial terms,” and “prune all completions when the
observer is known.” It does not
subsume one-record-per-observation enumeration unless supplemented by the
same semantic grouping and guard construction under audit here.

## Reduction to exact input-equivalence-class partitioning

Krafczyk and Peleska define an input equivalence class by equality of the set of
observable finite state/output classes reached from every source state class.
Their algorithms enumerate every satisfiable local truth pattern of transition
conditions, disjointify overlapping nondeterministic patterns, enumerate every
satisfiable product across source classes, and minimize the resulting finite
transducer to merge behaviorally identical input symbols. The output is an
exact, coarsest behavior-preserving partition of a possibly infinite input
domain.

Instrument the pure graph as a one-step I/O transition system with visible
finite output

\[
\overline T_G(x,R)
  \in\prod_{q\in Q}(\{\bot_q\}\cup\Omega_q).
\]

Then two inputs are IECP-equivalent exactly when their totalized selection
observations agree. This is an extensional subsumption of the desired
partition. It is not immediately an efficient implementation reduction:
providing one transition class or output code per feasible observation may
presuppose enumeration. Using individual activity/outcome predicates instead
produces a Boolean-atom refinement that must be projected and merged.

The later SFSM property-testing construction makes this alternative explicit.
For a fixed finite formula alphabet \(\Sigma\), it keeps every satisfiable atom

\[
\bigwedge_{\varphi\in P}\varphi\land
\bigwedge_{\varphi\in\Sigma\setminus P}\neg\varphi,
\qquad P\subseteq\Sigma.
\]

Choosing site-activity and outcome formulas makes each atom determine
\(\overline T_G\). The construction is disjoint and exhaustive by definition;
its worst-case class count is \(2^{|\Sigma|}\). Projecting away redundant truth
coordinates gives the desired fibers, exactly as projected AllSMT does.

These results eliminate novelty for exact finite-observer partitioning and
satisfiable truth-pattern enumeration. The graph-local theorem can still show
that observed positive outcome predicates alone characterize a full fiber,
without explicitly conjoining every negative inactive-site coordinate. A
structure-directed enumerator can still avoid materializing all atoms. Those
are representation and compilation results relative to an established
quotient, not a new enumeration object.

## Reduction to projected AllSMT

### Exact global encoding

Build a shared, let-bound formula rather than recursively expanding the DAG.
For every node, encode its total value \(e_v\), and define the direct
case-membership predicate

\[
  \eta_{q,j}(d)\Longleftrightarrow
  j\in C_q(\kappa_q(d)).
\]

Define observation reachability by the unique backward equations

\[
a_v \leftrightarrow
  [v\in R]
  \lor \bigvee_{u\text{ ordinary},\ v\in\operatorname{ops}(u)} a_u
  \lor \bigvee_{q:\,v=s_q}a_q
  \lor \bigvee_{q,j:\,v=c_{q,j}}
       \left(a_q\land\eta_{q,j}(e_{s_q})\right).
\]

Acyclicity makes these equations a definitional circuit; multiple consumers
contribute by disjunction. Using \(\eta\) directly avoids extensionally
listing exponentially many mask outcomes when case membership has a succinct
circuit. Its representation cost must be charged explicitly. Introduce one
finite-domain projected variable per site:

\[
z_q=
\begin{cases}
\bot_q & \neg a_q,\\
\operatorname{encode}(\omega) & a_q\land p_{q,\omega}.
\end{cases}
\]

Let \(\Phi_G(A,R)\) be \(A\) conjoined with the value, reachability, outcome, and
observation equations. For each input, all internal values, activities, and
\(Z=(z_q)_q\) are unique, and

\[
Z(x)=\overline T_G(x,R).
\]

Projecting \(\Phi_G\) onto \(Z\) therefore enumerates exactly the feasible
totalized observations. Ask the solver to retain an input valuation as a
witness. This is directly within AllSMT's important-variable interface after
finite-domain variables are bit- or one-hot encoded.

### Exact fibers and the local formula

For a complete projected assignment \(\overline\tau\), its input fiber is

\[
G_\tau(x)\equiv
\exists\,\text{internal}.
  \Phi_G(A,R)\land Z=\overline\tau.
\]

The claimed local guard is

\[
\Gamma_\tau(x)=
A(x)\land
\bigwedge_{q\in\operatorname{dom}(\tau)}p_{q,\tau(q)}(x).
\]

Showing \(G_\tau\leftrightarrow\Gamma_\tau\) is the exact-local-guard
theorem. It is not supplied by AllSMT. It uses the special structural fact that
every observed outcome determines the next enabled case edges, so explicit
negative literals for unobserved sites are redundant. The proof is a short
induction over graph depth.

### Enumerator equivalence

Blocking a complete projected assignment asserts

\[
\neg(Z=\overline\tau).
\]

Substituting the deterministic graph definition of \(Z\) makes this exactly
\(\neg G_\tau\), hence \(\neg\Gamma_\tau\). Model-and-full-fiber-block is
therefore lazy projected AllSMT with the projected-assignment blocker already
specialized to input variables. Both make (K) successful model-producing
calls and one final unsatisfiable call in the naive blocking scheme.

Projected AllSMT does **not** by itself return a residual symbolic function for
an entire fiber. A model gives one concrete output. A residual
(\mathcal R_\tau) must be obtained by specializing selection cases according
to (\tau) while retaining ordinary symbolic input terms, and its correctness
needs the usual symbolic-evaluation induction. Quantifier elimination could
also produce an input formula for (G_\tau), but the local traversal avoids
that general operation.

An enumerator that emits short partial cubes has a different result type. It
may omit an observed site whose value is a logical don't-care and may combine
several complete observations. Disjoint partial AllSMT is therefore a backend,
not a theorem that its cubes are selection observations.

## Reduction to output-directed symbolic execution

### Instrumented output encoding

Expose the total ghost vector as an ordinary symbolic output:

\[
\widehat G(x,R)=
\left(\operatorname{val}_x|_R,
      z_{q_1}(x,R),\ldots,z_{q_{|Q|}}(x,R)\right).
\]

An exact output-directed symbolic executor can now use all ghost coordinates
as its slicing criterion or value observer. Equal ordinary outputs reached
through different observed selections no longer merge, because their ghost
vectors differ. An unobserved nested selection has value \(\bot_q\), rather than
being silently projected away as a logical don't-care.

Multi-path symbolic execution with guarded value summaries can represent the
result as disjoint guards paired with (\widehat G). Dependence-directed and
all-values approaches can target the ghost coordinates as queried values. An
exact engine then computes a refinement of ordinary output equivalence that is
extensionally capable of representing the desired partition.

To obtain exactly one record per (T_G), the engine must group by the complete
ghost vector, not by concrete ordinary output and not merely by syntactic
path. Any extra lowering branches must be projected away. Any equal-expression
coalescing must include the ghost vector. Residual ordinary outputs must remain
symbolic within a group.

### The transfer limit

Existing exact symbolic-evaluation theorems can transfer concrete soundness
and coverage to the *instrumented program*. They do not automatically prove
that a particular imperative or CFG lowering preserves graph-node identity,
observes one shared selection once, or uses the same contextual occurrence
names. Dependence-directed systems may conservatively retain more branches;
papers without a formal end-to-end theorem cannot be used to inherit exact
fiber uniqueness.

Thus output-directed symbolic execution strongly subsumes the algorithmic
idea after instrumentation. The remaining obligations concern correctness of
the observer encoding, not a new exploration principle.

## Reduction to ghost instrumentation and selective interpretation

### Exact local instrumentation

Use a reader of concrete inputs and the total idempotent writer monoid of
finite event sets

\[
  \mathcal W=\mathcal P_{\mathrm{fin}}
  \left(\coprod_{q\in Q}\{q\}\times\Omega_q\right)
\]

under ordinary set union. Evaluation from \(R\) is defined as follows:

- an input returns its value and the empty log;
- an ordinary node evaluates all operands, applies the primitive, and unions
  their event sets;
- a selection evaluates its selector, computes \(\omega\), emits
  \((q,\omega)\), evaluates exactly the cases in \(C_q(\omega)\), and
  applies the corresponding combiner; and
- a memo table keyed by graph-node identity reuses both value and log.

For every fixed input, determinism proves the **functional-consistency
invariant** that the event set contains at most one pair with first component
\(q\). Decode a conflict-free event set to a partial map; the result is
\(T_G(x,R)\). This avoids calling compatible partial-map union a writer monoid:
that operation is partial on arbitrary maps. Erasing the log returns the
ordinary selected value. This is a standard selective
computation interpreted in a reader/writer target; the free selective
construction and its generic interpretation already provide the broad
compositional story.

A naive eager ghost assignment at every syntactic selection is wrong. Eagerly
executing the ghost writes in both case cones records sites that are unobserved
for \(R\). Instrumentation must either use selective execution, guard every
write by the exact reachability formula, or compute the enabled closure separately.
This condition is the substantive content hidden by the phrase “just add a
ghost variable.”

### Composition after instrumentation

Sequential composition is ordinary composition of value-and-log relations,
provided the caller first determines which component outputs it demands.
Parallel consumers union their demand masks and logs. Calls prefix internal
site names by occurrence; finite iteration also prefixes an iteration index.
These rules recover the whole-graph observation by substitution.

The result is exact, but selective functors and relational composition already
supply the generic algebra. The graph-specific equality with flattened
enabled-edge reachability still requires proof, especially for shared nodes and
output-demand masks. No compactness, canonicality, or delay bound follows from
compositionality alone.

## Dependency graph for the current theorems

The logical dependency is:

1. total deterministic DAG semantics gives unique (e_v) and outcomes;
2. outcome-determined case demand gives a unique enabled closure;
3. the enabled-closure induction proves both ghost-log and reachability-vector
   correspondence;
4. the same induction proves that observed outcome literals imply all unobserved
   coordinates, yielding the exact-local-guard theorem;
5. exact symbolic primitives plus that local theorem give residual correctness;
6. inverse-image partitioning plus exact blockers gives enumeration coverage,
   uniqueness, and the (K+1) call count; and
7. boundary-demand propagation plus graph substitution gives exact component
   composition.

AllSMT supplies step 6's generic projected-enumeration mechanism, but steps
2–5 are obligations of the encoding. Pull-tabbing supplies consistent choice
identity but not deterministic input fibers. Symbolic-evaluation frameworks
supply ordinary residual and merge correctness after the instrumentation is
shown faithful.

## Adversarial counterexamples

### Equal alternatives defeat output-only reductions

For `q = select(p, 7, 7); return q`, ordinary output has one value but the
selection observer has two fibers. AVaSE-style equal-value coalescing, output
equivalence, or residual-function equality loses the distinction unless the
ghost outcome is part of the observed value.

### Structural non-observation is not an omitted AllSMT literal

Let `outer = select(p, inner, 5)` and `inner = select(r, 5, 5)`. When `outer`
selects the second case, `inner` must have explicit totalized value
`unobserved`. A short cube that simply omits `inner` may also cover inputs where
`inner` is observed but either outcome is a don't-care. Sparse observation maps
and sparse implicants are not interchangeable.

### Syntax-tree instrumentation breaks sharing

For `q = select(p,a,b); return pair(q,q)`, duplicating the syntax yields two
ghost coordinates or permits inconsistent pull-tab choices. The source graph
has one site and one outcome. Memoization and identity must be tied to the
shared node.

### Reusing one callee identifier breaks contextual identity

Two calls to a callee with one internal selection are two observations in the
flattened contextual graph. Reusing the callee's bare site identifier merges
them. Dynamic MPT identifiers, static graph identifiers, and summary-local
identifiers coincide only after an explicit occurrence-naming theorem.

### Binary fingerprints do not preserve one-hot site arity

A width-(w) one-hot site can expose an arbitrary enabled-case mask as one
outcome. A binary MPT lowering uses several choice decisions for this one site.
Bounds in terms of fingerprint length or binary choices do not transfer to the
site-level parameter (L) without charging outcome encoding size and
projection.

### One AllSMT model is not a residual function

On a fiber where `return x + 1`, the solver may report `x = 0` and output `1`.
The required residual is `x + 1`, valid for every input in the fiber. Neither
AllSMT nor pull-tabbing reconstructs this function from one model without a
symbolic specialization step.

### Naive eager logging over-observes

If a pure implementation eagerly evaluates and logs every graph node before
selecting a case, it records the selections in all unobserved case cones. Value
erasure may still be correct, so ordinary semantics-preserving ghost
instrumentation is insufficient; preservation of the declared observer needs
its own proof.

## Theorem classification

| Proposed result | Classification | Adversarial assessment |
|---|---|---|
| Unique eager values and outcomes | elementary | Topological evaluation of a total deterministic DAG. |
| Unique finite selection observation and product bound | elementary | Finite reachability plus counting totalized coordinates. |
| Partial-map/`unobserved`-vector equivalence | elementary | Coordinatewise encoding for a fixed site set. |
| Root monotonicity and exact sharing union | elementary | Reachability from a union of roots; not a new sharing theory. |
| Schedule invariance under exact enabled-closure traversal | elementary | The conclusion is built into the traversal premise. Pull-tabbing handles a harder but different rewrite setting. |
| Erasure to ordinary value semantics | elementary | Structural induction, assuming totality and selected combiners. |
| Fiber partition | elementary | Inverse images of a total function. |
| Exact-local-guard theorem | requires a new proof | Not inherited from AllSMT or MPT. The enabled-closure induction is graph-specific but short. |
| Conflict-frontier theorem | requires a new proof | Distinct observations must disagree at a commonly observed site; this follows by a short lockstep reachability argument and is stronger than arbitrary function fibers. |
| Ghost/selective-log equals enabled-edge observation | requires a new proof | Generic selective interpretation is inherited; equality for shared contextual graph nodes is the new instantiation lemma. |
| Reachability vector equals totalized observation | requires a new proof | A direct induction over the acyclic value/reachability circuit. |
| Guarded functional-logic fingerprint projects to the observation | requires a new proof | The demand-populated partial map and complete result search are inherited from Braßel and Huch 2007; later fingerprint and pull-tab results do not cover deterministic guards, projection, or stable contextual naming. |
| Symbolic generator and residual correctness | requires a new proof | Standard symbolic-evaluation induction, with exact-local-guard as the only unusual dependency. |
| Exactly-once coverage and (K+1) oracle calls | elementary / inherited | Elementary full-fiber blocking and the naive projected-AllSMT baseline. Not an enumeration-class result. |
| Projected enumeration completeness | inherited | Standard AllSMT or projected model enumeration once the activation encoding is proved faithful. |
| Disjoint guarded residual representation | inherited after instrumentation | Value-summary and symbolic-merging frameworks already provide it; grouping by the declared ghost observer must be enforced. |
| Exact sequential composition | requires a new graph-specific proof | The graph-substitution, requested-boundary-demand, and contextual-identity instance needs proof. Selective and relational composition are inherited, and Geyer et al. 2010 already instantiate residual substitution, guard conjunction, and infeasibility pruning for affine component systems. |
| Parallel sharing and finite-iteration laws | elementary | Set union and finite induction once occurrence names are fixed. |
| Guarded-summary relational composition | inherited | Ordinary relational composition; Geyer et al. 2010 give the direct PWA component case. It may materialize a cross-product. |
| Coarsest equivalence preserving the declared observer | elementary / tautological | It is the kernel of a function. |
| Full abstraction for ordinary value contexts | false | Equal-valued observed alternatives are distinguished by the observation. |
| Full abstraction for a context that can read ghost events | elementary / by construction | The observer primitive makes the result tautological. |
| Exponential saving over total syntactic assignments | inherited phenomenon | Partial models, output-directed execution, and decision diagrams already exhibit it. |
| Exact all-sites-observed strict affine open-cell enumeration | inherited | On the full real domain with boundary points excluded, hyperplane-cell enumeration already proves complete duplicate-free OutputP streaming; neural work enumerates feasible full-dimensional activation guards and affine residuals. Non-strict or boundary-inclusive fibers need separate treatment. |
| (O(\sum_\tau S_\tau)) construction under DAG sharing | elementary bookkeeping | It excludes solver time and serialized expansion. |
| NP/#P/coNP hardness statements | inherited reductions | Standard circuit/SAT encodings; useful boundaries, not a distinctive algorithmic result. |

## Strongest defensible contribution

The current formal material supports the following narrow theorem package:

> For finite total selective term graphs with stable contextual site identity,
> outcome-determined case demand, and exact symbolic primitives, enabled-edge
> observation, selective reader/writer logging, guarded demanded fingerprints,
> concolic local guards, and activation-variable projection commute. In
> particular, the conjunction of only the observed outcome predicates is the
> exact inverse image of one totalized ghost observation, and graph-aware
> demand-parametric composition agrees with flattening.

The pieces on either side of this correspondence are established machinery.
The graph-specific correspondence, especially the absence of explicit
unobserved-site literals and the treatment of sharing/context, genuinely needs a
proof. It is the strongest formal statement not obtained by citing one prior
theorem verbatim. Nevertheless, its present proof burden is structural
induction plus relational composition; the affine residual-substitution core is
already explicit in Geyer et al. 2010. It should be positioned as a unifying
survey theorem or a foundation for an implementation, not as a fundamentally
new symbolic-execution algorithm.

The all-sites-observed real-CPA instance is fully occupied by exact
activation-region work. Any paper example using only a dense chain of ReLUs or
affine sign tests demonstrates an established special case, not the sparse-site
separator. Motivating and separating examples must include a nested selection
whose unselected case contains another site.

An original research claim would need an additional separation that survives
these reductions. Plausible targets are a non-flattening summary
representation with a proved asymptotic reuse advantage over the shared global
activation encoding, a nontrivial canonical/minimal observer theorem under an
independently motivated context language, or an extension to partial/cyclic
graphs whose fixpoint and enumeration results are not immediate. None is
currently established.

## Claims the paper should not make

- Do not claim novelty for partial maps from stable choice identities to
  outcomes; Braßel and Huch 2007 already define the exact partial-function
  shape, Alqaddoumi et al. 2010 propagate equivalent finite fingerprints, and
  later MPT reuses them.
- Do not claim novelty for postponing or omitting never-used finite choices, or
  for the resulting exponential path reduction; delayed-choice execution proves
  these for guarded-command falsification.
- Do not claim novelty for exact disjoint guarded residuals; symbolic merging
  and value summaries already provide them after instrumentation.
- Do not claim that full-fiber blocking improves the (K+1) model-producing
  invocation count over naive complete projected AllSMT.
- Do not identify structural non-observation with omitted literals in a short cube.
- Do not call an exact positive fiber guard literal-minimal; observed-site
  predicates can be redundant under the caller constraint and one another.
- Do not call the observation canonical under value-preserving graph rewrites.
- Do not claim generic compositionality of conditional static computations;
  selective functors already supply it.
- Do not claim OutputP, incremental polynomial time, or polynomial delay from
  an oracle-call count.
- Do not claim MPT's operational completeness automatically proves fairness or
  nonredundancy after projection onto selection observations.
