# trabish2018chopped — Chopped Symbolic Execution

- **Status:** deep-read; high-relevance supporting work
- **Primary source:** https://doi.org/10.1145/3180155.3180251
- **Version read:** authors' ICSE paper, https://srg.doc.ic.ac.uk/files/papers/chopper-icse-18.pdf
- **Bibliography key:** `trabish2018chopped`

## Why it matters

Chopped symbolic execution is a strong operational demand-driven technique: it
skips user-declared code and reexecutes only a slice when a later load demands
one of its effects. It establishes relevant precedent for lazy residual
recovery, but its observer and result differ from output-choice enumeration.

## Program and semantic model (RQ1, RQ7)

The paper formalizes a C-like imperative heap language with assignments,
assertions, conditional jumps, dynamic allocation, and calls. The implementation
extends KLEE at LLVM level. Users mark functions or call sites as
uninteresting; calls may have arbitrary side effects.

Sound recovery depends on conservative modification and points-to information.
The analysis is flow-insensitive, context-insensitive, field-sensitive, and
allocation-site based. Symbolic addresses, skipped nontermination, conservative
aliasing, and the current function-granularity interface are explicit
limitations.

## Operational object and algorithm (RQ2–RQ3)

At a skipped call the executor saves a snapshot and continues. Loads that may
read a location modified by the skipped code are *dependent loads*. When such a
load is encountered, the current state is suspended and a recovery execution is
forked from the snapshot. The skipped function is sliced with respect to the
load's address, and only stores relevant to recovery are copied back.

Recovery follows guiding constraints from the dependent execution. Branches
fork recovery and suspended states in tandem. Multiple skipped invocations are
recovered in order; recursive recovery and caching handle dependencies among
skipped calls, and allocation addresses are kept consistent.

The method explores ordinary feasible paths of the demanded slice. It does not
enumerate a partial map of branch outcomes or a logical partition of inputs.

## Guarantees (RQ4)

The paper argues informally that chopped execution preserves standard symbolic
execution soundness and explores only feasible paths, except that a skipped
function that never returns can make continued states spurious. It gives no
formal semantic theorem for completeness, disjointness, coverage, or
minimality.

## Residuals, witnesses, and sharing (RQ5)

Snapshots and recovered stores are operational residual state, and KLEE tests
are witnesses. Recovery results may be cached. There is no public table of
guarded output residuals, observation fibers, or compositional pure-subgraph
summaries.

## Complexity and performance (RQ6)

No asymptotic bound is given. The evaluation reproduces failures in real
libraries under a 24-hour budget and often reduces timeout/OOM cases to seconds
or minutes. Static slicing and recovery can also cost more than ordinary KLEE,
and the implementation uses a heuristic recovery-state selection probability
of 0.2. The gain is workload- and annotation-dependent.

## Motivating example (RQ8)

Figure 2 skips a function that mutates fields of a point-like structure. A
later load of `p.y` is dependent and triggers recovery through the relevant
`j > 0` branch, while stores to unrelated fields such as `p.z` or `p.x` are
sliced away. This is a useful example of demand-triggered effect recovery.

## Relationship to our hypothesis

### What is directly established by the work?

Lazy, demand-triggered recovery of side effects from skipped regions, guided by
static modification analysis and dynamic slicing.

### What is our interpretation or inference?

Its notion of observable effect is operational: whether later code reads a
possibly modified location. Our observation is proposed as an extensional
result of a pure graph evaluation: which contextual selection sites are reached
and which alternatives are chosen.

### Could it subsume our proposed contribution?

No. It is related to demanded evaluation and residual recovery, but neither its
mathematical object nor its enumeration goal is the same. It should remain
supporting related work rather than a critical novelty threat.

## Evidence locations

- Sections 2–3 and Algorithms 1–3: language, snapshots, dependent loads,
  `mayMod`, recovery, and slicing.
- Sections 3.1–3.6: branch synchronization, multiple skips, recursion, caching,
  allocations, and limitations.
- Section 5: failure reproduction, coverage experiments, and performance
  tradeoffs.

