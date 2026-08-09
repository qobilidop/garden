# mauborgne2005trace — Trace Partitioning in Abstract Interpretation

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-540-31987-0_2
- **Version read:** author-hosted ESOP 2005 paper
- **Bibliography key:** `mauborgne2005trace`

## Why it matters

This work occupies the term *trace partitioning* and formalizes keeping branch
and value distinctions only over scopes where they improve analysis precision.

## Program and semantic model

A program is a transition system. Concrete semantics is the prefix-closed set
of its finite traces. Abstract interpretation usually forgets trace correlations
and approximates reachable states; this work indexes abstract states by a
covering or partition of traces.

## Main definitions

Definitions 1–2 distinguish coverings and partitions. A control-flow partition
uses a sequence of branch choices. Later, partition tokens form a stack of
conditions such as true/false branch outcomes, loop iterations, call contexts,
and value cases. Create and merge operations refine and later forget selected
distinctions.

## Results and guarantees

Theorem 1 shows that a trace-discriminating reachability abstraction induced by
a covering is at least as precise as ordinary reachability and is strictly more
precise when the covering distinguishes traces sharing states. Subsequent
transfer functions give a sound abstract semantics; exact input regions and
concrete witnesses are not the objective.

## Algorithm

Partition directives create tokens at selected control/value points, and merge
directives discard no-longer-useful distinctions. The implementation shares
token prefixes in a tree and uses widening when the partition basis grows.

## Complexity

Each retained binary branch can at least double analysis cost. The method is
therefore deliberately selective and approximate; heuristics scope partitions
and merge them when precision is no longer useful.

## Terminology

*Trace partitioning*, *control-flow-based partition*, *value-based trace
partition*, *token*, *partition creation*, and *partition merge* are established.

## Motivating example

A branch sets a sign variable correlated with another value. Joining the branch
states loses the correlation; retaining a branch-history partition recovers it.

## Relationship to our hypothesis

### What is directly established by the work?

A generic framework for partitioning traces by branch or value observations,
dynamically retaining and forgetting distinctions.

### What is our interpretation or inference?

Our omission of unobserved choices resembles a principled lifetime for a token,
but ours is intended to be an exact output-induced observation rather than a
heuristic precision control.

### Could it subsume our proposed contribution?

Not directly: its domain is abstract traces and it intentionally merges cases.
However, it makes “trace partitioning” misleading as a name for our exact
non-temporal sparse map.

## Evidence locations

- Section 2.3, Definitions 1–2 and Theorem 1: coverings, partitions, and
  precision.
- Section 2.4: control-flow and value-based trace partitions.
- Section 3.1, Definition 5: branch/value tokens and scoped partitions.
- Section 3.4: create and merge operations and sound transfer.

## Questions and possible weaknesses

- Can our demanded-site map be formulated as an exact trace discrimination
  indexed by a nonheuristic observation function?
