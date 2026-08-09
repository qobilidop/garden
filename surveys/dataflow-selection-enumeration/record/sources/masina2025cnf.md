---
citekey: masina2025cnf
work:
  title: "On CNF Conversion for SAT and SMT Enumeration"
  author: "Gabriele Masina, Giuseppe Spallitta, Roberto Sebastiani"
  venue: "Journal of Artificial Intelligence Research"
  date: 2025
  doi: 10.1613/jair.1.16870
read: full-text
source: "Author preprint via https://doi.org/10.1613/jair.1.16870 (arXiv:2303.14971v7), matching the 2025 JAIR title and theorem structure"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Shows that ordinary CNF conversion (Tseitin) can fragment one short verifying partial assignment into many projected assignments, and that NNF plus Plaisted–Greenbaum preserves them — a required encoding baseline and warning for any activation/outcome instrumentation handed to projected AllSMT"
---

# On CNF Conversion for SAT and SMT Enumeration

## Evidence

### Why it matters

This paper shows that a solver encoding can split one short satisfying partial
assignment into many longer projected assignments even though the encoding is
equisatisfiable and has linear size. It is therefore a direct warning for any
claim that a straightforward activation/outcome encoding preserves the compact
observation partition operationally.

### Formula and output model

Formulas are Boolean or quantifier-free theory formulas represented as rooted
DAGs. A partial truth assignment `mu` propositionally satisfies `phi` when the
residual `phi|mu` simplifies to true. It is minimal when no strict
sub-assignment has this property. This notion is syntactic verification, not
logical entailment for a generic non-CNF formula (Section 2.1, pp. 3–5).

For a formula `phi`, `TA(phi)` is a set of satisfying partial assignments such
that every total satisfying assignment extends some member. In the disjoint
case, every pair assigns opposite values to at least one atom. Projected
enumeration of a CNF `psi(A,B)` returns assignments on relevant atoms `A` for
`exists B. psi`, with `B` serving as fresh or otherwise irrelevant atoms
(Section 2.2, pp. 6–7).

### Main results and guarantees

Fact 1 states that a partial assignment satisfying `phi` need not satisfy
`exists B. CNF_Ts(phi)`. Tseitin label equivalences can force the enumerator to
assign original atoms in subformulas that the original partial assignment left
irrelevant. Plaisted–Greenbaum conversion mitigates but does not eliminate the
problem when a subformula occurs with both polarities (Section 3, pp. 8–11).

Lemma 1 proves that conversion to negation normal form has size linear in the
input when formulas are DAGs: positive and negative versions of a subformula
are shared rather than tree-expanded (Section 2.1, pp. 4–5).

Theorem 1 proves that if `mu_A` propositionally satisfies `phi`, then `mu_A`
also propositionally satisfies `exists B. CNF_PG(NNF(phi))`. Its constructive
proof assigns a positive or negative label according to whether the
corresponding residual is true, false, or undecided. The result applies to SAT
and SMT and to disjoint and non-disjoint enumeration, independently of the
enumeration algorithm (Section 4, pp. 11–13).

The theorem preserves every *verifying* partial assignment through the
encoding. It neither says that a generic solver will discover the favorable
label assignment nor converts logically entailing but non-verifying partial
assignments into verifying ones. The authors explicitly state that current
enumerators may choose a different total label assignment and therefore have
no formal guarantee of obtaining the best minimization (Section 4, p. 15).

### Algorithm and empirical scope

The baseline projected procedure finds a total model, minimizes only relevant
atoms while retaining a total label assignment, blocks the projected cube, and
continues. One minimization step is stated to take
`O(number-of-clauses * number-of-variables)` (Algorithm 1, pp. 6–7).

The evaluation compares Tseitin, Plaisted–Greenbaum, and
`NNF + Plaisted–Greenbaum` encodings using MathSAT, TabularAllSAT, and
TabularAllSMT on synthetic Boolean and LRA formulas, ISCAS'85 circuits, AIGs,
and weighted-model-integration instances. The proposed encoding generally
reduces both output size and runtime, sometimes by orders of magnitude
(Section 5, pp. 15–22). The evidence is empirical; there is no OutputP, IncP,
or polynomial-delay theorem.

The paper reports no expected benefit for solvers that emit total or
nearly-total assignments. Its experiments with projected d-DNNF compilation
showed little output-size benefit and worse runtime, attributed to branching,
extra labels, caching, and partitioning behavior (Section 5.5, pp. 22–23).

### Motivating examples

Examples 1–3 use a seven-atom formula with a conjunction in one disjunct and a
nested equivalence in the other. The short original assignment
`{not A3, not A4, not A7}` verifies the formula. Tseitin conversion can require
nine projected assignments to cover that region; Plaisted–Greenbaum can require
three; `NNF + Plaisted–Greenbaum` again permits the single original assignment
(pp. 8–14).

### Evidence locations

- Section 2.1, pp. 3–5: partial satisfaction, minimality, DAG size, and NNF.
- Section 2.2 and Algorithm 1, pp. 6–7: projected enumeration contract and
  minimization cost.
- Fact 1 and Examples 1–2, pp. 8–11: Tseitin and Plaisted–Greenbaum
  fragmentation.
- Theorem 1 and Example 3, pp. 11–15: preservation by
  `NNF + CNF_PG` and the implementation limitation.
- Section 5, pp. 15–22: evaluation design and results.
- Section 5.5, pp. 22–23: boundaries for solving, counting, and d-DNNF.

## Bearing on RQs

What is directly established by the work: for verification-based partial
SAT/SMT enumeration, a common linear CNF conversion may introduce artificial
output fragmentation. NNF preprocessing followed by Plaisted–Greenbaum
conversion preserves each verifying partial assignment without adding
original-atom decisions.

Our interpretation or inference: the same risk applies if a non-CNF
activation/outcome instrumentation is handed to projected AllSMT: fresh
encoding labels can cause several cubes for one semantic observation region.
`NNF + CNF_PG` is therefore a required encoding baseline when comparing cube
enumeration, but it does not define the semantic observation.

Our enumerator instead obtains a complete graph-relative observation from one
model and blocks its exact input fiber. That construction does not depend on a
solver returning a shortest verifying cube. Conversely, a short cube produced
by this paper's methods can omit an active observation coordinate and cover
several selection observations. Logical don't-care remains different from
structural inactivity.

Could it subsume our proposed contribution: it subsumes the claim that a
better CNF conversion can preserve compact verification-based partial
assignments. It does not provide output-demanded selection semantics, exact
one-record-per-observation fibers, residual program values, modular
composition, or a theorem that a generic enumeration run emits one cube per
structural observation.

## Evidence limits

- The paper's `propositionally satisfies` relation is verification. The
  companion semantic analysis in `sebastiani2025entailment` shows that this is
  strictly stronger than entailment outside native tautology-free CNF.
- The theorem establishes existence of a favorable extension over fresh labels,
  not that a solver's search and minimization heuristic will choose it.
- Linear encoding size and fewer empirical outputs do not imply an
  output-sensitive total-runtime bound.
