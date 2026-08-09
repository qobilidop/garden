# geyer2010mode — compositional hybrid mode enumeration

- **Status:** deep-read; critical compositional affine baseline
- **Primary source:** https://doi.org/10.1080/00207170903159285
- **Open copy:** https://www.tobiasgeyer.org/GeTM10_EffModeEnum.pdf
- **Version read:** author manuscript of the 2010 journal article
- **Bibliography key:** `geyer2010mode`

## Why it matters

Geyer, Torrisi, and Morari enumerate the feasible modes of a composition of
discrete hybrid automata and translate the result into an equivalent
piecewise-affine system. For loop-free compositions, their algorithm processes
components in topological order, substitutes the selected upstream affine map
into downstream event guards, refines the current polyhedral partition, and
discards infeasible combinations. This is a direct predecessor for guarded
residual composition in the affine special case.

The preliminary HSCC paper appeared in 2003; the 2010 article is the expanded
canonical source and also treats feedback compositions.

## Model and output object

A discrete hybrid automaton contains a finite-state machine, an event
generator defined by affine inequalities, a mode selector, and switched affine
state and output equations. For each feasible compound case (j), the
algorithm emits

\[
  (P_j,S_j),
  \qquad
  S_j=(A_j,B_j,f_j,C_j,D_j,g_j),
\]

where the polyhedron (P_j) is the exact guard and (S_j) is the affine
next-state/output residual. Proposition 2.2 establishes coverage and
well-posedness of the resulting PWA representation for a well-posed automaton.
Different event markings may select the same mode, and neighboring cells may
carry the same affine dynamics, so the representation is intentionally not
canonical or minimum by behavior.

## Enumeration and composition

Algorithm 4.1 enumerates the feasible event markings of one component by
enumerating cells of its event-hyperplane arrangement. Algorithm 4.6 handles a
loop-free composition:

1. topologically order the component automata;
2. enumerate the current component inside each parent polyhedron;
3. substitute the parent's affine output map into the current component's
   event inequalities and affine dynamics;
4. intersect the guards and prune empty intersections; and
5. recurse over the refined cases.

In guarded-residual notation, one composition step has the familiar form

\[
  c(x)=g(x)\land h(r_G(x)),
  \qquad
  r(x)=r_H(r_G(x)).
\]

Lemma 3.5 supplies the constructive DHA/PWA equivalence, and Corollary 4.7
states that the loop-free algorithm yields a well-posed PWA partition for a
well-posed acyclic composition. Thus neither residual substitution into a
downstream guard nor topological refinement with infeasibility pruning is new
to our framework.

For feedback, the paper chooses a feedback arc set, replaces cut signals by
auxiliary inputs, performs the acyclic construction, adds equalities tying the
cut signals together, and projects the resulting polyhedra. Gaps or overlaps
can diagnose a composition that is not well posed. This is materially broader
than our current finite acyclic graph model, although the feedback result is
specialized to the paper's real polyhedral setting.

## Guarantees and complexity

For the loop-free case, coverage and disjointness follow from the component
PWA construction and the topological composition proof. The paper imports a
cell-enumeration bound of

\[
  O\!\left(n\,lp(n,d)\,\#M(R)\right)
\]

for one arrangement restricted to a polyhedron (R), where (n) is the
number of event hyperplanes, (d) the real dimension, (lp) the linear-
programming cost abstraction, and (\#M(R)) the number of reported markings.
It does not give a closed end-to-end output-sensitive bound for an arbitrary
compound automaton, a DelayP or IncP classification, coefficient-bit
complexity, or a serialized guard-size bound.

There is also a boundary qualification. The component model writes event
markings with one non-strict and one strict side, while the imported
reverse-search arrangement results enumerate strict full-dimensional cells.
The paper does not reconcile boundary-only markings with that imported count.
The cell-enumeration complexity credit is therefore safest under a strict or
interior-realizability assumption; the overall semantic construction still
uses the paper's stated deterministic boundary convention.

## Relationship to selection observations

If every affine threshold is represented as an always-observed selection site,
one emitted event marking is a dense observation and its PWA pair gives the
corresponding exact guard and affine residual. If instead one site represents
the mode chosen from several event bits, multiple Geyer cells can project to
one of our observations. Equal-dynamics cells likewise remain separate unless
an additional reduction is applied.

The surviving distinctions are structural rather than geometric:

- Geyer evaluates every component needed to construct the compound PWA model;
  it has no requested-root-relative enabled closure.
- Event markings are dense within each enumerated component; there is no
  input-dependent partial domain of static graph-site observations.
- The model is a real PWA composition, not an arbitrary typed shared pure DAG.
- It does not define contextual identities for internal sites under graph
  substitution or preserve observed equal-valued outcomes as a separate
  observer.
- It does not provide reusable summaries parameterized by a caller's requested
  output subset.

Consequently, this work defeats novelty for guarded affine residual
composition, componentwise topological refinement, infeasible-product pruning,
and exact PWA guard/residual output. It does not supply the requested-root
graph observer or the correspondence between sparse observations and their
positive local fibers.

## Motivating-example opportunity

The paper's Example 4.8 illustrates componentwise refinement by substituted
affine guards. A useful separating example can preserve that compositional
shape but add an outer bypass. On the bypass fiber, the downstream component's
selection site is structurally absent rather than merely assigned an entailed
or don't-care event marking. The non-bypass fibers then demonstrate the
inherited residual-substitution construction.

## Evidence locations

- Section 2 and Proposition 2.2: PWA representation and well-posedness.
- Section 3 and Lemma 3.5: constructive DHA/PWA equivalence.
- Algorithms 4.1 and 4.6: single-component and loop-free compound enumeration.
- Corollary 4.7: correctness of acyclic composition.
- Section 4.3: feedback-arc construction, projection, and well-posedness test.
- Section 5: examples and empirical behavior.

## Limitations

- The compound complexity is not summarized by an end-to-end enumeration
  theorem.
- The imported strict-cell bound and the model's non-strict boundary convention
  require care.
- Multiple event cells can have the same selected mode or affine behavior.
- The construction is specialized to real polyhedral guards and affine
  residuals.
