# Complexity of the unified framework

## Parameters

Use explicit parameters rather than the ambiguous phrase “graph size”:

- \(S_G\): weighted source-DAG size, counting nodes, operand and case edges,
  bit widths, constants, and aggregate leaves, but not pretending that one
  source node has a constant-size solver encoding;
- \(S_C\): total shared circuit size for every ordinary primitive, selected
  combiner, selector classifier, outcome encoding, direct case-membership
  predicate \(\eta_{q,j}(d)\equiv[j\in C_q(\kappa_q(d))]\), and typed-domain
  constraint;
- \(S_{\mathrm{enc}}\): actual shared size of the complete exact global
  value/reachability encoding. Under an explicit circuit lowering it is
  \(O(S_G+S_C)\), but it can be asymptotically larger than \(S_G\);
- \(S_{A_{\mathrm{enc}}}\): shared DAG or serialized size of
  \(A_{\mathrm{enc}}=\operatorname{Dom}_G\land A\), including both the
  caller-domain predicate and the typed-domain encoding;
- \(Q\): number of structural selection sites;
- \(b_q=|\Omega_q|\): outcome count at site \(q\);
- \(K\): number of feasible selection observations under the caller-domain predicate;
- \(L\): maximum number of observed selection sites in one observation;
- \(S_\tau\): weighted size of the demanded slice for observation \(\tau\),
  including the classifier and direct membership circuits used in that slice;
- \(E_G\): weighted size of any elaborated binary-choice or solver encoding,
  including auxiliary choices and the projection map back to source sites;
- \(B\): number of candidates built by a particular syntactic branching
  algorithm before feasibility filtering;
- \(Z\): total serialized or DAG output size, stated explicitly;
- \(W_{\mathrm{wit}}\): total serialized size of the emitted witnesses; and
- \(T_{\mathrm{SMT}}(\phi)\): cost of deciding and producing a model for
  formula \(\phi\).

\(S_G\) must count widths and case lists. One width-\(w\) mask-valued selector can
have one graph node but an \(\Omega(w)\) outcome predicate and \(2^w\) possible
masks.

Any comparison with a binary-choice formalism must use \(E_G\), not silently
substitute \(S_G\). Lowering one \(m\)-way source selector can introduce
multiple auxiliary binary choices; a naive one-hot or subset construction may
be linear in \(m\) or exponential in a succinct selector width. Projection must
then merge the auxiliary decisions back into one source-site outcome.

## Enumeration-complexity vocabulary

Standard enumeration classes charge more than the number of solver calls. Let
\(n\) be the serialized input size and \(Z\) the total serialized output size:

- **OutputP** requires total time polynomial in \(n+Z\).
- **IncP** requires polynomial time to produce the first \(k\) outputs,
  measured in \(n\) and the produced prefix.
- **DelayP** requires polynomial time before the first output, between
  successive outputs, and after the final output, measured in the input size.

Preprocessing is charged before the first output. Thus exponential d-DNNF or
decision-diagram compilation followed by small delay is not an end-to-end
DelayP result unless the compiled representation is declared to be the input.

The present output record contains an observation, exact guard, residual, and
witness. We have not proved that exact-record membership is polynomial-time
checkable, nor that the solver, guard serialization, or residual equivalence
cost is polynomial. No OutputP, IncP, or DelayP classification is claimed.

## Observation-count bounds

The general structural bound is

\[
K\le\prod_{q\in Q}(1+b_q).
\]

The unobserved-sentinel values are not independent, so this bound can be loose.
If every site is always observed,

\[
K\le\prod_q b_q.
\]

For \(n\) independent binary selectors whose results are all observed by the
output cone, \(K=2^n\). Any explicit enumerator therefore needs
\(\Omega(K)\) result records in the worst case. Demand sensitivity cannot
remove this unavoidable product.

A single width-\(w\) selection site whose outcome is an arbitrary mask can have
\(K=2^w\) while \(L=1\); complexity must include outcome-domain size, not only
trace length.

Delayed-choice execution provides a different bound: removing \(k\) distinct
\(N\)-way concrete forces reduces its eager path count by \(N^k\). That result
does not bound \(K\). A used choice is forced to a concrete value even when many
values induce one selection outcome, while symbolic residual computation may
leave all such values in a single observation fiber.

