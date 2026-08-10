#import "../../../style.typ": definition, theorem, proposition, proof

= Selection observations: formal model and semantics <sec-framework>

This section defines the problem independently of any solver or data
structure. The framework separates an observer, its inverse-image fibers, an
enumeration mechanism, and an output representation. Its graph model is
intentionally narrower than a general programming language: it isolates the
finite, acyclic, deterministic, total pure-graph case for which exhaustive
observation enumeration is a well-defined finite-output task.

== Notation map

@tab-notation collects the symbols used throughout the core definitions. A
subscript $G$ names the graph whose structure is being consulted; a fixed
caller predicate $A$ and requested-root set $R$ determine the enumeration
instance.

#figure(
  block(breakable: false)[
    #text(size: 8.5pt)[
      #table(
        columns: (21%, 37%, 42%),
        align: left,
        inset: 4pt,
        stroke: (x: none, y: 0.4pt + luma(200)),
        table.header([*Symbol*], [*Meaning*], [*Role in the framework*]),
        [$G=(V,E,I,O,Q,lambda)$],
          [Selective term graph: nodes, operand edges, inputs, output roots,
          selection sites, and labels],
          [The finite semantic object being observed],
        [$cal(X)_G$, $x$, $A$, $R$],
          [Typed input space, one input, caller-domain predicate, requested roots],
          [Fix the inputs and outputs covered by one enumeration instance],
        [$Omega_q$, $kappa_q$, $C_q$, $h_(q,omega)$],
          [Outcomes, classifier, demanded cases, and selected combiner at site $q$],
          [Determine an observed site's outcome and enabled case edges],
        [$op("val")_x$, $D_G(x,R)$, $T_G(x,R)$],
          [Total graph value, enabled closure, and sparse selection observation],
          [Evaluate the graph, expose requested dependencies, and record events],
        [$tau$, $F_tau$, $Gamma_tau$],
          [One feasible observation, its input fiber, and its observed-outcome guard],
          [Name one semantic bucket and an exact formula for it],
        [$(tau,gamma_tau,r_tau,m_tau)$],
          [Observation, exact guard, residual, and witness],
          [The required output record for one nonempty fiber],
      )
    ]
  ],
  caption: [Core notation. Later sections introduce only route-specific cost and
  composition symbols.],
  kind: table,
) <tab-notation>

== Selective term graphs

#definition("selective term graph")[
  A selective term graph is a tuple
  $
    G = (V, E, I, O, Q, lambda),
  $
  where $V$ is a finite node set; $I$, $O$, and $Q$ are respectively input
  nodes, output roots, and selection-site nodes; $I inter Q = emptyset$; and
  $N = V without (I union Q)$ is the set of ordinary nodes. Thus $I$, $N$,
  and $Q$ partition $V$; an output root may belong to any category. Input nodes
  have no operand positions. The finite typed operand relation
  $E subset.eq V times NN_0 times V$ contains $(v,j,u)$ when operand position
  $j$ of consumer $v$ is supplied by $u$. Operand positions are unique per
  consumer, edges are type-correct, and the consumer-to-operand relation is
  acyclic. Every ordinary node of arity $k$ has exactly one operand edge at
  each position $1,dots,k$ and no other operand edges. For every selection $q$,
  its operand edges are exactly
  $(q,0,s_q)$ and $(q,j,c_(q,j))$ for $1 <= j <= m_q$. The label map $lambda$
  supplies result types and node semantics.
]

An input valuation belongs to the typed product
$cal(X)_G = product_(i in I) cal(D)_i$. An ordinary node $v in N$ with operands
$u_1, dots, u_k$ denotes a deterministic total function

$
  f_v : cal(D)_(u_1) times dots times cal(D)_(u_k) -> cal(D)_v.
$

Ordinary nodes follow an _all-operands observation policy_: observing their
result observes every operand. This is a declared structural dependency policy,
not an operational evaluation order and not an assertion that $f_v$ depends
extensionally on every argument.

For readers used to runtime dataflow diagrams, the edge direction here may look
backward: an edge points from a consumer to one of its operands. This lets
reachability start at the requested results and walk directly toward everything
they declare as a dependency.

