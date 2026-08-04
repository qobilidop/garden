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

## Reopening after the hyperplane and PWA forward snowballs

The map is open again. Forward citation chasing from Avis--Fukuda and Sleumer,
followed by exact primary reading, exposed several predecessors that materially
change the geometric and compositional frontier:

- Dussault, Gilbert, and Plaquevent-Jourdain give the current circuit-guided
  central-arrangement baseline and make the incremental zero-witness case
  explicit.
- Geyer, Torrisi, and Morari's 2003/2010 mode-enumeration lineage already
  composes affine components by substituting residual maps into downstream
  guards, pruning infeasible intersections, and emitting exact PWA records.
- Their 2008 reduction work computes behavior-minimal polyhedral
  representations under explicit representation and logic-minimizer
  qualifications.
- Jones and Maciejowski give duplicate-free output-sensitive enumeration of
  full-dimensional parametric-LP critical regions with reconstructible affine
  optimizers.
- Ferrez, Fukuda, and Liebling strengthen the arrangement reverse-search
  implementation and complexity lineage used by later work.

These sources defeat novelty for guarded affine component composition,
behavior-preserving polyhedral minimization, and output-sensitive
guard-plus-affine region enumeration. They do not define the
requested-root-relative sparse graph observer, but they are plausible closest
competitors under the frozen trigger and therefore invalidate any previous
no-add sequence.

The reconciliation is not complete until each critical source has an exact
primary-bibliography screen, an auditable forward screen, a deep source note,
and catalog/claim integration. Any new candidate exposed by those screens must
also be adjudicated. Only then may two replacement no-add rounds be frozen;
neither round has yet been selected or executed.

Deza and Pournin's later zonotope-oracle presentation was separately audited
because its title could imply a stronger enumeration oracle. The final journal
version instead treats generator-to-vertex enumeration as known. All 18
published references and five unique forward works across OpenCitations,
Semantic Scholar, Crossref, and the publisher panel were screened. Its
unspecified \(O(Kp(Q,D,L))\) rational-bit bound and output-sized retention do
not improve Ferrez's \(O(KQ\,LP(Q,D))\) time and \(O(QD)\) working-space
frontier. The only algorithmic successor, symmetry-aware White Whale
enumeration, adds no stronger generic theorem. This audit therefore closes a
bit-complexity qualification without reopening the semantic map.

The pending output-projection chase is also complete. The accessible complete
Semantic Scholar neighborhood for König--Mönnigmann contains three works,
matching Google Scholar's independent count; every edge was primary-verified.
Mitze et al. broaden the sufficient same-first-action criterion to nonlinear
MPC, and a companion simulation paper caps and empirically evaluates the
seed's incomplete enumeration. Neither provides a maximal quotient, complete
or nonredundant enumeration, or a stronger complexity theorem. The companion
is cataloged, but it adds no new cluster and does not reopen the map.

## Reopening after the parametric-program seed chase

Exact primary-bibliography and OpenCitations screening for Borrelli--Bemporad--
Morari 2003, Jones--Kerrigan--Maciejowski 2007, and Patrinos--Sarimveis 2010
reopened the map once more. The bounded evidence comprises 94 backward
references and 273 forward citation records, resolving to 253 distinct forward
works after malformed-identifier and version duplicates are merged.

The chase exposed four material boundaries. Columbano--Fukuda--Jones give
explicit per-output LP-oracle bounds for sufficient-matrix pLCP enumeration,
including pLP and convex pQP. Spjøtvold--Tøndel--Johansen already give a unique
continuous minimum-norm pQP selection and algorithm-independent polyhedral
representation. Jones--Kerrigan--Maciejowski polynomially interreduce
polyhedral projection and pLP solution. Shin--Yang independently identify
polyhedral reward sets that yield the same optimal MDP policy. These findings
defeat generic claims of first canonical partition, first degeneracy-safe
output-sensitive pLP/pQP enumeration, a separate projection frontier, or first
requested-output quotient.

