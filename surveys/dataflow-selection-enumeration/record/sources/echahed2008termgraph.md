# echahed2008termgraph — Inductively Sequential Term-Graph Rewrite Systems

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-540-87405-8_7
- **Version read:** ICGT 2008 proceedings version
- **Bibliography key:** `echahed2008termgraph`

## Why it matters

The work shows that neededness results for trees do not transfer automatically
to graphs with sharing, cycles, and pointer redirection. It supplies an
important boundary for any claim about graph-sensitive relevance.

## Program and semantic model

The model is a many-sorted rooted term graph with operation and variable nodes,
sharing, and cycles. Rewrite rules match a rooted graph and execute node
definitions and pointer redirections (Definitions 1–8, pp. 85–90).

Graph definitional trees add `share.branch` nodes that distinguish separate
from collapsed/shared nodes (Definition 9 and Proposition 1, pp. 90–92).
Definition 12 calls a node needed when every derivation to a constructor normal
form eventually rewrites a descendant of that node at its root (p. 93).

## Results and assumptions

Strategy `Phi` follows a definitional tree to choose a redex (Definition 11).
Proposition 2 shows that ordinary tree conditions are insufficient: the
strategy may diverge, return a non-needed node, or be undefined despite an
existing constructor normal form (pp. 93–94).

Under the restrictions of Definition 13, Proposition 3 and Section 3's Theorem
1 make a returned redex outermost and needed, and undefinedness implies that no
constructor graph is reachable. Additional admissibility restrictions yield
closure and confluence up to node renaming (Proposition 4 and Section 4's
separately numbered Theorem 1, pp. 95–96).

The paper gives no asymptotic analysis; unrestricted strategy nontermination is
an explicit negative result.

## Relationship to our hypothesis

Neededness universally quantifies over normalizing rewrite derivations from one
graph. A selection observation records deterministic outcomes for one input
and requested result. The rewrite model permits mutation, cycles, and
identity tests, and its confluence intentionally erases derivational
differences. It provides no symbolic guards, input partition, residual, or
witness enumeration.

## Evidence locations

- Definitions 1–9 and Proposition 1, pp. 85–92: graph and definitional trees.
- Definitions 11–13 and Propositions 2–3, pp. 92–94: neededness and strategy.
- Section 4, pp. 95–96: admissibility and confluence.
