# Current position

## Survey question

The paper is a problem-centered survey of exhaustive enumeration of selection
observations in finite pure dataflow graphs. For a caller domain and requested
roots, the target observer records the contextual outcomes of exactly the
selection sites in the enabled closure. The required output is one exact guard,
residual, and witness per nonempty observer fiber.

The paper does not survey symbolic execution, dataflow, or model enumeration in
general. A work belongs in the main comparison only when it is a direct
presentation of this contract, a restricted specialization with stronger
assumptions, or an adjacent comparator needed to establish a boundary.

## Unified comparison framework

Every approach is described using three separate choices:

1. the **observer**, which determines the input partition;
2. the **enumeration mechanism**, which discovers the nonempty fibers; and
3. the **representation**, which stores guards, residuals, witnesses, and
   shared structure.

Observer refinement is kernel inclusion, equivalently factorization through
the finer observer's feasible image. Sparse and totalized selection maps
are isomorphic presentations of one observer. Coordinate projection,
equal-behavior coalescing, recording full paths, and property-relative pruning may
instead produce coarser, finer, or incomparable partitions.

## Closest established results

The closest works are not merely the broad traditions used to organize the
paper. PESO is the closest formal output-directed path-enumeration predecessor:
it gives relevant-slice conditions, symbolic outputs, witnesses, and a
conditional completeness argument. SPD is the closest shared path-family and
guarded-residual predecessor. Feng et al.'s mux functional-space partitions
are the closest restricted pure-dataflow guard/residual representation, while
Kanade et al. are the closest graphical-dataflow trace-equivalence predecessor.
Stable functional-logic fingerprints are the closest sparse choice-map
representation. SPLat is a close demand-populated configuration explorer, and
Wang et al. provide the strongest general exact equivalence-class enumeration
result under an acyclic decomposable AND/OR representation.

None is silently identified with the target. Exact correspondence to PESO,
SPD, and Feng's actual algorithms remains open; Kanade computes an
underapproximation; the functional-logic observer is nondeterministic; SPLat
does not emit exact fiber guards or residuals; and Wang's output is a colored
class tree rather than a caller-input record. The field-by-field comparison is
maintained in `approach-guarantees.md`.

## Recurring solution routes

| Route | Relationship to the target |
|---|---|
| Guarded symbolic execution | Direct only after requested-root demand, contextual event logging, and proved full-fiber grouping; the closest published output-directed algorithms have an open correspondence |
| Projected model enumeration | Direct for observation indexing after unobserved-or-outcome instrumentation; residuals require a separate exact step |
| Decision structures | Direct when compiling the totalized observer rather than only the output function |
| Demand-guided search | Open correspondence until its demand/trace judgment and record contract are proved equivalent |
| Geometric and parametric enumeration | Dense strict-sign cells are a restricted direct specialization on boundary-free whole-cell domains; optimizer critical regions generally use a different observer |
| Compositional guarded summaries | Exact representation under requested-output demand, contextual identity, and explicit interface support |

Partial-order reduction, Petri-net unfoldings, observer-guided state reduction,
and broad dataflow semantics remain adjacent evidence. They establish that
omission is observer-relative but do not emit caller-input fibers with typed
residuals.

## Stable conclusions

- The selection-observation formulation is not a new generic enumeration
  paradigm.
- Enabled reachability determines which sites contribute outcomes. Sparse event
  maps, observed-outcome guards, and totalized reachability-and-outcome
  coordinates are equivalent presentations of the target observer under the
  paper's finite total graph assumptions; the closure alone is coarser.
- A local model-and-full-fiber-block generator and a global projected encoding
  have the same naive complete-observation image, but projection alone does not
  build a fiber-wide residual and the routes need not share runtime, memory use,
  or output representation.
- Exact composition with flattening does not imply compact summaries or reuse.
- Stronger complexity results belong to restricted geometric, parametric, or
  precompiled representations and do not transfer automatically.

## Maintenance implication

A new work changes the paper when it provides a more direct reduction, a new
solution route, a stronger guarantee for the same observer, a broader exact
program model, or a representation result that changes the comparison. Such a
finding updates the source note, affected thematic synthesis, claim ledger,
evidence ledger, and manuscript; adding a catalog row alone does not complete
the update.

The record is presently a bounded search snapshot, not a closed evidence map.
Deep-read and screened works support the current synthesis, while the remaining
`candidate` rows are an unresolved discovery backlog. Absence of a closer paper
from the reviewed set is not evidence that none exists.