The six snapshots, their catalog dispositions, primary source notes, claims,
and complexity corrections were reconciled before the following replacement
rounds were frozen. Neither round had been executed or previewed at freeze
time.

## Replacement round `closure-replacement-16`: OpenAIRE

OpenAlex was the original frozen source, but every request returned HTTP 429
before exposing a result set or title. Semantic Scholar was then availability-
probed with an unrelated zero-result string; the first frozen query returned
zero records, queries 2--5 returned HTTP 429, and query 6 then exposed 100
records before the unstable batch was stopped. Those 100 policy-query records
are retained and screened as a supplementary snapshot, but the incomplete
Semantic Scholar batch does not count as a round. OpenAIRE Graph API v3 was
availability- and schema-probed only with unrelated strings, then selected and
refrozen on 2026-08-04 before any frozen query was executed against it. Each
query exports at most the first 100 relevance-ranked publication records,
including indexed descriptions. Every title is screened under the unchanged
two-part close-competitor trigger; plausible records receive abstract and
primary-source review.

| ID | Exact query |
|---|---|
| C16-01 | `output-sensitive multiparametric LCP sufficient matrix enumeration` |
| C16-02 | `degenerate multiparametric quadratic programming region enumeration complexity` |
| C16-03 | `canonical minimum norm parametric quadratic programming partition` |
| C16-04 | `polyhedral projection parametric linear programming output sensitive` |
| C16-05 | `requested output policy quotient parameter region` |
| C16-06 | `same policy reward parameter polyhedral regions` |
| C16-07 | `observer relative symbolic execution exact input fibers` |
| C16-08 | `demand driven dataflow selection trace enumeration` |
| C16-09 | `contextual choice identity term graph residual` |
| C16-10 | `equal output distinct branch provenance symbolic execution` |
| C16-11 | `projected model enumeration residual symbolic function` |
| C16-12 | `compositional guarded residual graph enumeration` |

## Replacement round `closure-replacement-17`: Crossref

Execute only if round 16 is a no-add round. Source: Crossref REST API. Frozen
2026-08-04 before either replacement round was executed. Each query exports
the first 100 relevance-ranked records. Wording differs deliberately while
targeting the same theorem, observer, and representation boundaries.

| ID | Exact query |
|---|---|
| C17-01 | `parametric complementarity problem output sensitive critical regions` |
| C17-02 | `degeneracy safe explicit parametric quadratic programming enumeration` |
| C17-03 | `unique polyhedral representation parametric optimizer selection` |
| C17-04 | `projection polyhedron parametric linear program equivalence complexity` |
| C17-05 | `reward functions same optimal policy multiparametric` |
| C17-06 | `requested action equivalence region enumeration` |
| C17-07 | `symbolic execution observation equivalence exact preimage` |
| C17-08 | `demand relative selection dataflow graph exhaustive` |
| C17-09 | `shared term graph choice identity symbolic residual` |
| C17-10 | `branch provenance equal value symbolic execution` |
| C17-11 | `projected enumeration guarded symbolic values` |
| C17-12 | `compositional conditional graph exact residual enumeration` |

Round 17 counts only if round 16 adds neither a cluster nor a plausible close
competitor. If either round adds one, both-round closure is abandoned and the
normal reconciliation and refreeze rule applies. Two no-add outcomes establish
closure only for these captured rankings and the frozen trigger, not world
literature completeness.

## Outcome of round 16

Round 16 is a no-add round under the frozen trigger. OpenAIRE's full-text search
semantics returned zero records for eight exact queries and five total records
for the other four. All five descriptions concern unrelated speculative
symbolic syntheses or repository artifacts. This low capture is itself a
limitation; it is not interpreted as evidence of absence.

The incomplete Semantic Scholar attempt contributes a separately logged
100-record policy-query supplement. Its title and abstract screen recovered
only the already-cataloged Shin--Yang work; the remaining records concern
ordinary reward shaping, reinforcement-learning optimization, policy training,
or unrelated regional studies. No record changes the taxonomy or meets the
choice-omission/quotient trigger beyond Shin--Yang. With those records
reconciled, the precondition for executing round 17 is satisfied.

