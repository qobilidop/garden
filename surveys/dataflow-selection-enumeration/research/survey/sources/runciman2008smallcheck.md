# runciman2008smallcheck — SmallCheck and Lazy SmallCheck

- **Status:** deep-read; critical demand-driven-testing predecessor
- **Primary source:** https://doi.org/10.1145/1411286.1411292
- **Version read:** ACM Haskell Symposium paper, pp. 37--48
- **Open copy:** https://www.cs.york.ac.uk/fp/smallcheck/smallcheck.pdf
- **Bibliography key:** `runciman2008smallcheck`

## Why it matters

Lazy SmallCheck already implements the central operational idea of refining
only an observer-demanded unknown. It applies a Boolean property to a partial
algebraic value, discovers the particular hole whose value was demanded, and
branches only on refinements of that hole. If the property returns a known
Boolean, every bounded total refinement has the same result and the remaining
holes are not generated.

This defeats any claim that demand-guided partial-input refinement, or pruning
all completions once an observer becomes known, is new. The safe separator is
the object being enumerated: the published algorithm searches for a
counterexample to one Boolean property. It does not enumerate a canonical set
of site-indexed selection observations, their exact inverse images, and
symbolic residual results.

## Bounded domain and partial values

SmallCheck enumerates all finite, total values of a first-order algebraic type
up to a user-supplied constructor-depth bound. Lazy SmallCheck represents a
candidate as a constructor tree with tagged holes. Each hole records a tree
position and stands for all depth-admissible total terms that refine it.

For a partial term $p$, write $\gamma_d(p)$ for its bounded set of total
refinements. The key observation in Section 4 is a cylinder property: if a pure
Boolean property evaluates to `True` or `False` without inspecting a hole,
then replacing that hole cannot alter the answer. Thus a known answer on $p$
summarizes every value in $\gamma_d(p)$.

The implementation uses imprecise exceptions to detect which tagged hole was
forced:

```haskell
data Answer = Known Bool | Unknown Pos
```

This is operational demand, not backward static dependence. Which position is
reported can depend on Haskell evaluation order and on whether the property
uses ordinary or parallel conjunction.

## Refutation algorithm

The generic `refute` procedure starts from the universal term for the chosen
depth and evaluates the property:

- `Known False` reports a counterexample and stops;
- `Known True` discards all total refinements of that partial term; and
- `Unknown pos` replaces the demanded hole by every one-step constructor
  refinement and recurses.

Consequently it is exhaustive for failure search over the same bounded domain
as ordinary SmallCheck, assuming a terminating pure first-order property and
the implementation's exception discipline. The paper presents this through
the construction and examples rather than a numbered soundness/completeness
theorem.

The standard interface deliberately stops at the first failure. Even if
adapted to emit every `Known True` partial term, its leaves need not be the
coarsest cylinders on which a richer observer is constant: distinct demand
orders or constructor prefixes can fragment one semantic fiber, and no merge
or maximality phase is given.

## Performance evidence

The paper gives empirical test counts, not a general asymptotic analysis. For
the depth-seven ordered-set insertion property, ordinary SmallCheck runs
109,600 tests while Lazy SmallCheck requires 1,716; parallel conjunction
reduces the latter to 653. Laziness can also lose: for a strict property at
depth six, SmallCheck runs 1,957 tests and Lazy SmallCheck 2,378 because the
latter fruitlessly visits partial terms before reaching total ones.

The search tree can still be as large as the bounded total domain. There is no
polynomial-delay, output-polynomial, nonduplication, or minimal-cylinder
result.

## Exact relationship to selection-observation enumeration

For a fixed graph observer $\Omega_G$, an adaptation could evaluate a partial
input and emit it when $\Omega_G$ is known. That would give a sound cover by
cylinders: every completion of an emitted partial input has the same
observation. It would not by itself provide the paper's intended contract:

- one record per realizable site-outcome map;
- an exact symbolic guard equal to the entire inverse image
  $\Omega_G^{-1}(o)$ rather than one constructor cylinder inside it;
- a graph-intensional identity for observed selection sites;
- a symbolic residual result valid throughout the guard;
- disjointness and completeness of the emitted guards; or
- a complexity bound in terms of realizable observations and solver calls.

The distinction is visible even for a single selector. A partial-input search
may split the same `true` observation fiber along unrelated constructor
prefixes before it discovers the selector value. Observation enumeration can
merge those fragments into the exact selector guard because the output key is
the site-outcome map, not the partial input that happened to reveal it.

Safe claim:

> Lazy SmallCheck establishes observer-demanded refinement and pruning of
> bounded completions once a Boolean observer is known. Our remaining target
> is canonical enumeration of exact graph-selection observation fibers with
> guards, residuals, and witnesses.

## Evidence locations

- Section 3, paper pp. 39--42: exhaustive depth-bounded total-value domain.
- Section 4 opening, p. 42: partial inputs summarize all total refinements.
- Sections 4.1--4.4, pp. 42--44: implication, evaluation-order sensitivity,
  parallel conjunction, and the strict-property counterexample.
- Sections 4.5--4.6, pp. 44--46: tagged holes, `Answer`, `refine`, and the
  refutation algorithm.
- Section 4.7 and Table 3, pp. 46--47: comparative test counts.

## Limitations for our use

- The bounded domain is constructor depth, not an arbitrary SMT-described
  finite or infinite input domain.
- The published interface is universal Boolean property refutation, not
  exhaustive enumeration of successful equivalence classes.
- Partiality is a constructor-tree hole; an absent graph-site coordinate is a
  different, intensional form of non-observation.
- No exact guard language, residual symbolic value, stable graph-site map, or
  semantic coalescing criterion is defined.
- Demand order is operational and can change the explored partial-term cover.