Pseudo-exhaustive testing provides another incomparable parameterization. For
a Boolean circuit whose output support hyperedges are \(k_o\subseteq I\), a
test set \(T\) satisfies

\[
\pi_{k_o}(T)=\{0,1\}^{k_o}
\]

for every output. If \(w=\max_o|k_o|\), successively testing cones costs
\(\sum_o2^{|k_o|}\), while shared global patterns can reduce that cost; the
standard elementary bounds are \(2^w\le |T|\le |O|2^w\). Specialized work
derives tighter generic and circuit-specific bounds. These are bounds on a
concrete covering set for static supports, not on \(K\) semantic observations
or their guard/residual output size. A mux cone contains both cases even when
our enabled closure contains only one, so neither parameterization can be
substituted for the other.

## Hyperplane and activation-region special case

When every selection site is a real affine sign test and every site is always
observed, an observation is a total sign vector, but a general selection fiber
need not be a full-dimensional arrangement cell. A non-strict classifier
assigns boundary points to one side, producing half-open regions; an arbitrary
caller-domain predicate can also cut or lower the dimension of a fiber. For example,
the outcomes \(x\ge0\) and \(-x\ge0\) are simultaneously true exactly at
\(x=0\).

For the boundary-free caller domain
\(A(x)\equiv\bigwedge_q\ell_q(x)\ne0\), \(Q\) distinct affine hyperplanes,
and strict positive/negative outcomes, each
nonempty sign fiber is open and therefore is one full-dimensional arrangement
cell. No simplicity or general-position assumption is needed. In this
restricted setting, Avis and Fukuda's reverse search gives

\[
  O(KQD\,L_{\mathrm{AF}}(Q,D))
\]

time and \(O(QD)\) working space. For fixed \(D\), Sleumer improves the
arithmetic bound to \(O(KQ)\) time with \(O(Q^2)\) space. For a central
arrangement, Ferrez, Fukuda, and Liebling's ray-shooting reverse search gives

\[
  O(KQ\,L_F(Q,D))
\]

time and \(O(QD)\) working space. Rada and Černý's later incremental
sign-prefix algorithm independently gives

\[
  O(KQ\,L_R(Q,D))
\]

time and \(O(L_R(Q,D))\) working space, where \(D\) is input dimension and
\(L_{\mathrm{AF}}\), \(L_F\), and \(L_R\) denote the source-specific LP-cost
abstractions for Avis--Fukuda, Ferrez et al., and Rada--Černý. These are
output-polynomial results for the restricted open-cell representation. The
Avis--Fukuda, Sleumer, and Ferrez analyses count arithmetic/LP operations
rather than proving a coefficient-bit bound, and none of the results transfers
automatically to boundary-inclusive fibers or an arbitrary caller theory.

These bounds enumerate core sign observations and their cell guards. They are
not automatically bounds for the survey's four-field record: residualization
must either be restricted to an explicitly charged affine/PWA computation or
its construction and serialization added to the cost, and a witness must be
obtained and represented. Restoring dense noncore observation coordinates
adds \(O(KQ)\) output work before those residual/witness costs.

Deza and Pournin give a complementary rational-bit-model analysis by
traversing the dual zonotope. Write \(B_Z\) for total generator encoding length
(to avoid overloading the observation-depth parameter \(L\)). Their proof
gives

\[
  O\!\left(KQ\,[q(Q,D,B_Z)+\log K]\right)
    = O\!\left(Kp(Q,D,B_Z)\right),
\]

where \(q\) and \(p\) are unspecified polynomials induced by exact rational
feasibility. This establishes OutputP in the bit model but neither improves
the Ferrez LP-relative oracle count nor proves polynomial delay or compact
working space: the traversal retains the visited vertices and one generator
subset per vertex. The symmetry-aware White Whale successor can greatly reduce
structured instances by orbit representatives and sound filters, but gives no
better generic worst-case theorem.

Dussault et al. later specialize the central-arrangement case, make the
zero-witness perturbation explicit, and introduce circuit-guided variants with
large empirical speedups. They do not state a new end-to-end OutputP, IncP, or
DelayP bound for those variants; circuit enumeration itself can be exponential.

A different geometric specialization arises from multi-parametric linear
programming. Jones and Maciejowski reduce every full-dimensional critical
region to one vertex of a projected polytope and enumerate those vertices by
reverse search. For their constraint matrix \(M\in\mathbb R^{m\times n}\)
with \(\operatorname{rank}M=m\), let \(e=n-m\), let \(N_r\) be the number of
critical regions, let \(d\) be the parameter dimension, and let \(L_P(a,b)\)
denote their LP-oracle cost. Their bound is