#definition("generalized selection site")[
  A selection site $q in Q$ consists of a selector operand $s_q$, case-root
  operands $c_(q,1), dots, c_(q,m_q)$, a finite outcome set $Omega_q$, and a
  total classifier
  $
    kappa_q : cal(D)_(s_q) -> Omega_q.
  $
  A case-demand function $C_q(omega) subset.eq {1,dots,m_q}$ states which case
  roots are observed for outcome $omega$. A typed total combiner
  $
    h_(q,omega) : product_(j in C_q(omega)) cal(D)_(c_(q,j)) -> cal(D)_q
  $
  constructs the result from those cases in increasing operand order.
]

The outcome is semantic, not necessarily the raw selector value. It must carry
enough information to determine both the demanded case set and the applicable
combiner. An indexed selection may have one outcome per case and one default;
a priority selection may identify the first enabled case; and a mask-valued
selection may use the complete enabled-case mask as one outcome and demand
several roots. If an interface intends to distinguish two raw values, they must
be distinct outcomes even when they choose the same cases.

Because the graph is acyclic and every primitive is total, each input $x$
induces a unique _total graph value_ $op("val")_x(v)$ at every node. At a selection site,
$omega_x(q) = kappa_q(op("val")_x(s_q))$, and the value is obtained by applying
$h_(q,omega_x(q))$ to the selected case-root values. Values in unselected case
cones remain mathematically defined; the observation judgment below determines
which of them are structurally exposed.

== Contextual identity and caller domain

A site inside one graph is identified by its node. Graph substitution prefixes
internal sites by the component occurrence, so two calls to the same callee
have different identities. Statically bounded iteration also includes the
iteration index. This policy preserves sharing within an occurrence while
excluding unbounded recursion and loops, which could create an infinite event
domain.

The observation is relative to a requested root set $R subset.eq O$ and a
caller-domain predicate $A : cal(X)_G -> BB$. All feasibility and completeness claims
range over $cal(X)_A = {x in cal(X)_G | A(x)}$. An open multi-output component
therefore takes $R$ as an interface parameter; observing all outputs
unconditionally would expose sites that a caller does not request.

== Enabled closure and selection observation

#definition("enabled operand edge")[
  Fix an input $x$. Every operand edge of an ordinary node is enabled. Every
  selector edge $(q,0,s_q)$ is enabled. A case edge $(q,j,c_(q,j))$ is enabled
  exactly when $j in C_q(omega_x(q))$. Write $E_x$ for this input-indexed edge
  relation.
]

#definition("enabled closure")[
  For $R subset.eq O$, $D_G(x,R)$ is the least node set containing $R$ and
  closed from a consumer to each operand along $E_x$. Equivalently, it is
  reachability from $R$ in the enabled consumer-to-operand graph. A selection
  site is _observed for_ $(x,R)$ exactly when it belongs to $D_G(x,R)$.
]

The word _observed_ is local terminology for this membership judgment. It does
not claim that the source evaluator is lazy. Classical neededness and demand
semantics use related backward relevance but impose different semantic
conditions; @sec-routes compares them.

#definition("selection observation")[
  The selection observation is the dependent finite partial map $T_G(x,R)$—a
  typed dictionary in which key $q$ can store only an outcome from $Omega_q$—
  with
  $
    op("dom")(T_G(x,R)) = Q inter D_G(x,R),
    quad T_G(x,R)(q) = omega_x(q).
  $
  Its totalized presentation uses one fresh sentinel
  $op("unobs")_q in.not Omega_q$ per
  site:
  $
    T^"tot"_G(x,R)(q) =
      cases(
        T_G(x,R)(q) & "if " q in D_G(x,R),
        op("unobs")_q & "otherwise."
      )
  $
]

For a fixed graph, the partial-map and totalized-vector presentations are
isomorphic. The first is the intended sparse record; the second permits direct
projection onto the finite product
$product_(q in Q)(Omega_q union {op("unobs")_q})$.

== Observers, refinements, and representations

