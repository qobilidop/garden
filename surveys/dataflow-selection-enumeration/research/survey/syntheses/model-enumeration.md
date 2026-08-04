# Projected enumeration and knowledge compilation

## Strongest reduction

Let each contextual selection occurrence `q` have an observation variable
`z_q` whose finite domain is `inactive` plus its outcomes. A polynomial graph
encoding defines site activity, selected outcomes, internal values, and the
ordinary output as functions or relations over inputs. Projecting the formula
onto the `z_q` variables gives exactly the feasible total selection
observations.

Existing machinery then supplies the operational pieces:

- AllSMT enumerates important Boolean predicates and returns values for chosen
  theory variables.
- Disjoint projected SAT/SMT enumeration removes internal variables and emits
  nonoverlapping partial models.
- Canonical decision diagrams modulo theories compile the selected atom space
  once the theory-inconsistent assignments are removed.
- Partitioned ROBDDs and deterministic decision diagrams already pair input
  regions with residual functions and can exploit extensive sharing.

## Two kinds of omission

Projection eliminates variables designated irrelevant to the query. Implicant
shrinking additionally omits literals that are logical don't-cares for a
formula. Our proposed sparse map uses a different criterion: `z_q` takes the
explicit value `inactive` precisely when the structural observer does not
expose site `q`. If `q` is active, its outcome remains observed even when both
alternatives compute the same output.

This distinction survives the reduction because `inactive` can simply be
encoded as a sentinel. It therefore does not establish algorithmic novelty.

## Complexity baseline

If there are `K` feasible observations, model-and-block enumeration can make
one satisfiable query per observation plus a final unsatisfiable query, provided
each emitted fiber formula is exact. This `K+1` oracle-call count is
output-sensitive but extensionally matches projected AllSMT. Total solver work,
formula construction, residual generation, and summary reuse—not merely query
count—must distinguish a new algorithm.

## Claims ruled out

- Sparse disjoint assignments are not new.
- Exact coverage and nonoverlap follow from deterministic observation or from
  established enumeration algorithms.
- “Canonical” cannot mean stable graph numbering; logical canonicity requires
  an equivalence and fixed representation conditions.
- Exponential savings over all total assignments are a standard consequence of
  partial models or shared decision diagrams.

## Remaining opportunity

A non-flattening compositional summary calculus could differ from the logical
reduction if it proves exact substitution and realizes asymptotic or practical
reuse unavailable to the flat encoding. That claim is currently open.
