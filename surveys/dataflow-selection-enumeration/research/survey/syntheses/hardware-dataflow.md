# Hardware, circuits, and dataflow-model traces

## Functional-space partitions

Feng et al. represent a signal by mutually exclusive control/data cells. Their
mux rule imports only the selected data arm's cells and moves the selector
condition into the control. If every mux is a split point, the result is already
an exact disjoint cover with residual data expressions and recursive omission of
unselected nested arms.

The difference from a site observation is provenance: Feng's cells carry
Boolean controls, and its merge theorem intentionally permits trace-distinct
cells to coalesce. Adding immutable site/outcome labels would recover much of
our proposed representation.

## Discrete symbolic traces

Kanade et al. explicitly include conditional-block outcomes in a model's
discrete state and group initial states by equality of a bounded discrete trace.
Their symbolic transformer is compositional and carries a residual expression,
but the computed region is an underapproximation of one sampled class rather
than an exact exhaustive partition.

Kölbl et al. use branch-control formulas and ITE assignments in full Verilog
simulation, then merge future events by disjoining controls. Dynamic $random
replay lists expose the need for contextual occurrence information, but branch
history is not retained as the final semantic object.

## Modular RTL symbolic execution

Sylvia independently explores path fragments for sequential blocks and uses SMT
to filter their cross-product. Its fragment-construction complexity improves
from exponential in all branch points to exponential in the largest block, but
the full combination still makes \(O(2^{bN})\) solver queries in the stated
worst case. It is a critical warning not to equate modular construction savings
with end-to-end enumeration savings.

## Demand and context

Palmer et al.'s reverse functional evaluator is demand-driven from a target
clause and uses relative stacks and contextual variables. It establishes that
context-sensitive demand evaluation is not new, while also clarifying the
advantage of our restricted domain: a finite total pure graph has no skipped
effects or divergence and admits a finite exact observation partition.

## Positioning consequence

No paper in this cluster packages the exact sparse contextual site map, but the
semantic ingredients are close:

- Feng supplies selected-arm control/data partitions;
- Kanade supplies conditional-trace equivalence;
- Kölbl supplies guarded RTL values and occurrence-aware replay;
- Sylvia supplies modular hardware paths and witnesses; and
- Palmer supplies formal context-sensitive demand.

The survey therefore rules out claims of inventing choice-induced dataflow
partitioning, symbolic trace equivalence, contextual demand, or modular hardware
path composition. The only remaining distinction is the fixed graph-intensional
observer—and selective functors plus projected AllSMT already express it.
