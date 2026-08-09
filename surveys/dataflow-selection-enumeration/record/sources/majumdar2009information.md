# majumdar2009information — Reducing Test Inputs Using Information Partitions

- **Status:** deep-read; high-relevance supporting work
- **Primary source:** https://doi.org/10.1007/978-3-642-02658-4_41
- **Version read:** authors' CAV paper, https://people.mpi-sws.org/~rupak/Papers/Reducing_test_generation_with_information_partitions.pdf
- **Bibliography key:** `majumdar2009information`

## Why it matters

Information partitions give an early, formal mechanism for avoiding Cartesian
products between independent input components during concolic testing. The
partition, however, is over input variables according to interference, not over
input valuations according to an output observation.

## Program and semantic model (RQ1, RQ7)

The core language is a CFG `P = (X,X0,L,l0,op,E)` over integer variables with
assignments, conditionals, and halt. The paper defines concrete, symbolic, and
concolic execution. The implementation extends this to C programs with pointers,
functions, structures, and dynamically allocated memory.

The theorem assumes all executions terminate, `FlowTest` terminates, and the
constraint solver is complete. In practice, bounds are needed for loops; the
prototype uses manually supplied initial partitions and conservative merging of
dynamic objects by allocation site.

## Enumerated object and algorithm (RQ2–RQ3)

An *information partition* divides input variables into blocks that do not
interfere. A flow map associates each runtime variable with the input blocks
that may influence it. `FlowTest` starts from a fine partition and repeats:

1. for each block, make just that block symbolic and assign random concrete
   values to the others;
2. use `Generate` to perform depth-first concolic path exploration;
3. use `Execute` to propagate flow labels through data and control
   dependencies; and
4. merge blocks when the observed flow establishes interference, repeating to
   a fixpoint.

The object is therefore a partition of input *variables*, not exact logical
regions of the input domain. It neither records branch outcomes nor associates
one residual result with each block.

## Guarantees (RQ4)

Theorem 1 states a relative reachability result: under the termination and
solver assumptions, every CFG location reachable by full concolic generation
is reachable by `FlowTest`. This preserves location and assertion reachability,
not all values, traces, observations, or a disjoint/minimal guard partition.

## Residuals, witnesses, and sharing (RQ5)

Generated concrete tests are witnesses. The method does not produce symbolic
output residuals or a shared result graph.

## Complexity and performance (RQ6)

For `n` independent inputs, the running example reduces `2^n` combined paths to
`2n` single-block paths. No general worst-case output-sensitive bound is given.
Per-path flow tracking costs roughly twice conventional concolic execution in
the experiments but can be dominated by path reduction. The `pmap` benchmark
completed 1,536 paths in 8m29s while Splat had explored 6,238 paths after one
hour without completing.

## Motivating example (RQ8)

The operating-system free-page example partitions array cells into
`{A[i], count[i]}` blocks. Exploring the complete loop yields `2^N` path
combinations, although each iteration depends only on one pair; at `N = 20`,
the baseline did not finish within a day. This is useful motivation for
independent-product avoidance, but not for output-observation fibers.

## Relationship to our hypothesis

### What is directly established by the work?

Interference-based input-variable partitioning, a concolic exploration
algorithm, and relative preservation of reachable locations.

### What is our interpretation or inference?

Information partitions explain one source of redundant cross products that a
selection-observation algorithm should also avoid. They do not identify which
selection sites are demanded by a particular result or enumerate their exact
input fibers.

### Could it subsume our proposed contribution?

No, because the mathematical quotient and reported result are different. It is
important related work for the performance thesis and motivating examples, not
a complete answer to our query.

## Evidence locations

- Sections 2–3, Algorithms 1–3: language, information partitions, flow maps,
  `FlowTest`, `Generate`, and `Execute`.
- Section 3, Theorem 1: relative reachability preservation.
- Section 4: the free-page example and `2^N` versus `2N` comparison.
- Section 5: implementation, evaluation, manual partitions, and limitations.