#definition("observer and refinement")[
  On a fixed caller domain $cal(X)_A$, an _observer_ is a total function
  $B : cal(X)_A -> Y$. Its observable equivalence is its kernel
  $
    op("ker")(B) = {(x,y) in cal(X)_A^2 | B(x)=B(y)}.
  $
  Observer $B_1$ _refines_ observer $B_2$ when
  $op("ker")(B_1) subset.eq op("ker")(B_2)$. Equivalently, there is a unique
  factor map $h : op("im")(B_1) -> op("im")(B_2)$ such that
  $B_2(x)=h(B_1(x))$ for every $x$. Thus $B_1$ preserves at least every
  distinction preserved by $B_2$.
]

In plain language, an observer is the function used to sort inputs into
buckets. A _fiber_ is one bucket. Refinement means that knowing the finer
bucket is enough to recover the coarser one. A residual is a formula or shared
expression that computes the requested result for every input in one bucket.

For fixed $G$ and $R$, $T_G(-,R)$ is the _selection observer_. Its sparse and
totalized presentations have the same kernel and are therefore two
representations of one observer. By contrast, projecting away site coordinates
or coalescing records with equal residual functions generally produces a
coarser observer. A control-flow path or execution trace may be finer, and it
may also preserve distinctions incomparable with requested-root selection
events.

This vocabulary separates semantic objects from encodings. A flat list of
guards, a decision tree, a decision diagram, and a projected-model stream may
represent the same observer image. A partial cube can instead represent a set
of image elements. Calling all of these outputs “partial decisions” obscures
whether the underlying partition has changed.

#proposition("determinacy, finiteness, and sharing")[
  For every $x$ and $R$, $D_G(x,R)$ and $T_G(x,R)$ are unique, and
  $
    abs({T_G(x,R) | x in cal(X)_G})
      <= product_(q in Q)(1 + abs(Omega_q)).
  $
  If $R_1 subset.eq R_2$, the smaller observation is the restriction of the
  larger. Moreover,
  $
    D_G(x,R_1 union R_2) = D_G(x,R_1) union D_G(x,R_2)
  $
  and the observation at the union is the compatible partial-map union of the
  two observations. A shared site therefore occurs once.
]

#proof[
  Total graph values and outcomes are unique, and finite reachability has one least
  closure. The product independently counts one unobserved sentinel or one of
  the outcomes at each site. Reachability from a union of roots is the union of
  reachability from each root in the same enabled graph; site outcomes are fixed
  by $x$, so the partial maps agree on their shared domain.
]

== Least valuation under the declared dependency policy

Extend each value domain with a fresh undefined value $bot_v$ and order it flatly,
$bot_v <= d$ for every ordinary value $d$, with distinct ordinary values
incomparable. Order valuations pointwise. An $x$-consistent partial valuation assigns each node
either $bot_v$ or its total graph value. It is dependency-closed when a defined
ordinary node has all operands defined and a defined selection has its
selector and every case root required by its concrete outcome defined. This is
an obligation, not a prohibition: another requested root or shared consumer
may independently require an unselected case root. The valuation is
$R$-complete when every requested root is defined.

#proposition("declared-dependency least valuation")[
  The valuation
  $
    nu^*_(x,R)(v) =
      cases(
        op("val")_x(v) & "if " v in D_G(x,R),
        bot_v & "otherwise"
      )
  $
  is the unique least $x$-consistent, dependency-closed, $R$-complete
  valuation. Its support is exactly $D_G(x,R)$, and projecting the outcomes of
  its defined selection sites yields $T_G(x,R)$.
]

#proof[
  The enabled closure contains $R$ and satisfies exactly the declared
  predecessor obligations, so $nu^*_(x,R)$ is admissible. The support of any
  other admissible valuation is a set containing $R$ and closed under the same
  enabled edges; least reachability therefore puts $D_G(x,R)$ inside that
  support. Consistency fixes every defined ordinary value, giving the pointwise
  order and uniqueness.
]

This proposition is a graph-reachability result for the stated all-operands
policy at ordinary nodes.
Equality with a language's semantic least demand requires a separate
translation showing that each source operator has precisely these predecessor
obligations.

== Fibers and exact observed-outcome guards

