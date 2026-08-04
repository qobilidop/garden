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

If there are `K` feasible observations, model-and-full-fiber-block enumeration
makes one successful model-producing solver invocation per observation plus a
final unsatisfiable invocation, provided each emitted fiber formula is exact.
This exact `K+1` count is linear in the number of records under a unit-cost
model-producing-oracle abstraction. It is not an OutputP, IncP,
polynomial-delay, or wall-clock result. It extensionally matches naive
projected AllSMT that emits every complete totalized observation tuple; short
partial cubes change the output object. Total solver work, serialized guards
and residuals, compilation, and summary reuse—not merely invocation count—must
distinguish an algorithm.

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
