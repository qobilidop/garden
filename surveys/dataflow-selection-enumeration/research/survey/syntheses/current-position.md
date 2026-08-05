# Current position

## Survey question

The paper is a problem-centered survey of exhaustive enumeration of selection
observations in finite pure dataflow graphs. For a caller domain and requested
roots, the target observer records the contextual outcomes of exactly the
selection sites in the enabled closure. The required output is one exact guard,
residual, and witness per nonempty observer fiber.

The paper does not survey symbolic execution, dataflow, or model enumeration in
general. A work belongs in the main comparison only when it is a direct
presentation of this contract, a strict specialization with stronger
assumptions, or an adjacent comparator needed to establish a boundary.

## Unified comparison framework

Every approach is described using three separate choices:

1. the **observer**, which determines the input partition;
2. the **enumeration mechanism**, which discovers the nonempty fibers; and
3. the **representation**, which stores guards, residuals, witnesses, and
   shared structure.

Observer refinement is kernel inclusion. Sparse and totalized selection maps
are isomorphic presentations of one observer. Coordinate projection,
equal-behavior coalescing, path refinement, and property-relative pruning may
instead produce coarser, finer, or incomparable partitions.

## Principal solution families

| Family | Relationship to the target |
|---|---|
| Guarded symbolic execution | Direct after requested-root demand, contextual event logging, and full-fiber grouping |
| Projected model enumeration | Direct after inactive-or-outcome activity instrumentation |
| Decision structures | Direct when compiling the totalized observer rather than only the output function |
| Demand-guided search | Direct only after its demand judgment and record contract are proved equivalent |
| Geometric and parametric enumeration | Strict all-sites-observed affine specialization with stronger output-sensitive results |
| Compositional guarded summaries | Exact representation under requested-output demand, contextual identity, and explicit interface support |

Partial-order reduction, Petri-net unfoldings, observer-guided state reduction,
and broad dataflow semantics remain adjacent evidence. They establish that
omission is observer-relative but do not emit caller-input fibers with typed
residuals.

## Stable conclusions

- The selection-observation formulation is not a new generic enumeration
  paradigm.
- Enabled reachability, sparse event maps, positive local guards, and
  totalized projected coordinates are equivalent presentations of the target
  observer under the paper's finite total graph assumptions.
- A local model-and-full-fiber-block generator and a global projected encoding
  have the same naive complete-observation image, but not the same runtime,
  memory use, or output representation.
- Exact composition with flattening does not imply compact summaries or reuse.
- Stronger complexity results belong to restricted geometric, parametric, or
  precompiled representations and do not transfer automatically.

## Maintenance implication

A new work changes the paper when it provides a more direct reduction, a new
solution family, a stronger guarantee for the same observer, a broader exact
program model, or a representation result that changes the comparison. Such a
finding updates the source note, affected thematic synthesis, claim ledger,
evidence matrix, and manuscript; adding a catalog row alone does not complete
the update.
