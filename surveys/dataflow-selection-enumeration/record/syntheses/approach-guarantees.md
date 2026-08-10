# Approach guarantees and correspondence status

This matrix is the canonical answer to RQ3 and RQ4. It compares the strongest
representative results against the survey target rather than treating a shared
algorithmic vocabulary as equivalence. A row is **direct** only when the work's
observer and output contract coincide with the target after stated mechanical
instrumentation. **Restricted direct** means exact correspondence on a strictly
smaller program/domain class. **Adjacent** means that one or more observer or
record obligations differ. **Open correspondence** means the source is close
enough that a reduction may exist, but the survey has not proved it.

The target record is one tuple

\[
  (\tau,\gamma_\tau,r_\tau,m_\tau)
\]

per nonempty fiber of the requested-root selection observer: complete and
duplicate-free observation image, an iff input guard, a fiber-wide residual,
and a witness.

## Route-level summary

| Route | Relationship to target | What is established | What remains separate |
|---|---|---|---|
| Local guarded generation | direct survey derivation on the stated graph model | observed-outcome guard is exactly one fiber; full-fiber blocking gives one model per fiber plus final unsatisfiability | solver cost, residual representation cost, and stronger enumeration-class bounds |
| Global projected enumeration | direct for observation indexing after reachability/outcome instrumentation | projected complete tuples enumerate the totalized observation image | a projected model is not a fiber-wide residual; short projected cubes can cover several complete observations |
| Decision structures | direct compilation target when terminals encode the totalized observer | exact finite-range function representation; canonicity under fixed-order BDD conditions | symbolic residuals and compactness relative to record count |
| Demand-guided search | open correspondence | partial objects, demand-populated decisions, feasibility pruning, and concrete witnesses | equality of its operational trace/demand key with the selection observer; one exact union guard and residual per fiber |
| Geometric/parametric traversal | restricted direct only for boundary-free all-sites-observed affine cells | complete duplicate-free cell or basis enumeration and stronger output-sensitive bounds under source-specific assumptions | variable structural absence, arbitrary caller predicates, boundary ownership, lower-dimensional fibers, and full record cost |
| Guarded component summaries | direct survey derivation under the full-domain, locality, identity, and exact component-summary assumptions | residual substitution and namespaced observation union agree with flattening | compactness, reuse, and output-sensitive construction |

The six rows are overlapping research and implementation routes, not a
classification of all literature. A work may contribute an observer,
enumerator, and representation from different rows.

## Closest representative works

