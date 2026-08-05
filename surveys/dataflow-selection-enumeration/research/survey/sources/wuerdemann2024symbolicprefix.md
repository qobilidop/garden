# wuerdemann2024symbolicprefix — Symbolic high-level complete prefixes

- **Status:** screened; high-level symbolic complete-prefix boundary
- **Primary source:** https://doi.org/10.3233/FI-242196
- **Open publisher record and full text:** https://fi.episciences.org/14249
- **Version read:** revised and extended 2024 journal article, superseding the
  PETRI NETS 2023 conference version
- **Bibliography key:** `wuerdemann2024symbolicprefix`

## Evidence locations

- Proposition 1.7 identifies the reachable markings of a high-level Petri net
  with the markings represented by configurations and satisfying assignments
  of its symbolic unfolding. Proposition 1.8 supplies the corresponding
  enabled-transition extension property.
- Definition 2.1 lifts complete prefixes to symbolic unfoldings: every
  reachable marking must be represented by a prefix configuration and every
  transition mode enabled there must have a corresponding possible extension.
- Definition 2.2 first treats the class `N_F`: finite safe high-level nets with
  guards in a decidable theory and finitely many reachable markings. The
  generalized ERV construction specializes to the ordinary construction when
  a safe P/T net is viewed as a one-color high-level net. Safety, decidable
  guards, and finite reachability are substantive assumptions; general
  k-bounded high-level nets are left for future work.
- Definition 4.2 enlarges the scope to symbolically compact nets `N_SC`, for
  which a uniform finite bound exists on the number of firings needed to reach
  any marking. Such a net may have infinitely many reachable markings even
  though its symbolic unfolding has a finite complete prefix.
- Definition 4.3 weakens the cut-off test to a cut-off-star criterion that
  compares the marking set of an event's cone against all smaller
  configurations. Theorem 4.4 proves that, with the stated size-compatible
  adequate order, the modified algorithm terminates on every `N_SC` net and
  returns a complete finite symbolic prefix.
- Theorem 5.3 and Corollary 5.4 reduce the required marking-set containment to
  implication between symbolic cut constraints. Section 6 reports a prototype
  and four benchmark families; the paper is explicit that the broader
  cut-off-star check can require representing the whole, possibly infinite,
  marking set symbolically.

## Relationship and evidence limit

This is a strong exact symbolic-enumeration comparator: it represents all
reachable high-level-net markings and enabled modes in a finite partial-order
prefix under explicit compactness assumptions, and it can avoid expanding
colors into an ordinary P/T net. Its quotient and symbolic constraints are over
Petri-net markings, modes, and concurrent histories. They are not the complete
sparse image of selected internal events over caller inputs, and prefix records
do not carry exact input-fiber guards plus typed residual program values.