\[
  O\!\left(
    N_r\left(e^2 L_P(d,e)+e\,L_P(m,n)\right)
  \right)
\]

time and output-relative \(O(1)\) auxiliary space. Each reported basis
reconstructs a polyhedral guard and affine optimizer. The result is
linear in \(N_r\) only after retaining the LP/dimension coefficient, and it
does not cover lower-dimensional-only regions, coefficient-bit complexity, or
our variable-domain graph observer.

The critical regions are closed and may overlap on their boundaries; the
algorithm reports full-dimensional basis regions and omits regions that exist
only in lower dimension. It is therefore not the survey's disjoint all-input
fiber contract without a boundary-ownership rule or a caller-domain
restriction that removes those boundaries.

The direct pLCP line gives a second explicit bound. Jones and Morari enumerate
full-dimensional positive-semidefinite pLCP regions under lexicographic
perturbation. Columbano, Fukuda, and Jones extend the method to sufficient
matrices, including pLP and convex pQP. For pLCP dimension \(n\), parameter
dimension \(d\), and LP-oracle cost \(T_{LP}\), their Theorem 6.1 charges each
general-position basis by

\[
  nT_{LP}(n,d+1)
  + \frac{n^2-n}{2}T_{LP}(2n,d+1),
\]

while Theorem 6.2 charges each lexicographically perturbed basis by

\[
  (n^2+n)T_{LP}(n,d+1)
  + \frac{n^3-n}{2}T_{LP}(2n,d+1).
\]

The total is the corresponding factor times the number of emitted bases. In
the degenerate case that is the perturbed output count, which can exceed the
unperturbed critical-domain count. The traversal retains a visited set of
discovered bases; the analysis abstracts LP cost and proves neither compact
space, coefficient-bit complexity, DelayP, nor separate coverage of
lower-dimensional-only regions.

Other traversals strengthen representation and degeneracy handling rather than
these complexity classifications. Jones, Kerrigan, and Maciejowski's
lexicographic mpLP treatment produces a unique continuous affine optimizer.
Spjøtvold, Tøndel, and Johansen independently construct a unique continuous
minimum-norm pQP selection and algorithm-independent polyhedral
representation. Patrinos and Sarimveis prove that a graphical-derivative facet
oracle discovers every full-dimensional convex-pQP neighbor without
nondegeneracy or a facet-to-facet assumption, but give no closed total-time,
delay, workspace, or bit bound. Bemporad's later strict-convex mpQP algorithm
considers at most \(2^q\) optimal combinations and gives practical NNLS
analyses rather than a new enumeration-class bound.

Finally, polyhedral projection is not an independent escape from these
baselines: Jones, Kerrigan, and Maciejowski give polynomial input and output
conversions in both directions between projection and pLP solution.

Dense ReLU networks refine the arrangement layerwise. Existing algorithms
enumerate feasible activation patterns by MILP, propagate exact stars that
retain input predicates and affine images, emit explicit region/map pairs,
walk adjacent polyhedral cells, extract the entire face complex, or parallelize
bounded layerwise enumeration. Their bounds depend on the number of dense
activation cells, network width/depth, LP or MIP cost, bounded-domain
assumptions, and often genericity. Tran's exact star procedure exposes the
worst-case (2^N) LP-feasibility split directly; Xu et al. likewise state
exponential time and space for exact local-polytope traversal. Those results do
not transfer unchanged to finite bitvector graphs, but they establish the
standard exact baseline for real all-sites-observed instances.

The output count also depends on the chosen quotient. Dense activation
patterns can split two adjacent cells that realize the same affine function.
Wang's maximal-region construction merges connected equal-map cells. Earlier,
Geyer et al. compute minimum-cardinality equal-behavior PWA representations
within a fixed arrangement, or minimum-product overlapping covers conditional
on an exact Boolean minimizer. Our selection observer instead preserves
observed equal-valued outcomes. Thus an activation-cell count, a
behavior-minimal PWA count, a maximal-affine-region count, and \(K\) are not
interchangeable without a nondegeneracy or observer-equivalence assumption.

