# logemann2024exact — Analyzing Exact Output Regions of Reinforcement Learning Policy Neural Networks for High-Dimensional Input-Output Spaces

- **Status:** deep-read; critical exact policy-region predecessor
- **Primary source:** https://doi.org/10.5220/0012928000003886
- **Version read:** EXPLAINS 2024 publisher PDF, pp. 96--107
- **Bibliography key:** `logemann2024exact`

## Why it matters

This work explicitly names and geometrically analyzes *exact output regions* of
feed-forward neural-network policies. It extends the authors' NN2EQCDT
conversion and represents each root-to-leaf decision-tree path as a convex
polytope paired with the leaf's affine output function.

## Program and semantic model

The input is a feed-forward ReLU policy network transformed by NN2EQCDT into a
pruned decision tree. A path is a conjunction of affine half-space rules. The
paper converts that conjunction into an H-polytope, optionally intersects it
with a box-shaped observation domain, and attaches the leaf expression.

## Results, algorithm, and guarantees

Section 5 derives a polytope from the path inequalities and observes that an
intersection of halfspaces is convex; the appendix proves convexity. Section 6
computes maximum-volume axis-aligned inner boxes. Sections 8--10 visualize
exact polytopes, action samples, and a neighborhood graph for a Mountain Car
example and a higher-dimensional power-grid policy.

The exactness of the network-to-tree conversion is inherited from Logemann and
Veith 2023 rather than reproved. The new formal argument establishes convexity
of each path region, not global completeness or uniqueness of the collection.

## Complexity

No asymptotic enumeration theorem is stated. Each path-polytope conversion is
linear in its recorded inequalities before polyhedral operations; feasibility,
inner-box optimization, adjacency, and the number of tree leaves can dominate.
The examples are methodological demonstrations rather than scaling bounds.

## Relationship to our hypothesis

The work already provides output regions as exact guards with affine residuals
for the policy-network specialization. Its tree tests are sparse after
NN2EQCDT pruning. It does not define requested internal roots, arbitrary typed
pure DAG primitives, contextual identities under sharing, or a theorem
relating enabled closure to an observed-sites-only guard.

## Evidence locations

- Sections 3--4, pp. 98--100: NN2EQCDT construction and pruning inherited from
  the 2023 source.
- Section 5, pp. 100--101: path inequalities and H-polytope representation.
- Sections 6--7, pp. 101--102: inner boxes and global observation bounds.
- Sections 8--10, pp. 102--105: policy-region and neighborhood-graph analyses.
- Section 11, pp. 105--106: limitations of inner-box summaries.
- Appendix, p. 107: convexity proof.

## Questions and possible weaknesses

- Strict ReLU inequalities are converted to a non-strict standard polytope
  form with equality requiring separate treatment; boundary ownership is not
  developed as a complete partition theorem.
- Exactness relies on the earlier transformation, whose evidence is partly
  constructive and empirical rather than a numbered equivalence theorem.

