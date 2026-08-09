---
citekey: voogd2025compositional
work:
  title: "Compositional Symbolic Execution Semantics"
  author: "Erik Voogd, Åsmund Aqissiaq Arild Kløvstad, Einar Broch Johnsen, Andrzej Wąsowski"
  venue: "Theoretical Computer Science"
  date: 2025
  doi: 10.1016/j.tcs.2025.115263
read: full-text
source: "Author-hosted Theoretical Computer Science manuscript at https://ebjohnsen.org/publication/25-tcs/25-tcs.pdf"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Gives exact, mechanized compositional denotations of symbolic executions as substitution/path-condition pairs with generic composition equations; a selection-observation construction can be obtained by projecting and quotienting this denotation, so the survey's contribution must focus on the observation and enumeration mechanisms the paper leaves undefined"
---

# Compositional Symbolic Execution Semantics

## Evidence

### Why it matters

This is the strongest direct semantic subsumption result. It gives exact
compositional denotations of symbolic executions as substitutions paired with
path conditions, with mechanized correspondence to concrete execution.

### Program and semantic model

Finite traces contain assignments, tests, and sequential composition
(Definitions 1–2, p. 7). A substitution denotes a state transformer, and each
trace denotes `Sub(t), PC(t)` (Definitions 4 and 7, pp. 8 and 11). Programs add
nondeterministic choice and finite iteration; their concrete semantics maps a
state to a set of states (Definitions 8–11, pp. 13–15).

The symbolic denotation is exactly

\[
F_p=\{(Sub(t),PC(t))\mid t\in T_p\}.
\]

### Results and guarantees

- Theorem 1: exact concrete correspondence for an individual trace.
- Lemma 10: compositional equations for sequence, choice, and iteration.
- Theorem 2: correctness and completeness of the denotational symbolic
  semantics for non-aborted concrete outputs.
- Theorems 3–4: operational symbolic execution agrees with the denotation,
  modulo logical equivalence of path conditions.
- Theorems 5–6: weakest liberal and weakest preconditions derived from the
  symbolic denotation.

The main results are mechanized in Coq. The value domain and expressions are
total; iteration may make a program's trace set countably infinite. Aborted
traces are discarded and nontermination is represented by absence of an output.

### Complexity

The paper gives no asymptotic complexity analysis.

### Evidence locations

- Definitions 1–7 and Theorem 1, manuscript pp. 7–11: trace semantics.
- Definitions 8–12 and Lemma 10, pp. 13–17: program denotation and composition.
- Theorems 2–6, pp. 17–22: correctness, completeness, and predicate transformers.

## Bearing on RQs

Lower selectors to guarded commands and add ghost assignments for stable
site/outcome observations. Our cases then arise by projecting and quotienting
`F_p`; Lemma 10 already gives generic composition. Boundary-demand masks decide
which ghost observations survive the projection, a policy not defined by the
paper. Consequently exact compositional symbolic-path semantics is known; the
survey must focus on observation and enumeration mechanisms.

## Evidence limits

- No separate limits section in the source note; the paper gives no
  asymptotic complexity analysis (see ### Complexity above), and it does not
  define the boundary-demand masking policy our observation construction
  needs.
