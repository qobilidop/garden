# Predeclared mapping-closure audit

This file freezes the final database-query batches before they are executed.
It prevents query selection from being changed after seeing whether a batch
adds a competitor. Citation chasing of the bounded critical set precedes these
batches and does not count as either no-add round.

Each query exports and title-screens the first 50 relevance-ranked results. A
record whose title and venue leave technical relevance plausible receives
abstract screening and, if still plausible, a primary-source reading. All
included candidates and explicit exclusions are reconciled with
`catalog.tsv`. A round counts as **no-add** only if it adds neither a conceptual
cluster nor a plausible close competitor after that reconciliation.

If a round adds either, the map is reopened: the addition is deep-read and
snowballed when critical, and two replacement audit rounds are predeclared
before execution. Search indexes are discovery instruments; even two no-add
rounds establish mapping closure under the protocol, not completeness of the
world literature.

## Reopening after the functional-logic fingerprint cluster

The batches below were refrozen on 2026-08-04 **before either batch was
executed**. Exact forward citation chasing for the JACM needed-narrowing seed
had exposed a previously missing closest cluster: demand-driven search,
set-function fingerprints, pull-tabbing, stable choice identifiers, and
memoized pull-tabbing. The earlier eight-query drafts did not name this
cluster directly. Four queries were therefore added to each still-unseen
batch. No round-3 or round-4 result was inspected before this revision, so the
no-add test remains prospective rather than outcome-dependent.

## Round `closure-audit-3`: OpenAlex

Source: OpenAlex works search API. Frozen 2026-08-04.

DBLP was initially selected for this round, but its publication-search API
returned HTTP 500 and then HTTP 503 for minimal queries before exposing any
result set. No DBLP titles were inspected. The source was therefore replaced
before round execution; round 4 still supplies an independent index.

| ID | Exact query |
|---|---|
| C3-01 | `symbolic execution dataflow graph enumeration` |
| C3-02 | `symbolic evaluation term graph choice` |
| C3-03 | `symbolic simulation mux functional space partition` |
| C3-04 | `projected model enumeration partial assignment` |
| C3-05 | `guarded value symbolic execution` |
| C3-06 | `demand driven symbolic evaluation graph` |
| C3-07 | `trace partitioning symbolic execution` |
| C3-08 | `conditional values configuration symbolic` |
| C3-09 | `functional logic demand driven search nondeterministic choice fingerprint` |
| C3-10 | `pull tabbing fingerprint choice identifier search` |
| C3-11 | `lazy nondeterministic computation demanded choice enumeration` |
| C3-12 | `set function fingerprint nondeterministic results` |

## Round `closure-audit-4`: Crossref

Execute only if round 3 is a no-add round. Source: Crossref REST API. Frozen
2026-08-04.

| ID | Exact query |
|---|---|
| C4-01 | `exhaustive symbolic enumeration dataflow graph` |
| C4-02 | `selection outcome trace symbolic execution` |
| C4-03 | `inactive choice projected model enumeration` |
| C4-04 | `disjoint partial model enumeration SMT` |
| C4-05 | `conditional term graph exhaustive evaluation sharing` |
| C4-06 | `multipath symbolic execution value summary` |
| C4-07 | `mux guided symbolic simulation partition` |
| C4-08 | `demand semantics conditional dataflow` |
| C4-09 | `demand driven search functional logic fingerprint` |
| C4-10 | `pull tab transformation choice identifier partial map` |
| C4-11 | `lazy nondeterministic shared choice exhaustive results` |
| C4-12 | `set function nondeterminism fingerprint computation` |

## Outcome of round 3 and retirement of round 4

Round 3 did not qualify as a no-add round. C3-05 exposed Gligoric et al.'s
delayed-choice execution, and C3-09 exposed Jost's Fair-Scheme dissertation and
thereby the bounded Fair Scheme and Sprite lineage. Both are close
predecessors under the protocol: the former proves omission of unforced finite
choices and visible-state preservation; the latter combines needed graph
reduction, sparse choice fingerprints, and fair exploration. They were
deep-read, backward-snowballed from their primary bibliographies, and
forward-snowballed before replacement rounds were frozen.

Consequently `closure-audit-4` is retired without execution. Its predeclared
queries remain above as an audit trail, but it cannot be relabeled or counted
because its explicit precondition—round 3 being no-add—is false.

## Revised close-competitor trigger

The replacement rounds use this criterion, frozen before execution. A work
reopens the map if it either:

1. introduces a semantic or algorithmic mechanism that cannot be placed in an
   existing cluster without changing the taxonomy; or
