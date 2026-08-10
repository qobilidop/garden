# Current position

This file is the compact entry point to the survey's current interpretation.
It owns the high-level cross-paper conclusions, not the study method, dated
status, update procedure, evidence records, or route-by-route matrix.

## Target of comparison

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
