# Composition and demand-parametric summaries

## Why output demand is an interface parameter

A component with several output ports may expose different internal selection
sites depending on which outputs a caller observes. A compositional summary
must therefore take an output-root set as an argument. Summarizing every output
unconditionally over-observes a component used through only one output.

For a component \(G:X\to Y\), define its semantic interface

\[
\Sigma_G(x,R)=
(\operatorname{val}_G(x),\delta_G(x,R),T_G(x,R)),
\]

where \(R\subseteq Y\) is the demanded output set and

\[
\delta_G(x,R)=I_G\cap D_G(x,R)
\]

is the demanded input-port set. Returning all output values is harmless under
total eager value semantics; \(\delta\) and \(T\) describe the separate
structural observation.

## Sequential composition

Let \(G:X\to Y\) and \(H:Y\to Z\), with disjoint site namespaces. For input
\(x\) and demanded outputs \(R\subseteq Z\), let

\[
y=\operatorname{val}_G(x),
\qquad
(z,S,\tau_H)=\Sigma_H(y,R),
\]

and

\[
(-,D,\tau_G)=\Sigma_G(x,S).
\]

Then

\[
\Sigma_{H\circ G}(x,R)
=(z,D,\iota_G(\tau_G)\sqcup\iota_H(\tau_H)),
\]

where \(\iota_G\) and \(\iota_H\) inject sites into disjoint contextual
namespaces.

### Exact-composition theorem

The equation above equals the whole-graph enabled-edge semantics of the
substituted composite.

*Proof sketch.* Reachability inside \(H\) determines exactly which of its input
ports are reached. Substitution replaces each such port by the corresponding
root of \(G\), so the composite reaches exactly \(D_G(x,S)\) inside \(G\). No
other \(G\) node is reached. Site namespaces are disjoint, and each side's
outcomes are fixed by the same eager values used in the flattened graph.

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

If inputs and output-demand masks have a decidable symbolic representation,
the fibers of \(\Sigma_G\) form a finite guarded relation. Composing guarded
summaries amounts to:

1. substitute \(G\)'s residual output into \(H\)'s guards;
2. use each \(H\) case's boundary-demand set \(S\) to select the matching
   demand-parametric cases of \(G\);
3. conjoin guards;
4. discard infeasible conjunctions; and
5. union namespaced observations and compose residual values.

Relational composition gives exact agreement with the semantic theorem. It may
still form a large cross-product before feasibility pruning; no output-sensitive
advantage is established.

## Algebraic interpretation

Ordinary operators combine independent computations. A selection first
computes a selector and conditionally observes case computations. Logging the
site outcome before conditional composition interprets the graph in a reader of
concrete inputs combined with an idempotent writer of site-outcome events.

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

is the coarsest input equivalence preserving the declared observation, but that
is the kernel of a function and is tautological. Full abstraction for a context
language with a primitive that directly reads site events is likewise obtained
by construction.

No non-tautological minimality, free, or full-abstraction theorem beyond
selective-functor interpretation is currently established. This is the main
failed condition for the original-paper route.
