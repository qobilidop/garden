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
This lineage is not a literal subsumption theorem, because its choices are
nondeterministic search decisions rather than deterministic functions of
program inputs. A guarded-choice encoding closes that gap, but then selection
observations are projections of feasible fingerprints rather than a new kind
of search object.

The strongest presently defensible formal result is a correspondence theorem:
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

### Exact guarded-choice encoding

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
coordinates decode to (T_G(x,R)).

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
  the nondeterministic encoded program, subject to that theory's rewrite-system
  assumptions.

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

## Reduction to projected AllSMT

### Exact global encoding

Build a shared, let-bound formula rather than recursively expanding the DAG.
For every node, encode its total value \(e_v\). Define observation reachability by the unique
backward equations

\[
a_v \leftrightarrow
  [v\in R]
  \lor \bigvee_{u\text{ ordinary},\ v\in\operatorname{ops}(u)} a_u
  \lor \bigvee_{q:\,v=s_q}a_q
  \lor \bigvee_{q,j:\,v=c_{q,j}}
       \left(a_q\land
       \bigvee_{\omega:\,j\in C_q(\omega)}p_{q,\omega}\right).
\]

Acyclicity makes these equations a definitional circuit; multiple consumers
contribute by disjunction. Introduce one finite-domain projected variable per
site:

\[
z_q=
\begin{cases}
\bot_q & \neg a_q,\\
\operatorname{encode}(\omega) & a_q\land p_{q,\omega}.
\end{cases}
\]

Let \(\Phi_G(A,R)\) be \(A\) conjoined with the value, reachability, outcome, and
observation equations. For each input, all internal values, activities, and
(Z=(z_q)_q) are unique, and

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

Use a reader of concrete inputs and an idempotent writer whose log is a finite
site-outcome map. Evaluation from (R) is defined as follows:

- an input returns its value and the empty log;
- an ordinary node evaluates all operands, applies the primitive, and unions
  their compatible logs;
- a selection evaluates its selector, computes (\omega), emits
  (q\mapsto\omega), evaluates exactly the cases in (C_q(\omega)), and
  applies the corresponding combiner; and
- a memo table keyed by graph-node identity reuses both value and log.

Map union is idempotent for a shared occurrence and compatible because one
input gives each site one outcome. The resulting log is (T_G(x,R)). Erasing
it returns the ordinary selected value. This is a standard selective
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
| Ghost/selective-log equals enabled-edge observation | requires a new proof | Generic selective interpretation is inherited; equality for shared contextual graph nodes is the new instantiation lemma. |
| Reachability vector equals totalized observation | requires a new proof | A direct induction over the acyclic value/reachability circuit. |
| Guarded functional-logic fingerprint projects to the observation | requires a new proof | The demand-populated partial map and complete result search are inherited from Braßel and Huch 2007; later fingerprint and pull-tab results do not cover deterministic guards, projection, or stable contextual naming. |
| Symbolic generator and residual correctness | requires a new proof | Standard symbolic-evaluation induction, with exact-local-guard as the only unusual dependency. |
| Exactly-once coverage and (K+1) oracle calls | elementary / inherited | Elementary full-fiber blocking and the naive projected-AllSMT baseline. Not an enumeration-class result. |
| Projected enumeration completeness | inherited | Standard AllSMT or projected model enumeration once the activation encoding is proved faithful. |
| Disjoint guarded residual representation | inherited after instrumentation | Value-summary and symbolic-merging frameworks already provide it; grouping by the declared ghost observer must be enforced. |
| Exact sequential composition | requires a new proof | The graph-substitution and contextual-identity instance needs proof, while selective and relational composition are inherited. |
| Parallel sharing and finite-iteration laws | elementary | Set union and finite induction once occurrence names are fixed. |
| Guarded-summary relational composition | inherited | Ordinary relational composition; it may materialize a cross-product. |
| Coarsest equivalence preserving the declared observer | elementary / tautological | It is the kernel of a function. |
| Full abstraction for ordinary value contexts | false | Equal-valued active alternatives are distinguished by the observation. |
| Full abstraction for a context that can read ghost events | elementary / by construction | The observer primitive makes the result tautological. |
| Exponential saving over total syntactic assignments | inherited phenomenon | Partial models, output-directed execution, and decision diagrams already exhibit it. |
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
induction plus relational composition. It should be positioned as a unifying
survey theorem or a foundation for an implementation, not as a fundamentally
new symbolic-execution algorithm.

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
- Do not claim novelty for exact disjoint guarded residuals; symbolic merging
  and value summaries already provide them after instrumentation.
- Do not claim that full-fiber blocking improves the (K+1) model-producing
  invocation count over naive complete projected AllSMT.
- Do not identify structural inactivity with omitted literals in a short cube.
- Do not call the observation canonical under value-preserving graph rewrites.
- Do not claim generic compositionality of conditional static computations;
  selective functors already supply it.
- Do not claim OutputP, incremental polynomial time, or polynomial delay from
  an oracle-call count.
- Do not claim MPT's operational completeness automatically proves fairness or
  nonredundancy after projection onto selection observations.
