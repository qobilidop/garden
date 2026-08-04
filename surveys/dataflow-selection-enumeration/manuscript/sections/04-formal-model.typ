#import "../style.typ": definition, theorem, proposition, proof

= Formal model <sec-formal-model>

This section fixes the observer before discussing an implementation. The model
is intentionally narrower than a general programming language: it isolates the
finite pure-graph case for which exhaustive observation enumeration is a
well-defined finite-output task.

== Selective term graphs

#definition("selective term graph")[
  A selective term graph is a tuple
  $
    G = (V, E, I, O, Q, lambda),
  $
  where $V$ is a finite node set; $I$, $O$, and $Q$ are respectively input
  nodes, output roots, and selection-site nodes; and
  $N = V without (I union Q)$ is the set of ordinary nodes. An output root may
  belong to any category. The typed operand relation
  $E subset.eq V times NN times V$ contains $(v,j,u)$ when operand position
  $j$ of consumer $v$ is supplied by $u$. Operand positions are unique per
  consumer, edges are type-correct, and the consumer-to-operand relation is
  acyclic. The label map $lambda$ supplies result types and node semantics.
]

An input valuation belongs to the typed product
$cal(X)_G = product_(i in I) cal(D)_i$. An ordinary node $v in N$ with operands
$u_1, dots, u_k$ denotes a deterministic total function

$
  f_v : cal(D)_(u_1) times dots times cal(D)_(u_k) -> cal(D)_v.
$

Ordinary nodes are _strict only for the observation judgment_: observing their
result observes every operand. This is a declared structural dependency policy,
not an operational evaluation order and not an assertion that $f_v$ depends
extensionally on every argument.

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
a priority selection may identify the first enabled case; and a one-hot
selection may use the complete enabled-case mask as one outcome and demand
several roots. If an interface intends to distinguish two raw values, they must
be distinct outcomes even when they choose the same cases.

Because the graph is acyclic and every primitive is total, each input $x$
induces a unique eager value $op("val")_x(v)$ at every node. At a selection site,
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
caller predicate $A : cal(X)_G -> BB$. All feasibility and completeness claims
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
conditions; Section @sec-related compares them.

#definition("selection observation")[
  The selection observation is the dependent finite partial map $T_G(x,R)$
  with
  $
    op("dom")(T_G(x,R)) = Q inter D_G(x,R),
    quad T_G(x,R)(q) = omega_x(q).
  $
  Its totalized presentation uses one fresh sentinel $bot_q in.not Omega_q$ per
  site:
  $
    overline(T)_G(x,R)(q) =
      cases(
        T_G(x,R)(q) & "if " q in D_G(x,R),
        bot_q & "otherwise."
      )
  $
]

For a fixed graph, the partial-map and totalized-vector presentations are
isomorphic. The first is the intended sparse record; the second permits direct
projection onto the finite product
$product_(q in Q)(Omega_q union {bot_q})$.

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
  Eager values and outcomes are unique, and finite reachability has one least
  closure. The product independently counts one unobserved sentinel or one of
  the outcomes at each site. Reachability from a union of roots is the union of
  reachability from each root in the same enabled graph; site outcomes are fixed
  by $x$, so the partial maps agree on their shared domain.
]

== Least valuation under the declared dependency policy

Extend each value domain with a fresh bottom $bot_v$ and order it flatly below
all ordinary values. An $x$-consistent partial valuation assigns each node
either $bot_v$ or its eager value. It is dependency-closed when a defined
ordinary node has all operands defined and a defined selection has its
selector and exactly the case roots required by its concrete outcome defined.
It is $R$-complete when every requested root is defined.

#proposition("strict-dependency least valuation")[
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

This proposition is a graph-reachability result for the stated strict policy.
Equality with a language's semantic least demand requires a separate
translation showing that each source operator has precisely these predecessor
obligations.

== Fibers and exact positive guards

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

For each site outcome, define

$
  chi_(q,omega)(d) <=> kappa_q(d) = omega,
  quad
  p_(q,omega)(x) <=> chi_(q,omega)(op("val")_x(s_q)).
$

For feasible $tau$, its _positive local guard_ is

$
  Gamma_tau(x) = A(x) and
    product_(q in op("dom")(tau)) p_(q,tau(q))(x),
$

where the displayed product is logical conjunction. It mentions outcomes of
observed sites but contains no literal for an unobserved site.

#theorem("exact local guard")[
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

Thus two positive local guards are disjoint because they contain incompatible
outcome predicates at a shared observed site. This structural separator is
stronger than the generic fact that distinct function fibers are disjoint and
is the key reason full-fiber blocking does not need explicit unobserved-site
literals.
