# Complexity analysis

## Parameters

Use explicit parameters rather than the ambiguous phrase “graph size”:

- \(S_G\): weighted DAG size, counting nodes, operand and case edges, bit
  widths, constants, aggregate leaves, and outcome-predicate lowering cost;
- \(Q\): number of structural selection sites;
- \(b_q=|\Omega_q|\): outcome count at site \(q\);
- \(K\): number of feasible selection observations under the caller constraint;
- \(L\): maximum number of active sites in one observation;
- \(S_\tau\): weighted size of the demanded slice for observation \(\tau\);
- \(B\): number of candidates built by a particular syntactic branching
  algorithm before feasibility filtering;
- \(Z\): total serialized or DAG output size, stated explicitly; and
- \(T_{\mathrm{SMT}}(\phi)\): cost of deciding and producing a model for
  formula \(\phi\).

\(S_G\) must count widths and case lists. One width-\(w\) one-hot selector can
have one graph node but an \(\Omega(w)\) outcome predicate and \(2^w\) possible
masks.

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

The inactive values are not independent, so this bound can be loose. If every
site is always active,

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

## Full-fiber blocking

With a unit-cost model-producing oracle, the algorithm performs exactly

\[
K+1
\]

queries. Candidate-local concolic construction with memoization costs

\[
O\!\left(\sum_\tau S_\tau\right)
\subseteq O(KS_G)
\]

and creates guard-plus-residual DAGs of the same asymptotic size.

Before query \(j\), the solver sees

\[
A\land\bigwedge_{i<j}\neg g_i.
\]

An honest solver-time statement is therefore

\[
\sum_{j=0}^{K}
T_{\mathrm{SMT}}\!\left(A\land\bigwedge_{i<j}\neg g_i\right).
\]

The cumulative blocker DAG can be \(O(KS_G)\). Incrementality may reuse learned
facts but gives no general polynomial-delay or monotone-runtime bound.

## Prefix model-discovery baseline

If an alternative algorithm discovers only feasible outcome children at each
feasible observation prefix, let \(I\) be the number of feasible internal
prefixes. An internal prefix \(p\) with \(d(p)\) feasible children needs
\(d(p)\) successful discovery queries plus one exhaustion query. Since

\[
\sum_p d(p)=I+K-1,
\]

the total is

\[
2I+K-1\le 2KL+K-1.
\]

The inequality charges each internal prefix to one descendant leaf. It fails
if the algorithm tests infeasible raw outcomes, blocks concrete selector values
instead of whole semantic outcomes, duplicates shared sites, or permits a
feasible prefix with no total result.

Full-fiber blocking has the smaller invocation count in this comparison, but
naive projected AllSMT over complete observation tuples has the same \(K+1\)
model-producing-invocation count.

## Formula representation

For one observation,

\[
|g_\tau|_{\mathrm{DAG}}+|\mathcal R_\tau|_{\mathrm{DAG}}=O(S_\tau).
\]

This is false for naive tree serialization. In the shared chain

\`\`\`text
e0 = x
e1 = f(e0,e0)
e2 = f(e1,e1)
...
en = f(e[n-1],e[n-1])
\`\`\`

the graph has linear size but recursive textual expansion has exponential
size. Paper claims must specify formula DAG, let-bound SMT,
definitional/Tseitin encoding, or actual serialized bytes.

## Decision and counting hardness

Even for Boolean circuits, feasibility of a requested active-site outcome is
NP-hard: let one selector compute an arbitrary Boolean circuit \(F(x)\) and ask
whether its \(\mathsf{true}\) outcome is feasible. It is in NP when a finite
concrete input is a polynomial-size witness and graph evaluation is polynomial.

Counting feasible observations is #P-hard when caller constraints are part of
the input: under a Boolean constraint \(F(x)\), expose each input bit as an
always-active binary selection outcome, making observations injective on
satisfying inputs. The number of observations is then \(\#\mathrm{SAT}(F)\).

Do not call the general image-counting problem #P-complete without an upper
bound proof; multiple inputs may map to one observation.

Checking that a supplied finite guard family covers all Boolean inputs is
coNP-hard by propositional validity. The enumeration algorithm establishes
coverage operationally through the final unsatisfiable query.

## Representation comparisons

The activation-variable projected-AllSMT baseline constructs one shared graph
encoding of \(O(S_G)\) weighted DAG size. Full-fiber generation can avoid
inactive slices per result but may emit \(O(KS_G)\) separate structures.
Neither dominates asymptotically in the general model.

Performance claims must separately report construction work, model queries,
solver time, time to first result, cumulative asserted formula size, output DAG
nodes, serialized bytes, and peak memory.
