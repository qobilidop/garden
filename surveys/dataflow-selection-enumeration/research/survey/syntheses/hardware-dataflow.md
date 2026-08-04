# Hardware, circuits, and dataflow-model traces

## Pseudo-exhaustive local support coverage

McCluskey's pseudo-exhaustive testing lineage applies every assignment to each
combinational output cone without necessarily applying the entire global truth
table separately for each output. Mumtaz et al. state the contract as a test
set whose projection covers every assignment of every cone, remove support
sets contained in larger supports, and synthesize shared LFSR pattern sets by
linear-independence checks and set cover. This directly precedes exhaustive
coverage relative to local graph supports.

The locality is nevertheless static: a mux output cone contains its selector
and both data arms. The technique emits complete concrete test vectors and
does not enumerate dynamic selected-edge observations, their inverse images,
or symbolic residuals. The local-exhaustive-testing synthesis gives the exact
comparison.

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

Lurette uses a different relevance notion: a Lustre observer constrains every
prefix of a randomized synchronous test trajectory. It is a foundational
dataflow test generator, but it neither enumerates an input partition nor
retains internal selector outcomes. The word “relevance” therefore does not by
itself imply structural observation.

## Dataflow traces, refinement, and observers

The dataflow boundary is substantially stronger than a collection of
implementation analogies. Brunet and Mattavelli's journal execution-trace graph
formalism claims a complete representation of all admissible trajectories of a
dynamic dataflow process network. Jonsson gives a compositional fully abstract
trace model for nondeterministic FIFO dataflow and more general asynchronous
channels. Cedersjö and Janneck give meaning-preserving translations from Kahn
processes to firing-based actors. These results defeat any claim that complete
dataflow trajectory objects, compositional trace semantics, or cross-style
firing translations are new here. Their objects are whole action or channel
histories, not caller-input fibers of one sparse graph observer.

Cross-level guarantees are also established. Tripakis et al. map synchronous
hardware signals to asynchronous token events and define conformance preserving
throughput and latency. Vijayaraghavan and Arvind compose refinements from
synchronous machines to bounded latency-insensitive dataflow networks. Law's
mechanization extends operational dataflow-circuit semantics toward a hardware
refinement. The proposed observer therefore cannot be justified by claiming a
first formal bridge between dataflow and hardware; its scope is the narrower
input-indexed requested-site map.

Petri-net and discrete-event work supplies close requested-observation
boundaries. Dynamic slices can be marking or MTL relative; maximal slicing can
retain every transition that contributes tokens to selected places in any
computation; timed aggregate graphs preserve timed traces and states; dynamic
observation policies compile to deterministic observed-event generators; and
minimal-observation synthesis reduces the observable alphabet while preserving
supervisor control equivalence. These constructions establish requested-place,
policy-relative, and minimal event observation without producing typed program
residuals or caller-input inverse fibers.

## Positioning consequence

No paper in this cluster packages the exact sparse contextual site map, but the
semantic ingredients are close:

- Feng supplies selected-arm control/data partitions;
- Kanade supplies conditional-trace equivalence;
- Kölbl supplies guarded RTL values and occurrence-aware replay;
- Sylvia supplies modular hardware paths and witnesses; and
- Palmer supplies formal context-sensitive demand; and
- pseudo-exhaustive testing supplies support-local exhaustive circuit tests
  and local-support complexity bounds;
- execution-trace graphs supply complete dynamic-dataflow trajectory objects;
- conformance and bounded-network refinement relate dataflow to hardware; and
- Petri-net slicing and observation-policy synthesis supply exact
  requested-event reductions.

The survey therefore rules out claims of inventing choice-induced dataflow
partitioning, symbolic trace equivalence, contextual demand, or modular hardware
path composition. The only remaining distinction is the fixed graph-intensional
observer—and selective functors plus projected AllSMT already express it.