The graph problem's additional parameter is not merely \(Q\): each record has
an input-dependent domain of at most \(L\) observed sites, while unselected
case subgraphs are absent. A comparison must therefore distinguish dense
activation-cell output size from sparse observation/fiber/residual output
size. No improvement over the hyperplane bound is claimed when all sites are
observed.

## Fixed-alphabet and state-product partition baselines

Let \(P\) be a finite family of predicates. Exact Boolean-atom enumeration
forms or implicitly searches up to

\[
2^{|P|}
\]

positive/negative combinations, retaining only satisfiable atoms. This is the
baseline used by the SFSM property-testing construction of Huang, Krafczyk,
and Peleska. Setting \(P\) to site-reachability and outcome predicates makes each
atom determine an observation, but atoms can refine observations when they
retain truth coordinates the observation projects away. Aggregating atoms by
observation can make the guard a disjunction whose serialized size is
exponential even when \(K\) is small.

The IOSTS IECP construction has a more structured but still exponential
baseline. For state class \(i\), let \(r_i\) be its number of transition
conditions and \(m_i\) the number of satisfiable disjoint local classes.
Algorithm 1 searches at most \(2^{r_i}\) condition subsets. Algorithm 2
searches at most

\[
\prod_i m_i
\]

cross-state products. Failed SMT prefixes prune entire subset/product
subtrees, and transducer minimization can merge emitted classes, but neither
changes the worst case. A one-state graph instrumentation avoids the
cross-state product only by making the finite observation code available as
the one-step behavior.

These baselines sharpen the comparison required of any structure-directed
algorithm. Reporting \(K+1\) model queries is insufficient: the paper must
also show whether it avoids the fixed-alphabet atom space, avoids post hoc
unions, or produces asymptotically smaller guards on a stated graph family.

## Decision-tree and decision-diagram baseline

A deterministic decision tree already partitions its input domain by
root-to-leaf paths. Each path records only the tests encountered for that
input, its branch conjunction is a disjoint leaf guard, and the leaf can store
an observation/result identifier. A full tree over \(n\) Boolean inputs has at
most \(2^{n+1}-1\) nodes, while shorter leaves omit suffix tests.

For a finite Boolean encoding of the whole input domain, an MTBDD or ADD can
compile the totalized observation function, using a fresh outside-domain
terminal when \(\neg A\), and remove tests with equal
observation successors. Classical ADD claims do not apply unchanged to
infinite input domains. Nor does an observation ADD automatically produce one
symbolic residual per fiber: compiling concrete output values can split one
fiber into many terminals, while residual expressions require separate
partial evaluation or a richer labeled structure. Let
\(D_Z\) be the number of nodes in the compiled diagram, \(P_Z\) the number of
root-to-terminal paths, and \(C_Z\) the total size of cubes emitted from those
paths. None is bounded polynomially by \(K\) in general:

- \(D_Z\) can be exponential in the encoded input width and is variable-order
  sensitive, even when its terminals use a finite carrier;
- one observation terminal may have many incoming paths, so \(P_Z\) can exceed
  \(K\); and
- flattening a terminal preimage into one exact guard may require a disjunction
  whose size is \(\Theta(C_Z)\), while retaining the diagram shares it.

Conversely, a compiled diagram may be much smaller than a flat list of
serialized guards. Comparisons must declare whether compilation time and
\(D_Z\) are charged, whether the output is the shared diagram or \(K\) flat
records, and whether residual values are represented extensionally or as
symbolic DAGs. The number of fibers alone is not an adequate representation
bound.

## Full-fiber blocking

With a unit-cost model-producing oracle, the algorithm performs exactly

\[
K+1
\]

queries. Candidate-local concolic construction with memoization costs

\[
O\!\left(\sum_\tau S_\tau\right)
\subseteq O(KS_{\mathrm{enc}})
\]

and creates outcome-guard-plus-residual DAGs of the same asymptotic size. If
every emitted complete guard copies \(A_{\mathrm{enc}}\), flat output size is

\[
  O\!\left(KS_{A_{\mathrm{enc}}}+\sum_\tau S_\tau+W_{\mathrm{wit}}\right).
\]

If all records share one immutable reference to \(A_{\mathrm{enc}}\), it is instead
\(O(S_{A_{\mathrm{enc}}}+\sum_\tau S_\tau+W_{\mathrm{wit}})\). The explicit
witness term is necessary because the unrestricted theory assumes no bound on
serialized model length.

