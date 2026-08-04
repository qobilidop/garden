# Value and selection-observation semantics

## Eager value semantics

Because the graph is acyclic and every primitive is total and deterministic,
each input \(x\) induces a unique eager value
\(\operatorname{val}_x(v)\) for every node. Inputs use \(x\); ordinary nodes
apply \(f_v\); and a selection site applies the combiner for

\[
\omega_x(q)=\kappa_q(\operatorname{val}_x(s_q)).
\]

Eager values for unselected case cones remain mathematically defined. Purity and
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

This is the **enabled closure**. A selection site in this closure is
**observed for** \((x,R)\). “Observed” is local terminology for membership in
this precisely defined set; it is not a claim that the source language is
operationally lazy. Related literature may describe analogous backward
relevance using demand or neededness, but those terms have several distinct
formal meanings.

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
instrumentation deliberately distinguishes observed equal-valued alternatives.

## Basic properties

### Least demanded partial valuation

The enabled closure admits a finite graph-theoretic presentation of the
classical least demanded computation. For each node (v), extend its value
domain to the flat domain

\[
  \widehat{\mathcal D}_v=\mathcal D_v\cup\{\bot_v\},
\]

where \(\bot_v\sqsubseteq d\) for every ordinary value (d), and distinct
ordinary values are incomparable. For fixed input (x), a partial valuation
\(\nu\) is **(x)-consistent** when

\[
  \nu(v)\in\{\bot_v,\operatorname{val}_x(v)\}
\]

for every node. It is **dependency-closed** when every defined node has the
dependencies required by its concrete result also defined:

- a defined ordinary node has every operand defined;
- a defined selection site (q) has its selector and every case root in
  (C_q(\omega_x(q))) defined; and
- an input node has no predecessor obligation.

It is **(R)-complete** when every requested root is defined. Order partial
valuations pointwise by the flat-domain order.

Define

\[
  \nu^*_{x,R}(v)=
  \begin{cases}
    \operatorname{val}_x(v) & v\in D_G(x,R),\\
    \bot_v & v\notin D_G(x,R).
  \end{cases}
\]

**Least-demanded-valuation theorem.** The valuation \(\nu^*_{x,R}\) is the
unique least (x)-consistent, dependency-closed, (R)-complete valuation, and

\[
  \operatorname{supp}(\nu^*_{x,R})=D_G(x,R).
\]

*Proof.* The enabled closure contains (R) and is closed under exactly the
dependency obligations above, so \(\nu^*_{x,R}\) is admissible. Conversely, the
support of any admissible valuation contains (R) and is closed under every
enabled dependency. Minimality of graph reachability gives
\(D_G(x,R)\subseteq\operatorname{supp}(\nu)\). (x)-consistency fixes the
ordinary value at every defined node, hence
\(\nu^*_{x,R}\sqsubseteq\nu\). Antisymmetry gives uniqueness.

Projecting defined selection sites from the least valuation recovers the
selection observation:

\[
  T_G(x,R)=\pi_{\mathrm{sel}}(\nu^*_{x,R}).
\]

This theorem is a finite acyclic specialization of established fixed-input
demand-driven dataflow semantics, not a new least-computation principle.
Pingali and Arvind provide reverse-demand graph transformations, while Avron
and Sasson characterize least legal demanded valuations under stability. The
specialization above fixes a strict dependency interpretation for ordinary
nodes and an outcome-indexed least dependency set for selections. The object
studied by the enumeration theory is instead the image and inverse-image
fibers of \(\pi_{\mathrm{sel}}(\nu^*_{x,R})\) as (x) varies.

### Determinacy and finiteness

For every \(x\) and \(R\), \(D_G(x,R)\) and \(T_G(x,R)\) are unique. The number
of possible observations is finite and bounded by

\[
\prod_{q\in Q}(1+|\Omega_q|),
\]

although most such totalized tuples are structurally invalid.

*Proof.* Eager values and outcomes are unique. The enabled graph is finite;
reachability has one least closure. The product bound counts every unobserved or
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
identity, and records each observed site once returns \(T_G(x,R)\), independent
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

*Proof.* The reverse implication is immediate. For the forward direction,
choose a witness \(m\in F_\tau\), which exists because \(\tau\) is feasible.
Construct the enabled closures for \(m\) and \(x\) by the same finite sequence
of reachability approximants, beginning with \(R\). Suppose the approximants
agree through one step. Ordinary nodes add the same operands. A selection site
\(q\) in the common approximant belongs to \(D_G(m,R)\), hence
\(q\in\operatorname{dom}(\tau)\); the conjunct
\(p_{q,\tau(q)}(x)\) gives
\(\omega_x(q)=\tau(q)=\omega_m(q)\). The two evaluations therefore add the
same selector and the same case roots \(C_q(\tau(q))\). Induction makes every
approximant, and hence the two least closures, equal. Their observed-site
domains agree, and every site in that domain has the outcome recorded by
\(\tau\), so \(T_G(x,R)=\tau\).

The result relies on the outcome determining the selected case set. No literal
for an unobserved site is needed: omission follows structurally from the
outcomes of observed sites.

### Conflict-frontier theorem

If \(\tau\ne\sigma\) are feasible observations, then some site is observed in
both and has different outcomes:

\[
\exists q\in\operatorname{dom}(\tau)\cap\operatorname{dom}(\sigma).
\quad \tau(q)\ne\sigma(q).
\]

*Proof.* Take witnesses \(x\in F_\tau\) and \(y\in F_\sigma\). Suppose, for
contradiction, that the two maps agree wherever both are defined. Build
\(D_G(x,R)\) and \(D_G(y,R)\) by reachability approximants. They begin with the
same roots. If two approximants agree, ordinary nodes add the same operands.
Every selection site in the common approximant is observed in both executions,
so the assumption gives it the same outcome; it therefore adds the same
selector and case roots. All approximants, and thus the two enabled closures,
are equal. The observation domains are equal, and the maps agree throughout
that domain, contradicting \(\tau\ne\sigma\).

Consequently the positive cylinders \(\Gamma_\tau\) and
\(\Gamma_\sigma\) are disjoint: they contain incompatible predicates for the
shared site. This strengthens the elementary inverse-image partition with a
structural separator.

Exactness does not imply literal minimality. A predicate recorded for an
observed site may be logically redundant under \(A\) and the other recorded
predicates. The theorem says that no *unobserved-site* literal is required; it
does not say that removing any observed-site literal enlarges the fiber.