## Provisional outcome of round 17, later invalidated

The initial screen incorrectly classified round 17 as no-add. The independent
audit checked all 1,305 captured round-16/17 occurrences after its deterministic
sample exposed Logemann and Veith's *Analyzing Exact Output Regions of
Reinforcement Learning Policy Neural Networks* at C17-01 rank 97. That paper
meets trigger 2 directly: it inherits a feasibility-pruned exact neural-policy
decision tree and turns each leaf path into a polyhedral output region with an
affine residual. The dated audit row in `search-log.tsv` therefore reopens the
map and the earlier no-add conclusion has no closure weight.

The other round-17 adjudications remain valid as screening evidence. Löhne and
Weißing relate polyhedral projection to multiple-objective and vector linear
programming; Hempel et al. establish parametric-LP representability of
continuous piecewise-affine functions; Yan studies two multiparametric-SDP
partitions; and Madhusudanan enumerates elementary-function expression trees.
None repairs the missed neural-policy lineage.

## Reopening after exact neural trees and output regions

Primary reading and citation chasing around the missed work exposed a direct
lineage that changes the closest-comparator boundary:

- Logemann and Veith's 2023 NN2EQCDT construction removes infeasible paths and
  forced ReLU rules before producing policy leaves; their 2024 work gives the
  leaves exact polyhedral input regions with affine outputs.
- Chang et al. give the strongest theorem: LP tests omit a ReLU split when one
  side is infeasible, output comparisons are introduced only while competing
  actions remain, and Theorem 1 proves pointwise equivalence to the original
  ReLU--argmax controller under a deterministic tie rule.
- Aytekin and Nguyen et al. provide earlier dense or contradiction-pruned
  neural-to-tree constructions. Villani--McBurney give an exact regression-tree
  existence theorem but no feasibility-pruned enumerator.
- Affinitree independently symbolically executes PWL neural networks into exact
  typed affine decision structures, prunes LP-infeasible paths, and applies
  semantics-preserving structural reductions.

These works falsify the statement that exact neural methods necessarily retain
a dense activation vector. The defensible distinction is narrower: they target
fixed neural/PWL architectures and extensional outputs, whereas the present
synthesis specifies a requested-root partial map of preserved internal event
identities for arbitrary typed pure DAGs.

The reconciliation deep-read and separately chased the printed or publisher-
deposited bibliographies and indexed forward neighborhoods of the four critical
representatives: Chang 2026, Logemann--Veith 2024, Affinitree 2024, and the
BDD4BNN journal treatment described next.

## Reopening after exact neural decision-diagram compilation

Forward lineage inspection then exposed exact neural-to-OBDD/SDD compilation,
another trigger-2 family absent from the earlier map:

- Shih--Darwiche--Choi learn an OBDD exactly equivalent to a BNN on a chosen
  CNF input region using membership and SAT-backed equivalence queries.
- Shi et al. compile binary-neural decision functions into OBDDs and SDDs and
  give a pseudo-polynomial integer-weight neuron bound.
- Zhang et al.'s expanded BDD4BNN constructs exact per-class BDDs for a
  requested binary input region, existentially removes hidden activation
  vectors, propagates feasible block inputs, and supports exact counts,
  prime-implicant explanations, and essential features.
- Tang et al. later construct exact margin-qualified aligned BDDs for threshold
  neurons. Their 2026 extension is exact for binary residual/attention
  structures, while its real-valued sigmoid conversion is bounded-error
  approximate.

The primary BDD4BNN PDF has 121 references, exactly matching the publisher's
Crossref array; all were screened. Forward indexes disagree: Crossref and
OpenAlex report seven records, OpenCitations eight, and Semantic Scholar ten.
The largest stable snapshot is retained and screened, but no claim of complete
forward coverage is made. The neural-specific diagrams are exact extensional
requested-class quotients and can skip irrelevant input tests; they do not
preserve internal observation-event provenance.

All critical additions, source notes, backward and forward snapshots, and
catalog dispositions were reconciled before the replacement batches below were
chosen. The map remains open until two new prospective no-add rounds and a new
independent audit succeed.