Fix $G$, $A$, and $R$. The feasible observation image and the fiber of one
$tau$ in that image are

$
  cal(T)_(G,A,R) = {T_G(x,R) | A(x)},
  quad
  F_tau = {x | A(x) and T_G(x,R) = tau}.
$

Because $T_G(-,R)$ is a total function on $cal(X)_A$, its nonempty fibers are
pairwise disjoint and cover the caller domain. This elementary inverse-image
partition is the semantic enumeration contract.

#definition("exact selection-observation enumeration")[
  An exact solution emits one record
  $(tau, gamma_tau, r_tau, m_tau)$ for every
  $tau in cal(T)_(G,A,R)$ and no other record. Its semantic fields have types
  $gamma_tau : cal(X)_G -> BB$,
  $r_tau : cal(X)_G -> product_(o in R) cal(D)_o$, and
  $m_tau in cal(X)_G$. For every typed input $x$ they satisfy
  $
    gamma_tau(x) <=> A(x) and T_G(x,R)=tau;
  $
  $gamma_tau(m_tau)$; and whenever $gamma_tau(x)$ holds,
  $
    r_tau(x)=op("val")_x|_R.
  $
  The four obligations are respectively exhaustive duplicate-free indexing,
  exact fiber representation, a feasibility witness, and residual correctness
  throughout the fiber.
]

These are semantic functions. A concrete implementation may encode a guard as
an SMT formula and a residual as a term DAG, provided evaluation has the stated
meaning; the contract does not require tabulating either function.

For each site outcome, define

$
  chi_(q,omega)(d) <=> kappa_q(d) = omega,
  quad
  p_(q,omega)(x) <=> chi_(q,omega)(op("val")_x(s_q)).
$

For feasible $tau$, its _observed-outcome guard_ is

$
  Gamma_tau(x) = A(x) and
    and.big_(q in op("dom")(tau)) p_(q,tau(q))(x),
$

It mentions outcomes of
observed sites but contains no outcome or absence atom for an unobserved site.
The name is semantic rather than syntactic: an outcome predicate may contain
negation or an inequality, and expanding it may traverse nested selection
expressions. The demanded generator in @sec-algorithms avoids constructing
unobserved case cones.

#theorem("exact observed-outcome guard")[
  For every feasible observation $tau$ and every input $x$,
  $
    Gamma_tau(x) <=> A(x) and T_G(x,R) = tau.
  $
]

#proof[
  The reverse implication follows from the definition. For the forward
  direction, choose a witness $m in F_tau$. Build enabled closures for $m$ and
  $x$ by the same finite sequence of reachability approximants, beginning at
  $R$. Suppose the current approximants agree. Ordinary nodes expose identical
  operand positions. A selection $q$ in the common approximant is observed at
  $m$, hence $q in op("dom")(tau)$; the corresponding conjunct gives
  $omega_x(q)=tau(q)=omega_m(q)$. Both evaluations therefore expose the same
  selector edge and the same case roots $C_q(tau(q))$. Induction makes every
  approximant, and thus both least closures, equal. Their observed-site domains
  coincide, and every outcome in that domain is fixed by $tau$.
]

The result relies on each outcome determining its case-demand set. It proves
exactness, not literal minimality: an observed-site predicate may still be
entailed by $A$ and the remaining predicates.

#theorem("conflict frontier")[
  If $tau != sigma$ are feasible observations, then some site is observed in
  both with different outcomes:
  $
    exists q in op("dom")(tau) inter op("dom")(sigma) : tau(q) != sigma(q).
  $
]

#proof[
  Assume instead that both maps agree wherever both are defined. Their closure
  approximants begin at the same roots. Ordinary nodes expose the same
  operands, and every selection in a common approximant has the same outcome,
  so it exposes the same case roots. The approximants remain equal, yielding
  equal domains and equal maps, a contradiction.
]

Thus two observed-outcome guards are disjoint because they contain incompatible
outcome predicates at a shared observed site. This structural separator is
stronger than the generic fact that distinct function fibers are disjoint and
is the key reason full-fiber blocking does not need explicit unobserved-site
literals.
