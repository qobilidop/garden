# Observer-induced equivalence partitions

## Established construction

For any total observer $f:X\to Y$, equality of observations induces the
kernel equivalence

\[
  x\sim_f x'\iff f(x)=f(x'),
\]

whose classes are the nonempty fibers $f^{-1}(y)$. This elementary fact has
algorithmic precedents unusually close to our target:

- Krafczyk and Peleska enumerate exact input classes preserving a finite
  transition-behavior observer from every state class, then minimize to the
  coarsest behavioral partition.
- Huang, Krafczyk, and Peleska enumerate every satisfiable Boolean atom of a
  finite guard/output/property alphabet over possibly infinite domains.
- Projected AllSMT enumerates the finite image of instrumented observer
  variables directly.

Consequently, the paper cannot present “partition the input domain by a finite
observer and enumerate all nonempty fibers” as an original theoretical result.

## Exact placement of our observer

Our total observer is

\[
  \overline\Omega_{G,R}:X\to
  \prod_{q\in Q}(\{\bot_q\}\cup\Omega_q),

where coordinate $q$ is $\bot_q$ precisely when $q$ is outside the
input-relative enabled closure of requested roots $R$. The sparse partial map
$\Omega_{G,R}$ and this total vector are bijective presentations of the same
finite observation.

This makes the desired result set exactly

\[
  \operatorname{im}\overline\Omega_{G,R}
  \quad\text{and guards}\quad
  \overline\Omega_{G,R}^{-1}(o).

The mathematics of this quotient is standard. What requires graph-specific
proof is the claimed compact representation

\[
  \Gamma_o=A\land
  \bigwedge_{q\in\operatorname{dom}(o)}p_{q,o(q)},

with no explicit negative literal for the unobserved coordinates. That formula
is exact only if the observed outcomes structurally entail the same enabled
closure. A proof must handle sharing, multiple requested roots, selectors that
demand several cases, and contextual call identities.

## Comparison of enumerators

| Construction | Coordinates fixed per result | Search organization | Result guard | Coarsening |
|---|---|---|---|---|
| Boolean-atom enumeration | every formula in a fixed alphabet | all satisfiable positive/negative combinations | complete atom | project or union atoms |
| IOSTS IECP | transition behavior from every finite state class | satisfiable local subsets, then global products | conjunction/product formula | transducer minimization to coarsest behavior |
| projected AllSMT | chosen finite ghost vector | solver model plus projected blocking | existential projected fiber | inherent equality on projection |
| graph full-fiber blocking | only observed site outcomes; inactivity intended to follow structurally | evaluate witness, derive local fiber, block it | claimed compact exact fiber | group by complete sparse observation |

The fourth row is therefore best understood as a specialized compilation and
enumeration strategy for a standard observer quotient.

## Remaining research hypothesis

A defensible original theorem package would need more than equivalence-class
existence:

1. a graph semantics proving enabled closure, selective logging, and totalized
   ghost instrumentation equivalent;
2. exact-local-guard and residual-correctness theorems;
3. a structure-directed enumerator that produces one record per observation
   without pre-enumerating the full Boolean alphabet;
4. a precise comparison with projected AllSMT and IECP showing what work or
   representation is avoided; and
5. a lower/upper-bound analysis that accounts for solver cost, guard size,
   residual DAG size, duplicate suppression, and serialized output.

Without a nontrivial advantage in item 4 or 5, the work is a valuable semantic
reconciliation or survey result, but not yet a PLDI-level algorithmic
contribution.

## Terminology

Use **selection observation**, **observed site**, **observation fiber**, and
**observer-induced partition**. The neighboring literature supports
*equivalence class partitioning*; it does not support *active selection* as a
term of art.

