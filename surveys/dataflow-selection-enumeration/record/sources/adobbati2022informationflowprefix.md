# adobbati2022informationflowprefix — Full prefixes for transition information flow

- **Status:** deep-read; finite-prefix and transition-observation boundary
- **Primary source:** https://doi.org/10.1109/ACCESS.2022.3165185
- **Publisher-version full text:**
  https://pure.rug.nl/ws/portalfiles/portal/216878575/A_Finite_Prefix_for_Analyzing_Information_Flow_Among_Transitions_of_a_Free_Choice_Net.pdf
- **Version read:** IEEE Access version of record, volume 10, 2022,
  pp. 38483--38501
- **Bibliography key:** `adobbati2022informationflowprefix`

## Why it matters

The paper gives an exact finite summary for an internal-event observer over
concurrent behavior. Its full prefix supports positive and negative
information-flow queries and exhaustive enumeration of the distinct sets of
transition labels appearing in maximal runs. It is therefore close precedent
for finite observer-relative summarization, although its semantic object is a
Petri-net run rather than a caller-input fiber.

## Program and semantic model

The working setting is a finite, 1-safe, 1-live Petri net whose transitions
have nonempty presets (Section II, p. 38485). Section III additionally assumes
progress: an enabled transition fires or is disabled by a conflicting
transition (p. 38486). The main prefix results require free-choice nets and
maximal-step semantics.

The maximal-step computation tree represents concurrent behavior: nodes
correspond to cuts and markings of the unfolding, while arcs carry maximal
enabled steps (Definition 4, pp. 38487--38488). For free-choice nets, maximal
configurations of the ordinary unfolding and maximal paths of this tree
correspond; the paper shows that the correspondence fails for general
non-free-choice nets (Lemma 2 and Example 9, p. 38488).

## Main definitions

- Transition `a` reveals transition `b` when every maximal configuration
  containing an occurrence of `a` also contains an occurrence of `b`
  (Definition 1, p. 38486). Extended-reveals lifts this implication to sets of
  transitions (Definition 2, p. 38486).
- Two transitions exclude one another when no maximal configuration contains
  occurrences of both (Definition 3, p. 38487).
- The full prefix expands every maximal-step-tree node until its marking
  repeats an ancestor marking on that path; the repeated node becomes a leaf
  and points back to the corresponding ancestor (Definition 5, p. 38489).
- A footprint is the set of transition labels observed in a maximal
  configuration or run. It discards firing multiplicity and ordering
  (Section V-C, pp. 38493--38494; conclusion, p. 38499).

## Results, algorithm, and complexity

- Lemma 4 proves that the full prefix is finite, and Lemma 7 establishes that
  all maximal-step behavior is recoverable through the repeated-marking links
  (pp. 38489--38490).
- Theorem 1 proves reveals equivalence between the full computation tree and
  the prefix (p. 38491). Algorithm 1 and Theorem 2 decide excludes exactly
  (pp. 38492--38493).
- Algorithm 2 recursively explores the prefix and its repeated-marking links.
  Theorem 3 proves that it returns exactly the set of footprints of all maximal
  runs (pp. 38494--38496).
- A single excludes query costs `O(|L|)` for full prefix `L`; all ordered
  transition pairs cost `O(|L| |T|^2)` (p. 38493). Footprint computation has
  worst-case complexity `O(|L|^2 2^{|T|})`, excluding construction of `L`
  (p. 38496).

## Relationship and evidence limit

The footprint construction can be viewed as computing the finite image of a
run-to-observed-transition-set map. That interpretation is ours: the paper
does not formulate footprints as caller-input inverse fibers. For finite
1-safe free-choice Petri nets under its progress and maximal-step assumptions,
the paper directly establishes a finite exact basis for reveals and excludes
and an exact terminating enumeration of every distinct maximal-run footprint.

The domain is maximal Petri-net runs, not symbolic inputs to a requested pure
program result. The method does not define sparse reached-selection-site
observations, enumerate inverse caller-input fibers, produce guards for those
fibers, or attach typed residual program values. Its free-choice restriction,
loss of order and multiplicity, and exponential footprint bound are essential
limits.

## Evidence locations

- Section II, p. 38485: finite 1-safe/1-live model and nonempty-preset
  assumptions.
- Section III, pp. 38486--38487: progress assumption and Definitions 1--3.
- Section IV-A, pp. 38487--38488: maximal-step tree and free-choice
  correspondence.
- Definition 5 and Lemmas 4 and 7, pp. 38489--38490: full-prefix finiteness and
  recovery of all maximal-step behavior.
- Theorem 1, p. 38491: reveals correctness.
- Algorithm 1 and Theorem 2, pp. 38492--38493: excludes correctness.
- Section V-C, Algorithm 2, and Theorem 3, pp. 38493--38496: footprint
  semantics, exhaustive computation, correctness, and complexity.
- Conclusion, p. 38499: summary of guarantees and future scope.
