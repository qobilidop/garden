---
citekey: hanus2021memoized
work:
  title: "Memoized Pull-Tabbing for Functional Logic Programming"
  author: "Michael Hanus, Finn Teegen"
  venue: "Functional and Constraint Logic Programming"
  date: 2021
  doi: 10.1007/978-3-030-75333-7_4
read: full-text
source: "arXiv v1 (27 August 2020) at https://arxiv.org/abs/2008.11999, metadata checked against the 2021 revised-selected-paper record at https://doi.org/10.1007/978-3-030-75333-7_4"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Memoized pull-tabbing's fingerprint is a partial map from stable choice identifiers to outcomes, populated on demand — the closest representational precedent for the partial-map shape and demand-prefix sparsity, though it is a nondeterministic search history, not a deterministic guard-induced observation with exact input fibers"
---

# Memoized Pull-Tabbing for Functional Logic Programming

## Evidence

### Why it matters

This is the closest representational precedent found so far. Its *fingerprint*
is exactly a partial map from stable choice identifiers to outcomes, populated
on demand while a graph computation is explored. We therefore cannot claim
the partial-map shape, stable shared choice decisions, or demand-prefix
sparsity as new in isolation.

### Program and semantic model

The setting is Curry under call-time choice. Expressions and shared actual
arguments are represented by heaps or term graphs, with update-in-place for
deterministic lazy computation. A pull-tab step moves a nondeterministic choice
through a function that demands the choice-bearing argument. Repeated
occurrences created from one choice retain its identifier so that every task
must select them consistently.

Evaluation maintains a set or queue of tasks. Each task has a graph root, a
unique task identifier, a parent-task history, and a fingerprint. A root choice
whose identifier is absent forks the task; a choice already present in the
fingerprint follows the recorded alternative.

### Main definitions

The paper's exact informal definition is central: a fingerprint is a **partial
mapping from choice identifiers to choice alternatives, Left or Right**. If a
root choice identifier is absent, the evaluator creates two tasks and extends
their fingerprints with the two decisions. If it is present, the recorded
branch is selected.

The domain is partial because a task records a choice only when pull-tabbing
has brought that choice to the root. This is a demand/search prefix, not a
minimal observation of the final value: the map can retain earlier decisions
that are no longer structurally relevant.

Memoized pull-tabbing (MPT) adds a different partial map to every function-call
node: its task-result map `tr : TaskID -> Node`. It stores branch-specific graph
results so a choice already fixed by the current fingerprint can be selected
locally without unsafely updating a node shared by other tasks. Owner-task and
ancestor lookup refinements allow safe in-place deterministic updates and reuse
of earlier task results.

Choice identity here is a dynamic runtime identity preserved across copies of
that choice. It is not a static identifier for a fixed source-graph selection
site across all concrete inputs or contextual invocations. A task-result map is
memoization state, not part of the observed choice assignment.

### Results and guarantees

Fingerprints enforce call-time-choice consistency: the worked `xorSelf`
evaluation produces only semantically legal results. The paper attributes the
theoretical correctness and operational completeness of pull-tabbing to Antoy
2011. It argues that MPT keeps flexible, operationally complete search and the
positive properties of pull-tabbing, but it does not state and prove a numbered
soundness or completeness theorem specifically for MPT.

Breadth-first and depth-first task scheduling are both implemented. The phrase
“operationally complete strategies” describes strategies under which an
existing value is eventually computed; the paper does not prove that every
queue discipline is fair. It also gives no theorem of nonredundant result or
fingerprint enumeration. Different choice identifiers can lead to the same
value, so fingerprints are not canonical output classes.

For a finite graph under fair exhaustive task processing, fingerprints can be
viewed as consistent cylinders of nondeterministic resolutions. That statement
is our inference, not a theorem formulated in the paper, and it still says
nothing about inverse images of concrete program inputs.

### Algorithm

Pure pull-tabbing moves every demanded occurrence of a shared choice to the
root, then discards inconsistent copies using fingerprints. MPT pull-tabs the
first occurrence. After the root split, each descendant task's fingerprint
already selects that choice, so later occurrences select the branch locally and
store any result in the parent function node's task-result map. Task ownership
determines when updating in place is safe; ancestor lookup permits reuse along
the task tree. Deterministic subcomputations can consequently be shared across
nondeterministic branches.

### Complexity

For a function body containing `n` demanded occurrences of a shared argument,
each at depth `d`, the paper estimates approximately `n*d` pull-tab steps for
pure pull-tabbing. MPT performs `d` pull-tab steps and `n-1` local selection
steps for each of the two child tasks. This is a local cost calculation, not a
global or output-sensitive enumeration theorem.

