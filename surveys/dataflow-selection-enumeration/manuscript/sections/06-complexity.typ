= Complexity and established special cases <sec-complexity>

The number of solver calls is not a cost model. This section first charges the
graph, symbolic circuits, solver formulas, and serialized output, and then
compares restricted instances with established output-sensitive enumeration
results.

== Parameters and enumeration classes

Let $S_G$ be weighted source-DAG size, including nodes, edges, case lists,
constants, widths, and aggregate leaves. Let $S_C$ be the total shared circuit
size for classifiers, outcome encodings, and direct case-membership predicates,
and put $S_("enc")=S_G+S_C$. Let $S_A$ be caller-constraint size; $Q=abs(Q)$
the number of sites; $b_q=abs(Omega_q)$; $K$ the number of feasible
observations; $L$ the maximum observed-site count in one record; $S_tau$ the
weighted demanded-slice size for record $tau$; and $Z$ the total serialized or
DAG output size, whichever representation is declared. Finally,
$T_("SMT")(phi)$ denotes the cost of deciding $phi$ and producing a model.

The source-node count alone is insufficient. A width-$w$ one-hot selector is
one node but can have $2^w$ mask outcomes. Lowering one multiway site to binary
choices can also introduce auxiliary decisions whose projection must be merged
back to one source outcome; such an elaboration must be charged separately.

OutputP requires total time polynomial in serialized input plus total output.
IncP bounds the time for each produced prefix, and DelayP bounds preprocessing,
every inter-output delay, and final exhaustion by an input polynomial. A
compiled decision diagram or d-DNNF is not free preprocessing unless it is
declared to be the input. No such classification is proved for the general
algorithm here: exact-record membership, SMT solving, coefficient growth,
residual equivalence, and flat guard serialization need not be polynomial.

== Output count and unavoidable products

Totalization gives the general structural bound

$
  K <= product_(q in Q) (1 + b_q).
$

The coordinates are not independent, so the bound may be loose. If every site
is always observed, the `1` terms disappear. For $n$ independent observed
binary selectors, $K=2^n$, and any explicit record enumerator needs
$Omega(K)$ output time. Demand-relative omission cannot remove this necessary
product. Conversely, a single mask-valued site can have $K=2^w$ while $L=1$;
trace length alone is not a complexity parameter.

The output quotient also matters. Dense activation cells can differ while
implementing the same affine function; maximal affine regions merge connected
equal-map cells @wang2022regions. Piecewise-affine minimization can merge still
other equal-behavior guards @geyer2008optimal. The selection observer retains
observed equal-valued outcomes, so those output counts cannot be substituted
for $K$ without changing the task.

== Cost of full-fiber blocking

Ignoring solver work, memoized candidate-local construction costs

$
  O(sum_(tau in cal(T)_(G,A,R)) S_tau)
    subset.eq O(K S_("enc"))
$

shared-DAG operations and creates guard/residual DAGs of the same order. If
every flat record copies $A$, output size includes $O(K S_A)$; if records share
one immutable reference to $A$, it includes only $O(S_A)$ once.

Before model query $j$, the solver sees

$
  A and product_(i < j) not g_i.
$

An honest solver-time expression is therefore

$
  sum_(j=0)^K T_("SMT")(A and product_(i < j) not g_i).
$

The cumulative blocker DAG can grow to $O(K S_("enc"))$. Incremental solving
may reuse learned clauses but supplies no general monotone-runtime or
polynomial-delay guarantee. The global projected encoding has one shared
$O(S_("enc"))$ circuit but may spend exponential work compiling or enumerating
its projected image. The two presentations have the same $K+1$
model-producing invocation count under naive complete-tuple blocking, not the
same runtime or memory.

Formula representation must also preserve graph sharing. In the chain

```text
e0 = x
e1 = f(e0, e0)
e2 = f(e1, e1)
...
en = f(e[n-1], e[n-1])
```

the source DAG is linear while recursive tree serialization is exponential.
Every size claim therefore refers to a formula DAG, let-bound SMT term,
definitional encoding, or measured serialized bytes.

== Decision and counting hardness

Feasibility of one requested outcome is NP-hard even for Boolean graphs: let a
selector compute an arbitrary circuit $F(x)$ and ask whether its `true` outcome
is feasible. With finite polynomial-size inputs the problem is in NP, but the
general typed model makes no uniform membership claim.

Counting feasible observations is \#P-hard when $A$ is part of the input. Under
a Boolean constraint $F(x)$, expose every input bit as an always-observed
binary outcome; observations are then injective on satisfying assignments and
$K=op("#SAT")(F)$. We do not call general image counting \#P-complete because
many inputs may map to one observation and an upper-bound proof is separate.
Checking that a supplied finite guard family covers every Boolean input is
coNP-hard by propositional validity.

== Hyperplane cells: a strict all-sites-observed case

Suppose every site is a strict real affine sign test, every site is observed,
$A$ is the full real domain, and boundary points are excluded. Each feasible
observation is then one full-dimensional cell of an arrangement of $Q$
hyperplanes in dimension $D$. Avis and Fukuda's reverse search enumerates all
$K$ cells in

$
  O(K Q D l(Q,D))
$

