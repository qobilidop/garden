---
citekey: santelices2010dependencies
work:
  title: "Exploiting Program Dependencies for Scalable Multiple-Path Symbolic Execution"
  author: "Raul Santelices, Mary Jean Harrold"
  venue: "ISSTA 2010"
  date: 2010
  doi: 10.1145/1831708.1831733
read: full-text
source: "ISSTA paper via https://doi.org/10.1145/1831708.1831733, plus the author's dissertation chapter 4 for the extended algorithm and complexity discussion"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Symbolic program dependence computes path families only through control/data dependences affecting a requested reachability condition, represented as a shared graph of guarded case-like expressions — a close output/query-directed predecessor with large empirical family-count reductions over path counts, without a numbered soundness/completeness theorem"
---

# Exploiting Program Dependencies for Scalable Multiple-Path Symbolic Execution

## Evidence

### Why it matters

Symbolic program-dependence (SPD) is a close output/query-directed predecessor.
It computes path families only through control and data dependences that can
affect a requested reachability condition or variable set, and represents the
result as a shared graph of guarded, case-like symbolic expressions.

### Program and semantic model (RQ1, RQ7)

The method uses an interprocedural control-flow graph and interprocedural
control-dependence graph (ICDG) for imperative Java bytecode. A query supplies a
start statement `s`, target statement `t`, and variables `V` whose symbolic
values are wanted at `t`. Reaching definitions, control dependences, aliases,
calls, and dynamic contexts can all affect the result.

Exactness relies on sufficiently precise dependence, reaching-definition, and
alias information and on omitting the optional abstraction step. Cyclic
dependences can prevent termination. The implementation bounds ICDG edge-list
length at 10 and loop iterations at 2 by default, models libraries manually,
and uses CVC3.

### Enumerated object (RQ2–RQ3)

A *path family* is a triple `<s,t,E>`, where `E` is a nonempty set of valid
ICDG-edge lists connecting `s` to `t`. An edge list records only relevant
control-dependence outcomes, not every CFG edge. The path-family condition
(`PFC`) symbolically characterizes executions in that family. Infinite loop
families may be represented using regular expressions; interprocedural
families use context-free grammars.

Branches and definitions outside the backward dependence closure of `PFC(s,t)`
and `V` are omitted. Dynamic/contextual occurrences are retained where needed.

### Algorithm

`DoSPD` first obtains the initial edge lists and PFC between `s` and `t`, then
introduces pseudo-uses for requested variables. A workset contains pairs of a
use and the path family in which it must be explained. For each pair, the
algorithm:

1. optionally abstracts the use or PFC;
2. finds reaching definitions or identifies an input;
3. computes a definition-clear path family;
4. recursively expands uses in right-hand sides and path-family conditions; and
5. records the result in a shared use/path-family graph.

The graph induces `case`-like symbolic expressions. Repeated subexpressions can
be named as special variables to retain sharing. The optional abstraction
replaces deeper terms by a multivalued `*`, yielding an overapproximation.

### Guarantees (RQ4)

The exact mode is stated to compute the same requested result as traditional
symbolic execution while skipping irrelevant points and ICDG combinations.
The paper and dissertation chapter do not present a numbered semantic
soundness/completeness theorem for `DoSPD`; the same-result statement is an
algorithmic claim supported by definitions and evaluation. Abstraction is
explicitly underconstraining and overapproximating.

### Residuals, witnesses, and sharing (RQ5)

The output graph contains guarded symbolic values and explicit shared
subexpressions. Solver feasibility can supply models, but a canonical
witness-bearing family table is not the exposed object. SPD is particularly
important prior art for residual sharing and contextual branch outcomes.

### Complexity and performance (RQ6)

The dissertation states that worst-case SPD complexity is exponential in the
number of program points affecting `PFC(s,t)` or `V`, because the dependence
traversal is path-sensitive. It is claimed to be no worse than traditional
symbolic execution, while dependence analysis itself is polynomial. Cyclic
dependencies may make `DoSPD` diverge unless abstraction, closed forms, or loop
bounds intervene.

In the bounded evaluation, path-family construction was comparatively
negligible and family counts could be orders of magnitude below path counts.
For one Tcas query, traditional symbolic execution considered 2,520 paths and
SPD 71 families. For Schedule1, examples include 965,353 paths versus 338
families and 83,915,178 paths versus 1,695 families.

### Motivating example (RQ8)

In the running `addElem` example, a query for the final value `sz15` has twelve
ordinary paths but four final families, determined by the relevant outcomes
`<1F,4F>`, `<1F,4T>`, `<1T,4F>`, and `<1T,4T>`. Branches 6 and 11 are omitted
because they do not affect the requested result. This is direct precedent for
sparse output-relevant choice records.

### Evidence locations

- ISSTA Sections 3.1–3.5 and Figures 1, 3, and 4: path families, PFCs, the
  `addElem` example, `DoSPD`, and graph-shaped symbolic expressions.
- Dissertation Sections 4.2.2 and 4.2.4–4.2.6: formal objects, extended
  algorithm, expression sharing, complexity, and termination.
- ISSTA Section 4 / dissertation Section 4.4 and Table 4: bounded empirical
  path-family reduction.

## Bearing on RQs

What is directly established by the work: dependence-directed computation of
guarded path families and requested symbolic values, omission of irrelevant
branches, contextual occurrences, and shared graph-shaped residuals.

Our interpretation or inference: for pure acyclic dataflow graphs, a selection
observation may be a specialized and more canonical SPD edge-list family: its
sites are selected by an operational demand closure, and its guard is intended
to be the exact fiber of a deterministic partial-map observation.

Could it subsume our proposed contribution: it could subsume a broad
“query-directed dependence exploration” contribution. The paper does not
define one record per sparse observation, prove exact fiber
coverage/disjointness/uniqueness, or give compositional reusable subgraph
summaries. A research paper must establish one or more of those differences and
formally relate them to SPD rather than presenting the approach as wholly new.

## Evidence limits

- On a finite pure DAG, are SPD edge-list families extensionally identical to
  selection-observation fibers?
- Does SPD's dependence analysis retain infeasible or semantically redundant
  sites that selected-edge demand omits?
- Can the shared use/path-family graph be memoized compositionally across
  callers, or is it query-specific by construction?
