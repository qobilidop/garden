# Demand-driven bounded testing and partial-state exploration

## Result of the focused survey

Demand-guided refinement is established prior art. Lazy SmallCheck gives the
cleanest functional statement: apply a Boolean observer to a partial input,
refine exactly the hole it demands, and discard all bounded completions when
the answer is known. The lazy-initialization lineage gives the imperative heap
analogue: instantiate a symbolic field only when the program accesses it, and
use increasingly precise feasibility tests to reject partial heaps with no
valid completion.

Lindblad predates Lazy SmallCheck with a closely related property-directed
constructor search: it refines the metavariable on which evaluation is blocked
and may return a partial constructor term denoting many satisfying completions.
The paper explicitly leaves its stated soundness and completeness conditions
unproved, so the construction is precedent for the refinement shape, not a
theorem-strength exact enumerator. SPLat supplies a separate configuration
lineage: it discovers options on first read, checks partial assignments against
a feature model, and backtracks over the resulting access stack.

| Work | Partial object | What triggers refinement | Feasibility/stop test | Preserved object | Missing relative to our target |
|---|---|---|---|---|---|
| Lindblad (2007) | partial constructor term with metavariables | property evaluation blocks on one metavariable | return when the property reduces to true; refine blocked constructor alternatives | intended satisfying-completion sets; soundness/completeness stated but unproved | no theorem-strength exact fiber aggregation or requested residual |
| Korat (2002) | finitized object-field vector with a dynamic accessed prefix | executable predicate reads a field | Boolean `repOk`; unread suffix cannot alter the answer | every bounded nonisomorphic satisfying concrete input | emits concrete inputs, not one exact symbolic class per observer result |
| Lazy SmallCheck (2008) | constructor tree with tagged holes | Boolean property forces one hole | `Known Bool` vs `Unknown Pos` | exhaustive bounded failure search | no canonical observer image, exact fiber, residual, or all-class output |
| SPLat (2013) | partial configuration stack populated by first reads | test reads a configuration variable | SAT feasibility under a feature model; DFS backtrack | one execution per claimed unique reachable test trace | no formal exact-fiber theorem, exposed iff guard, or symbolic residual; reset/effects assumptions matter |
| BLI (2013) | scoped heap with symbolic reference fields | program reads a field | relational field bounds and canonical labels | valid LI heap structures | locally consistent heaps can lack a global completion; no observation quotient |
| BLISS (2015) | refined bounded symbolic heap | program reads a field | SAT with equivalent declarative invariant | exactly LI's valid bounded heaps | heap invariant separate from path behavior; no class enumeration |
| LISSA (2022) | bounded partial heap | program reads a field; `repOK` demands fields while solving | bounded-exhaustive SymSolve using executable `repOK` | no valid heap path is pruned | heap and primitive path feasibility can conflict |
| PLI (2023) | symbolic heap plus path condition | field access or primitive branch | joint SymSolve, SMT, and symbolic precondition execution | exactly LI's feasible scoped symbolic states | paths/states are not grouped into exact observer fibers |

## Claims the lineage defeats

The paper must not claim any of the following as new:

- representing many bounded concrete inputs by a partial input;
- backtracking only on fields read by an executable predicate;
- refining only the component demanded by a consumer;
- avoiding construction of components the consumer never inspects;
- pruning all completions when a Boolean result is already known;
- using an existential completion solver to prune partial states;
- canonical allocation to remove isomorphic bounded heaps; or
- proving that demand-driven feasibility pruning preserves every feasible
  state of a baseline symbolic exploration.

Korat, Lazy SmallCheck, and SPLat are especially damaging to a thesis phrased
merely as “demand-sensitive exhaustive symbolic evaluation.” Korat already
gives access-guided bounded exhaustive generation; Lazy SmallCheck gives
demanded-hole refinement of partial pure inputs; SPLat gives demand-populated
configuration exploration with feasibility checks and concrete witnesses.

## Remaining exact object

The defensible target is narrower and more mathematical. Fix a pure graph
$G$, requested roots $R$, and a total input domain $X$. Define independently
of the algorithm:

\[
  \Omega_{G,R}:X\to\mathcal O,
\]

where $\Omega_{G,R}(x)$ is the partial map from selection-site identity to
the outcome observed in the input-relative enabled closure. The algorithm must
enumerate the finite image $\operatorname{im}\Omega_{G,R}$ and, for every
$o$ in that image, return:

1. the exact guard $\Gamma_o=\Omega_{G,R}^{-1}(o)$;
2. a witness in $\Gamma_o$;
3. the symbolic residual result valid on all of $\Gamma_o$; and
4. no second record for the same $o$.

This changes the problem from searching a partial-input tree to enumerating a
semantic quotient. Lazy SmallCheck's known partial terms are cylinders that
*cover* a Boolean preimage; they are not claimed to be the full preimage or
its canonical maximal components. Heap lazy initialization preserves baseline
states; it does not identify and merge all states with the same observer key.

## Reduction stress test

There is nevertheless a serious possible reduction to Lazy SmallCheck or
SPLat:

1. encode the graph input as a bounded algebraic term;
2. make the property return an encoded observation rather than `Bool`;
3. use tagged-hole exceptions to refine a demanded input component; and
4. collect known partial terms by returned observation.

This supplies a sound cylinder cover when the evaluator is pure and the
bounded domain matches. To realize our full contract it still needs a
nontrivial aggregation layer that proves the union of all cylinders with key
$o$ is exactly $\Omega^{-1}(o)$, represents that union as a guard, computes a
single residual, and detects completion without enumerating every cylinder.
Our novelty cannot rest on the refinement skeleton; it must rest on this
observer-specific quotient construction, its graph semantics, and its
enumeration/complexity guarantees.

For SPLat, the analogous key is the accessed-variable assignment that produces
one test trace. Equality of this operational trace with the graph's contextual
selection observation has not been proved. Nor does the paper expose the union
of all complete configurations for a trace as one exact symbolic guard or
compute a residual result over that union.

## Terminology consequence

Use source-specific terms:

- **demanded hole** for Lazy SmallCheck;
- **accessed/uninitialized field** for lazy initialization;
- **feasible partial state** for solver-pruned heap exploration; and
- **observed selection site** for our graph semantics.

Neither *active selection* nor bare *demand* should identify our formal object.
The established neighboring words refer to different operational events.

## Theoretical obligations sharpened by this lineage

- Define the observation function before presenting the enumerator.
- Prove exact-fiber equality, not merely sound cylinder coverage.
- State whether the output is one record per observation or a possibly
  fragmented cover; the paper requires the former.
- Separate structural non-observation from an unknown unforced input field.
- Account for duplicate suppression/merging and guard serialization in the
  complexity measure.
- State finiteness assumptions precisely. Lazy SmallCheck and heap methods buy
  exhaustiveness through explicit depth/scope bounds; our finite image must
  follow from finite selection sites/outcomes even when input theories are
  infinite.
