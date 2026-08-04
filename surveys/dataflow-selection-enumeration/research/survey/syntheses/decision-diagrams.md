# Decision trees and decision diagrams as the generic baseline

## The tree shape is already established

For a deterministic decision tree, one input follows one root-to-leaf path.
That path is exactly a finite input-relative map from the encountered test
occurrences to their outcomes. Its conjunction of branch predicates is a
guard, guards of distinct reachable leaves are disjoint, and the leaf stores a
result or residual computation. Tests below an untaken branch are absent from
the path.

This is the same abstract *shape* as a sparse selection observation with a
guard and residual. Calling the record sparse, input-relative, exhaustive, or
guarded therefore cannot establish novelty. The graph setting changes what
the test identities mean and how the observer is derived, not generic
representability by a decision tree.

## Sharing and reduction

Bryant's ordered reduced function graphs merge isomorphic residual functions
and remove a test whose two successors denote the same function. Bahar et
al.'s ADDs generalize terminals to finite algebraic carriers. For a fixed
variable order and exact terminal equality, reduction gives a canonical shared
representation of the compiled function.

This exposes two different notions of omission:

- a decision-diagram variable is skipped when the *compiled terminal
  function* is independent of that variable in the current residual context;
- a graph selection site is unobserved when it is outside the input-indexed
  enabled closure of the requested roots.

The first is extensional reduction. The second is an intensional observation
policy. They coincide only after the latter has been made part of the compiled
terminal value.

## Exact reduction

For a fixed caller constraint, totalize over the entire encoded input domain:

\[
  \widetilde T_{G,A,R}(x)=
  \begin{cases}
    \mathsf{outside}_A & \neg A(x),\\
    \overline T_G(x,R) & A(x),
  \end{cases}
\]

where \(\mathsf{outside}_A\) is a fresh terminal. For finite encoded inputs,
compile \(\widetilde T_{G,A,R}\) as an MTBDD or ADD. Each non-outside reachable
terminal is one feasible observation and its terminal preimage is exactly the
observation fiber. Defining the function on all encoded assignments is needed
for the usual fixed-order canonicity claim; leaving inadmissible assignments
as unspecified don't-cares would not determine one reduced diagram.

If the desired artifact also contains a concrete ordinary result, one
can compile the similarly totalized function

\[
  x\mapsto
  \begin{cases}
    \mathsf{outside}_A & \neg A(x),\\
    (\overline T_G(x,R),\operatorname{val}_x|_R) & A(x),
  \end{cases}
\]

but this may refine one observation fiber into several concrete-value
terminals. One symbolic residual expression per observation requires a
separate partial-evaluation construction or a richer carrier of residual
identifiers with a stated equality theory. Root-to-terminal cubes represent
guards, possibly in a shared or fragmented form.

The observation-only compilation is a generic solution in the finite-domain
setting. It may construct a
representation finer than the flat list of fibers, and extracting one formula
per terminal can require a disjunction of many cubes. Conversely, diagram
sharing can be exponentially more compact than serializing every guard.

## Complexity consequence

Reduced decision diagrams remain exponential in the worst case and are highly
sensitive to variable order; even integer-multiplier outputs have exponential
ordered BDD size for every order. A small number of observation fibers does not
alone imply a small diagram when the fiber characteristic functions are hard,
and a small diagram does not imply small flat guard serialization.

Any graph-specific algorithmic contribution must therefore compare at least:

- source-graph and encoded-input size;
- compiled diagram size and variable order;
- number of observation terminals;
- number and total size of root-to-terminal cubes;
- size of flat exact guards and residuals; and
- reuse under graph composition.

## Neural-specific exact compilation

This generic reduction has concrete neural predecessors. Shih, Darwiche, and
Choi learn an OBDD exactly equivalent to a BNN on a chosen CNF region. Shi et
al. compile Boolean neuron functions and the resulting network circuit into
OBDDs/SDDs, with a pseudo-polynomial integer-weight neuron bound. BDD4BNN gives
the strongest requested-region construction: exact cardinality translations,
feasible-input propagation, relational products that existentially remove
hidden activation vectors, and one exact BDD per output class. Tang et al. add
margin-qualified exact aligned BDDs for threshold neurons.

These results are not merely applications of generic diagrams. They directly
defeat claims of first exact neural output compilation, first requested-region
class fibers, or first sparse diagram explanation. Their terminal observer is
the final class function, however, so they intentionally erase internal event
identity and equal-valued provenance.

## Surviving research question

The graph semantics still offers a useful specialization: site identities are
context-qualified graph occurrences, unselected case subgraphs are
structurally absent even when equal-valued, and guards have the local
conjunction form induced by observed outcomes. The open question is whether a
structure-directed construction or compositional summary theorem yields a
provable representation or reuse advantage over generic decision-tree/ADD and
projected-AllSMT compilation. Without such a result, the decision-structure
view belongs in the survey synthesis rather than the contribution list.
