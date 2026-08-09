# anand2008demand — Demand-Driven Compositional Symbolic Execution

- **Status:** deep-read
- **Primary source:** https://patricegodefroid.github.io/public_psfiles/tacas2008.pdf
- **Version read:** author-hosted TACAS 2008 paper
- **Bibliography key:** `anand2008demand`

## Why it matters

This work directly occupies “demand-driven compositional symbolic execution,”
but its demand is for reaching one target location. It supplies exact partial
summaries and target-directed expansion, not enumeration of all selection
observations.

## Summary object

The complete summary background is a disjunction of path pre/post relations.
The incremental representation is instead a partial intraprocedural execution
tree whose unexplored leaves are dangling. Calls in a local path condition are
uninterpreted function terms. A partial definition for callee `g` disjoins its
finished leaves and fresh Boolean flags for its dangling leaves (Section 4.2,
pp. 372–374).

Calling-context predicates record where a function may be invoked. Combining
local path conditions, calling contexts, and partial function definitions
forms an interprocedural target formula whose syntactic size is linear in the
current execution-tree sizes (Section 4.2, pp. 374–375).

## Meaning of demand and algorithm

Demand means relevance to a target program location. Algorithm 2 first forces
all non-target dangling flags false and asks whether known paths reach the
target. If not, an unrestricted model identifies dangling paths that may need
exploration (Section 4.3, pp. 376–377). A relevant-exploration input is
guaranteed to exercise a new intraprocedural path, but need not reach the
target because the dangling behavior is still unknown.

## Results and assumptions

Three unnumbered results in Section 4.3 establish relative completeness,
progress, and termination when the program has finitely many paths. They assume
perfectly precise constraint generation and solving. The presentation also
assumes sequential nonrecursive functions and individually terminating
executions. No solver-time or semantic-outcome bound is proved.

## Motivating example

`testAbs` calls `abs` twice. Existing path fragments can sometimes reach the
target without expanding unused `abs` paths; when that fails, dangling flags
identify a genuinely new relevant path (Section 3, pp. 369–371).

## Relationship to our hypothesis

One could encode a desired observation as a target and obtain one witness, but
the algorithm does not enumerate all observations, quotient paths with the same
observation, produce exact fiber guards, or bound work in the number of fibers.
Its use of “demand” is target-directed search, not enabled-edge observation.

## Evidence locations

- Sections 2 and 4.2, pp. 368–375: summaries and interprocedural formula.
- Section 4.3, pp. 376–378: algorithm and metatheory.
- Section 5, pp. 378–379: evaluation.
