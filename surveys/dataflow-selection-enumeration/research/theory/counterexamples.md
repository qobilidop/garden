# Counterexamples and scope tests

Each example rejects a tempting theorem or an underspecified definition.

## Equal alternatives defeat extensional observation

\`\`\`text
q = select(p, 7, 7)
return q
\`\`\`

Both inputs produce value \(7\), but the proposed structural observer records
different outcomes of \(q\). Therefore the semantics is not fully abstract for
ordinary value contexts and is not invariant under rewriting the graph to
\`return 7\`.

## Trace without values is not compositional

Let a component return its input without containing a selection site. Every
input has the same empty internal observation. A caller selects a branch based
on that returned value. Replacing the component summary by its trace alone
cannot predict the caller observation. A compositional interface needs values
or residual value relations in addition to events.

## Output-insensitive summaries over-observe

A component has two outputs; each depends on a disjoint internal selection. A
caller uses only the first output. A summary that always observes both outputs
records the second selection even though the flattened whole graph does not.
Component summaries must be parameterized by demanded output ports.

## Syntax-tree unfolding duplicates shared sites

\`\`\`text
q = select(p, a, b)
return pair(q, q)
\`\`\`

The graph has one selection site. Unfolding it to a tree and naming by syntax
position creates two sites or permits inconsistent outcomes. Memoization and
identity must follow the shared graph node.

## Selector-in-selector order

\`\`\`text
inner = select(p, 0, 1)
outer = select(inner, a, b)
return outer
\`\`\`

The selector of \`outer\` contains \`inner\`. The observation closure must
include and constrain \`inner\` before the outer outcome. Splitting only
top-level case operands misses a demanded site.

## Inactive vs. logical don't-care

\`\`\`text
inner = select(r, 5, 5)
outer = select(p, inner, 5)
return outer
\`\`\`

When \`outer\` chooses its second case, \`inner\` is structurally inactive.
When it chooses the first case, \`inner\` is active even though both of its
alternatives and the final outputs are equal. Implicant minimization of the
ordinary output may drop both decisions; structural observation must retain the
active ones.

## One-hot outcomes are not binary paths

A width-\(w\) one-hot selection may demand several case roots simultaneously.
Treating it as one winning branch is wrong. Treating every raw mask as a
separate outcome gives \(2^w\) possible outcomes at one site; any bound based
only on number of active sites is wrong.

## Priority raw values can share one outcome

Many selector bit vectors have the same first enabled priority case. Blocking
one concrete selector value repeatedly rediscovers the same observation.
Enumeration must block the semantic outcome predicate.

## Partial primitives break eager erasure

\`\`\`text
return select(p, 0, divide(1, 0))
\`\`\`

If the unselected division is undefined, eager evaluation of every node is not
total even when selected evaluation has a result. The eager-value erasure and
simple reachability semantics require total primitives or an explicit
definedness/relational extension.

Underconstrained operators likewise do not induce a unique observation without
a fixed refinement or relational semantics.

## Contextual call identity

Calling the same callee twice with the same arguments may produce equal values
and identical local outcomes. A graph-relative occurrence semantics still has
two prefixed event identities. Merging them is a different observation policy,
not a harmless implementation optimization.

## Tree serialization destroys linear DAG bounds

Repeatedly define \(e_i=f(e_{i-1},e_{i-1})\) and use \(e_n\) in a selector.
The arena has linear nodes; recursive serialization has exponential text. Size
theorems must name a shared representation.

## Cycles and unbounded occurrences

A cyclic graph can require a fixed point for both values and demand. An
unbounded loop can create infinitely many contextual site occurrences. Neither
is covered by finite acyclic observation or enumeration theorems.
