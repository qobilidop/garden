---
citekey: godefroid2007compositional
work:
  title: "Compositional Dynamic Test Generation"
  author: "Patrice Godefroid"
  venue: "POPL 2007"
  date: 2007
  doi: 10.1145/1190215.1190226
read: full-text
source: "Author-hosted revised POPL 2007 PDF: https://patricegodefroid.github.io/public_psfiles/popl2007.pdf"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "SMART builds reusable per-function precondition/postcondition summaries and reuses them at calls, refuting any claim that demand-driven compositional symbolic execution avoiding interprocedural path products is new — though it does not quotient by an observation map"
---

# Compositional Dynamic Test Generation

## Evidence

### Why it matters

SMART is a direct antecedent for demand-driven, reusable symbolic summaries.
It refutes any broad claim that avoiding interprocedural path products through
on-demand component analysis is new.

### Program and semantic model

The paper uses an imperative RAM-level language. A concrete execution is a
finite word of assignments and conditions ending in abort or halt; executions
form a tree. DART carries a concrete memory, symbolic memory, and path
constraint simultaneously (Section 2, pp. 2–3 of the revised version).

### Main definitions and algorithm

For each function `f`, SMART builds a summary

\[
\phi_f=\bigvee_w(pre_w\land post_w).
\]

Inputs are addresses read by the function; outputs are addresses written by it
and subsequently read by its caller. At a call, SMART asks whether the current
calling context implies the disjunction of known summary preconditions. If it
does, the summary is conjoined and the call is treated as a black box. If it
does not, execution descends into the callee and extends the summary (Sections
3.1–3.3, pp. 3–5; Figure 2).

### Results and guarantees

- Theorem 1 gives DART's bug soundness and conditional path coverage.
- Theorem 2 gives SMART the same path coverage as DART when generated
  constraints belong to a decidable theory.
- Theorem 3 gives SMART bug soundness and its clean-termination guarantee.

The presentation assumes terminating executions and an acyclic call graph,
while noting that standard interprocedural techniques can lift the latter.
Unsupported expressions are concretized and make completeness conditional.

### Complexity

Section 3.5 argues that if each of `n` functions has at most `b` paths, SMART
considers at most `nb` directed paths whereas flat DART may consider
exponentially many combinations. Summary size is linear in `b`, although
satisfiability may remain exponential. This is an informal asymptotic argument,
not a polynomial-runtime theorem.

### Motivating example

The `is_positive` example shows how separate pre/post cases summarize a
function and are reused at calls, motivating a survey example that contrasts
path summaries with observation-fiber summaries.

### Evidence locations

- Sections 2 and 3.1–3.3, revised-version pp. 2–5: execution and summaries.
- Theorems 1–3 and Section 3.5, revised-version p. 6: guarantees and complexity.

## Bearing on RQs

Observed selections can be encoded as ghost outputs in SMART summaries. SMART
does not quotient multiple paths by a sparse output-observed selection map, nor
does it enumerate distinct observation fibers or analyze complexity in their
number. Demand-driven compositional symbolic execution is nevertheless known.

## Evidence limits

Read at full-text level from the author-hosted revised POPL 2007 PDF; the note
records no limitations beyond the scope distinction already given in Bearing
on RQs above.