2. enumerates executions, results, configurations, or decision records while
   omitting, delaying, or quotienting choices that do not affect a requested
   observation.

The second condition applies regardless of whether the source calls the object
a fingerprint, branching information, suspension, choice history, partial
assignment, trace, path condition, cube, visible state, or something else.
Correctness, completeness, nonredundancy, exact-region, complexity, or
composition theorems strengthen relevance but are not required to reopen the
map.

## Replacement round `closure-audit-5`: Crossref

Source: Crossref REST API. Frozen 2026-08-04 after the two reopened lineages
and their citation neighborhoods were reconciled, and before any query below
was executed.

Semantic Scholar paper search was initially selected. The first request was
rejected with HTTP 429 after bounded retries and returned no result set; no
titles were exposed. Crossref therefore replaced it before round execution.

Each query exports the first 100 relevance-ranked records with DOI or source
identifier, title, year, venue, and type. Duplicate query occurrences remain in
their snapshots, but the underlying work is adjudicated once.

| ID | Exact query |
|---|---|
| C5-01 | `delayed choice bounded exhaustive execution` |
| C5-02 | `delayed nondeterministic value force suspension` |
| C5-03 | `deferred nondeterminism symbolic execution visible state` |
| C5-04 | `lazy initialization bounded exhaustive testing choice` |
| C5-05 | `unforced choice observable result enumeration` |
| C5-06 | `Fair Scheme functional logic nondeterminism` |
| C5-07 | `fair search needed computation choice fingerprint` |
| C5-08 | `demand driven search choice identifier branching information` |
| C5-09 | `pull tabbing fingerprint exhaustive results` |
| C5-10 | `shared choice term graph demand evaluation` |
| C5-11 | `partial choice assignment result enumeration` |
| C5-12 | `projected model enumeration irrelevant variables` |
| C5-13 | `demanded decisions input partition symbolic execution` |
| C5-14 | `observable choice trace exact enumeration` |
| C5-15 | `mux dataflow graph demand selection` |
| C5-16 | `residual symbolic value partial decision map` |

Every title is screened. Every plausible or ambiguous title is abstract-
screened, and a primary source is read whenever the abstract does not exclude
the revised trigger. The round counts as no-add only after every adjudication
is reconciled with the catalog.

## Replacement round `closure-audit-6`: OpenAlex

Execute only if round 5 is a no-add round. Source: OpenAlex works search API.
Frozen 2026-08-04 before either replacement round was executed. Each query
exports and screens the first 100 relevance-ranked records, retaining abstracts
when the index provides them.

| ID | Exact query |
|---|---|
| C6-01 | `delayed choice execution falsification` |
| C6-02 | `suspension unforced choice bounded exhaustive testing` |
| C6-03 | `needed computation fair search choice fingerprint` |
| C6-04 | `branching information functional logic search` |
| C6-05 | `partial choice assignment lazy nondeterminism` |
| C6-06 | `projected enumeration partial assignments irrelevant variables` |
| C6-07 | `selection outcomes dataflow graph symbolic` |
| C6-08 | `mux path partition symbolic simulation` |
| C6-09 | `demand-driven symbolic execution result observation` |
| C6-10 | `guarded residual values symbolic evaluation` |
| C6-11 | `exact input partition branch outcomes` |
| C6-12 | `duplicate-free projected enumeration` |
| C6-13 | `dynamic dependence selective evaluation pure function` |
| C6-14 | `visible state projection delayed execution` |
| C6-15 | `choice history path quotient symbolic execution` |
| C6-16 | `compositional graph observations symbolic residual` |

Crossref and OpenAlex are distinct retrieval systems but are not statistically
independent and share upstream metadata. A no-add result establishes saturation
only under this predeclared protocol and capture date, not completeness of world
literature.
If either replacement round adds a cluster or close competitor, the map reopens
again and two further rounds must be frozen after reconciliation.

## Outcome of round 5 and retirement of round 6

Round 5 did not qualify as a no-add round. All sixteen Crossref queries returned
very large result sets; the first 100 relevance-ranked records of each query
were frozen and screened. Four queries materially changed the map:

- C5-04 exposed Lazy SmallCheck, property-directed generation, and bounded lazy
  initialization, forcing a demand-driven bounded-testing lineage from Korat
  through partial-input refinement and solver-backed partial heaps;
- C5-09 exposed pseudo-exhaustive circuit testing, which exhausts local support
  projections rather than dynamic observation fibers;
