# Exact fiber generation and enumeration

## Symbolic setting

Assume symbolic terms represent every ordinary primitive and every outcome
predicate exactly. A model oracle for a formula returns \(\mathsf{sat}(m)\),
\(\mathsf{unsat}\), or \(\mathsf{unknown}\). Completeness is claimed only after
\(\mathsf{unsat}\); \(\mathsf{unknown}\) produces an explicit incomplete
result.

## Concolic fiber generation

Given a model input \(m\), generate its observation and guard without first
guessing an abstract observation. Maintain

\[
(\gamma,T,\mu),
\]

where \(\gamma\) is the symbolic guard, \(T\) the discovered partial site map,
and \(\mu\) a candidate-local memo from graph-node identity to
concrete/symbolic value pairs.

Evaluation of a demanded node returns \((c_v,e_v)\):

1. An input returns its value under \(m\) and its symbolic variable.
2. An ordinary node demands all operands, applies the concrete primitive to
   concrete values, and the exact symbolic primitive to symbolic values.
3. A selection site:
   - first evaluates its selector, including any selections in that cone;
   - computes \(\omega=\kappa_q(c_s)\);
   - records \(T(q)=\omega\) once;
   - conjoins the symbolic predicate \(p_{q,\omega}(e_s)\);
   - evaluates exactly the case roots in \(C_q(\omega)\); and
   - constructs the selected symbolic result combiner.

A memo hit reuses the pair and does not duplicate a shared site. The symbolic
component must not replace an ordinary symbolic value with its value under
\(m\); only selection outcomes are specialized. Model-specific constant
propagation would make the guard too strong.

Write

\[
\operatorname{Gen}(G,m,R)
=(T_m,g_m,\mathcal R_m),
\]

where the complete observation guard is \(A\land g_m\) and \(\mathcal R_m\) is
the residual symbolic output.

## Generator theorem

Assuming exact symbolic primitives, total deterministic value semantics, and
memoization by node identity,

\[
x\models A\land g_m
\quad\Longleftrightarrow\quad
A(x)\land T_G(x,R)=T_m,
\]

and

\[
x\models A\land g_m
\quad\Longrightarrow\quad
\llbracket\mathcal R_m\rrbracket_x
=\operatorname{val}_x|_R.
\]

*Proof sketch.* Induct over the demanded evaluation. The lockstep invariant is
that \(e_v(m)=c_v\), \(m\) satisfies the accumulated guard, and the residual
agrees with the eager node value for every input satisfying the guard. At a
selection, the new outcome predicate holds for \(m\). Inputs satisfying all
recorded predicates induce the same enabled closure by the exact-local-guard
theorem. The selected combiner then preserves residual correctness.

The generator's model \(m\) is already a witness for its complete guard.

## Full-fiber blocking

Initialize the uncovered-domain formula \(U_0=A\). At iteration \(j\):

1. Query the model oracle for \(U_j\).
2. On \(\mathsf{unknown}\), report incomplete enumeration.
3. On \(\mathsf{unsat}\), return the accumulated results as complete.
4. On \(\mathsf{sat}(m_j)\), compute
   \((T_j,g_j,\mathcal R_j)=\operatorname{Gen}(G,m_j,R)\).
5. Emit \((T_j,A\land g_j,\mathcal R_j,m_j)\).
6. Set
   \[
   U_{j+1}=U_j\land\neg g_j.
   \]

The emitted guard contains \(A\); the incremental blocker need only negate
\(g_j\) because every query already assumes \(A\). Previous blockers must not
be folded into the emitted guard.

## Enumeration theorem

If there are \(K\) feasible observations and the oracle eventually decides
every query, full-fiber blocking performs exactly \(K\) satisfiable queries and
one final unsatisfiable query. It emits every feasible observation once, with
its exact guard, a correct residual, and a witness.

*Proof.* Each satisfiable model lies in one nonempty exact fiber. Blocking that
fiber prevents its repetition and cannot remove another fiber. Before all
fibers have been blocked, an input in an unblocked fiber satisfies \(U_j\);
after all \(K\) have been blocked, the fiber-partition theorem makes \(U_K\)
unsatisfiable.

This is an output-sensitive oracle-call theorem, not a polynomial-delay or
wall-clock theorem.

## Activation-variable projected-AllSMT baseline

For every node \(v\), construct a symbolic value term \(e_v(x)\). Construct an
activity formula \(a_v(x,R)\) by propagating observation backward from \(R\):

- roots in \(R\) are active;
- an active ordinary node activates every operand;
- an active selection activates its selector;
- it activates case \(j\) under
  \[
  j\in C_q(\kappa_q(e_{s_q}(x)));
  \]
- multiple consumers contribute by disjunction.

For every selection site introduce a finite-domain observation variable

\[
z_q=\operatorname{ite}
(a_q,\operatorname{encode}(\kappa_q(e_{s_q})),\bot_q).
\]

Project the graph formula onto the vector \(Z=(z_q)\). Standard AllSMT,
projected enumeration, or decision-diagram compilation then enumerates the
feasible totalized observations. Internal values and activity variables are
unimportant variables.

## Reduction theorem

For every input \(x\), the activation encoding has a unique \(Z\) equal to
\(\overline T_G(x,R)\). Thus projected enumeration over \(Z\) is in bijection
with the feasible sparse observations.

For each feasible \(\tau\), let \(\overline\tau\) be its totalization. Then,
under the graph definitions,

\[
Z=\overline\tau
\quad\Longleftrightarrow\quad
g_\tau(x).
\]

Consequently full-fiber blocking and projected AllSMT enumerate the same
partition. Full-fiber blocking lazily constructs an input-only substitution of
the projected-assignment blocker; it does not improve the general \(K+1\)
model-query bound.

## Representation tradeoff

Full-fiber generation avoids symbolically constructing inactive cones for one
observation, directly returns input guards and residuals, and can keep each
observation sparse. The activation encoding constructs one global graph of
weighted size linear in the source graph, shares it across all observations,
and can use mature disjoint-enumeration algorithms that avoid ordinary
blocking-clause accumulation.

These are representation and implementation tradeoffs. No general asymptotic
advantage follows from the current theory.
