# copia2023precise — Precise Lazy Initialization

- **Status:** deep-read; high-priority demand-driven heap predecessor
- **Primary source:** https://doi.org/10.1109/ISSRE59848.2023.00080
- **Version read:** ISSRE 2023 paper, pp. 752--762
- **Bibliography key:** `copia2023precise`

## Why it matters

Precise Lazy Initialization (PLI) closes LISSA's feasibility gap by deciding
whether the symbolic heap and the primitive program path condition have a
common bounded completion. Its theorem proves preservation of exactly the
feasible symbolic states explored by ordinary lazy initialization. This is
strong prior work for joint feasibility pruning during demand-driven symbolic
execution.

## State and algorithm

A PLI symbolic state is a pair $(\mathit{symH},\mathit{pathCond})$. The
precondition is split into a heap-structural executable predicate
$pre_H$ and a primitive predicate $pre_P$. For each candidate heap generated
by SymSolve for $pre_H$, PLI:

1. extracts equalities for concretized primitive fields;
2. checks their conjunction with the current program path condition by SMT;
3. symbolically executes $pre_P$ from that conjunction; and
4. returns a concrete-heap/path-condition witness if some precondition path
   succeeds.

If all candidate heaps fail, the symbolic state is pruned. The implementation
reuses a parent's witness when a new primitive branch or lazy heap assignment
does not invalidate it.

## Formal guarantee

Theorem 1 states, for a program, precondition, and finite scopes, that a
symbolic state feasible with respect to the precondition is explored by LI iff
it is explored by PLI. Soundness follows because exhausting every bounded heap
candidate and every symbolic path through $pre_P$ can reject only a state with
no joint witness. Completeness follows because PLI traverses LI's tree and
only removes infeasible states.

The direction labels in the prose use *soundness* for “PLI does not prune a
feasible LI state” and *completeness* for “PLI introduces no state outside
LI”; the biconditional is the reliable formal statement.

This theorem concerns feasible symbolic-execution states, not uniqueness,
disjointness, or maximality of their concretizations. PLI can visit many states
that correspond to the same coarser observation.

## Complexity boundary

The bounded heap candidates can grow exponentially with scope, and the
precondition itself is symbolically executed for candidates. PLI reduces paths
by avoiding eager over-concretization and reports fewer paths than competitors
on most subjects, but gives no output-polynomial or polynomial-delay
enumeration bound. Its experimental output is feasible paths and concrete test
inputs, not observer equivalence classes.

## Relationship to selection observations

PLI provides a directly reusable oracle contract for finite heap encodings:

\[
  \operatorname{Feasible}(p)
  \iff
  \exists x\in\gamma(p).\;pre(x)\land path_p(x).
\]

Our prefix feasibility question has the same existential shape. What is not
provided by PLI is an extensional key that says when two feasible executions
belong to the same result-relative graph observation. PLI follows imperative
program branches and field accesses; it neither omits selector sites outside a
requested enabled closure nor aggregates all states sharing the same partial
site-outcome map into an exact fiber with one residual.

Thus PLI defeats a broad claim of first exact on-demand symbolic exploration
with joint solver pruning. It does not subsume a theorem about enumerating the
image and inverse images of the selection-observation function.

## Evidence locations

- Sections I--II, paper pp. 752--755: motivation, symbolic-state model, and
  LISSA's separation problem.
- Section III and Algorithm 1, pp. 755--758: joint candidate-heap, SMT, and
  symbolic-precondition solver.
- Section III-E, pp. 758--759: Theorem 1 and proof sketch.
- Sections IV--V, pp. 759--761: empirical path/runtime results and exponential
  candidate-space discussion.

