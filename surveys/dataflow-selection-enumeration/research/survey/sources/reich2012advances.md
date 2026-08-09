# reich2012advances — Advances in Lazy SmallCheck

- **Status:** deep-read; high-priority Lazy SmallCheck successor
- **Primary source:** https://doi.org/10.1007/978-3-642-41582-1_4
- **Version read:** IFL 2012 draft proceedings, pp. 171--185; the draft marks
  the full refutation-algorithm account as deferred to the final paper
- **Open copy:** https://www.cs.ox.ac.uk/files/5260/CS-RR-12-06.pdf
- **Bibliography key:** `reich2012advances`

## Why it matters

Reich, Naylor, and Runciman extend Lazy SmallCheck without changing its core
semantic object: partially defined bounded test values refined when a property
forces them. The successor adds first-order functional inputs, nested universal
and existential quantification, better demanded-position tracking, and exact
wildcard displays for unforced parts of counterexamples.

It confirms that demanded partiality is not confined to simple algebraic
values. It does not supply an exact partition, minimal-cylinder theorem, or
selection-observation result.

## Extensions

Functional values are represented as lazily generated tries. An argument
pattern can contain wildcards where the tested property never interrogated the
function, so undefined portions of the generated function remain absent from
the counterexample. A modifier wraps functions at their quantifier binding to
record the patterns and results that were actually demanded.

Refinement exceptions carry both a path into the partial value and a quantifier
nesting tag. A quantification context lets the refuter distinguish whether an
unknown belongs to a universal or existential search and reconstruct the
appropriately nested partial counterexample. The worked search tree explicitly
marks whole subtrees the lazy refuter does not explore.

The phrase “minimal definition” for a displayed function is informal: it means
that irrelevant mappings show as wildcards. The paper gives no order-theoretic
minimality, uniqueness, disjointness, or maximal-cylinder proof.

## Guarantee and complexity boundary

The paper inherits the bounded-exhaustive intent of Lazy SmallCheck and
explains the extended architecture operationally. The inspected IFL draft does
not give a complete formal proof of the refutation algorithm; it explicitly
notes that the final paper will contain the full account. There is no
output-sensitive complexity analysis or theorem that the emitted partial
counterexamples form an exact cover of a semantic equivalence class.

Nested existentials also make a single depth insufficient in some cases; the
API includes depth modifiers such as `existsDeeperBy`. Exhaustiveness is thus
relative to the chosen finite depth schedule.

## Relationship to selection observations

Wildcards in a displayed function are unforced regions of an *input
function*. They are not unobserved coordinates of an internal graph-event map.
The property may demand a function at selected arguments without exposing any
stable source selector; conversely, our graph may observe a selector whose two
cases return equal values.

The work strengthens the implementation precedent for:

- tagged demanded positions;
- partial input values with precise wildcard presentation;
- higher-order-looking but first-order-enumerable function tries; and
- mixed-quantifier lazy search.

It still returns a Boolean counterexample, not every observation class with an
exact input guard and symbolic XLS residual.

## Evidence locations

- Draft Sections 1--2, proceedings pp. 171--174: scope and wildcard partial
  counterexamples.
- Sections 3--4, pp. 174--179: search-tree omission, partial values, paths, and
  quantification context.
- Section 5, pp. 179--182: lazy functional tries and wildcard mappings.
- Sections 6--7, pp. 182--185: mixed quantification, depth control, and stated
  limitations.