## Replacement round `closure-replacement-21`: arXiv

Semantic Scholar was the originally frozen source, but its first frozen query
returned HTTP 429 after every retry and exposed no result set. OpenAlex was
then availability-probed with an unrelated string and also returned HTTP 429.
Neither attempt counts as a round. The arXiv API was availability- and
schema-probed only with the unrelated phrase `quantum otter`, then selected and
refrozen on 2026-08-04 before any frozen query below was submitted to it.

The neural-tree, exact-output-region, Affinitree, and BNN-diagram additions were
fully reconciled before this refreeze. Each plain-text query below is submitted
as the conjunction of all its alphanumeric terms across arXiv's `all` field,
with relevance-descending sorting, and exports at most the first 100 records
including abstracts. Every title and abstract is screened under the unchanged
two-part close-competitor trigger; plausible records receive primary-source
review.

| ID | Exact query |
|---|---|
| C21-01 | `equivalent compact neural network decision tree exact transformation` |
| C21-02 | `exact output regions policy neural network decision tree` |
| C21-03 | `ReLU controller decision tree infeasible activation pruning` |
| C21-04 | `piecewise linear neural network affine decision tree symbolic execution` |
| C21-05 | `neural controller piecewise affine compositional exact regions` |
| C21-06 | `exact binarized neural network BDD output class` |
| C21-07 | `neural network decision diagram exact equivalence` |
| C21-08 | `hidden activation existential elimination neural BDD` |
| C21-09 | `requested output relative neural network region enumeration` |
| C21-10 | `demand guided symbolic execution neural decision structure` |
| C21-11 | `contextual internal event observer dataflow graph exact fiber` |
| C21-12 | `projected model enumeration guarded residual function` |

## Replacement round `closure-replacement-22`: Crossref

Execute only if round 21 adds neither a conceptual cluster nor a plausible
close competitor. This round was also frozen on 2026-08-04 without previewing
any query. Source: Crossref REST API. Each query exports the first 100
relevance-ranked records. The wording differs deliberately while targeting the
same exact-neural-observer and general graph-observer boundaries.

| ID | Exact query |
|---|---|
| C22-01 | `feasibility pruned exact neural policy tree` |
| C22-02 | `output action partition ReLU argmax equivalent tree` |
| C22-03 | `compressed decision tree exact reinforcement learning policy` |
| C22-04 | `affine decision structure deep neural network exact` |
| C22-05 | `switched system representation neural controller composition` |
| C22-06 | `binary neural network reduced decision diagram exact class` |
| C22-07 | `OBDD SDD compilation neural classifier explanation` |
| C22-08 | `eliminate intermediate activations BDD neural network` |
| C22-09 | `output quotient activation regions neural network` |
| C22-10 | `sparse observed decisions symbolic execution exact preimage` |
| C22-11 | `requested root selection observation term graph residual` |
| C22-12 | `totalized observer projected AllSMT symbolic residual` |

If either round adds a cluster or plausible close competitor, both-round
closure is abandoned, the addition is reconciled, and two later prospective
rounds are required. Two no-add outcomes establish closure only for these
captured rankings, sources, date, and trigger; they do not establish world
literature completeness.

## Outcome of round 21

Round 21 is a no-add round under the frozen trigger. The conjunctive arXiv
queries captured two records in total. C21-01 rediscovered Chang et al.'s
already critical exact neural-controller tree. C21-07 found an exact BDD
compression of the certified ACAS-Xu lookup-table decision function. The latter
is retained as a finite-observer decision-diagram comparator, but it neither
observes neural internals nor introduces a new omission, quotient, or residual
mechanism beyond the audited BDD lineage. The ten other queries returned
complete zero-result responses. This narrow capture is an explicit source and
query-semantics limitation, not evidence of absence. Because no new cluster or
plausible close competitor was added, the precondition for round 22 holds.

## Outcome of round 22, invalidated

Round 22 is not a no-add round. All 1,200 captured titles were screened, and
four findings meet the frozen close-competitor trigger:

