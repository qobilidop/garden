# hanus1998demand — Demand-driven Search in Functional Logic Programs

- **Status:** deep-read
- **Primary source:** https://www.univ-orleans.fr/lifo/membres/rety/publications.html
- **Preserved report scan read:** https://citeseerx.ist.psu.edu/document?doi=7024c267c1bb285904c62094c1b725c636b6f6a5&repid=rep1&type=pdf
- **Version read:** LIFO research report RR-LIFO-98-08, 20-page report scan
- **Bibliography key:** `hanus1998demand`

## Access and version limitations

Pierre Réty's current institutional publication page identifies the work as
research report 98-08 and links to the original LIFO archive. That compressed
PostScript link currently returns HTTP 404. The text read was a preserved scan
whose cover identifies it as LIFO report 98-08 and whose title, authors, and
contents agree with the institutional record. RWTH's bibliography also records
a WLP 1998 version on pp. 13--24, but the version analyzed here is the longer
research report requested for this survey. The report has no DOI.

## Why it matters

This is a direct early precedent for omitting search work because a consumer
does not demand it. A lazy tester consumes a nondeterministic generator, so
only enough of a candidate is produced to accept or reject that branch. The
paper also makes nondeterministic alternatives explicitly available to a search
strategy and factors independent local solution sets to avoid their Cartesian
product. It does not, however, preserve demanded and undemanded choices as an
observable output object.

## Computation and demand model

A Curry value is a constructor data term. Functions are defined by conditional
equations, and evaluation rewrites expressions to data terms. Evaluation is
lazy and generally outermost. The report calls an argument **demanded** when
its value is required by the defining rules before a function call can reduce;
the example `add (add Z (S Z)) Z` must first expose the head constructor of its
first argument (Section 2, pp. 3--4).

Functions may be nondeterministic: overlapping equations can give several
result values. A free variable is instantiated only when the left-hand sides
of rules demand its value, at which point it is nondeterministically bound to
the demanded constructors. For inductively sequential programs, the described
method coincides with needed narrowing; its minimal-solution and shared-term
optimality properties are cited from prior work rather than reproved here
(Section 2, pp. 4--6).

The report represents a computation result as a disjunction of
substitution/expression pairs. A step is nondeterministic when that disjunction
has more than one alternative. This is an operational branching notation, not
a stable identity for a source-level choice site.

## Search exposure and encapsulation

The primitive

```text
try :: (a -> Constraint) -> [a -> Constraint]
```

evaluates a search goal until it finishes or reaches a nondeterministic step.
At a nondeterministic step, `try` returns the alternatives as a list of search
goals. Ordinary Curry code can then implement depth-first, breadth-first,
iterative-deepening, or branch-and-bound traversal. `all` performs depth-first
search and `findall` returns the corresponding variable values (Section 2,
pp. 6--7).

This **encapsulation of search** has two roles. It separates traversal policy
from generation and allows local nondeterminism to be used under monadic I/O.
It can also retain independent subproblems as separate lists of alternatives:
two three-solution goals are represented by two lists of length three instead
of their nine combined substitutions. The report calls this a disjunctive
representation of solutions (Section 2, pp. 6--7).

## Demand-driven search algorithm

The central program shape is `test(generate)` (Section 3, pp. 7--10):

- `generate` is a nondeterministic function producing candidate data.
- `test` is a partial function that consumes a candidate and returns an
  appropriate result only for actual solutions.
- Lazy evaluation reduces `generate` only as far as `test` demands.
- If a demanded prefix already makes `test` inapplicable, that branch fails and
  the remaining candidate structure and its descendant choices are not built.

The key example defines `psort xs = sorted (permute xs)`, where `sorted` is a
partial identity on ascending lists. For reverse lists of lengths 4 through 10,
the report counts 19, 59, 180, 544, 1,637, 4,917, and 14,758 alternatives for
test-of-generate, versus 24 through 3,628,800 for full generate-and-test. It
claims the same search-space size as a coroutining Prolog formulation, without
its risk of floundering. Demand-driven generation is independent of the chosen
depth-first or breadth-first traversal policy.

