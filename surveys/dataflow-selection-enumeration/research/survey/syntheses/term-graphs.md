# Term graphs, choices, sharing, and structural observation

## What term-graph work already establishes

Pull-tabbing gives nondeterministic choice nodes stable identifiers, requires
all copies of one choice to resolve consistently, and defines the represented
set by resolving every choice. Its invariance lemmas and correctness theorem
show that pull-tab and ordinary rewrite steps preserve all and only the
consistent results, independently of a particular evaluation strategy.

Antoy, Echahed, and Hanus establish sound, complete, pairwise-disjoint needed
narrowing for inductively sequential constructor systems, with an optimal
shared-family cost result. Echahed's later term-graph treatment shows that
tree-level definitional conditions do not automatically lift through sharing,
cycles, and redirection: the unrestricted graph strategy may diverge or select
a non-needed node.

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

The Fair Scheme makes the operational overlap closer. It places live graph
expressions in a fair queue, performs only needed steps, and associates each
queued expression with a finite choice-identifier fingerprint. Its formal
theorem preserves the set of source values reachable by consistent
computations from every simulated state. The extended paper explicitly leaves
eventual production of every value as a strong-completeness conjecture, and the
later dissertation does not add a separate numbered liveness theorem. It also
emits values rather than fingerprints: distinct fingerprints may produce the
same value, so neither duplicate-free projected enumeration nor exact input
fibers follow.

This difference suggests two semantic layers:

1. eager deterministic value semantics for the pure graph; and
2. a result-observation judgment producing a graph-relative map of outcomes for
   sites observed in that evaluation.

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
- A proof relating Fair-Scheme fingerprints to graph occurrences must translate
  dynamic computation-local choice identifiers to static context-qualified
  occurrence names.
- Needed reduction to constructor head normal form does not silently establish
  strict pure-dataflow semantics; the encoding must preserve ordinary strict
  operands, selective case edges, and requested roots.

These are theorem obligations. They cannot be discharged by silently unfolding
the graph into a tree.

## Survey consequence

Graph sharing is not itself the missing theory. The formal synthesis must
distinguish immutable deterministic DAG selections from nondeterministic
rewriting, quantify contextual occurrence identity explicitly, and show the
enabled-closure union law. Exporting every internal activity/outcome variable
then reduces the problem to established selective interpretation and projected
enumeration; it is a useful correspondence, not a new graph calculus.

Multi-way selectors add a further accounting obligation. A binary pull-tab
encoding may use several auxiliary choices for one source site and can increase
the encoding size substantially; projection back to one source outcome and all
complexity bounds must charge for that lowering explicitly.