Before query \(j\), the solver sees

\[
A_{\mathrm{enc}}\land\bigwedge_{i<j}\neg g_i.
\]

An honest solver-time statement is therefore

\[
\sum_{j=0}^{K}
T_{\mathrm{SMT}}\!\left(A_{\mathrm{enc}}\land\bigwedge_{i<j}\neg g_i\right).
\]

The cumulative blocker DAG can be \(O(KS_{\mathrm{enc}})\), plus one shared
copy of \(A_{\mathrm{enc}}\). Incrementality may reuse learned facts but gives no general
polynomial-delay or monotone-runtime bound.

## Prefix model-discovery baseline

Assume \(K\ge1\) and that an alternative algorithm organizes discovery as a
finite rooted tree: the root is the empty observation prefix, each edge adds
the next observed site/outcome chosen by a deterministic expansion policy,
and each leaf is one complete observation. If the algorithm discovers only
feasible outcome children, let \(I\) be the number of feasible internal
prefixes, including the root. An internal prefix \(p\) with \(d(p)\) feasible
children needs
\(d(p)\) successful discovery queries plus one exhaustion query. Since

\[
\sum_p d(p)=I+K-1,
\]

the total is

\[
2I+K-1\le 2KL+K-1.
\]

The equality is the edge count of this rooted tree. The inequality charges
each internal prefix to one descendant leaf at each of at most \(L\) depths.
It fails
if the algorithm tests infeasible raw outcomes, blocks concrete selector values
instead of whole semantic outcomes, duplicates shared sites, or permits a
feasible prefix with no total result.

Full-fiber blocking has the smaller invocation count in this comparison, but
naive projected AllSMT over complete observation tuples has the same \(K+1\)
model-producing-invocation count.

## Formula representation

For one observation, the outcome-only guard generated from observed sites
satisfies

\[
|g_\tau|_{\mathrm{DAG}}+|\mathcal R_\tau|_{\mathrm{DAG}}=O(S_\tau).
\]

The complete guard is \(A_{\mathrm{enc}}\land g_\tau\). Its size is
\(O(S_{A_{\mathrm{enc}}}+S_\tau)\) when serialized independently, or
\(O(S_\tau)\) additional space when it shares a global reference to
\(A_{\mathrm{enc}}\).

This is false for naive tree serialization. In the shared chain

```text
e0 = x
e1 = f(e0,e0)
e2 = f(e1,e1)
...
en = f(e[n-1],e[n-1])
```

the graph has linear size but recursive textual expansion has exponential
size. Paper claims must specify formula DAG, let-bound SMT,
definitional/Tseitin encoding, or actual serialized bytes.

## Decision and counting hardness

Even for Boolean circuits, feasibility of a requested observed-site outcome is
NP-hard: let one selector compute an arbitrary Boolean circuit \(F(x)\) and ask
whether its \(\mathsf{true}\) outcome is feasible. It is in NP when a finite
concrete input is a polynomial-size witness and graph evaluation is polynomial.

Counting feasible observations is #P-hard when caller-domain predicates are part of
the input: under a Boolean constraint \(F(x)\), expose each input bit as an
always-observed binary selection outcome, making observations injective on
satisfying inputs. The number of observations is then \(\#\mathrm{SAT}(F)\).

Do not call the general image-counting problem #P-complete without an upper
bound proof; multiple inputs may map to one observation.

Checking that a supplied finite guard family covers all Boolean inputs is
coNP-hard by propositional validity. The enumeration algorithm establishes
coverage operationally through the final unsatisfiable query.

## Representation comparisons

The reachability-and-outcome projected-AllSMT baseline constructs one shared graph
encoding of \(O(S_{\mathrm{enc}})\) weighted DAG size when \(\kappa_q\), the
outcome encoding, and every direct \(\eta_{q,j}\) circuit are supplied
effectively. An extensional disjunction over all outcomes is charged to
\(S_C\) or \(E_G\) and can be exponential in a succinct selector width.
Full-fiber generation can avoid unobserved slices per result but may emit
\(O(KS_{\mathrm{enc}})\) separate structures.
Neither dominates asymptotically in the general model.

Performance claims must separately report construction work, model queries,
solver time, time to first result, cumulative asserted formula size, output DAG
nodes, serialized bytes, and peak memory.
