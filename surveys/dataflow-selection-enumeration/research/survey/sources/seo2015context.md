# seo2015context — Context and Precondition-Guided Search Strategies

- **Status:** primary-abstract screened; target-relative search comparator
- **Primary source:** https://doi.org/10.14711/thesis-b1477728
- **Version inspected:** HKUST primary repository abstract
- **Bibliography key:** `seo2015context`

## Why it matters

The dissertation combines CGS with precondition-guided search (PGS). PGS uses
previous executions that failed to reach one requested target branch to build,
incrementally merge, and apply preconditions for non-reachability. This is a
target-relative symbolic-search reduction and therefore meets the survey's
broad close-competitor trigger even though it is not exact fiber enumeration.

## Evidence locations

- Primary abstract: CGS prioritizes new branch contexts after excluding
  dominator-irrelevant context and increasing context depth incrementally.
- Primary abstract: PGS constructs bottom-up preconditions for not reaching a
  target from prior failing paths, merges them incrementally, and uses them to
  reduce the search space.
- Primary abstract: the evaluation distinguishes general branch-coverage gains
  for CGS from target-branch gains for PGS.

## Relationship and evidence limit

The learned preconditions prune a search for a target branch; the abstract does
not claim a complete quotient, disjoint fibers, or residual functions. The
repository required an interactive challenge for the full thesis during this
audit, so no theorem-level or implementation-detail claim is drawn from it.