- C22-07 rank 15 exposed Bertossi and Leon's exact BNN-to-SDD route. Internal
  threshold definitions are substituted, the output is compiled to an SDD and
  smooth deterministic decomposable circuit, and repeated exact SHAP queries
  become tractable on the compiled representation. This strengthens the
  already reopened neural decision-diagram cluster and is a new close
  comparator even though it does not create another cluster.
- C22-10 rank 1 exposed sparse symbolic loop execution. It observes sibling
  states' branch-edge patterns up to a loop-impact barrier and postpones
  repeats. The method is a coverage heuristic, not an exact quotient, but it
  adds the observation-pattern exploration cluster under the deliberately broad
  trigger.
- C22-10 rank 25 exposed Seo's dissertation. Context-guided search prioritizes
  new dominator-filtered branch contexts, while precondition-guided search
  learns and merges target-nonreachability conditions from prior failing paths.
  This adds target-relative learned search reduction; the PGS evidence is
  explicitly limited to the primary repository abstract.
- C22-10 rank 60 exposed Capra's constraint-based colored-Petri-net state-space
  reduction and its foundational Chiola et al. lineage. The latter directly
  constructs a symmetry-reduced reachability graph whose analysis is stated to
  be equivalent to ordinary reachability analysis for well-formed nets. This
  adds the exact symmetry-reduced-state-space cluster; both uses are limited to
  primary-abstract claims.

The Li dissertation at C22-10 rank 43 is a duplicate lineage of the already
cataloged Z-equivalence paper and does not add a result. The other plausible
titles were abstract- or primary-screened and reconciled in `catalog.tsv`.
Because round 22 reopens the map, neither rounds 21 nor 22 contributes to the
required final two-round no-add sequence. The additions must be reconciled and
two later prospective rounds frozen before execution.

## Replacement round `closure-replacement-23`: Crossref

Source: Crossref REST API. Frozen on 2026-08-04 after the exact-neural SHAP,
loop-pattern, target-guided search, and symmetry-reduced reachability additions
were reconciled, and before any query below was executed. Each query exports
the first 100 relevance-ranked records for title screening, followed by
abstract and primary review when plausibility remains.

| ID | Exact query |
|---|---|
| C23-01 | `binarized neural network knowledge compilation deterministic decomposable circuit` |
| C23-02 | `exact SHAP binary neural SDD` |
| C23-03 | `hidden activation elimination neural classifier decision diagram` |
| C23-04 | `symbolic loop observation pattern state postponement` |
| C23-05 | `context guided precondition symbolic execution target branch` |
| C23-06 | `dominator irrelevant branch context concolic search` |
| C23-07 | `colored Petri net symmetry quotient symbolic reachability` |
| C23-08 | `constraint based state space reduction symbolic execution` |
| C23-09 | `partial symmetry reachability graph symbolic state` |
| C23-10 | `requested event observer exact input fiber` |
| C23-11 | `demand relative symbolic execution residual graph` |
| C23-12 | `observation guided symbolic exploration quotient` |

## Replacement round `closure-replacement-24`: arXiv

Execute only if round 23 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any frozen
round-23 or round-24 query was executed. Each plain-text query is submitted as
the conjunction of all its alphanumeric terms across arXiv's `all` field, with
relevance-descending sorting, and exports at most the first 100 records with
abstracts.

| ID | Exact query |
|---|---|
| C24-01 | `neural knowledge compilation` |
| C24-02 | `neural SDD SHAP` |
| C24-03 | `neural hidden activation BDD` |
| C24-04 | `symbolic loop pattern` |
| C24-05 | `precondition guided symbolic execution` |
| C24-06 | `context guided concolic search` |
| C24-07 | `colored Petri symbolic reachability` |
| C24-08 | `symmetry quotient state space` |
| C24-09 | `constraint symbolic reachability graph` |
| C24-10 | `requested observer input fiber` |
| C24-11 | `symbolic observation residual` |
| C24-12 | `demand guided event enumeration` |