The paper presents this as a programming construction and worked operational
argument. It states no new soundness, completeness, disjointness, polynomial
delay, or output-complexity theorem for the generic construction.

## Application evaluation

The prototype harmonizes each bar of a melody. Nondeterministic generators
choose one or two chords, while a partial tester enforces local and global
dissonance constraints. The second chord is generated only after the first
passes its local test. Encapsulated search first tries whole-bar chords and
considers half-bar pairs only if no whole-bar solution exists (Section 4,
pp. 10--14).

Each bar's alternatives are printed separately rather than forming all
cross-bar combinations. The report therefore describes output linear in the
number of bars instead of an approximately exponential Cartesian product; one
example would otherwise have 24,576 combined accompaniments. The validation is
a prototype and examples on two songs, not a controlled runtime experiment
(Section 4, conclusion, and Appendix A, pp. 13--20).

## Relationship to our hypothesis

### What is directly established by the work?

Lazy producer-consumer evaluation can avoid generating nondeterministic search
subtrees whose contents are not demanded by a tester. The generator and tester
remain modular, search traversal remains programmable, and encapsulating
independent local searches can prevent an unnecessary Cartesian product.

### What is our interpretation or inference?

This is a strong precedent for **demand-sensitive omission**: an uninspected
suffix and all choices beneath it are absent from the actual computation. It
also demonstrates that a computation can expose alternatives at its current
nondeterministic frontier without evaluating every alternative fully.

The omitted work is not represented by an explicit inactivity value. `try`
returns residual search goals at the next nondeterministic step, not a stable
partial map from graph-site identities to selected outcomes. Successful output
is a value or variable binding; two executions with the same result but
different demanded choices are not separate observations. Nor does the report
enumerate exact input fibers for a complete demand observation.

### Could it subsume our proposed contribution?

No. It subsumes neither graph-relative observation semantics nor exact fiber
enumeration. It is nevertheless a high-priority conceptual predecessor for
the claim that laziness prunes a search space according to consumer demand.

## Terminology distinctions for the manuscript

- Use **demand-driven search** here for lazy interleaving of a tester with a
  nondeterministic generator, not for our enumeration of demand observations.
- Use **search encapsulation** for converting a local nondeterministic search
  into an explicit collection of residual goals or values.
- Use **demanded argument/substructure** for an expression forced to expose a
  constructor. Reserve **demanded selection site** for our graph-addressed
  observation coordinate.
- The report's **disjunctive representation** factors independent solution
  lists; it is not a disjoint symbolic partition or an exact observation fiber.

## Evidence locations

- Section 2, pp. 3--6: demanded arguments, nondeterministic functions, free
  variables, and answer/expression disjunctions.
- Section 2, pp. 6--7: `try`, traversal policies, and encapsulated independent
  searches.
- Section 3, pp. 7--10: `test(generate)`, sorting example, and alternative
  counts.
- Section 4.3, pp. 13--14: local search ordering and factored bar outputs.
- Section 5 and Appendix A, pp. 14--20: scope of the contribution and musical
  examples.

## Questions and possible weaknesses

- The generic construction has no formal theorem in this report; it relies on
  Curry and needed-narrowing results cited from earlier work.
- The reported counts are search alternatives for one sorting family, not
  asymptotic upper bounds or timing measurements.
- Local factoring changes how a family of solutions is presented; it is useful
  only when the independent structure matches the consumer's desired output.
- Choice sites have no stable identities, and unobserved choices are absent rather
  than explicitly observed.

## Citation-chasing record

The primary report contains 26 references, all transcribed in
`primary-hanus1998demand-backward.tsv`. Semantic Scholar's exact-title match
resolves paper `80f5e42efc4230b5652c1c9264ff231a10bbedc0` with both authors and
the exact title, and its four forward records are frozen in
`semantic-hanus1998demand-forward.tsv`. The index labels the seed year 2005,
which conflicts with the institutional RR-LIFO-98-08 record and primary report
year 1998. The forward snapshot is therefore usable as a title-and-author
matched citation neighborhood, not as authoritative publication metadata.