- C5-14 exposed exact neural activation-region enumeration, including earlier
  complete hyperplane-cell, mixed-integer, adjacency-walk, and polyhedral-complex
  algorithms; and
- C5-15 exposed the older dataflow meaning of demand-driven evaluation and its
  stability and sequentiality conditions.

Reconciliation also prompted a targeted observer-equivalence search. Exact
input-equivalence-class partitioning and exhaustive property-oriented testing
show that finite observer alphabets already induce exactly enumerable input
partitions. This is a generic reduction of the proposed object, not merely an
application neighbor.

The original broad novelty thesis therefore fails: selection observations can
be presented as projected AllSMT assignments, finite Boolean-observer atoms, or
input-equivalence classes, while demand-driven testing already refines partial
inputs only as an observer forces them. The remaining possible contribution is
the graph-specific synthesis: a precise sparse structural observer, equivalence
of enabled-closure and ghost-output presentations, exact fiber guards and
residuals, composition laws, and a structure-directed enumeration analysis.

Because round 5 added multiple conceptual clusters and close predecessors,
`closure-audit-6` is retired without execution. Its frozen queries remain above
as an audit trail but cannot count toward closure. After every newly critical
seed and its citation neighborhood is reconciled, two new replacement rounds
must be predeclared before either is executed.

## Reconciliation after the neural and dataflow deep snowballs

The first neural reconciliation was not sufficient. A second pass screened the
current printed bibliographies and two independent forward indexes for the
seven exact-region seeds. Counting the 2025 Masden publication rather than its
22-reference arXiv version, the bounded evidence set comprises 204 printed
references, 427 Semantic Scholar forward records, and 73 OpenAlex forward
records, plus 280 relevance-ranked results from six targeted OpenAlex queries.
These are screened-record counts, not unique-world-work counts: normalized
titles reduce the forward sets to 394 and 69 respectively, and index coverage
is visibly incomplete.

This pass exposed an older exact guard/residual lineage: Xiang's exact output
polyhedra, Tran's exact stars with retained input predicates and affine images,
Robinson's explicit region/map conversion, Bak's complete neural-path stars,
and Yang's retained input subpolytopes. It also added SyReNN, DISCO, Xu's
theorem-backed local-polytope traversal, Wang's activation-cell versus maximal
affine-region distinction, SplineCam's heterogeneous two-dimensional CPWL
partitioning, and AffineLens's later broad bounded-domain traversal. These
works do not add demand-relative graph-site absence, but they invalidate any
priority claim for exact guard-plus-residual enumeration or heterogeneous CPWL
partition construction.

The adversarial special-case pass also identified a simpler reduction:
ordinary decision-tree execution already produces an input-relative sparse
map of reached tests to outcomes, with a path guard and terminal result; BDDs
and ADDs add shared compilation. Dynamic sparsity is therefore not itself a
surviving separator. The map reopened conceptually even though noisy database
rankings did not surface the classical special case.

For stream dataflow, exact primary-bibliography screening covered 29 Avron--
Sasson references, 16 Pingali--Arvind Part 1 references, and four Part 2
references. OpenAlex reported two forward records for Avron--Sasson and 38 for
Part 1; only Part 2 and Vin--Berman--Mattson materially strengthened the direct
lineage. The index backward neighborhoods were not faithful transcriptions, so
the primary bibliographies govern closure. This reconciliation establishes
that least fixed-input demanded computation and reverse demand propagation are
prior work; the changed quantification over symbolic inputs remains the only
separation.

The resulting bounded statement is deliberately narrow: within these audited
sets, no source combines exact inverse fibers of a requested-root-relative
selection observer with contextual identities and typed residuals over an
arbitrary shared pure dataflow graph. This is not evidence of global absence,
and generic decision structures, projected AllSMT, and finite observer
partitions already represent the object. Two newly predeclared no-add rounds
are still required after every source and snapshot above is reconciled.

## Independent audit

After both replacement rounds qualify, a reviewer who did not choose the
queries receives:

1. all screened snapshots;
2. the included and excluded catalog entries;
3. every critical source note; and
4. the claimed closure conditions.

The reviewer must sample borderline exclusions, look for uncataloged plausible
titles in every audit snapshot, and either sign a dated audit row in
`search-log.tsv` or reopen the map with concrete findings.

The sample includes ten deterministically selected exclusions per query using
a recorded seed, plus every work excluded solely because its abstract appeared
to describe ordinary path enumeration. Opaque and time-varying relevance
ranking, shared upstream metadata, and title-screening judgment are explicit
limitations of the closure claim.
