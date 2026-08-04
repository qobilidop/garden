# denaro2012allvalues — All-Values Symbolic Execution

- **Status:** deep-read; critical predecessor
- **Primary source:** https://doi.org/10.1109/IWAST.2012.6228982
- **Version read:** author-uploaded AST paper indexed by ResearchGate; metadata cross-checked against Crossref and the University of Milano-Bicocca record
- **Bibliography key:** `denaro2012allvalues`

## Why it matters

All-values symbolic execution (AVaSE) explicitly changes the unit of symbolic
execution from paths to the distinct symbolic values that can reach each
statement. It is a direct predecessor for any claim that dataflow symbolic
execution can avoid redundant Cartesian products of independent choices.

## Program and semantic model (RQ1, RQ7)

The presentation uses ordinary imperative control-flow graphs with assignments
and conditionals and discusses Java-oriented heap and interprocedural analysis.
The prototype is a WALA dataflow analysis driven by a reverse-postorder
worklist. The paper is deliberately a proof of concept rather than a complete
formal semantics.

The method relies on equality comparison between symbolic expressions, an SMT
solver for guard satisfiability, and fixpoint convergence. It reports finite
convergence on one looping example but leaves full treatment of loops, aliasing,
heap objects, and interprocedural flow as future work.

## Enumerated object (RQ2–RQ3)

At each statement AVaSE stores a set of pairs consisting of a symbolic value and
a path condition under which that value reaches or is produced at the
statement. Assignment statements produce the assigned expression; predicates
produce their evaluated Boolean value. Different traversals yielding the same
symbolic expression at the same statement are collapsed.

Guards are reconstructed using control dependences, data dependences, and
killing/redefinition information. A branch that neither changes a demanded
value nor its reachability need not induce a distinct downstream value.

## Algorithm

The worklist propagates newly discovered operand values through the CFG.
Statements are reevaluated only when an operand acquires a new symbolic value.
Dependency information supplies path conditions for the reaching value, and an
SMT solver removes infeasible combinations. Forward-edge paths are processed in
one dataflow pass; loops iterate only while they discover new values.

## Guarantees (RQ4)

The paper does not give a numbered soundness, completeness, disjointness,
coverage, uniqueness, or minimality theorem. Its algorithm and examples motivate
the intended result, but a general correspondence between the computed pairs
and concrete executions is not formally proved.

## Residuals, witnesses, and sharing (RQ5)

The symbolic expressions are residual values and the statement-indexed table
shares them across paths. Satisfying models are used to establish feasibility,
but a witness-bearing public result is not a central abstraction. Because equal
expressions are collapsed, AVaSE intentionally forgets which active branch
produced an equal-valued result unless that provenance is encoded explicitly.

## Complexity and performance (RQ6)

No general asymptotic bound is provided. In the synthetic `simple_n` family,
ordinary path exploration has a stated worst case of `6^n`, whereas AVaSE grows
linearly with the number of independent blocks; the prototype processed
`n = 10` in one pass in about six seconds. JPF symbolic execution took about ten
minutes at `n = 7` and exhausted memory beyond that. The `coinbox` example has
infinitely many paths but finitely many statement values, and AVaSE discovers no
new values after three loop iterations.

## Motivating examples (RQ8)

`simple_n` is the clearest example of redundant products: independent
conditionals multiply complete paths although the value demanded at each later
statement depends on only a small subset. `coinbox` separates infinite path
count from finite symbolic-value count. Both are useful precedents for a
dataflow-graph motivation.

## Relationship to our hypothesis

### What is directly established by the work?

A practical statement-indexed representation of guarded symbolic values and a
dataflow worklist intended to discover each new symbolic value once, with
examples showing large savings over path enumeration.

### What is our interpretation or inference?

AVaSE's equal-expression coalescing loses an active selection's identity when
two alternatives have the same value. A ghost value recording contextual
selection outcomes could prevent that coalescing and encode our observation,
but the paper does not present that construction.

### Could it subsume our proposed contribution?

It subsumes a broad claim of value-directed rather than path-directed symbolic
execution. It does not by itself establish sparse selection observations,
exact/disjoint observation fibers, or compositional graph summaries. Those
properties would need to be stated and proved, and compared against the ghost
instrumentation reduction.

## Evidence locations

- Section II: `simple_n` and `coinbox`, including the path/value scaling claims.
- Section III: control/data/killing dependencies, guarded values, the WALA
  worklist prototype, and SMT feasibility checks.
- Sections IV–V: relationship to prior symbolic execution and the explicit
  proof-of-concept limitations and future work.

## Questions and possible weaknesses

- What conditions ensure termination when a loop generates infinitely many
  syntactically distinct expressions?
- Is symbolic-expression equality syntactic or solver-mediated, and how does
  that choice affect uniqueness?
- Would recording selection provenance destroy the empirical linear behavior
  on `simple_n`?

