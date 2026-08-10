# Compositional and demand-parametric summaries

## Why output demand is an interface parameter

A component with several output ports may expose different internal selection
sites depending on which outputs a caller observes. A compositional summary
must therefore take an output-root set as an argument. Summarizing every output
unconditionally over-observes a component used through only one output.

For a component \(G:X\to Y\), define its semantic interface

\[
\Sigma_G(x,R)=
(\operatorname{val}_G(x)|_R,\delta_G(x,R),T_G(x,R)),
\]

where \(R\subseteq Y\) is the requested root set and

\[
\delta_G(x,R)=I_G\cap D_G(x,R)
\]

is the demanded input-port set. The residual interface for demand \(R\)
therefore has the typed output tuple \(\prod_{o\in R}\mathcal D_o\); \(\delta\)
and \(T\) describe the separate structural observation.

## Sequential composition

Let \(G:X\to Y\) and \(H:Y\to Z\), with disjoint site namespaces, and fix a
type-preserving bijection

\[
  \rho:I_H\xrightarrow{\cong}O_G.
\]

The flattened composite has node set
\(V_G\uplus(V_H\setminus I_H)\). Every operand edge in \(H\) that targeted an
input node \(i\) instead targets \(\rho(i)\); all other ordered edges and
semantic labels are unchanged. This is the graph substitution meant by
\(H\circ_\rho G\).

For input \(x\) and requested roots \(R\subseteq O_H\), define the boundary
valuation \(y_i=\operatorname{val}_G(x)(\rho(i))\), and let

\[
y=(y_i)_{i\in I_H},
\qquad
(z,S_H,\tau_H)=\Sigma_H(y,R),
\]

and

\[
S_G=\rho(S_H),
\qquad
(-,D,\tau_G)=\Sigma_G(x,S_G).
\]

Then

\[
\Sigma_{H\circ_\rho G}(x,R)
=(z,D,\iota_G(\tau_G)\sqcup\iota_H(\tau_H)),
\]

where \(\iota_G\) and \(\iota_H\) inject sites into disjoint contextual
namespaces.

### Exact-composition theorem

The equation above equals the whole-graph enabled-edge semantics of the
substituted composite.

*Proof.* A topological induction gives the **value-substitution lemma**: every
retained \(H\) node has in the flattened graph the value it has under boundary
valuation \(y\), while every \(G\) node keeps its value under \(x\).

Now construct enabled closures by reachability approximants. Before crossing a
substituted boundary, the restriction to retained \(H\) nodes is exactly
\(D_H(y,R)\setminus I_H\), because the value-substitution lemma makes every
selection outcome and hence every enabled \(H\) edge identical. Its boundary
crossings are exactly \(S_H=I_H\cap D_H(y,R)\), redirected to
\(S_G=\rho(S_H)\). Starting from precisely those roots, the restriction of
flattened reachability to \(G\) is \(D_G(x,S_G)\); no other edge enters \(G\).
Thus the demanded external inputs are \(D\), and the observed sites are
exactly the disjoint contextual union of the two component observations. The
value-substitution lemma supplies \(z\).

## Parallel composition and sharing

