# Term graphs, choices, sharing, and structural observation

## What term-graph work already establishes

Pull-tabbing gives nondeterministic choice nodes stable identifiers, requires
all copies of one choice to resolve consistently, and defines the represented
set by resolving every choice. Its invariance lemmas and correctness theorem
show that pull-tab and ordinary rewrite steps preserve all and only the
consistent results, independently of a particular evaluation strategy.

Needed-narrowing work further establishes demand-guided complete evaluation in
functional-logic programs. Related term-graph results warn that neededness on
trees does not automatically lift to shared graphs.

Selective applicative functors separately give an algebraic interface for
statically visible computations whose effects are selected dynamically. Their
free construction and generic interpreter already provide ordinary
compositionality for conditional static structure.

Consequently, a paper about our calculus cannot claim that delayed choice,
shared choice identity, exhaustive alternatives, or schedule independence are
new in general.

## Different source of alternatives

Pull-tabbing choices are nondeterministic: the represented set retains possible
resolutions. Our selection outcomes are deterministic functions of the input.
They are retained as instrumented structural observations even when ordinary
values do not reveal them.

This difference suggests two semantic layers:

1. eager deterministic value semantics for the pure graph; and
2. a result-observation judgment producing a graph-relative set or map of
   active site outcomes.

The second layer must erase to the first. It cannot be called fully abstract
for ordinary value contexts, because equal-valued selections are deliberately
distinguished.

## Sharing obligations

- A site is a graph node or contextual occurrence, not a duplicated syntax-tree
  position.
- A shared internal node demanded by several consumers is observed once; its
  activity is the disjunction of consumer demands.
- Reusing a callee at two call sites needs distinct contextual occurrence names
  unless the intended observation explicitly merges them.
- Memoization and any legal evaluation order must preserve the observation.

These are theorem obligations. They cannot be discharged by silently unfolding
the graph into a tree.

## Candidate original question

Does there exist a finite *graph-sharing-aware* interface summary for a
subgraph that exposes exactly
the structural observations required by its callers and composes under sharing
and substitution? A positive exactness and minimality theorem could be stronger
than both the direct flattened AllSMT encoding and a symbolic interpretation of
a free selective computation. A summary that merely exports every internal
activity and outcome variable is not.
