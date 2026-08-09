# vanoverberghe2011theoretical — Theoretical Aspects of Compositional Symbolic Execution

- **Status:** deep-read
- **Primary source:** https://lirias.kuleuven.be/retrieve/aa72da53-49fa-4f96-ac20-056420fc6355/
- **Version read:** KU Leuven author deposit of FASE 2011 paper
- **Bibliography key:** `vanoverberghe2011theoretical`

## Why it matters

The paper supplies a generic precision, monotonicity, and progress discipline
for compositional symbolic execution. It covers eventual path/state discovery,
not quotienting or enumerating observations.

## Summary and analysis state

A method summary is the current leaf set of a partial execution tree. Each
leaf contains a status, symbolic state, and path condition. The global analysis
state maps methods to summaries, records an invocation graph, and tracks leaves
already proved reachable (Section 4.1, pp. 254–255).

Uninterpreted return predicates and per-global return functions summarize
finished paths. At a call, the callee predicate is added to the caller path
condition, globals are updated through return functions, and an invocation is
recorded. Reachability checking recursively substitutes calling contexts and
current summary interpretations before invoking SMT (Sections 4.2–4.3,
pp. 255–258). New call or return information can invalidate an earlier
unreachable classification, so affected leaves become unknown again.

## Results and assumptions

Definitions 1–3 use precision for absence of false reachability conclusions,
progress for eventual discovery of every reachable state, and monotonicity for
preserving positive conclusions. Theorems 1–3 prove precision, monotonicity,
and progress under a fair choice of unknown leaves (pp. 253–259).

The progress proof uses summary totality and restricted completeness of its
checking operation. Assumptions include sequential finite CFGs, no mutual
recursion in the presentation, sound/complete SMT as required, precise symbolic
interpretation, terminating analysis transitions, and fairness. Exploration
may remain infinite; no asymptotic runtime or summary-size result is given.

## Motivating example

Figures 1–2 show that dropping caller context or input/return correlation is
imprecise, and that mutually dependent loop summaries repeatedly reopen
frontier leaves. A simple global-depth progress proof therefore fails.

## Relationship to our hypothesis

Ghost instrumentation could turn observations into reachability states, and
fairness would eventually discover them in the finite acyclic setting. The
analysis enumerates path leaves rather than equivalence classes under a sparse
observation; it supplies neither fiber merging nor a bound in the number of
observations.

## Evidence locations

- Definitions 1–3, pp. 253–254: terminology.
- Sections 4.1–4.3, pp. 254–258: summaries and calls.
- Theorems 1–3 and Definition 4, pp. 258–259: metatheory and fairness.
