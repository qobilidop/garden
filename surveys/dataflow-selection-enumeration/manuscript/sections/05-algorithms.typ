#import "../style.typ": definition, theorem, proposition, proof

= Two general presentations and their equivalence <sec-algorithms>

The survey identified two general routes to the exact record contract. A local
presentation discovers one complete fiber from a model, constructs its
residual, and blocks the fiber. A global presentation eagerly instruments the
whole graph and projects a conventional model enumerator onto totalized
observation coordinates. This section states both in the unified terminology
and proves that they enumerate the same observer. The constructions are
comparison baselines, not claims of new generic enumeration paradigms.

== Symbolic and solver assumptions

Every primitive, classifier outcome, case-membership relation, selected
combiner, caller predicate $A$, and typed input-domain constraint must have an
exact symbolic representation. A model-producing oracle for a formula returns
`sat(m)`, `unsat`, or `unknown`. Only `unsat` certifies exhaustion; `unknown`
produces an explicit incomplete result. We do not assume that the oracle runs
in polynomial time or that a decision-only oracle returns a witness for free.

For an input model $m in cal(X)_A$, a demanded evaluator carries three objects:

- a conjunction $g$ of observed outcome predicates;
- a partial observation map $T$; and
- a candidate-local memo $mu$ from graph-node identities to pairs of concrete
  and symbolic values.

The memo is essential for shared DAGs. Memoizing syntax-tree positions could
duplicate one source site or allow inconsistent outcomes.

== Concolic exact-fiber generation

Evaluation of a demanded node $v$ returns a concrete value $c_v$ at $m$ and a
symbolic residual $e_v$:

1. An input returns its component of $m$ and its symbolic variable.
2. An ordinary node demands all operands and applies the exact concrete and
   symbolic primitive.
3. A selection $q$ first evaluates its selector, including any selections in
   that cone. It computes $omega = kappa_q(c_(s_q))$, records $T(q)=omega$ once,
   conjoins $chi_(q,omega)(e_(s_q))$, evaluates exactly the case roots in
   $C_q(omega)$, and applies the corresponding symbolic combiner.
4. A memo hit reuses the pair and records no duplicate event.

Only selection outcomes are specialized to $m$. Replacing an ordinary symbolic
value by its sampled concrete value would make the guard or residual too
strong. Write

$
  op("Gen")(G,m,R) = (T_m, g_m, r_m),
$

where $r_m$ is the residual tuple for the requested roots and the complete
guard is $A and g_m$.

#theorem("generator correctness")[
  Under the symbolic assumptions above and memoization by node identity,
  $
    x models A and g_m
      <=> A(x) and T_G(x,R) = T_m,
  $
  and every input satisfying that guard satisfies
  $
    op("eval")(r_m,x) = op("val")_x |_R.
  $
  The model $m$ itself satisfies the emitted guard.
]

#proof[
  Induct over demanded evaluation while carrying a prefix guard
  $g^("pre")$. The strengthened invariant says that $e_v$ evaluates to $c_v$
  at $m$ and, for every $x models A and g^("pre")$, evaluates to the eager
  value of $v$ at $x$. Ordinary primitives preserve the invariant by exactness.
  At a selection, the selector residual may itself contain selections already
  specialized to $m$, but the induction hypothesis makes it equal to the eager
  selector value throughout the prefix guard. The new predicate
  $chi_(q,omega)(e_(s_q))$ is therefore equivalent there to the global outcome
  predicate $p_(q,omega)(x)$ and selects the same case roots. The complete
  guard $A and g_m$ is therefore semantically equivalent to
  $Gamma_(T_m)$ from the exact-local-guard theorem, while the residual invariant
  gives value correctness. Every chosen outcome predicate holds at $m$, so the
  guard is nonempty.
]

== Full-fiber blocking

Initialize the uncovered formula $U_0=A$ and repeat:

1. Query the model oracle for $U_j$.
2. On `unknown`, return all accumulated records marked incomplete.
3. On `unsat`, return them marked complete.
4. On `sat(m_j)`, compute
   $(T_j,g_j,r_j)=op("Gen")(G,m_j,R)$ and emit
   $(T_j,A and g_j,r_j,m_j)$.
5. Set $U_(j+1)=U_j and not g_j$.

Previous blockers are not folded into an emitted guard. Every query already
assumes $A$, so the incremental blocker need only negate $g_j$.

#theorem("complete nonredundant enumeration")[
  Let $K = abs(cal(T)_(G,A,R))$. If the model-producing oracle decides every
  query, full-fiber blocking performs exactly $K$ satisfiable invocations and
  one final unsatisfiable invocation. It emits every feasible observation once,
  with its exact guard, correct residual, and a witness.
]

