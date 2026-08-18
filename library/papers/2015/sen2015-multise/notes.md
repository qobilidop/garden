---
citekey: sen2015-multise
work:
  title: "MultiSE: Multi-Path Symbolic Execution using Value Summaries"
  author: Koushik Sen, George Necula, Liang Gong, Wontae Choi
  venue: "ESEC/FSE '15, Proceedings of the 2015 10th Joint Meeting on Foundations of Software Engineering, pp. 842–853"
  date: "2015-08-30"
  doi: 10.1145/2786805.2786830
sources:
  pdf: https://people.eecs.berkeley.edu/~ksen/papers/multise.pdf  # author-hosted camera-ready → shadow; title, authors, and venue match the DOI record
retrieved: 2026-08-09
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-09
synthesis: "MultiSE represents one consolidated execution as per-variable sets of guarded values, making path sharing incremental and explicit; its prototype shows large speedups on small JavaScript harnesses, but the comparison does not establish that path explosion is solved or that conventional merging must lose paths."
---

# MultiSE: Multi-Path Symbolic Execution using Value Summaries

A [[symbolic-execution]] method and prototype that attacks path explosion by
changing the unit of state. Conventional dynamic symbolic execution (DSE)
keeps one symbolic state per path; conventional state merging combines whole
states at selected join points, often by introducing solver-visible auxiliary
variables. MultiSE instead maps every variable—including the program
counter—to a set of guarded symbolic expressions called a *value summary*.
The result is one continuously consolidated execution in which equal values
can be shared across paths. The representation is technically clear and the
same-implementation DSE comparison is informative, but the evaluation is a
2015 prototype study on 15 hand-built JavaScript harnesses, not evidence that
the exponential worst case disappears.

## A path tree becomes guarded columns

For each program variable, a value summary stores pairs `(guard, value)`. If
two paths give a variable the same value, their guards can be disjoined and
the value stored once. The guards for a variable are mutually exclusive and
collectively cover the represented executions. Extending this representation
to the program counter turns separate control states into guarded labels, so
computed jumps, exceptions, and unstructured control flow need no statically
identified join point.

This factorization is the paper's central contribution. Rather than encoding
a merge as a fresh variable plus a formula such as an if-then-else, MultiSE
keeps the alternative concrete or symbolic values outside the path
constraint and says under which input predicate each applies. That separation
has three practical consequences:

- values unsupported by the SMT solver—floating-point values, function
  objects, heap addresses—can remain concrete payloads under supported
  guards;
- operations on those payloads can often execute concretely, and calls or
  indirect accesses can enumerate the explicit alternatives without asking
  the solver for every possible auxiliary-variable value; and
- merging happens as each assignment updates a guarded portion of a value
  summary, rather than by scanning modified whole states when control flow
  reconverges.

The price is not eliminated but relocated. Operations combine the value
summaries of their operands, so their cost can grow with the product of the
set sizes. Guards also grow and still require satisfiability checks. The
implementation uses binary decision diagrams (BDDs) to share and simplify
Boolean guard structure, then invokes CVC3 for integer-linear-arithmetic and
string constraints.

## The semantics preserve DSE only inside an explicit boundary

The paper gives operational rules for guarded update, binary operations,
computed conditionals, loads, and stores. Its key operator preserves an old
summary where a guard is false, installs a new summary where it is true, drops
unsatisfiable guards, and coalesces identical values. Turning off that last
coalescing step yields the authors' conventional-DSE baseline, which is why
the DSE comparison controls for most implementation differences.

The authors argue informally that, absent approximation, the final MultiSE
state encodes the same behaviors as DSE and that retained behaviors
correspond to concrete executions. Completeness against concrete execution
is not unconditional. Input-dependent loops can be cut off by dropping
guarded program-counter alternatives. When an expression falls outside the
solver's theory—for example nonlinear multiplication of two symbolic
inputs—MultiSE concretizes one value, discards the other corresponding paths,
and raises an `incomplete` flag. Value summaries therefore expand where
precise merging is practical; they do not make arbitrary programs fully
tractable.

## What the evaluation supports

The prototype is implemented for JavaScript on Jalangi's `symfront` branch.
The authors construct symbolic harnesses that call methods from 15 public
libraries and algorithms, from 32 to 1,061 lines of code. Each timing is
averaged over several runs on one 2.3 GHz Core i7 laptop with 16 GB RAM.
Table 1 supports three narrower findings:

- **Sharing exists in these harnesses.** Average value-summary sizes range
  from 1.0 to 29.3, while each distinct value is shared across roughly 3.2 to
  45.8 paths on average. This validates the representation's opportunity,
  not a general bound on summary growth.
- **Coalescing avoids substantial repeated work.** Against the same engine
  with coalescing disabled, MultiSE is 1.3× to 87.7× faster across all 15
  cases. DSE executes 2.7× to 47.5× as many summary-weighted operations, and
  most runtime is spent in the SMT solver rather than BDD manipulation.
- **Unsupported merge payloads are common in dynamic-language code.** Seven
  of the 15 harnesses contain merges that the paper's auxiliary-variable CSM
  model cannot represent precisely with its integer/string solver; its
  estimated precise-merge fraction falls as low as 22%, while MultiSE keeps
  those payloads outside the solver and records 100% for this metric.

The last column is an instrumented estimate, not a run against a conventional
state-merging implementation. More importantly, failure to perform one merge
does not logically require dropping a path: a hybrid executor can retain the
states separately and pay the exploration cost. The study therefore shows
that MultiSE can merge cases the chosen auxiliary-variable encoding cannot;
it does not establish that competing executors must be incomplete. Nor does
the evaluation report bugs found, coverage gained, memory consumption, or
performance on large applications. The need to hand-build harnesses is
acknowledged as the reason the experiment set is small.

## Assessment

- **Durable:** treating a merged execution as guarded values rather than a
  bag of whole-path states; extending the same representation to the program
  counter; and keeping unsupported concrete payloads outside the solver are
  reusable design ideas. The paper is especially good at exposing where
  solver theory choices leak into executor architecture.
- **Era-bound:** Jalangi `symfront`, CVC3, the 2015 JavaScript workloads, and
  absolute timings. The reported speedup range is evidence for this prototype
  and workload construction, not a contemporary performance expectation.
- **Weaknesses:** the empirical set is small and author-harnessed; the DSE
  baseline is controlled but shares the prototype's engineering choices; the
  conventional-merging comparison is modeled rather than executed; and no
  memory or end-task effectiveness measure accompanies runtime. The
  soundness/completeness claims are sketched, not presented as formal theorems
  with proofs, while the admitted approximation deliberately drops paths.
- **Against the library:** [[yang2026-forbench]] reaches a related conclusion
  in hardware by a different representation: keep design branches inside
  symbolic expressions and fork only on testbench conditions. MultiSE merges
  after branching; Forbench avoids many branches in the first place. Both
  demonstrate that path explosion is partly a choice of where alternatives
  live, and both ultimately trade path count for expression and solver cost.

MultiSE is best remembered as a state-representation result: path sharing can
be made incremental, per-variable, and solver-aware. It is not a claim that
symbolic execution has escaped its exponential boundary.