time with $O(Q D)$ working space @avis1996reverse. Sleumer gives $O(K Q)$
arithmetic time for fixed $D$ and $O(Q^2)$ space @sleumer1998output. For central
arrangements, Ferrez, Fukuda, and Liebling give the pre-Rada bound

$
  O(K Q op("LP")(Q,D))
$

with $O(Q D)$ working space @ferrez2005fixedrank. Rada and Černý later give a
different incremental sign-prefix formulation with
$O(K Q op("lp")(Q,D))$ time @rada2018new.

These are already complete duplicate-free OutputP results under their stated
arithmetic or LP-cost abstractions. Deza and Pournin add a rational-bit-model
zonotope traversal. If $B_Z$ is total generator encoding length, its proof gives

$
  O(K Q [q(Q,D,B_Z) + log K]) = O(K p(Q,D,B_Z)),
$

for unspecified polynomials $q$ and $p$, while retaining all visited vertices
and generator subsets @deza2022linear. The symmetry-aware White Whale successor
can greatly reduce structured instances but gives no stronger generic theorem
@deza2026whitewhale. Newer circuit-guided central-arrangement algorithms report
large practical improvements without a replacement OutputP, IncP, or DelayP
bound @dussault2025bdifferential.

The reduction has sharp boundaries. A non-strict classifier assigns boundary
points to one side, and an arbitrary $A$ can cut or lower the dimension of a
fiber. Such a fiber need not be an open full-dimensional arrangement cell.
None of the geometric bounds transfers automatically to general typed
bitvector primitives or an arbitrary solver theory.

== Parametric and neural partitions

Jones and Maciejowski enumerate every full-dimensional critical-region basis
of a multiparametric LP by reverse search. With $e=n-m$ and $N_r$ regions, their
LP-relative bound is

$
  O(N_r [e^2 op("LP")(d,e) + e op("LP")(m,n)]),
$

with output-relative constant auxiliary space; each basis reconstructs a
polyhedral guard and affine optimizer @jones2006parametric. The later
sufficient-matrix pLCP treatment covers pLP and convex pQP and gives a stronger
explicit comparator. For pLCP dimension $n$, parameter dimension $d$, and
$N_g$ reported bases in general position, Columbano, Fukuda, and Jones bound
the LP-oracle work by

$
  O(N_g [n op("LP")(n,d+1)
    + (n^2-n)/2 op("LP")(2n,d+1)]).
$

Under lexicographic perturbation, for $N_p$ perturbed bases the corresponding
bound is

$
  O(N_p [(n^2+n) op("LP")(n,d+1)
    + (n^3-n)/2 op("LP")(2n,d+1)]).
$

The perturbed basis count can exceed the number of unperturbed critical
domains; the analysis retains an output-sized visited set and supplies neither
a coefficient-bit nor a DelayP theorem @columbano2009sufficient.

Separate work resolves other degeneracy and representation questions.
Lexicographic perturbation selects a unique continuous affine optimizer and
nonoverlapping basis regions @jones2007lexicographic. A minimum-norm secondary
selection yields, under stated assumptions, a unique continuous pQP solution
with an algorithm-independent polyhedral representation
@spjotvold2007unique. Patrinos and Sarimveis discover every full-dimensional
convex-pQP neighbor across a facet without nondegeneracy or a facet-to-facet
assumption, but state no polynomial total, delay, space, or bit bound
@patrinos2010graphical. Bemporad's rank-deficiency treatment likewise gives
practical per-combination analyses rather than a new enumeration-class theorem
@bemporad2015multiparametric. Finally, pLP solution and halfspace polyhedral
projection are polynomially interreducible, so renaming one side as projection
does not establish a different complexity frontier @jones2008projection.

Dense ReLU networks are another all-sites-observed specialization. Exact
methods enumerate feasible activation patterns by MIP, propagate exact input
stars and affine images, walk adjacent activation polyhedra, or construct the
full face complex @serra2018bounding @vincent2021reachable. They establish the
guard-plus-affine-residual baseline and exponential worst cases. They do not
provide a faster bound for the sparse nested-selection observer, but that fact
cannot be inverted into a speedup claim: when every site is observed, our task
is exactly their finer activation-cell partition.

== Fixed observers and compiled decision structures

A finite predicate alphabet can always be partitioned into satisfiable Boolean
atoms. Exact input-equivalence-class methods enumerate and then minimize
behavior-preserving classes @krafczyk2017effective, while exhaustive
property-oriented testing enumerates satisfiable atoms of a fixed observer
alphabet @huang2024exhaustive. A one-state instrumentation with totalized
selection coordinates reduces our semantic partition to that established
construction.

For finite Boolean inputs, an MTBDD or ADD can compile the totalized observation
function; reduced ordered diagrams are canonical only for a fixed variable
order and may be exponential @bryant1986bdd @bahar1997add. One observation
terminal can have many incoming paths, and flattening its preimage to one guard
can destroy diagram sharing. Conversely, a compiled diagram can be much smaller
than a list of flat guards. Any comparison must state whether compilation time,
diagram nodes, terminal paths, residual labels, or flattened formulas are the
output.

The resulting complexity claim is intentionally negative but precise: the
general theory proves finite exact enumeration and an exact $K+1$ oracle-call
accounting, while established special cases already have stronger
output-sensitive algorithms. It proves no general asymptotic advantage from
demand-relative sparsity alone.
