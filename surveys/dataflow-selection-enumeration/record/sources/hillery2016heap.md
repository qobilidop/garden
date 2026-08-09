---
citekey: hillery2016heap
work:
  title: "Exact Heap Summaries for Symbolic Execution"
  author: "Benjamin Hillery, Eric Mercer, Neha Rungta, Suzette Person"
  venue: "VMCAI 2016"
  date: 2016
  doi: 10.1007/978-3-662-49122-5_10
read: full-text
source: "Author-hosted full text (pp. 1-20) via https://doi.org/10.1007/978-3-662-49122-5_10"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "A stronger lazy-initialization predecessor for exact guarded heap values, with a bisimulation proof that its symbolic transition system matches generalized symbolic execution's control-flow sequences exactly; its observer is program-exposed heap aliasing, not requested contextual sites in a pure dataflow graph"
---

# Exact Heap Summaries for Symbolic Execution

## Evidence

### Evidence locations

- Introduction and symbolic-initialization rules: one guarded value set in one
  symbolic heap represents null, fresh-object, alias, and uninitialized cases
  without the case split performed by generalized symbolic execution (GSE).
- Theorem 12 and Corollaries 13--14: a bisimulation proves that the symbolic
  transition system has exactly the GSE control-flow sequences and one final
  symbolic state per such sequence.
- Evaluation: the representation covers exactly the same feasible control-flow
  paths while substantially increasing the bounded heaps analyzed on the
  reported list and tree subjects.

## Bearing on RQs

This is a stronger predecessor than ordinary lazy initialization for exact
guarded heap values: alternatives are summarized before they induce paths,
with a semantic equivalence proof.

## Evidence limits

- Its observer is heap aliasing as exposed by program control, not requested
  contextual sites in a pure dataflow graph, and its output is a final heap
  state rather than one exact caller-input fiber per selection observation.
