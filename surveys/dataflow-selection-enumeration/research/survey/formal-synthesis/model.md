# Formal model

## Scope and assumptions

The base object is a finite, typed, acyclic, rooted term graph. It is a
mathematical model of a pure dataflow function, not an operational CFG.

Assumptions:

1. Every primitive operator is deterministic and total on its typed domain.
2. Every selection site has a finite outcome set.
3. Graph sharing is semantic: one node identity may have several consumers.
4. Site identities are fixed relative to the graph. Calls and finite iteration
   use context-qualified occurrences.
5. The caller constraint is interpreted in a logic for which the enumeration
   algorithm has a sound model-producing decision procedure. \`unknown\` is not
   silently treated as infeasible.

Value domains need not be finite for the semantic partition to have finitely
many observations: the graph and each outcome set are finite. XLS bit vectors
and finite aggregates are finite domains, which gives stronger termination and
complexity statements.

Partial, nondeterministic, relational, cyclic, stateful, or time-varying graphs
are outside the base theorem. They require explicit extensions rather than
informal appeals to purity.

## Graph

A selective term graph is

\[
G=(V,E,I,O,\lambda,Q),
\]

where \(V\) is a finite node set; \(I,O,Q\subseteq V\) are respectively
input nodes, output-root nodes, and selection-site nodes; \(I\cap Q=\varnothing\);
and

\[
  N=V\setminus(I\cup Q)
\]

is the set of ordinary nodes. Thus \(I,N,Q\) are disjoint and exhaustive,
while an output root in \(O\) may belong to any one of those categories.
Finally, \(\lambda\)
assigns every node its result type and semantic label. The operand relation

\[
  E\subseteq V\times\mathbb N\times V
\]

contains \((v,j,u)\) when operand position \(j\) of consumer \(v\) is supplied
by node \(u\). Operand positions are unique within a consumer, all edges are
type-correct, and the consumer-to-operand relation is acyclic. Input and output
ports are therefore identified with graph nodes rather than left as a separate
uninterpreted interface.

An input node denotes one component of an input valuation

\[
x\in\mathcal X_G=\prod_{i\in I}\mathcal D_i.
\]

The component output value is the typed tuple

\[
  \operatorname{val}_G(x)=
  (\operatorname{val}_x(o))_{o\in O}.
\]

An ordinary node \(v\in N\) with ordered operands \(u_1,\ldots,u_k\) denotes a total
function

\[
f_v:\mathcal D_{u_1}\times\cdots\times\mathcal D_{u_k}
\longrightarrow\mathcal D_v.
\]

Every ordinary operator is strict for the separate result-observation
judgment: observing \(v\) observes all of its operands. This does not assert a
particular runtime evaluation order.

## Generalized selection site

A selection site \(q\) contains:

- a selector operand \(s_q\), represented by edge \((q,0,s_q)\);
- case-root operands \(c_{q,1},\ldots,c_{q,m_q}\), represented by edges
  \((q,j,c_{q,j})\) for \(1\le j\le m_q\);
- a finite outcome set \(\Omega_q\);
- a total classifier
  \[
  \kappa_q:\mathcal D_{s_q}\to\Omega_q;
  \]
- a case-demand function
  \[
  C_q:\Omega_q\to\mathcal P(\{1,\ldots,m_q\});
  \]
- for each outcome \(\omega\), a total, typed result combiner
  \[
    h_{q,\omega}:
    \prod_{j\in C_q(\omega)}\mathcal D_{c_{q,j}}
    \longrightarrow\mathcal D_q,
  \]
  whose arguments occur in increasing case-position order.

This separates *selector outcomes* from raw selector values. Examples:

- A finite indexed select has one outcome per case plus a default outcome;
  each outcome observes one case root.
- A priority select has one outcome per winning position plus a default.
- A one-hot select may use the enabled-case mask as its outcome and observe all
  enabled case roots. Its combiner is the typed join specified by the language.

The outcome must contain enough information to determine \(C_q(\omega)\). Two
raw selector values may share an outcome when they observe the same event and
case set. If the intended API distinguishes them, they must be separate
outcomes.

## Site and occurrence identity

Within one graph, a site is its graph-node identity. Substitution prefixes
internal sites with the component occurrence. Two calls to the same function
therefore have distinct sites such as \((\mathit{call}_1,q)\) and
\((\mathit{call}_2,q)\).

For statically finite iteration, occurrence identity includes the iteration
index. Unbounded recursion or loops would produce a potentially infinite event
domain and are excluded.

Identity is intensional. Graph rewrites may preserve ordinary values while
changing sites and observations.

## Caller domain

A caller constraint is a predicate

\[
A:\mathcal X_G\to\mathbb B.
\]

All coverage, feasibility, and completeness claims are relative to

\[
\mathcal X_A=\{x\in\mathcal X_G\mid A(x)\}.
\]

For open components, the observed output-root set is an additional parameter.
This is necessary for compositional summaries of multi-output graphs.
