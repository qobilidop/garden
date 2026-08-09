---
citekey: michelutti2024canonical
work:
  title: "Canonical Decision Diagrams Modulo Theories"
  author: "Massimo Michelutti, Gabriele Masina, Giuseppe Spallitta, Roberto Sebastiani"
  venue: "ECAI 2024"
  date: 2024
  doi: 10.3233/faia241007
  arxiv: "2404.16455"
read: full-text
source: "Author preprint arXiv:2404.16455v3; published version via https://doi.org/10.3233/FAIA241007"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Combines AllSMT theory lemmas with canonical Boolean decision-diagram compilation to give theory-canonical decision diagrams for a fixed atom universe — sharply limiting any claim that selection guards or stable configurations are canonical outside a fixed graph-relative instrumentation"
---

# Canonical Decision Diagrams Modulo Theories

## Evidence

### Why it matters

The work gives a precise, recent meaning to canonicity for SMT-level decision
diagrams. It sharply limits any claim that stable selection configurations or
guards are "canonical."

### Program and semantic model

The input is a theory formula over a fixed set of theory atoms. Its Boolean
abstraction is represented by an OBDD, SDD, or another decision-diagram form.
AllSMT supplies theory lemmas that eliminate theory-inconsistent Boolean
assignments before ordinary Boolean DD compilation.

### Main definitions

Definition 2 distinguishes Boolean canonicity, theory canonicity, and theory
semicanonicity under an explicit canonicity condition such as an ordered atom
list. Theory canonicity requires theory-equivalent formulas to produce the
same diagram under those conditions.

### Results and guarantees

Theorems 5–11 characterize sufficient theory-lemma sets and prove that a
canonical Boolean DD compiler produces theory-canonical diagrams after the
AllSMT refinement. The construction is theory- and DD-agnostic, subject to the
solver and compiler assumptions.

### Algorithm

Run AllSMT on the input formula, collect theory-valid clauses excluding every
theory-inconsistent assignment over the chosen atoms, conjoin the clauses to
the Boolean abstraction, and invoke an off-the-shelf canonical DD compiler.

### Complexity

The paper identifies up-front AllSMT and subsequent Boolean existential
quantification as bottlenecks and evaluates runtime empirically. It does not
remove the exponential worst case of total atom-assignment enumeration.

### Terminology

Use *canonical* only with an explicit equivalence, representation, atom set,
and ordering or vtree condition. Stable naming or deterministic traversal is
not logical canonicity.

### Motivating example

Two propositionally different formulas over arithmetic atoms can be
theory-equivalent. Ordinary Boolean DD compilation can distinguish them;
theory lemmas remove the inconsistent assignments that caused the difference.

### Evidence locations

- Introduction and contributions, pp. 1–2: AllSMT-plus-DD construction.
- Definition 2 and Theorems 3 and 5, pp. 3–4: canonicity notions.
- Definitions 3–4 and Theorems 6–11, pp. 4–6: theory-lemma construction and
  canonicity results.
- Section 4.2, pp. 7–8: scope and consequences of canonicity.
- Evaluation and conclusion, pp. 9–11: empirical costs and limitations.

## Bearing on RQs

Canonical theory decision diagrams can be built for a fixed atom universe by
combining AllSMT with a canonical Boolean DD representation.

A selection observation may be unique relative to a fixed graph, contextual
site naming scheme, caller constraint, and demand policy. It is not canonical
under graph rewrites or theory equivalence: equal extensional programs can
contain different observed sites.

It subsumes any broad canonicity claim about guarded theory partitions. It
does not preserve a graph-intensional observation unless selection atoms are
made explicit, at which point the result is canonical only relative to that
instrumentation and the DD conditions.

## Evidence limits

- The theory diagram is extensional over the chosen atoms; whether an atom
  denotes an active structural event is outside its semantics.
- Any paper use of "canonical selection trace" should be replaced by a
  graph-relative uniqueness statement.