| Work | Native observer or quotient | Coverage/nonrepetition | Guard | Residual | Witness | Relationship and limiting assumption |
|---|---|---|---|---|---|---|
| Qi et al., PESO (2013) | reordered relevant-slice condition at requested output criteria | conditional exploration completeness for the finite RSC set under a sound and complete solver; no proof that RSCs are the coarsest output quotient | RSC/path condition | symbolic requested outputs | solver-generated test | closest formal output-directed predecessor; open whether instrumentation plus RSC subsumption yields one exact selection fiber per record |
| Santelices et al., SPD (2010) | queried values represented by dependence-relevant path families | exact mode is described as matching pathwise symbolic execution; no numbered end-to-end theorem | path-family conditions | shared guarded symbolic values | not the exposed record | closest shared path-family/residual predecessor; open correspondence because dependence may conservatively retain distinctions and records may fragment a fiber |
| Feng et al. (2004) | mutually exclusive control/data functional-space cells | mux rules are intended to cover the functional space; no target-level completeness proof for every observed source site | Boolean control cell | data expression | not exposed | restricted-close pure hardware/dataflow representation; merge and heuristic split-point choices can erase source-event provenance |
| Kanade et al. (2009) | equality of bounded discrete Simulink traces | symbolic regions underapproximate the sampled trace class | sufficient symbolic predicate | symbolic transformer | sampled trace/input | closest graphical-dataflow trace-equivalence predecessor, but not an exhaustive exact partition |
| Sylvia (2023) | feasible combinations of RTL block path fragments | SMT filters the path-fragment cross-product; no selection-fiber theorem | fragment path constraints | not a fiber-wide symbolic result contract | replayable model | adjacent modular construction; full combination remains exponential in the stated worst case |
| Functional-logic fingerprints and memoized pull-tabbing (2009--2021) | 2009 executed-step fingerprint; 2010 stable choice-ID propagation; 2021 task-local partial map from IDs to outcomes | complete/fair search belongs to source-specific strategies; MPT itself has no new soundness/completeness theorem | no caller-input guard | computed nondeterministic result, not a symbolic input residual | evaluation task | closest representation lineage for stable sparse choice maps; different nondeterministic observer and identity discipline |
| Lazy SmallCheck (2008) | Boolean property result over demanded partial constructor input | bounded exhaustive failure search | known partial terms are sound cylinders, not one maximal/exact fiber | no requested graph residual | concrete completions during search | adjacent demand-refinement skeleton |
| SPLat (2013) | unique reachable test execution trace under configuration inputs | paper claims one execution per distinct trace; no formal soundness/completeness/nonrepetition theorem | feasible partial configuration cylinder, not exposed as an exact guard API | none | executed configuration | close demand-populated configuration precedent; reset/effects and observer correspondence remain separate |
| Wang et al. (2021) | locally colored equivalence classes of solution trees in an acyclic decomposable AND/OR graph | Theorem 7 enumerates every class exactly once with delay \(O(ns)\) | none over caller inputs | class tree only | none | strongest general quotient-enumeration precedent; direct only after a nontrivial reduction to its restrictive representation |
| Projected AllSMT | equality on selected instrumented coordinates | complete tuples give exact image enumeration; disjoint projected methods may instead emit shorter covers | existential projected fiber; a cube may cover multiple tuples | none by projection alone | model | direct observation-index baseline after totalized reachability/outcome instrumentation |
| Hyperplane reverse search | strict sign vector/full-dimensional cell | complete, duplicate-free, output-sensitive under arithmetic or LP-oracle models | open polyhedral cell | only if ordinary graph computation is separately specialized/charged | representative point varies by method | restricted direct observation/guard enumerator, not automatically the full four-field record |
| Parametric LP/QP/LCP traversal | optimizer basis or critical region | full-dimensional basis/region coverage under source-specific degeneracy assumptions | usually closed polyhedral critical region | affine optimizer | basis/point varies | adjacent unless observer correspondence and boundary ownership are supplied; closed regions can overlap on boundaries and lower-dimensional-only regions may be omitted |
| Chang et al. (2026) | extensional neural-policy region/decision tree | exact policy preservation for the stated representation | decision-region predicates | selected action/policy output | not the target record | strong modern comparator for requested-output quotienting, which is coarser than event-preserving selection observation when equal-valued outcomes differ |

## Consequences for novelty and transfer

The local guard/residual/witness shape is not new as a collection of fields.
PESO, SPD, functional-space partitioning, symbolic execution, and geometric
methods collectively supply close precedents for all of them. Nor is direct
equivalence-class enumeration new: Wang et al. prove it for a restricted
decomposable representation.

The survey's defensible contribution is the explicit target observer, the
proof that two general SMT presentations induce its exact fibers on the stated
graph model, the demanded-port locality/composition derivation, and the
comparison discipline that prevents guarantees from moving between different
observers. These formal correspondences are survey-authored and have not been
peer reviewed, mechanized, or independently verified.

Three reductions remain open and should not be implied by wording such as
"subsumes" or "is equivalent":

1. whether PESO over an instrumented selection-output vector, with an explicit
   RSC quotient, yields exactly one record per selection fiber;
2. whether SPD's dependence-relevant path-family graph can be proved to denote
   exactly the enabled-closure observer rather than a refinement; and
3. whether Feng's mux partitioning with immutable contextual event labels and
   all source muxes retained gives the same partition under its actual
   split/merge algorithm.