Parallel composition combines value tuples, demanded boundary ports, and
disjointly namespaced observations. When two consumers share one component
node, their root demands combine by union. The exact-sharing law from
\`semantics.md\` gives

\[
T_G(x,R_1\cup R_2)
=T_G(x,R_1)\sqcup T_G(x,R_2),
\]

so a shared site is recorded once with one compatible outcome.

Duplicating a shared component and prefixing the two copies is a different
intensional graph: it may produce two distinct events even when ordinary values
remain equal.

## Calls and finite iteration

A call occurrence prefixes every callee site with the call-site identity. The
exact-composition theorem then applies to the call node as sequential
substitution.

A statically bounded iteration is a finite fold of composition. Iteration \(i\)
prefixes callee sites with \((\mathit{loop\_site},i)\). Induction on the bound
proves agreement between repeated summary composition and full unrolling.

This statement does not cover unbounded loops, recursion, or merging dynamic
occurrences with the same source location.

## Symbolic guarded summaries

The full concrete map \(\Sigma_G\) need not have finite range when value
domains are infinite. Instead partition only by the finite structural
projection

\[
  \Pi_G(x,R)=(\delta_G(x,R),T_G(x,R)),
\]

and retain \(\operatorname{val}_G|_R\) as a symbolic residual inside each case.
If inputs, output-demand masks, and primitive operations have an exact
decidable symbolic representation, the fibers of \(\Pi_G\) form a finite
guarded relation. Represent a component case by
\((g,\delta,\tau,r)\), where \(g\) is its exact input guard,
\((\delta,\tau)\) its structural projection, and \(r\) an exact symbolic
residual for the demanded output tuple.

### Demanded-port locality lemma

If \(\Pi_G(x,R)=(\delta,\tau)\) and a typed input \(x'\) agrees with \(x\) on
\(\delta\), then

\[
  \Pi_G(x',R)=(\delta,\tau)
  \quad\text{and}\quad
  \operatorname{val}_{x'}|_R=\operatorname{val}_{x}|_R.
\]

*Proof sketch.* Couple a topological value induction with the reachability
approximants of the enabled closure. Every ordinary operand of a reached node
is reached, and every selector whose outcome can enable a case has its selector
operand reached. Hence every external input capable of changing a reached
value, observed outcome, or subsequent enabled edge lies in \(\delta\). Agreement
on those inputs preserves values on the current closure, then the same
selection outcomes preserve the next reachability approximant. Induction gives
the same closure, observation, and requested values.

The lemma is what permits both the case guard and residual to be typed over
\(\prod_{i\in\delta}\mathcal D_i\); this does not follow from notation alone.

More precisely, for every \((\delta,\tau)\in\operatorname{im}\Pi_G(-,R)\),
the full-domain exact-summary contract requires

\[
g:\prod_{i\in\delta}\mathcal D_i\to\mathbb B,
\qquad
r:\prod_{i\in\delta}\mathcal D_i\to\prod_{o\in R}\mathcal D_o,
\]

and, for every full input \(x\in\mathcal X_G\),

\[
g(x|_\delta)\iff\Pi_G(x,R)=(\delta,\tau),\qquad
g(x|_\delta)\Rightarrow r(x|_\delta)=\operatorname{val}_x|_R.
\]

This statement uses full-domain component summaries. An independent component
precondition that mentions otherwise undemanded inputs must be carried as an
additional interface predicate and its support charged explicitly; it cannot
silently be dropped by the demand projection.

For an \(H\) case \((h,S_H,\tau_H,r_H)\), let

\[
 h:\prod_{i\in S_H}\mathcal D_i\to\mathbb B,
 \qquad
 r_H:\prod_{i\in S_H}\mathcal D_i
       \to\prod_{o\in R}\mathcal D_o.
\]

Pair it with a \(G\) case \((g,D,\tau_G,r_G)\) summarized at demand
\(S_G=\rho(S_H)\), where

\[
  g:\prod_{j\in D}\mathcal D_j\to\mathbb B,
  \qquad
  r_G:\prod_{j\in D}\mathcal D_j\to\prod_{o\in S_G}\mathcal D_o.
\]

Reindex this boundary tuple as

\[
  \widehat r_G(x)_i=r_G(x|_D)_{\rho(i)}
  \qquad(i\in S_H),
\]

and form

\[
\begin{split}
c(x) &\equiv g(x|_D)\land h(\widehat r_G(x)),\\
r(x) &= r_H(\widehat r_G(x)),\\
\tau &= \iota_G(\tau_G)\sqcup\iota_H(\tau_H).
\end{split}
\]

Discard pairs whose \(c\) is infeasible.

The guard/residual algebra in these two equations is established in the
piecewise-affine special case. Geyer, Torrisi, and Morari's compositional mode
enumerator topologically refines component polyhedra, substitutes upstream
affine output maps into downstream event guards, composes the affine maps, and
prunes empty intersections. The theorem below is therefore not a claim of a
new guarded-composition operator. Its graph-specific content is that a
requested output mask induces exactly the boundary demand used to choose the
upstream summary, and that contextual sparse observations agree with the
flattened shared graph.

### Guarded-summary composition theorem

The feasible records above are an exact observation partition for the
flattened composite: every caller input satisfies exactly one record, every
record's residual and structural data agree with the concrete composite, and
distinct records have distinct composite structural projections.

*Proof sketch.* The concrete boundary value selects the unique exact \(H\)
case. Its \(S_H\) fixes the demand at which the concrete input selects the
unique exact \(G\) case. Residual substitution and the concrete
exact-composition theorem give soundness and coverage. If two paired records
had the same composite structural projection, disjoint site namespaces would
make both \(\tau_H\) and \(\tau_G\) equal. The observed-outcome lockstep then
makes \(S_H\), followed by \(D\), equal as well, so the component fiber cases
and hence the pair are identical.

This one-record conclusion assumes that each component summary already has
one exact record per \(\Pi\)-fiber and that the composite retains both
components' observations. Fragmented component guards or deliberate erasure
of internal events can require a later quotient, but that is a different
summary contract.

Operationally, guarded composition amounts to:

1. substitute \(G\)'s residual output into \(H\)'s guards;
2. use each \(H\) case's boundary-demand set \(S\) to select the matching
   demand-parametric cases of \(G\);
3. conjoin guards;
4. discard infeasible conjunctions; and
5. union namespaced observations and compose residual values.

It may still form a large cross-product before feasibility pruning; no
output-sensitive advantage is established.

## Algebraic interpretation

Ordinary operators combine independent computations. A selection first
computes a selector and conditionally observes case computations. Logging the
site outcome before conditional composition interprets the graph in a reader
of concrete inputs combined with the idempotent writer monoid

\[
  \left(\mathcal P_{\mathrm{fin}}
  \left(\coprod_{q\in Q}\{q\}\times\Omega_q\right),
  \cup,\varnothing\right).
\]

Determinism gives a functional-consistency invariant: for a fixed input the
event set contains at most one outcome for each site. Decoding such a set gives
the partial map \(T_G\). Compatible partial-map union is useful notation for
already-consistent observations, but is not itself a total writer monoid.

This is naturally a selective computation. Selective applicative functors
already provide laws, a free construction, and generic interpretation for
statically visible computations with dynamically skipped effects. Node
identity, sharing, output-demand masks, exact SMT fibers, and symbolic residuals
must therefore carry any remaining contribution; plain compositionality does
not.

## Universal-property status

The equivalence

\[
x\equiv_G x'
\quad\Longleftrightarrow\quad
\mathcal O_G(x,R)=\mathcal O_G(x',R)
\]

is the coarsest input equivalence preserving the instrumented value-and-event
denotation \(\mathcal O_G=(\operatorname{val}|_R,T_G)\), but that is the kernel
of a function and is tautological. It is generally finer than the
selection-observer fiber because it also distinguishes requested output values.
Full abstraction for a context
language with a primitive that directly reads site events is likewise obtained
by construction.

No non-tautological minimality, free, or full-abstraction theorem beyond
selective-functor interpretation is currently established; the
manuscript accordingly presents the selective interpretation as an
organizing derivation only (F05).
