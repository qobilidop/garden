# hillery2016heap — Exact symbolic heap summaries

- **Status:** deep-read; exact guarded-heap comparator
- **Primary source:** https://doi.org/10.1007/978-3-662-49122-5_10
- **Version read:** author-hosted full text, pp. 1--20
- **Bibliography key:** `hillery2016heap`

## Evidence locations

- Introduction and symbolic-initialization rules: one guarded value set in one
  symbolic heap represents null, fresh-object, alias, and uninitialized cases
  without the case split performed by generalized symbolic execution (GSE).
- Theorem 12 and Corollaries 13--14: a bisimulation proves that the symbolic
  transition system has exactly the GSE control-flow sequences and one final
  symbolic state per such sequence.
- Evaluation: the representation covers exactly the same feasible control-flow
  paths while substantially increasing the bounded heaps analyzed on the
  reported list and tree subjects.

## Relationship and evidence limit

This is a stronger predecessor than ordinary lazy initialization for exact
guarded heap values: alternatives are summarized before they induce paths, with
a semantic equivalence proof. Its observer is heap aliasing as exposed by
program control, not requested contextual sites in a pure dataflow graph, and
its output is a final heap state rather than one exact caller-input fiber per
selection observation.
