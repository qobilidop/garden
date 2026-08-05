# Current position

## Survey conclusion

The selection-observation formulation is not a new enumeration paradigm.
Existing literatures already provide the principal ingredients: guarded
symbolic partitions, projected and partial model enumeration, sparse choice
fingerprints, demand-relative refinement, observer-equivalence partitions,
decision structures, exact geometric regions, and observer-preserving search
reductions.

The paper's defensible role is to compare these mechanisms under one explicit
observer and explain which notions of “omission” preserve which information.
The selection-observation formalism is a unifying running instance, not evidence
of priority merely because no paper uses exactly the same package.

## Stable comparison boundaries

| Theme | Established boundary | Consequence for this survey |
|---|---|---|
| Symbolic execution | Exact guards and residual states or values already partition behavior | Do not claim guard-plus-residual output as new |
| Model enumeration | Projected AllSMT and disjoint partial models enumerate selected finite coordinates | Treat activation instrumentation as a direct baseline |
| Demand and functional logic | Needed evaluation and fingerprints omit choices not reached by a computation | Distinguish graph observation from operational demand, not by sparsity alone |
| Decision structures | Root-to-leaf paths and reduced diagrams encode partial encountered tests and exact finite observers | A sparse decision map or exact input partition is insufficient novelty |
| Observer equivalence | Finite observers induce exact input fibers and can be minimized behaviorally | Present the quotient as standard and the graph-local guard as specialized |
| Geometric and neural regions | Exact region enumerators emit guards and affine outputs, sometimes pruning forced tests | Separate structural non-observation from feasibility or extensional pruning |
| Concurrency and unfoldings | POR, prefixes, and state quotients preserve selected behaviors or observers | Avoid conflating caller-input fibers with run/configuration reduction |
| Dataflow and composition | Demand propagation, selective interpretations, and guarded component composition are established | Attribute component constructions and state only the cross-literature correspondence |

## Narrow formal synthesis

For a fixed deterministic pure graph and requested roots, the paper observes
the outcomes of exactly those input-selected sites in the enabled closure,
retains equal-valued observed alternatives, and omits sites outside that
closure. It then relates:

1. enabled-edge reachability;
2. sparse graph-relative outcome maps;
3. exact inverse-image guards and residual values;
4. ghost inactive-or-outcome instrumentation; and
5. projected model enumeration.

The elementary fiber partition and one-model-per-fiber query count are known or
derived baselines. The useful result is a careful correspondence with explicit
scope conditions for sharing, contextual identity, totality, and solver
completeness.

## Maintenance implication

A new work matters when it changes one of the boundaries above: it introduces a
new omission mechanism, proves a stronger preservation or complexity result,
handles a broader program model, or more directly subsumes the running
observer. Such a work updates the relevant thematic synthesis, the subsumption
table, `research/claims.md`, and the manuscript; merely adding it to the catalog
does not complete the update.
