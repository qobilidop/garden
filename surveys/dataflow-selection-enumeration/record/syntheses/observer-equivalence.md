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
  \prod_{q\in Q}(\{\mathsf{unobs}_q\}\cup\Omega_q),

where coordinate $q$ is $\mathsf{unobs}_q$ precisely when $q$ is outside the
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

## Framework proof obligations and survey value

The survey's formal synthesis establishes more than equivalence-class
existence while making no novelty claim for the component machinery:

1. enabled closure determines which sites contribute outcomes, while selective
   logging and totalized reachability-and-outcome coordinates represent the
   same sparse observation;
2. the observed-outcome guard and residual-correctness theorems state the full
   local record contract;
3. local full-fiber blocking and global projection enumerate the same complete
   observation image, with residualization charged separately;
4. comparison with projected AllSMT and IECP exposes which observer and output
   representation each method preserves; and
5. the complexity analysis charges solver cost, guard size, residual DAG size,
   duplicate suppression, and serialized output.

These are maintained transfer conditions for the survey framework. They show
why the approaches are comparable without implying a new generic enumeration
algorithm or an automatic performance advantage.

## Terminology

Use **selection observation**, **observed site**, **observation fiber**, and
**observer-induced partition**. The neighboring literature supports
*equivalence class partitioning*; it does not support *active selection* as a
term of art.
