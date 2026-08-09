---
citekey: li2014zequivalent
work:
  title: "Scaling Up Symbolic Analysis by Removing Z-Equivalent States"
  author: "Yueqi Li, S. C. Cheung, Xiangyu Zhang, Yepang Liu"
  venue: "ACM Transactions on Software Engineering and Methodology"
  date: 2014
  doi: 10.1145/2652484
read: full-text
source: "Accepted TOSEM manuscript via https://cse.hkust.edu.hk/~scc/ScalingSymbolicAnalysis.pdf; metadata checked against the published article at https://doi.org/10.1145/2652484"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Z-equivalence quotients symbolic states by caller-observable behavior at function-return boundaries, provably preserving feasibility and validity — a strong precedent for caller-observational quotienting that nonetheless erases exactly what a graph-intensional selection observation retains"
---

# Scaling Up Symbolic Analysis by Removing Z-Equivalent States

## Evidence

### Why it matters

Z-equivalence is a strong precedent for quotienting symbolic states by what a
caller can observe rather than by path history or literal formula identity. It
is weaker than logical equivalence, yet the paper proves that equivalent states
have the same feasible continuations and the same satisfiability and validity
answers. The implementation removes redundant states at function-return
boundaries using a sound, incomplete, linear-time recognizer.

This is not a selection-observation construction: it intentionally erases
internal distinctions that our graph-intensional observer retains. It is
nonetheless critical to any claim that caller-observational state quotienting
or future-equivalent component results are new.

### Program and analysis model

The formal presentation uses a first-order imperative language with integer
and Boolean expressions, assignments, conditionals, calls, returns, and an
`unknown()` expression for external functions. The implementations extend KLEE
for C/LLVM and a custom Sym-JVM engine for Java, including heap objects,
pointers, arrays, and external/native APIs.

The executor remains path-sensitive. It explores all paths within a callee
before resuming the caller and compares states at return instructions. Paths
within the same invocation share the caller precondition, stack, parameters,
and incoming heap, so the comparison can focus on changes made by the callee.

At a function boundary, variables are classified as:

- **observable:** parameters, the return value, globals, and fields reachable
  through pointer parameters; or
- **unobservable:** fresh symbols introduced while analyzing the callee and
  its callees, including local variables and values standing for external
  APIs.

The boundary is pragmatic rather than maximally semantic. The paper notes that
a forward analysis could classify more variables as unobservable.

### Formal equivalence

Let \(\phi\) and \(\psi\) be Boolean state constraints. Let \(\vec\beta\) be
the union of their observable variables and let \(\vec\alpha_\phi\) and
\(\vec\alpha_\psi\) be disjointly renamed vectors of their unobservable
variables. Definition 1 states:

\[
\phi\approx_z\psi
\quad\Longleftrightarrow\quad
\begin{aligned}
&\forall\vec\beta\,\forall\vec\alpha_\phi\,
  \exists\vec\alpha_\psi.\;\phi=\psi,\\
{}\land{}&\forall\vec\beta\,\forall\vec\alpha_\psi\,
  \exists\vec\alpha_\phi.\;\phi=\psi.
\end{aligned}
\]

Here equality compares the Boolean outcomes of the two constraints. An
equivalent restatement is that for every fixed observable valuation, the set
of truth values attainable by varying hidden variables is the same for both
constraints. This restatement is our interpretation of the quantified
definition.

Z-equivalence is consequently sensitive to both satisfiability and
falsifiability. Merely existentially projecting hidden variables would not
preserve enough information for the paper's validity results.

### Guarantees

The paper states the following results, with proofs delegated to its 2013
technical report.

- **Theorem 1:** \(\approx_z\) is reflexive, symmetric, and transitive.
- **Theorem 2:** logical equivalence implies z-equivalence, while the converse
  need not hold.
- **Theorems 3--4:** if two states are z-equivalent, conjoining the same
  subsequent-path constraint preserves satisfiability and unsatisfiability,
  provided that constraint cannot mention either state's hidden variables.
  Under the same exploration strategy, the two states therefore induce the
  same feasible continuation paths.
- **Theorems 5--6:** validity of a subsequent property is preserved in both
  directions.

Thus discarding all but one state in a z-equivalence class does not add
analysis imprecision beyond the executor's pre-existing approximation of
external APIs. With unbounded resources, reduced and unreduced executions have
the same coverage, warnings, and true/false-positive behavior under the stated
model.

### Sound linear recognizer

Exact z-equivalence is undecidable over first-order logic because its
definition alternates universal and existential quantifiers over possibly
infinite domains. The paper also states that even a Boolean-only instance
requires exponential computation in general.

Its practical recognizer therefore proves only a subset of z-equivalences.
There are two phases.

#### Flexible expression analysis

For a set of disjoint constraint-AST subexpressions, local hidden variables
occur only within the set; non-local hidden variables also occur elsewhere.
The set is *unconstrained* when, after fixing all observable and non-local
hidden variables, any type-correct vector of desired subexpression values can
still be obtained by choosing the local hidden variables.

The algorithm classifies operators by how flexible operands and results can be
solved, then annotates AST nodes as flexible (`F`), inflexible (`I`), or
undecided (`?`). Six monotone rules propagate flexibility and add ordering arcs
that witness a valid valuation order. At the fixed point, maximal subtrees
rooted at `F` nodes are called flexible abstract-syntax subtrees (`FAST`s).