#proof[
  Every model lies in one nonempty fiber, and generator correctness emits that
  entire fiber. Its blocker prevents repetition and, because distinct fibers
  are disjoint, removes no other observation. Before all fibers are blocked, an
  input in an unblocked fiber satisfies $U_j$. Once all $K$ are blocked, the
  fiber-partition property makes $U_K$ unsatisfiable.
]

This is a $K+1$ _model-producing invocation count under a unit-cost oracle_. It
is not an OutputP, IncP, DelayP, wall-clock, or decision-oracle theorem. Formula
construction, serialized guard and residual size, solver work, and the final
exhaustion query must all be charged separately.

== Global reachability-and-outcome encoding

The alternative presentation symbolically evaluates every node, including
unobserved case cones. Let $e_v(x)$ be the exact eager symbolic value of $v$.
For each case position define the direct predicate

$
  eta_(q,j)(d) <=> j in C_q(kappa_q(d)).
$

Introduce one Boolean activity variable $a_v$ per node. It is true exactly when
$v$ is reachable from a requested root through an enabled consumer edge. The
acyclic defining equations are

$
  a_v <=> [v in R]
    or (∨_((w,j,v) in E, w in N) a_w)
    or (∨_(q : v = s_q) a_q)
    or (∨_(q,j : v = c_(q,j))
          (a_q and eta_(q,j)(e_(s_q)))).
$

Multiple consumers contribute by disjunction, and the biconditional prevents
spurious disconnected activity. Acyclicity gives a unique valuation of the
activity circuit for every input.

For each selection site introduce a projected coordinate ranging directly over
$Omega_q union {bot_q}$:

$
  z_q = cases(
    kappa_q(e_(s_q)) & "if " a_q,
    bot_q & "otherwise,"
  )
$

Let $Phi_(G,A,R)(x,a,Z)$ conjoin the exact typed input-domain encoding,
$A(x)$, every displayed activity biconditional, and every displayed coordinate
definition. Project $Phi_(G,A,R)$ onto $Z=(z_q)_(q in Q)$, so its projected
image is

$
  {Z | exists x,a : Phi_(G,A,R)(x,a,Z)}.
$

An exact projected enumerator or finite decision-diagram compiler can then
enumerate the feasible totalized observations. A Boolean-backed implementation
may injectively encode the entire finite domain $Omega_q union {bot_q}$ into
designated projected atoms; an SMT enumerator with appropriate finite-domain
projection may instead retain $z_q$ as a theory term.

#theorem("projection equivalence")[
  For every caller-domain input $x in cal(X)_A$, the activity equations have
  the unique solution
  $a_v <=> v in D_G(x,R)$, and $Z=overline(T)_G(x,R)$. Hence projected
  models of $Phi_(G,A,R)$ over $Z$ are in bijection with feasible sparse
  observations. For every typed input $x$ and feasible $tau$,
  $
    (exists a : Phi_(G,A,R)(x,a,overline(tau)))
      <=> Gamma_tau(x).
  $
]

#proof[
  Induct backward over the acyclic consumer-to-operand graph. Requested roots
  establish the base activity. An ordinary consumer enables every operand; a
  selection enables its selector and exactly the cases selected by the direct
  $eta$ predicates. The biconditionals therefore compute precisely the least
  enabled closure, including disjunctive sharing from multiple consumers.
  Substitution in the definition of $z_q$ gives the totalized partial map.
  Therefore the existential formula holds exactly when $A(x)$ holds and the
  induced totalized observation equals $overline(tau)$; the exact-local-guard
  theorem gives the final equivalence.
]

Consequently, naive projected enumeration of complete observation tuples and
full-fiber blocking have the same $K+1$ model-producing invocation count.
Full-fiber generation is an input-only, lazily constructed substitution of one
projected-assignment blocker. An enumerator that emits a short partial cube has
a different output contract: one cube may cover several complete selection
observations.

== Representation boundary

Local generation avoids constructing unobserved cones for one record and
returns a sparse observation, guard, and residual directly. The global encoding
constructs one shared eager value/activity circuit and reuses it across all
records; it can exploit mature projected-enumeration algorithms that avoid a
growing sequence of ordinary blocking clauses. Neither dominates in the
general model. Classifier and direct case-membership circuits can themselves be
exponential in a succinct selector description, and local output can repeat
large residual structures unless DAG sharing is explicit.

The equivalence also fixes attribution. Projected enumeration supplies the
generic enumerator; symbolic execution supplies residual construction; the
graph-specific obligation is proving that enabled reachability, totalized
activity coordinates, and the positive local guard denote the same observer.