If either round adds a cluster or plausible close competitor, this sequence is
abandoned and two later prospective rounds are required after reconciliation.

## Outcome of round 23 and retirement of round 24

Round 23 is not a no-add round. The primary screener and an independent
reviewer each resolved all 1,200 captured records; every query contains ranks
1--100 exactly once. The audit found no remaining uncataloged plausible title
after reconciliation. The findings that meet the deliberately broad frozen
trigger include:

- exact truth-table enumeration and Boolean rule minimization for a small
  Boolean-feature neural classifier;
- assertion-relative and compatible-branch pruning, together with
  coverage-preserving seed-suite reduction before symbolic exploration;
- canonical higher-order concolic inputs with soundness and qualified
  bug-finding completeness;
- qualifying-event branch caps and several target-guided exploration
  comparators;
- basis-marking, partial-observation, time-anonymous, symbolic-unfolding, and
  partial-order state/run reductions; and
- fully symbolic computation of a bisimulation quotient.

These findings add or sharpen the coverage-preserving seed reduction,
canonical higher-order input, behavior-relative state reduction, and fully
symbolic bisimulation clusters. They therefore invalidate this replacement
sequence. The map records important evidence limits: several supporting titles
remain full-text-follow-up candidates, the compatible-branch and basis-marking
claims are abstract-limited, the time-anonymous construction discloses minor
information loss, and the practical SRV implementation is explicitly unsound
because its Postset approximation is context-insensitive.

Round 24 was prospectively frozen but its execution precondition required a
round-23 no-add outcome. That precondition failed, so round 24 is retired
unexecuted. Neither round contributes to the required final two-round no-add
sequence. Two new rounds must be reconciled and frozen before execution.

## Replacement round `closure-replacement-25`: Crossref

Source: Crossref REST API. Frozen on 2026-08-04 after every round-23 plausible
record and the four new outcome clusters were reconciled, and before any query
below was executed. Each query exports the first 100 relevance-ranked records
for title screening, followed by abstract and primary review whenever
plausibility remains.

| ID | Exact query |
|---|---|
| C25-01 | `exact Boolean neural rule extraction truth table minimization` |
| C25-02 | `assertion guided symbolic execution predicate summary subsumption` |
| C25-03 | `compatible branch coverage symbolic execution dependency pruning` |
| C25-04 | `canonical higher order concolic input complete search` |
| C25-05 | `basis marking implicit transition symbolic reachability` |
| C25-06 | `time anonymous token symbolic reachability reduction` |
| C25-07 | `colored Petri net symbolic unfolding factorization concurrent interleavings` |
| C25-08 | `symbolic partial order reduction BDD local property` |
| C25-09 | `fully symbolic bisimulation decision diagram quotient saturation` |
| C25-10 | `coverage preserving test seed reduction symbolic execution` |
| C25-11 | `partial observation estimation reachability graph observer` |
| C25-12 | `requested event exact input fiber symbolic residual` |

## Replacement round `closure-replacement-26`: arXiv

Execute only if round 25 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any
round-25 or round-26 query was executed. Each plain-text query is submitted as
the conjunction of all its alphanumeric terms across arXiv's `all` field, with
relevance-descending sorting, and exports at most the first 100 records with
abstracts.

| ID | Exact query |
|---|---|
| C26-01 | `Boolean neural rule extraction exact` |
| C26-02 | `assertion guided symbolic execution` |
| C26-03 | `branch coverage symbolic pruning` |
| C26-04 | `higher order concolic canonical inputs` |
| C26-05 | `basis marking reachability` |
| C26-06 | `time anonymous Petri reachability` |
| C26-07 | `symbolic unfolding colored Petri` |
| C26-08 | `symbolic partial order reduction` |
| C26-09 | `symbolic bisimulation quotient` |
| C26-10 | `coverage preserving test reduction` |
| C26-11 | `partial observation reachability observer` |
| C26-12 | `requested event input fiber` |

If either round adds a cluster or plausible close competitor, this sequence is
abandoned and two later prospective rounds are required after reconciliation.

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