- **Lemma 1:** the constructed partial valuation order has a conforming
  sequence.
- **Theorem 7:** the expressions represented by the resulting FASTs form an
  unconstrained set.
- **Theorem 8:** the fixed-point FAST set is independent of rule-application
  order.

#### State-constraint unification

An adapted first-order unifier compares two constraint ASTs top down. It may
alpha-rename unobservable variables and unify two syntactically different
FASTs, while observable variables, ordinary operators, and constants must
match according to the published rules. Successful unification implies
z-equivalence, after which only one return state is continued.

The recognizer is sound but incomplete. Tightly coupled occurrences of hidden
variables can prevent the rules from finding an unconstrained set even when
one exists.

### Complexity and performance

Each AST node changes to flexible and enters the worklist at most once, and
removal processing is constant time under the paper's data structures.
Flexible-expression annotation is therefore linear in the constraint AST
size. Together with structural unification, the paper describes the practical
z-equivalence test as linear.

This is a per-test syntactic bound, not an output-sensitive bound on the whole
symbolic analysis. Comparing a new return state against previously retained
representatives and constructing the symbolic states can still multiply the
cost; the paper does not provide a global asymptotic bound in the number of
paths or equivalence classes.

Across Ant, Lucene, Hadoop, and twenty Linux-kernel modules, the multiplicity
metric reports average in-memory state reductions of 15 orders of magnitude
for the Java subjects and 10 orders for the kernel modules. Under a 24-hour
budget, the z-equivalence strategy represents roughly seven orders of
magnitude more explored states on average. Equivalence detection consumed 24%
of Sym-JVM time and 6% of KLEE time; instruction-throughput degradation was
4.1% and about 1%, respectively. These enormous reductions are multiplicity
estimates over represented paths, not directly allocated state counts for an
unreduced run, which would be infeasible.

### Motivating example

The running program reads from either a file or a socket. Loops call external
`hasNext` and `nextInt` operations, modeled by fresh unconstrained symbols. Two
paths may return constraints such as

\[
RET=y_1
\qquad\text{and}\qquad
RET=y'_1+y_2.
\]

Although the formulas and loop histories differ, the hidden symbols can be
chosen so that either return expression attains every integer value attainable
by the other. The caller cannot distinguish the states. The first reduction
turns six callee paths into four return cases; a later return-boundary reduction
uses the fact that a local `type` value is also unobservable and retains only
three continuation cases. The example makes the central distinction concrete:
internal branch histories are discarded when they have identical boundary
possibilities.

### Evidence locations

- Sections 1--2 and Figure 2, pp. 2--6: external-function motivation and
  file/socket example.
- Section 3.1, pp. 6--9: path-sensitive interprocedural semantics and return
  boundary.
- Definition 1 and Theorems 1--6, pp. 9--11: z-equivalence and continuation
  guarantees.
- Sections 3.3--3.4, pp. 11--17: unconstrained sets, FAST analysis,
  unification, soundness, incompleteness, and linear cost.
- Sections 4--5, pp. 17--29: implementation boundaries, evaluation, and
  comparison with state merging.

## Bearing on RQs

What is directly established by the work:

- a formally defined caller-observational equivalence on symbolic-state
  constraints;
- preservation of all future path-feasibility and validity queries that cannot
  mention hidden variables;
- function-boundary state removal without additional semantic imprecision; and
- a sound, incomplete linear recognizer for a useful fragment.

What is our interpretation or inference: because z-equivalence is an
equivalence relation, its classes are trivially fibers of the quotient map
from symbolic states to z-equivalence classes. They are not the fibers of our
deterministic graph observer \(T_G(-,R)\).

The two policies preserve almost opposite information. Z-equivalence erases
callee-local syntax, paths, and fresh symbols whenever callers have the same
future possibilities. A selection observation deliberately retains the
identity and outcome of every active graph selection, even if two alternatives
produce equal values and are indistinguishable at the boundary.

There is no general refinement ordering between the objects without an
encoding. Distinct selection observations can be z-equivalent when their
different internal choices expose the same boundary behavior. Conversely,
the same selection observation can accompany different data values or
residual functions and hence different boundary constraints; including
\(\operatorname{val}|_R\) in our instrumented observation may separate those
cases.

Z-equivalence is also post hoc with respect to demand. It first explores paths
through a callee, then removes redundant states at its return. It does not
define an output-rooted enabled-edge closure, omit inactive selector cones
during evaluation, or record a sparse site-outcome map.

Could it subsume our proposed contribution: it subsumes a broad claim of
novelty for caller-indistinguishable state quotienting, continuation-preserving
component results, or removing path-distinct but observationally identical
symbolic states. It does not provide one record per graph-relative selection
observation, exact guards over concrete inputs, a disjoint exhaustive input
cover, shared residual DAGs, or an enumeration bound in the number of feasible
observations.

Any compositional-summary theorem in our paper should state whether summaries
preserve graph-intensional selection history or quotient it by a boundary
relation. The latter direction must be compared explicitly with z-equivalence.

This work merits **critical** status for the boundary-observation and
compositional-summary axes. It does not subsume graph-intensional selection
observations, but it is strong enough to invalidate any unqualified novelty
claim about quotienting symbolic states by caller-visible behavior or
preserving all future queries after pruning equivalent component results.

## Evidence limits

Read at full-text level (accepted TOSEM manuscript, cross-checked against the
published article); the note records no evidence-quality caveats beyond the
scope boundary above.