The prototype has small deterministic overhead (`nrev`: 2.37 s MPT versus
2.29 s pure pull-tabbing) and large gains on shared nondeterminism (`addNum5`:
1.61 s versus 47.69 s; `select100`: 0.18 s versus 111.47 s). It also demonstrates
sharing across nondeterminism (`sort2`: 9.84 s MPT versus 155.64 s
backtracking). No asymptotic bound is given for total task count, fingerprint
size, task-result-map storage, or delay between outputs.

### Terminology

Established terms include *fingerprint*, *choice identifier*, *task*, *task
identifier*, *task-result map*, *owner task*, *pull-tabbing*, *memoized
pull-tabbing*, *sharing nondeterminism*, *sharing across nondeterminism*, and
*operationally complete search strategy*. We should use “fingerprint” when
discussing this runtime search object, but retain a separate term such as
*selection observation* for our deterministic graph-relative object.

### Motivating example

The paper again uses `xorSelf aBool`: a shared nondeterministic Boolean is
consumed twice, and copied choices must agree. Fingerprints `[1/L]` and `[1/R]`
both yield only `False`. A second generic example, `f x = C[x,...,x]`, isolates
the `n*d` repeated-pull-tab cost and motivates memoization. The appendix gives
an especially useful cautionary example: globally updating a shared node after
a task-local choice decision loses a result, proving that branch-specific state
cannot be implemented by an ordinary global heap update.

### Evidence locations

- Sections 1–2, arXiv pp. 1–4: call-time choice, sharing, heaps, and tasks.
- Section 3, pp. 4–6: pull-tabbing, exact fingerprint definition, `xorSelf`,
  operational-completeness attribution, and the `n*d` cost problem.
- Sections 4.1–4.2, pp. 6–9: task identifiers, task-result maps, MPT, the
  `d` plus per-task selection cost, ownership, and ancestor reuse.
- Section 5, pp. 9–10: graph-node and task-queue implementation.
- Section 6 and Tables 1–3, pp. 10–12: performance and search-strategy results.
- Sections 7–8, pp. 12–15: relationship to demand analysis, claimed runtime
  properties, limitations, and future work.
- Appendix A, pp. 16–17: unsoundness of globally applying task-local selected
  choices.

## Bearing on RQs

What is directly established by the work: the work explicitly uses sparse
partial maps from choice identifiers to binary outcomes, extends them only
when a demanded choice reaches the root, preserves decisions across copied
occurrences, and uses per-task memoization to avoid repeated graph work. These
are direct precedents for the *shape* and runtime engineering of our
observation.

Our interpretation or inference: instrumenting a deterministic selection as a
choice-like node with a stable site identifier could reuse this implementation
pattern: lazy evaluation would record the input guard's actual outcome only
when the selection is demanded, and sharing would reuse that outcome. But that
interpretation changes the node from nondeterministic search to deterministic
guard observation.

To obtain our proposed theorem, a separate proof must establish all of the
following:

1. the identifiers encountered by root evaluation are exactly the selections
   in the graph-relative enabled closure;
2. identity remains stable under sharing and contextual invocation;
3. the conjunction of recorded local guard outcomes entails the same enabled
   closure, including the absence of further observed selections;
4. an observed selection is recorded even when its alternatives happen to have
   equal values; and
5. the resulting input guards are exact, exhaustive, and pairwise-disjoint
   inverse images, with correct residual symbolic functions.

None of these deterministic input-fiber obligations follows merely from the
fingerprint mechanism.

Could it subsume our proposed contribution: it subsumes any claim that a
demanded graph computation can be summarized by a partial map from stable
shared choice identifiers to outcomes. It does not define guard predicates
over concrete inputs, a root-relative enabled closure, exact local-guard
fibers, full-fiber blocking, residual DAGs, or compositional and
output-sensitive bounds. The defensible novelty boundary is therefore the
deterministic guard-induced observer and its exact fiber/composition theory,
not the sparse partial-map representation itself.

## Evidence limits

- The detailed reading used arXiv v1; the DOI identifies a later 2021 revised
  selected paper, whose full text was not accessible in this environment.
- MPT's claimed preservation of pull-tabbing properties is experimentally and
  operationally argued rather than presented as a standalone formal theorem.
- Fingerprints are task histories, not minimized observations or canonical
  equivalence-class representatives.
- The paper itself leaves integration with the 2012 static demand optimization
  as future work because sufficiently precise demand analysis for complex data
  is difficult.
