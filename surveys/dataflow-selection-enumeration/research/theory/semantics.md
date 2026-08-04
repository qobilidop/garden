# Value and selection-observation semantics

## Eager value semantics

Because the graph is acyclic and every primitive is total and deterministic,
each input \(x\) induces a unique eager value
\(\operatorname{val}_x(v)\) for every node. Inputs use \(x\); ordinary nodes
apply \(f_v\); and a selection site applies the combiner for

\[
\omega_x(q)=\kappa_q(\operatorname{val}_x(s_q)).
\]

Eager values for inactive case cones remain mathematically defined. Purity and
totality make them irrelevant to the selected result. This value semantics is
separate from the structural observation below.

## Input-indexed enabled edges

For a fixed input \(x\), define enabled operand edges:

- every operand edge of an ordinary node is enabled;
- the selector edge of every selection site is enabled;
- case edge \((q,c_{q,j})\) is enabled exactly when
  \[
  j\in C_q(\omega_x(q)).
  \]

Given an observed output-root set \(R\), let

\[
D_G(x,R)
\]

be the least node set containing \(R\) and closed under enabled operand edges.
Equivalently, it is graph reachability from \(R\) in the input-indexed enabled
edge relation.

This is a result-observation or demand judgment, not an operational claim that
the source language is lazy.

## Selection observation

The selection observation is the finite partial map

\[
T_G(x,R):Q\rightharpoonup\bigcup_q\Omega_q
\]

with

\[
\operatorname{dom}(T_G(x,R))=Q\cap D_G(x,R),
\qquad
T_G(x,R)(q)=\omega_x(q).
\]

A total-vector presentation uses one additional value \(\bot_q\):

\[
\overline T_G(x,R)(q)=
\begin{cases}
T_G(x,R)(q) & q\in D_G(x,R),\\
\bot_q & q\notin D_G(x,R).
\end{cases}
\]

The partial and totalized presentations are isomorphic for a fixed graph. The
sentinel presentation is convenient for projected AllSMT; the partial map is
the intended sparse API.

An instrumented denotation is

\[
\mathcal O_G(x,R)=
(\operatorname{val}_x|_R,T_G(x,R)).
\]

Erasing the second component recovers ordinary eager value semantics. The
instrumentation deliberately distinguishes active equal-valued alternatives.

## Basic properties

### Determinacy and finiteness

For every \(x\) and \(R\), \(D_G(x,R)\) and \(T_G(x,R)\) are unique. The number
of possible observations is finite and bounded by

\[
\prod_{q\in Q}(1+|\Omega_q|),
\]

although most such totalized tuples are structurally invalid.

*Proof.* Eager values and outcomes are unique. The enabled graph is finite;
reachability has one least closure. The product bound counts every inactive or
outcome value independently and therefore overapproximates the image.

### Root monotonicity and exact sharing

If \(R_1\subseteq R_2\), then

\[
D_G(x,R_1)\subseteq D_G(x,R_2)
\]

and the smaller observation is the restriction of the larger one. Moreover,

\[
D_G(x,R_1\cup R_2)
=D_G(x,R_1)\cup D_G(x,R_2),
\]

and

\[
T_G(x,R_1\cup R_2)
=T_G(x,R_1)\sqcup T_G(x,R_2),
\]

where the union is compatible because a site outcome is fixed by \(x\).

*Proof.* Reachability from a union of roots is the union of the two reachable
sets in the same enabled graph. Shared nodes and sites occur once in the set or
map.

### Schedule and memoization invariance

Any evaluator that visits exactly the enabled closure, memoizes by graph-node
identity, and records each active site once returns \(T_G(x,R)\), independent
of legal traversal order.

This is a corollary of the reachability definition, not a claim about arbitrary
term-graph rewrite systems. Memoizing syntax-tree occurrences instead of graph
nodes can violate it.

### Equivariance, not canonicity

A type- and edge-preserving graph isomorphism transports observations by its
site renaming. Ordinary value-preserving rewrites need not preserve selection
observations. The semantics is graph-relative, not canonical modulo extensional
or theory equivalence.

## Observation fibers

Fix \(G\), \(R\), and caller constraint \(A\). Let

\[
\mathcal T_{G,A,R}=
\{T_G(x,R)\mid A(x)\}
\]

be the feasible observations. For each \(\tau\) in this image, define its fiber

\[
F_\tau=
\{x\mid A(x)\land T_G(x,R)=\tau\}.
\]

### Fiber-partition theorem

The nonempty fibers are pairwise disjoint and their union is exactly
\(\mathcal X_A\).

*Proof.* \(T_G(-,R)\) is a total function on \(\mathcal X_A\); inverse images
of distinct function values are disjoint and the inverse images of the image
cover the domain.

This theorem fixes the semantic contract but is elementary and not a novelty
claim.

## Local characterization of a fiber

For each site and outcome define

\[
p_{q,\omega}(x)
\;\Longleftrightarrow\;
\kappa_q(\operatorname{val}_x(s_q))=\omega.
\]

For a feasible observation \(\tau\), define

\[
\Gamma_\tau(x)
=A(x)\land
\bigwedge_{q\in\operatorname{dom}(\tau)}p_{q,\tau(q)}(x).
\]

### Exact-local-guard theorem

For every feasible \(\tau\),

\[
\Gamma_\tau(x)
\quad\Longleftrightarrow\quad
A(x)\land T_G(x,R)=\tau.
\]

*Proof sketch.* The reverse implication is immediate. For the forward
direction, traverse the enabled closure induced by \(\tau\) from \(R\). Every
active site has the recorded outcome under \(x\), so it enables exactly the
same case edges. Induction over graph depth yields exactly the same active
closure and no additional site. Selector-in-selector dependencies are already
in the closure; multi-case selections are determined by \(C_q(\tau(q))\).

The result relies on the outcome determining the demanded case set. No literal
for an inactive site is needed: inactivity follows structurally from the active
outcomes.
