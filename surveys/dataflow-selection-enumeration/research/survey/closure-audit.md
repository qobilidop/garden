# Predeclared mapping-closure audit

This file freezes the final database-query batches before they are executed.
It prevents query selection from being changed after seeing whether a batch
adds a competitor. Citation chasing of the bounded critical set precedes these
batches and does not count as either no-add round.

The initial batches export and title-screen the first 50 relevance-ranked
results; later frozen round blocks explicitly raise that depth to 100. A record
whose title and venue leave technical relevance plausible receives abstract
screening and, if still plausible, a primary-source reading. All included
candidates and explicit exclusions are reconciled with
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

## Outcome of round 25 and retirement of round 26

Round 25 is not a no-add round. The primary screener and two independent
reviewers each resolved all 1,200 captured records. Every snapshot contains
ranks 1--100 exactly once, with 100 unique source identifiers. The independent
audits found additions that the initial pass had missed, so the reconciliation
uses the union of all three dispositions.

The strongest additions are substantive rather than lexical neighbors:

- exact Boolean-algebra composition of a binary or bipolar neural network into
  simplified rules, including hidden-neuron removal without a function change;
- abstract symbolic-state subsumption, approximate learned state/function
  pruning, and an earlier counterexample-complete higher-order verifier;
- exact color quotienting in Petri-net unfolding and hierarchical basis
  estimation under partial observation;
- SAT/SMT, BDD, concolic, local, and schedule-bearing symbolic partial-order
  reductions with preservation, optimality, or relative-completeness results;
- the foundational BDD, rank, signature, and parallel symbolic-bisimulation
  lineage, including evidence that quotient construction can cost more than
  direct invariant checking; and
- exact marking sets and timed state observers induced by partial event
  records, plus the early coverage-preserving POR lineage.

Evidence tiers remain explicit. Bouali--de Simone and several implementation
neighbors remain primary-full-text candidates; Ma--Zhu--Li and Herdt et al. are
used only at publisher-abstract level; approximate POR and learned pruning are
not presented as exact; and general-input neural preprints are separated from
the exact binary-domain result. Duplicate posted records and conference/tool
companions were adjudicated once.

These works fit existing clusters but are plausible close competitors under
the second frozen trigger, so round 25 reopens the map. Round 26's execution
precondition required round 25 to add neither a cluster nor a close competitor.
That precondition failed; round 26 is therefore retired unexecuted and cannot
count toward closure. Two later prospective rounds must be frozen only after
this reconciliation is complete.

The required critical-source chases were then completed before selecting any
later round. SymPaths' exact 35-item bibliography and the one-record COCI
forward set added only established symbolic-execution, POR, and merging
lineage. Giua--Júlvez--Seatzu's exact 12-item bibliography and 16-record
Semantic Scholar forward set did reopen the map once more: an earlier
event-observation Petri-net estimator was missing, and Li--Hadjicostis later
compute the complete set of minimum-total-token initial markings consistent
with an observed label word. That result is an optimization-restricted initial-
state inverse fiber and materially sharpens the partial-observation boundary.
It has been reconciled before the next prospective queries are frozen.

## Replacement round `closure-replacement-27`: Crossref

Source: Crossref REST API. Frozen on 2026-08-04 after the round-25 additions
and both critical citation neighborhoods were reconciled, and before any query
below was executed. Each query exports the first 100 relevance-ranked records
for title screening, followed by abstract and primary review whenever
plausibility remains.

| ID | Exact query |
|---|---|
| C27-01 | `binary neural network Boolean rule extraction hidden neuron redundancy exact` |
| C27-02 | `abstract subsumption symbolic execution heap state inclusion` |
| C27-03 | `learned state pruning symbolic execution coverage approximation` |
| C27-04 | `counterexample complete higher order function verification SMT` |
| C27-05 | `event observation state estimator Petri net consistent marking` |
| C27-06 | `minimum initial marking observed label word Petri net` |
| C27-07 | `color quotient unfolding colored Petri net bisimulation` |
| C27-08 | `symbolic path schedule partial order reduction completeness` |
| C27-09 | `optimal symbolic partial order reduction SMT interleavings` |
| C27-10 | `BDD symbolic bisimulation minimization invariant checking` |
| C27-11 | `signature rank maximum symbolic bisimulation quotient` |
| C27-12 | `requested internal event observer exact input preimage residual` |

## Replacement round `closure-replacement-28`: arXiv

Execute only if round 27 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-27
or round-28 query was executed. Each phrase is submitted as the conjunction of
its alphanumeric terms across arXiv's `all` field, with relevance-descending
sorting, and exports at most the first 100 records with abstracts.

| ID | Exact query |
|---|---|
| C28-01 | `Boolean neural rule extraction` |
| C28-02 | `abstract subsumption symbolic execution` |
| C28-03 | `learned symbolic state pruning` |
| C28-04 | `higher order counterexample complete verification` |
| C28-05 | `Petri net marking estimation observation` |
| C28-06 | `minimum initial marking label` |
| C28-07 | `colored Petri net color quotient unfolding` |
| C28-08 | `symbolic paths partial order reduction` |
| C28-09 | `optimal symbolic partial order reduction` |
| C28-10 | `symbolic bisimulation minimization` |
| C28-11 | `partial observation exact state estimator` |
| C28-12 | `requested event input preimage residual` |

If round 27 reopens the map, round 28 is retired unexecuted. If both qualify,
they establish the two-round no-add sequence only for these recorded sources,
queries, capture date, rankings, and trigger.

## Outcome of round 27 and retirement of round 28

Round 27 is not a no-add round. The primary screener and two independent
reviewers each resolved all 1,200 captured records. Every snapshot contains
exactly 100 unique source identifiers and ranks 1--100 exactly once. The two
reviewers independently found the same decisive families and agreed that the
map must reopen:

- exact guarded heap summaries, proved bisimilar to generalized symbolic
  execution, and path-optimal symbolic execution with ite-valued heap fields;
- minimal-explanation basis observers whose unobservable reach equals the
  complete marking estimate, observation-equivalent Petri-net generator
  compilation, and exact minimum-initial-marking estimators under silent and
  timed behavior;
- observer-conditioned DPOR, where future observer operations determine the
  dependency relation and one representative is retained per observational
  class; and
- supporting graph-subsumption, relatively complete higher-order
  verification, probabilistic-estimation, and symbolic-bisimulation lineage.

The evidence boundary is material. Hillery et al.'s equivalence follows from a
primary full-text bisimulation result. Braione et al.'s path-optimality claim is
primary-full-text and empirical/formal at the algorithm level, but a
soundness-and-completeness proof against generalized symbolic execution is
explicitly left for future work. Ruan et al.'s minimum-initial-marking result
is exact only under its stated contact-free silent-transition assumptions;
heuristic successors are not promoted to exact results. Several 2024--2026
Petri-net extensions remain abstract- or metadata-level comparators and are
not used for stronger mechanism claims.

All eight critical additions were then backward- and forward-chased before a
later prospective batch was selected. Their exact primary bibliographies
contained 242 records and their bounded forward indexes contained 228 records,
all title-screened. The chases reopened the map again with guarded and modular
heap-summary antecedents, representative and timed marking estimators,
reads-from and reads-value-from schedule quotients, canonical symbolic
distributed configurations, and dynamic cone-of-influence reduction. These
strengthen established conditional-value, inverse-observation, schedule-
quotient, and property-relevance clusters; none supplies the paper's exact
caller-input observer-fiber result. All have nevertheless been cataloged and
the strongest comparators incorporated before the next queries were chosen.

Round 28's execution precondition required
round 27 to add neither a conceptual cluster nor a plausible close competitor.
That precondition failed, so round 28 is retired unexecuted and cannot count
toward closure. Two later rounds must be frozen only after the citation
neighborhood reconciliation is complete.

## Replacement round `closure-replacement-29`: Crossref

Source: Crossref REST API. Frozen on 2026-08-04 after the round-27 additions
and all eight critical backward and forward neighborhoods were reconciled, and
before any query below was executed. Each query exports the first 100
relevance-ranked records for complete title screening, followed by abstract
and primary review when plausibility remains.

| ID | Exact query |
|---|---|
| C29-01 | `guarded heap summary conditional values generalized symbolic execution exact` |
| C29-02 | `path optimal heap alias ite symbolic execution` |
| C29-03 | `compact modular heap procedure summary guarded value` |
| C29-04 | `relatively complete higher order functional verification refinement type` |
| C29-05 | `minimal explanation basis marking unobservable reach observation` |
| C29-06 | `representative marking graph observation consistent Petri net` |
| C29-07 | `observation equivalent Petri net generator adaptive label` |
| C29-08 | `minimum initial timed marking unobservable transition observation` |
| C29-09 | `reads value from schedule equivalence stateless model checking` |
| C29-10 | `observer conditioned dynamic partial order reduction future read` |
| C29-11 | `dynamic cone influence concurrent model checking property reduction` |
| C29-12 | `requested root selection input fiber residual dataflow graph` |

## Replacement round `closure-replacement-30`: arXiv

Execute only if round 29 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-29
or round-30 query was executed. Each phrase is submitted as the conjunction of
all alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C30-01 | `exact guarded heap symbolic execution summary` |
| C30-02 | `path optimal heap symbolic execution alias` |
| C30-03 | `compact heap procedure summary symbolic` |
| C30-04 | `higher order functional relatively complete refinement verification` |
| C30-05 | `basis marking minimal explanation partial observation` |
| C30-06 | `Petri observation equivalent generator` |
| C30-07 | `minimum initial marking unobservable timed observation` |
| C30-08 | `reads value from partial order reduction` |
| C30-09 | `observer dynamic partial order reduction` |
| C30-10 | `canonical symbolic distributed state interleaving` |
| C30-11 | `dynamic cone influence model checking` |
| C30-12 | `requested event input preimage residual` |

If round 29 reopens the map, round 30 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger.

## Outcome of round 29 and retirement of round 30

Round 29 is not a no-add round. The primary screener and an independent
adversarial reviewer each parsed and title-screened all 1,200 occurrences. All
twelve snapshots contain exactly 100 unique source identifiers and ranks
1--100. Across queries there are 1,078 unique identifiers and 985 unique
nonblank normalized titles. Eight blank titles were resolved as research
grants or supplemental datasets rather than technical publications.

The strongest additions are close but remain distinguishable from the target:

- exact preprocessing conditional values avoid directive-path enumeration;
- path-minimal objects synthesize only the fields required for one selected
  path, while postconditioned execution exactly prunes path suffixes already
  covered by prior weakest-precondition summaries;
- relatively complete higher-order symbolic execution decomposes unknown
  functions and reconstructs concrete functional counterexamples;
- maximum-causality, reads-from, release-acquire, and value-happens-before
  quotients retain nonredundant concurrent executions under progressively
  coarser observation relations; and
- dynamic interface reduction omits internal component behavior that cannot
  propagate to the discovered external interface.

Bounded case-optimal heap exploration, symmetry-canonical Petri markings,
correction-qualified timed marking estimation, candidate-event generation for
digital-twin checking, and shared property-specific cone computation provide
supporting boundaries. DOI container and journal aliases were adjudicated
once. Abstract-only and application-level evidence is not promoted to an exact
semantic theorem.

These additions satisfy the deliberately broad close-competitor trigger, even
though they fit established conditional-value, symbolic-input, state-
subsumption, schedule-quotient, and finite-observer clusters. Round 30's
precondition therefore failed; it is retired unexecuted and cannot count
toward closure.

Six bounded critical-neighborhood chases then screened 366 further records:
218 primary-complete backward references and 148 exact-DOI forward citations.
The backward bibliographies were checked against the complete primary full
texts or, for the recent path-minimal-object paper, a contiguous 16-entry IEEE
publisher deposit. The chases added the earlier exact conditional-compilation
line, observation-specific DSE redundancy detection, higher-order contract and
bounded game semantics, weak-memory and dependency-guided maximal-causality
variants, and adjacent JavaScript heap-execution systems. OpenCitations
returned no forward citation for the 2025 path-minimal-object paper; that
recent-work zero is recorded but is not treated as saturation evidence.
Publication aliases and one misleading self-DOI mapping for a cited CoRR
preprint were corrected rather than counted as distinct works.

Because these citation neighborhoods also reopened the map, the next two
prospective rounds are frozen only after this reconciliation. Neither round
29 nor retired round 30 contributes to the eventual two-round no-add sequence.

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

## Replacement round `closure-replacement-31`: Crossref

Frozen on 2026-08-04 after complete reconciliation of round 29 and its six
critical citation neighborhoods, and before any round-31 or round-32 query was
executed. Source: Crossref REST API. Each exact phrase is searched with
`query.bibliographic`, sorted by relevance, with the first 100 records exported
unless the source returns fewer. A round qualifies as no-add only if complete
screening adds neither a conceptual cluster nor a plausible close competitor.

| ID | Exact query |
|---|---|
| C31-01 | `path minimal objects symbolic execution input object` |
| C31-02 | `case optimal symbolic heap strong property` |
| C31-03 | `postconditioned symbolic execution path redundancy` |
| C31-04 | `conditional value preprocessing symbolic evaluation` |
| C31-05 | `higher order symbolic counterexample functional input` |
| C31-06 | `symbolic execution game semantics open higher order` |
| C31-07 | `maximal causality reduction stateless model checking` |
| C31-08 | `value happens before dynamic partial order reduction` |
| C31-09 | `dynamic interface reduction model checking observer` |
| C31-10 | `exact timed marking observation unobservable transitions` |
| C31-11 | `requested selection observer input partition residual` |
| C31-12 | `totalized input fiber dataflow selection event` |

## Replacement round `closure-replacement-32`: arXiv

Execute only if round 31 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-31
or round-32 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C32-01 | `path minimal symbolic execution object input` |
| C32-02 | `case optimal symbolic heap exploration` |
| C32-03 | `postcondition symbolic execution redundancy pruning` |
| C32-04 | `conditional value symbolic preprocessing` |
| C32-05 | `higher order symbolic functional counterexample` |
| C32-06 | `symbolic game semantics open program` |
| C32-07 | `maximal causality stateless model checking` |
| C32-08 | `value centric dynamic partial order reduction` |
| C32-09 | `dynamic interface reduction model checking` |
| C32-10 | `timed marking observation unobservable transition` |
| C32-11 | `requested observer input partition residual` |
| C32-12 | `input fiber dataflow selection event` |

If round 31 reopens the map, round 32 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for these sources,
exact queries, captured rankings, date, and frozen trigger. Independent audit
remains mandatory before either outcome is promoted to closure.

## Outcome of round 31 and retirement of round 32

Round 31 is not a no-add round. The primary screen and two independent audits
each parsed and title-screened all 1,200 occurrences. Every snapshot has 100
unique source identifiers and ranks 1--100; the round contains 1,006 unique
identifiers. One blank-title record is an EU grant, not a technical
publication. Independent title-normalization implementations counted 899 and
901 unique nonblank titles; that harmless difference is recorded rather than
forcing a shared normalization after the reviews.

The round added three especially close boundaries. Lazy happens-before omits
mutex-only ordering when defining schedule-state equivalence. Interface
grammars compile analyst-declared nested call behavior into component stubs for
exhaustive modular checking. A recent hardware-verification paper advertises
dataflow-based symbolic path pruning and is retained at a title-only candidate
tier because primary technical evidence was not yet accessible. None emits a
complete requested-root caller-input partition.

The full screen also reconciled sound DPOR under combined scheduling and store-
buffer nondeterminism, fair stateless checking, demand-axiomatized and bottom-
up symbolic heap summaries, symbolic proofs for higher-order store, and the
1977 global value graph. These strengthen existing schedule, heap, higher-
order, and merged-value clusters. Publication aliases and conference
predecessors were excluded once.

One reviewer reported “no add” relative to the catalog visible at review time,
after the primary screen had already inserted the round's three closest works.
That reviewer nevertheless independently identified the same records and
found nothing beyond the updated catalog. The prospective comparison is to the
catalog frozen before execution, so the adjudicated round outcome is reopen.
Round 32's precondition therefore failed; it is retired unexecuted and cannot
count toward closure. No reviewer found the direct requested-root event-fiber
construction.

## Replacement round `closure-replacement-33`: Crossref

Frozen on 2026-08-04 after complete reconciliation and independent audit of
round 31, and before any round-33 or round-34 query was executed. Source:
Crossref REST API. Each exact phrase is searched with `query.bibliographic`,
sorted by relevance, with the first 100 records exported unless fewer are
returned. A round qualifies as no-add only if complete screening adds neither a
conceptual cluster nor a plausible close competitor.

| ID | Exact query |
|---|---|
| C33-01 | `lazy happens before schedule state equivalence mutex` |
| C33-02 | `interface grammar modular model checking component stub` |
| C33-03 | `dataflow based path pruning symbolic hardware verification` |
| C33-04 | `dynamic partial order relaxed memory store buffer` |
| C33-05 | `demand driven axiomatization symbolic heap memory invariants` |
| C33-06 | `bottom up heap path data access summary` |
| C33-07 | `global value graph symbolic evaluation dataflow` |
| C33-08 | `fair stateless model checking schedule equivalence` |
| C33-09 | `higher order store symbolic execution proof` |
| C33-10 | `path generalization input decomposition symbolic execution` |
| C33-11 | `requested root event observer caller input fiber` |
| C33-12 | `sparse selection observation residual dataflow` |

## Replacement round `closure-replacement-34`: arXiv

Execute only if round 33 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-33
or round-34 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C34-01 | `lazy happens before schedule state equivalence` |
| C34-02 | `interface grammar modular model checking` |
| C34-03 | `dataflow path pruning symbolic hardware verification` |
| C34-04 | `dynamic partial order relaxed memory` |
| C34-05 | `demand driven symbolic heap invariant` |
| C34-06 | `symbolic heap data access summary` |
| C34-07 | `global value graph symbolic evaluation` |
| C34-08 | `fair stateless model checking` |
| C34-09 | `higher order store symbolic execution` |
| C34-10 | `path generalization symbolic execution input` |
| C34-11 | `requested event observer caller input fiber` |
| C34-12 | `sparse selection observation dataflow residual` |

If round 33 reopens the map, round 34 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Independent
audit remains mandatory before closure.

## Outcome of round 33 and retirement of round 34

Round 33 is not a no-add round. The primary screen and two independent audits
each parsed and title-screened all 1,200 occurrences. Every snapshot has 100
unique source identifiers and ranks 1--100; the round contains 1,192 unique
identifiers. Six blank-title records are grants or supplemental datasets, not
technical publications. Independent normalization implementations counted
1,084 and 1,085 unique nonblank titles; the one-title difference is retained
as an audit detail rather than normalized away after review.

Relaxed visibility is the decisive close addition: the checked temporal
property changes which concurrent actions may safely be treated as invisible.
The round also adds sound may-happen-before schedule pruning, static
happens-before task abstractions, modular grouped-state checking, symbolic path
simulation as a dataflow-analysis service, and several weaker dataflow, path,
heap, and weak-memory comparators. None returns a complete requested-root
caller-input image, its inverse fibers, and typed residuals.

Because relaxed visibility is a close observer-relative comparator, its exact
journal bibliography and complete OpenCitations DOI neighborhood were chased
separately. All 19 backward and 17 forward records were screened. The forward
set exposes safety-property-driven and question-guided stubborn sets,
transparent and optimal stubborn-set variants, and automata-driven POR. These
make the property-observer precedent explicit but continue to quotient
concurrent executions rather than caller inputs. Historical dependency,
representative-interleaving, and on-the-fly stubborn-set works were reconciled
from the backward set. No chase record supplies the target construction.

The prospective comparison is to the catalog frozen before round execution,
so the adjudicated outcome is reopen even though both independent audits found
no direct target work. Round 34's precondition therefore failed; it is retired
unexecuted and cannot count toward closure.

## Replacement round `closure-replacement-35`: Crossref

Frozen on 2026-08-04 after complete reconciliation, citation chasing, and
independent audit of round 33, and before any round-35 or round-36 query was
executed. Source: Crossref REST API. Each exact phrase is searched with
`query.bibliographic`, sorted by relevance, with the first 100 records exported
unless fewer are returned. A round qualifies as no-add only if complete
screening adds neither a conceptual cluster nor a plausible close competitor.

| ID | Exact query |
|---|---|
| C35-01 | `safety property driven stubborn sets` |
| C35-02 | `question guided stubborn set state properties` |
| C35-03 | `transparent partial order reduction invisible actions` |
| C35-04 | `optimal stubborn sets representative interleavings` |
| C35-05 | `automata driven partial order reduction guided LTL` |
| C35-06 | `relaxed visibility partial order observer property` |
| C35-07 | `symbolic path simulation dataflow feasibility` |
| C35-08 | `modular glass box similar states abstraction` |
| C35-09 | `explicit happens before schedule abstraction` |
| C35-10 | `infeasible path generalization symbolic input` |
| C35-11 | `requested internal event observer caller input fiber` |
| C35-12 | `sparse dataflow selection residual observation` |

## Replacement round `closure-replacement-36`: arXiv

Execute only if round 35 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-35
or round-36 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C36-01 | `safety property stubborn sets` |
| C36-02 | `question guided stubborn set state property` |
| C36-03 | `transparent partial order reduction` |
| C36-04 | `optimal stubborn sets interleavings` |
| C36-05 | `automata driven partial order reduction LTL` |
| C36-06 | `relaxed visibility partial order property` |
| C36-07 | `symbolic path simulation dataflow feasibility` |
| C36-08 | `modular glass box similar states` |
| C36-09 | `happens before schedule abstraction` |
| C36-10 | `infeasible path generalization symbolic input` |
| C36-11 | `requested event observer caller input fiber` |
| C36-12 | `sparse dataflow selection residual observation` |

If round 35 reopens the map, round 36 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Independent
audit remains mandatory before closure.

## Outcome of round 35 and retirement of round 36

Round 35 is conservatively adjudicated as a reopen, not a no-add round. The
primary screen and two independent audits each parsed and title-screened all
1,200 occurrences. Every snapshot has 100 unique source identifiers and ranks
1--100; the round contains 1,108 unique identifiers. Ten blank-title
occurrences are grants, including one grant repeated across two queries. The
primary normalization counted 1,006 unique nonblank titles; the two independent
implementations each counted 1,009.

The independent reviewers disagreed about the prospective trigger. One
reviewer classified the uncataloged records as variants wholly inside the
already mapped property-POR and infeasible-path clusters and therefore
reported no-add. The adversarial reviewer classified property-specific
stubborn sets, state/event LTL reduction, and synchronous-dataflow symbolic
simulation with timers as distinct close boundaries and required reopen. The
primary adjudication accepts the latter, more conservative classification:
these works do not supply the target object, but omitting their explicit
property and dataflow program models would weaken the closest-work boundary.

The reconciliation retains expanded journal or chapter versions where the
round exposed publication lineages. It adds standard, linear-time, simple
linear-time, and state/event temporal-property variants to the stubborn-set
and POR account; a direct synchronous-dataflow symbolic-simulation neighbor;
and supporting path-feasibility, modular-state, schedule-abstraction, and
sparse-dataflow works. Conference predecessors and container aliases are
excluded once. No title in the round presents a requested-root internal-event
observer with complete caller-input fibers and typed residuals; the direct
query returns only control-observer, caller-identifier, sensor, and other
homonym noise.

Because at least the conservative close-work criterion is met, round 35
reopens the map. Round 36's precondition failed; it is retired unexecuted and
cannot count toward closure.

## Replacement round `closure-replacement-37`: Crossref

Frozen on 2026-08-04 after complete conservative reconciliation and
independent audit of round 35, and before any round-37 or round-38 query was
executed. Source: Crossref REST API. Each exact phrase is searched with
`query.bibliographic`, sorted by relevance, with the first 100 records exported
unless fewer are returned. A round qualifies as no-add only if complete
screening adds neither a conceptual cluster nor a plausible close competitor.

| ID | Exact query |
|---|---|
| C37-01 | `stubborn sets standard linear time state event property` |
| C37-02 | `synchronous dataflow symbolic simulation timers selection` |
| C37-03 | `compositional weak stubborn sets fair testing` |
| C37-04 | `LTL partial order snapshots next operator` |
| C37-05 | `symbolic dataflow path feasibility iterative refinement` |
| C37-06 | `infeasible path pruning graph transformation symbolic` |
| C37-07 | `schedule abstraction partial order response time` |
| C37-08 | `modular state abstraction similar executions` |
| C37-09 | `internal selection event inverse input image` |
| C37-10 | `requested site sparse observation exact guard` |
| C37-11 | `caller input equivalence residual dataflow` |
| C37-12 | `selection observation fiber symbolic enumeration` |

## Replacement round `closure-replacement-38`: arXiv

Execute only if round 37 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-37
or round-38 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C38-01 | `stubborn sets linear time state event property` |
| C38-02 | `synchronous dataflow symbolic simulation timers` |
| C38-03 | `weak stubborn sets fair testing` |
| C38-04 | `LTL partial order snapshots next operator` |
| C38-05 | `symbolic dataflow path feasibility refinement` |
| C38-06 | `infeasible path pruning graph transformation symbolic` |
| C38-07 | `schedule abstraction partial order response time` |
| C38-08 | `modular state abstraction similar executions` |
| C38-09 | `internal selection event inverse input image` |
| C38-10 | `requested site sparse observation exact guard` |
| C38-11 | `caller input equivalence residual dataflow` |
| C38-12 | `selection observation fiber symbolic enumeration` |

If round 37 reopens the map, round 38 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Independent
audit remains mandatory before closure.

## Outcome of round 37 and retirement of round 38

Round 37 is not a no-add round. The primary screen and both independent audits
parsed and title-screened all 1,200 occurrences and independently required
reopen. Every snapshot has 100 unique source identifiers and ranks 1--100; the
round contains 1,166 unique identifiers. Six blank-title occurrences are one
grant, one EU grant, and four versions of a supplemental dataset. The primary
normalization counted 1,091 unique nonblank titles; both independent
implementations counted 1,093.

The decisive additions are directly adjacent to the paper's program model and
semantic boundary. An early paper applies symbolic simulation to synchronous
programs, while separate work studies schematological equivalence of dataflow
networks and partially interpreted dataflow networks. Transparent and
compositional synchronous-dataflow language work further sharpens the network-
semantics boundary. These papers still do not enumerate the image or inverse
caller-input fibers of a requested internal selection observer, but they are
too close to omit from the systematic map.

The complete screen also reconciles timed and frozen-action stubborn sets,
property-preserving sweep-line POR, infeasible-path pruning for synchronous
programs, schedule-abstraction POR, event-order and SystemC abstraction,
multiple-execution abstraction, and ordinary symbolic flow/path enumeration.
Conference predecessors and container aliases are excluded once. The three
direct observer/fiber queries return only imaging, sensing, logic, statistics,
biology, and other homonyms; neither independent auditor found the target
construction.

Round 37 therefore reopens the map. Round 38's precondition failed; it is
retired unexecuted and cannot count toward closure.

## Replacement round `closure-replacement-39`: Crossref

Frozen on 2026-08-04 after complete reconciliation and two agreeing
independent audits of round 37, and before any round-39 or round-40 query was
executed. Source: Crossref REST API. Each exact phrase is searched with
`query.bibliographic`, sorted by relevance, with the first 100 records exported
unless fewer are returned. A round qualifies as no-add only if complete
screening adds neither a conceptual cluster nor a plausible close competitor.

| ID | Exact query |
|---|---|
| C39-01 | `schematological equivalence dataflow networks partially interpreted` |
| C39-02 | `symbolic simulation synchronous programs` |
| C39-03 | `transparent synchronous dataflow compositionality` |
| C39-04 | `synchronous program infeasible path WCRT pruning` |
| C39-05 | `timed dataflow refinement reordering symbolic` |
| C39-06 | `stubborn time real time Petri nets frozen actions` |
| C39-07 | `sweep line LTL partial order preservation` |
| C39-08 | `modular multiple execution abstraction refinement` |
| C39-09 | `caller input selection observation inverse fiber` |
| C39-10 | `requested internal site sparse guard residual` |
| C39-11 | `exact observation image program inputs` |
| C39-12 | `dataflow observer fiber enumeration` |

## Replacement round `closure-replacement-40`: arXiv

Execute only if round 39 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-39
or round-40 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C40-01 | `schematological equivalence dataflow partially interpreted` |
| C40-02 | `symbolic simulation synchronous programs` |
| C40-03 | `transparent synchronous dataflow compositionality` |
| C40-04 | `synchronous program infeasible path pruning` |
| C40-05 | `timed dataflow refinement reordering symbolic` |
| C40-06 | `stubborn real time Petri nets frozen actions` |
| C40-07 | `sweep line LTL partial order preservation` |
| C40-08 | `modular multiple execution abstraction refinement` |
| C40-09 | `caller input selection observation inverse fiber` |
| C40-10 | `requested internal site sparse guard residual` |
| C40-11 | `exact observation image program inputs` |
| C40-12 | `dataflow observer fiber enumeration` |

If round 39 reopens the map, round 40 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Independent
audit remains mandatory before closure.

## Outcome of round 39 and retirement of round 40

Round 39 reopens the map. The primary screen and both independent audits parsed
and title-screened all 1,200 occurrences and independently reached that verdict.
Every snapshot has 100 unique source identifiers and ranks 1--100; the round
contains 1,179 unique identifiers. Five blank-title occurrences are four grant
records, one repeated across two queries. The primary and first independent
normalizations counted 1,088 unique nonblank titles; the second independent
normalization counted 1,091.

The decisive addition is a coherent foundational dataflow-network semantics
lineage surrounding the already cataloged schematological-equivalence papers.
It includes algebraic, categorical, full-abstraction, calculus, compositional
relational, partially ordered event, stability, and sequentiality treatments.
The round also exposes exact symbolic-state-space WCET analysis of synchronous
programs, mixed-style and scenario-aware compositionality, mechanized and
verified synchronous-dataflow semantics, and several close WCRT, POR, and
abstraction-refinement variants. Published articles are retained where the
retrieval returned theses, preliminary reports, or container aliases.

These works sharpen the network, state-space, timing, and compilation
boundaries but do not supply the target construction. The three direct-query
blocks contain selection, imaging, fiber, clinical, biological, and statistical
homonyms. The sole ambiguous observation-sequence dissertation was chased and
found to observe behavior as a concurrency resource bound changes rather than
partition caller inputs by a selected internal event. Neither independent
auditor found a title claiming complete requested-site observations, exact
caller-input inverse fibers, or typed residuals.

Round 39 therefore cannot count toward closure. Round 40's precondition failed;
it is retired unexecuted and cannot count toward the required no-add sequence.

## Replacement round `closure-replacement-41`: Crossref

Frozen on 2026-08-04 after complete reconciliation and two agreeing
independent audits of round 39, and before any round-41 or round-42 query was
executed. Source: Crossref REST API. Each exact phrase is searched with
`query.bibliographic`, sorted by relevance, with the first 100 records exported
unless fewer are returned. A round qualifies as no-add only if complete
screening adds neither a conceptual cluster nor a plausible close competitor.

| ID | Exact query |
|---|---|
| C41-01 | `algebra calculus full abstraction dataflow networks` |
| C41-02 | `compositional relational indeterminate dataflow semantics` |
| C41-03 | `dataflow networks fibrations stability sequentiality` |
| C41-04 | `synchronous program symbolic state space WCET` |
| C41-05 | `synchronous dataflow compositional pattern matching` |
| C41-06 | `dependence graph local symbolic simulation equivalence` |
| C41-07 | `verified synchronous dataflow semantics state machines reset` |
| C41-08 | `dataflow partially ordered events observer` |
| C41-09 | `exact internal selection observer caller inputs` |
| C41-10 | `sparse selection observation inverse image guards` |
| C41-11 | `requested site residual input fiber` |
| C41-12 | `dataflow selection map exact enumeration` |

## Replacement round `closure-replacement-42`: arXiv

Execute only if round 41 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-41
or round-42 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C42-01 | `algebra calculus full abstraction dataflow networks` |
| C42-02 | `compositional relational indeterminate dataflow semantics` |
| C42-03 | `dataflow networks fibrations stability sequentiality` |
| C42-04 | `synchronous program symbolic state space WCET` |
| C42-05 | `synchronous dataflow compositional pattern matching` |
| C42-06 | `dependence graph local symbolic simulation equivalence` |
| C42-07 | `verified synchronous dataflow semantics state machines reset` |
| C42-08 | `dataflow partially ordered events observer` |
| C42-09 | `exact internal selection observer caller inputs` |
| C42-10 | `sparse selection observation inverse image guards` |
| C42-11 | `requested site residual input fiber` |
| C42-12 | `dataflow selection map exact enumeration` |

If round 41 reopens the map, round 42 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Independent
audit remains mandatory before closure.

## Outcome of round 41 and retirement of round 42

Round 41 reopens the map. The primary screen and both independent audits parsed
and title-screened all 1,200 occurrences and independently reached that
verdict. The twelve snapshots each contain ranks 1--100 and collectively hold
1,160 unique identifiers. There are 39 blank-title occurrences representing 38
identifiers: four grant occurrences, one dataset, and 34 unrelated issue or
volume records from the wound-care publication named *WCET Journal*. The
primary and first independent normalizations counted 1,017 unique nonblank
titles; the second counted 1,018.

The decisive additions are three boundaries. First, the foundational
dataflow-semantics lineage extends through compositional Petri-net fixed-point
semantics, indeterminate fair-merge expressiveness, profunctor relational
semantics with congruent bisimulation, and an extensional deadlock-freedom
test. Second, a symbolic observation graph explicitly divides transitions into
observed and unobserved classes, grouping states connected by unobserved
transitions and retaining observed transitions as explicit edges. Third,
parametric WCET analysis derives procedure-argument-dependent formulas whose
conditions reflect branch and loop control flow. Constructive synchronous
state-machine semantics and symbolic-equivalence variants add supporting
program-model boundaries. Published or fuller articles replace report,
dissertation, artifact, alias, and short-version records where applicable.

These works substantially sharpen the semantic, observer, and input-sensitive
summary comparisons but do not supply the target construction. The symbolic
observation graph quotients concurrent-system states for model checking, not
caller inputs. Parametric WCET produces a timing formula, not every sparse
internal selection observation paired with an inverse input fiber and general
program residual. The four direct-query blocks returned only disciplinary
homonyms and established neighbors. Neither independent auditor found a title
claiming complete requested-site observations, exact caller-input inverse
fibers, or typed residuals.

Round 41 therefore cannot count toward closure. Round 42's precondition failed;
it is retired unexecuted and cannot count toward the required no-add sequence.

## Replacement round `closure-replacement-43`: Crossref

Frozen on 2026-08-04 after complete reconciliation and two agreeing
independent audits of round 41, and before any round-43 or round-44 query was
executed. Source: Crossref REST API. Each exact phrase is searched with
`query.bibliographic`, sorted by relevance, with the first 100 records exported
unless fewer are returned. A round qualifies as no-add only if complete
screening adds neither a new conceptual cluster nor a plausible closer
competitor. A publication within an already represented lineage does not
reopen the map unless it changes the compared semantic object, guarantee, or
program-model boundary, or is materially closer to the target construction.

| ID | Exact query |
|---|---|
| C43-01 | `compositional fixed point Kahn indeterminate dataflow` |
| C43-02 | `relational nondeterministic dataflow profunctor bisimulation` |
| C43-03 | `Petri net compositional dataflow input output semantics` |
| C43-04 | `symbolic WCET input dependent branches parametric` |
| C43-05 | `symbolic observation graph observed unobserved actions LTL` |
| C43-06 | `constructive synchronous dataflow semantics interpreter` |
| C43-07 | `dataflow process networks firing deadlock semantics` |
| C43-08 | `fair merge expressive power dataflow networks` |
| C43-09 | `exact requested internal observer input partition` |
| C43-10 | `caller inputs selection event inverse fibers` |
| C43-11 | `sparse requested site guard symbolic residual` |
| C43-12 | `dataflow internal observation exact enumeration` |

## Replacement round `closure-replacement-44`: arXiv

Execute only if round 43 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-43
or round-44 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C44-01 | `compositional fixed point Kahn indeterminate dataflow` |
| C44-02 | `relational nondeterministic dataflow profunctor bisimulation` |
| C44-03 | `Petri net compositional dataflow input output semantics` |
| C44-04 | `symbolic WCET input dependent branches parametric` |
| C44-05 | `symbolic observation graph observed unobserved actions LTL` |
| C44-06 | `constructive synchronous dataflow semantics interpreter` |
| C44-07 | `dataflow process networks firing deadlock semantics` |
| C44-08 | `fair merge expressive power dataflow networks` |
| C44-09 | `exact requested internal observer input partition` |
| C44-10 | `caller inputs selection event inverse fibers` |
| C44-11 | `sparse requested site guard symbolic residual` |
| C44-12 | `dataflow internal observation exact enumeration` |

If round 43 reopens the map, round 44 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Complete
primary and independent audits remain mandatory before closure.

## Outcome of round 43 and retirement of round 44

Round 43 reopens the map under the frozen conservative trigger. All three
auditors parsed and title-screened the 1,200 occurrences. Each snapshot has 100
logical TSV records, ranks 1--100, and 100 unique nonblank source identifiers;
the batch contains 1,133 unique identifiers. Forty blank-title occurrences
represent 39 identifiers: two grant identifiers, three versions of a
variant-caller supplemental dataset, and 34 unrelated issue or volume records
from the wound-care publication named *WCET Journal*. The primary normalization
counted 1,034 unique nonblank titles; the independent normalizations counted
1,036 and 1,031 under their documented rules.

Two reviewers returned reopen and one returned no-add. The disagreement turns
on the predeclared lineage exception, not on the direct-target screen. The
no-add reviewer classified all works as variants within represented semantics.
The other two identified changed program-model or guarantee boundaries that
the frozen rule says are independently sufficient: a Coq-mechanized operational
semantics for asynchronous FIFO-connected dataflow circuits with determinacy
conditions and graph/calculus equivalence; an explicit equivalence between
extensional Kahn functions and intensional stepwise token-production semantics;
and a compositional Time Petri Net observer semantics derived from real-time
property patterns. Conservative adjudication therefore records reopen.

Supporting additions include causal non-interleaving semantics, operational
fibrational semantics that abstracts deterministic internal computations,
relational specification and feedback refinement, composable actor-causality
interfaces for deadlock analysis, and older fair-merge and parametric-WCET
variants. Conference, report, dissertation, and duplicate DOI records are
reconciled to the retained fuller or published versions when relevant.

None of the additions supplies the target construction. The mechanized
circuit semantics observes whole channel histories; the intensional semantics
records whole token-production interactions; RT-MOBS composes a property
monitor with a system; and the other semantics denote causal, relational,
timing, or deadlock objects. The four direct-query blocks contain established
neighbors and disciplinary homonyms. All three auditors agree that no title or
primary abstract claims complete requested-site observations, exact
caller-input inverse fibers, and typed residuals together.

Round 43 cannot count toward closure. Round 44's precondition failed; it is
retired unexecuted and cannot count toward the required no-add sequence.

## Replacement round `closure-replacement-45`: Crossref

Frozen on 2026-08-04 after reconciliation and independent adjudication of
round 43, and before any round-45 or round-46 query was executed. Source:
Crossref REST API. Each exact phrase is searched with `query.bibliographic`,
sorted by relevance, with the first 100 records exported unless fewer are
returned. A round qualifies as no-add only if complete screening adds neither
a conceptual cluster nor a plausible close competitor. A publication within
an already represented lineage does not reopen the map unless it changes the
compared semantic object, guarantee, or program-model boundary, or is
materially closer to the target construction.

| ID | Exact query |
|---|---|
| C45-01 | `mechanized operational dataflow circuits determinacy channel histories` |
| C45-02 | `intensional extensional dataflow token production observer` |
| C45-03 | `compositional observer semantics Petri net property pattern` |
| C45-04 | `causal noninterleaving dataflow internal computation equivalence` |
| C45-05 | `dataflow causality interface deadlock enabled dependencies` |
| C45-06 | `relational specification refinement timed dataflow networks` |
| C45-07 | `exact selection observation caller input fiber residual` |
| C45-08 | `requested site outcome partial map inverse image` |
| C45-09 | `contextual dataflow internal event input partition` |
| C45-10 | `symbolic residual observation guard enumeration` |
| C45-11 | `demand selected dataflow observer exact image` |
| C45-12 | `dataflow circuit selection observer caller inputs` |

## Replacement round `closure-replacement-46`: arXiv

Execute only if round 45 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-45
or round-46 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C46-01 | `mechanized operational dataflow circuits determinacy channel histories` |
| C46-02 | `intensional extensional dataflow token production observer` |
| C46-03 | `compositional observer semantics Petri net property pattern` |
| C46-04 | `causal noninterleaving dataflow internal computation equivalence` |
| C46-05 | `dataflow causality interface deadlock enabled dependencies` |
| C46-06 | `relational specification refinement timed dataflow networks` |
| C46-07 | `exact selection observation caller input fiber residual` |
| C46-08 | `requested site outcome partial map inverse image` |
| C46-09 | `contextual dataflow internal event input partition` |
| C46-10 | `symbolic residual observation guard enumeration` |
| C46-11 | `demand selected dataflow observer exact image` |
| C46-12 | `dataflow circuit selection observer caller inputs` |

If round 45 reopens the map, round 46 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Complete
primary and independent audits remain mandatory before closure.

## Outcome of round 45 and retirement of round 46

Round 45 reopens the map under the frozen conservative trigger. All three
auditors parsed and title-screened the 1,200 occurrences. Each snapshot has 100
logical TSV records, ranks 1--100, and 100 unique nonblank source identifiers;
the batch contains 1,171 unique identifiers. Eight blank-title occurrences
represent five grant identifiers and contain no technical publication. The
primary normalization counted 1,048 unique nonblank titles; the two independent
normalizations each counted 1,046 under their documented rules. Three quoted
multiline titles were parsed as single logical records.

All three auditors returned reopen. The decisive additions change one or more
of the semantic-object, guarantee, or program-model boundaries named by the
frozen rule:

- Law's 2026 dissertation extends the mechanized dynamically scheduled
  dataflow-circuit development from a dataflow specification level toward a
  lower hardware implementation and refinement guarantee.
- Brunet's 2013 paper and 2015 dissertation represent concrete action firings
  in execution-trace DAGs with explicit token, port, state, guard-enable, and
  guard-disable dependencies, then use them for post-mortem design-space
  reconstruction.
- Chariyathitipong and Vatanawood slice a Time Petri Net relative to an initial
  marking and MTL property while preserving the paths needed for equivalent
  property checking.
- Xu and collaborators prove selected generic handshake behaviors absent from
  HLS-generated dataflow circuits, simplify the circuit accordingly, and use
  HLS-guided inductive invariants to make those proofs scale.

Trace-theoretic asynchronous-circuit determinacy and translation from general
slack-elastic programs to dataflow circuits are retained as supporting
program-model boundaries. Conference, dissertation, and companion records are
kept distinct only where their compared object or guarantee differs.

None of these additions supplies the target construction. The mechanized work
relates whole circuit levels and channel behavior; the guard-trace work starts
from concrete serial executions; the Petri-net slice preserves one temporal
property; and the circuit-verification work proves selected behaviors absent.
All three auditors agree that no record combines a complete requested-site
observation image, exact caller-input inverse fibers, and typed general
residuals.

Round 45 cannot count toward closure. Round 46's precondition failed; it is
retired unexecuted and cannot count toward the required no-add sequence.

## Replacement round `closure-replacement-47`: Crossref

Frozen on 2026-08-04 after reconciliation and independent adjudication of
round 45, and before any round-47 or round-48 query was executed. Source:
Crossref REST API. Each exact phrase is searched with `query.bibliographic`,
sorted by relevance, with the first 100 records exported unless fewer are
returned. A round qualifies as no-add only if complete screening adds neither
a conceptual cluster nor a plausible close competitor. A publication within
an already represented lineage does not reopen the map unless it changes the
compared semantic object, guarantee, or program-model boundary, or is
materially closer to the target construction.

| ID | Exact query |
|---|---|
| C47-01 | `guard enable disable dynamic dataflow execution trace` |
| C47-02 | `dataflow execution trace graph action firing guard dependency` |
| C47-03 | `dataflow circuits excessive dynamism inductive invariants` |
| C47-04 | `mechanized dataflow hardware refinement dynamic HLS` |
| C47-05 | `property directed slicing timed Petri net dependency graph` |
| C47-06 | `slack elastic program dataflow circuit semantics` |
| C47-07 | `exact caller input partition internal guard observation` |
| C47-08 | `selection site observation symbolic residual fiber` |
| C47-09 | `requested root dataflow event inverse image` |
| C47-10 | `dynamic dataflow guard trace input equivalence` |
| C47-11 | `dataflow observer partial map caller inputs` |
| C47-12 | `complete internal event observation enumeration residual` |

## Replacement round `closure-replacement-48`: arXiv

Execute only if round 47 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-47
or round-48 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C48-01 | `guard enable disable dynamic dataflow execution trace` |
| C48-02 | `dataflow execution trace graph action firing guard dependency` |
| C48-03 | `dataflow circuits excessive dynamism inductive invariants` |
| C48-04 | `mechanized dataflow hardware refinement dynamic HLS` |
| C48-05 | `property directed slicing timed Petri net dependency graph` |
| C48-06 | `slack elastic program dataflow circuit semantics` |
| C48-07 | `exact caller input partition internal guard observation` |
| C48-08 | `selection site observation symbolic residual fiber` |
| C48-09 | `requested root dataflow event inverse image` |
| C48-10 | `dynamic dataflow guard trace input equivalence` |
| C48-11 | `dataflow observer partial map caller inputs` |
| C48-12 | `complete internal event observation enumeration residual` |

If round 47 reopens the map, round 48 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Complete
primary and independent audits remain mandatory before closure.

## Outcome of round 47 and retirement of round 48

Round 47 reopens the map under the frozen conservative trigger. All three
auditors parsed and title-screened the 1,200 logical occurrences. Every
snapshot has the required seven-column header, 100 records, ranks 1--100, and
100 unique nonblank source identifiers. The batch contains 1,091 unique
identifiers. Twenty blank-title occurrences represent 18 nontechnical grant,
dataset, journal-issue, or container identifiers. One quoted title spans two
physical lines and was parsed as one logical record. All three independent
normalizations counted 1,005 unique nonblank titles under their documented
punctuation and Unicode rules.

All three auditors returned reopen and agreed on three decisive additions:

- Casale Brunet and Mattavelli's 2018 journal execution-trace-graph formalism
  explicitly claims a complete representation capable of covering all
  admissible trajectories of a dynamic dataflow process network. This is a
  stronger guarantee than the earlier serial trace and post-mortem framing.
- The fuller *Tokens vs. Signals* journal article maps synchronous-hardware
  signals to asynchronous token-production and token-consumption events and
  defines conformance preserving worst-case throughput and latency.
- Maximal and minimal dynamic Petri-net slicing respectively preserves every
  computation that may contribute tokens to requested places and one shortest
  contributing computation, with maximality and minimality proved.

Conservative reconciliation also retains changed or supporting boundaries
identified by at least one complete audit: structural-dependency Petri slicing;
finite timed aggregate graphs; fully abstract compositional dataflow traces;
meaning-preserving translation from Kahn processes to firing actors; modular
bounded-dataflow and latency-insensitive circuit refinement; latency/occupancy
balancing for spurious dataflow dynamism; observation-policy-relative
discrete-event generators; and minimum observable event alphabets preserving
supervisor control equivalence. Report, conference, and malformed-DOI aliases
are reconciled to their fuller canonical publications.

None of these works supplies the target construction. Execution-trace graphs
range over action-firing trajectories; conformance and refinement compare
whole dataflow and hardware behaviors; Petri slices return subnets or timed
state graphs; and discrete-event observers return languages or supervisors.
All three auditors found no work combining a complete sparse requested-site
observation image, exact inverse caller-input fibers, and typed general
residuals.

Round 47 cannot count toward closure. Round 48's precondition failed; it is
retired unexecuted and cannot count toward the required no-add sequence.

## Replacement round `closure-replacement-49`: Crossref

Frozen on 2026-08-04 after reconciliation and independent adjudication of
round 47, and before any round-49 or round-50 query was executed. Source:
Crossref REST API. Each exact phrase is searched with `query.bibliographic`,
sorted by relevance, with the first 100 records exported unless fewer are
returned. A round qualifies as no-add only if complete screening adds neither
a conceptual cluster nor a plausible close competitor. A publication within
an already represented lineage does not reopen the map unless it changes the
compared semantic object, guarantee, or program-model boundary, or is
materially closer to the target construction.

| ID | Exact query |
|---|---|
| C49-01 | `execution trace graph complete dataflow all admissible trajectories` |
| C49-02 | `dataflow process network execution trace graph complete dependencies` |
| C49-03 | `tokens signals conformance dataflow hardware throughput latency` |
| C49-04 | `bounded dataflow networks latency insensitive circuit refinement` |
| C49-05 | `maximal minimal dynamic Petri net slicing token contribution` |
| C49-06 | `timed aggregate graph observation policy Petri net` |
| C49-07 | `Kahn processes actors translation firing semantics` |
| C49-08 | `fully abstract trace model dataflow asynchronous networks` |
| C49-09 | `minimal event observation policy supervisor equivalence` |
| C49-10 | `requested selection observation caller input inverse fiber` |
| C49-11 | `sparse internal event map symbolic residual` |
| C49-12 | `complete observation image requested dataflow site inputs` |

## Replacement round `closure-replacement-50`: arXiv

Execute only if round 49 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-49
or round-50 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C50-01 | `execution trace graph complete dataflow all admissible trajectories` |
| C50-02 | `dataflow process network execution trace graph complete dependencies` |
| C50-03 | `tokens signals conformance dataflow hardware throughput latency` |
| C50-04 | `bounded dataflow networks latency insensitive circuit refinement` |
| C50-05 | `maximal minimal dynamic Petri net slicing token contribution` |
| C50-06 | `timed aggregate graph observation policy Petri net` |
| C50-07 | `Kahn processes actors translation firing semantics` |
| C50-08 | `fully abstract trace model dataflow asynchronous networks` |
| C50-09 | `minimal event observation policy supervisor equivalence` |
| C50-10 | `requested selection observation caller input inverse fiber` |
| C50-11 | `sparse internal event map symbolic residual` |
| C50-12 | `complete observation image requested dataflow site inputs` |

If round 49 reopens the map, round 50 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Complete
primary and independent audits remain mandatory before closure.

## Outcome of round 49 and retirement of round 50

Round 49 reopens the map under the frozen conservative trigger. All three
auditors parsed and title-screened the 1,200 logical occurrences. Every
snapshot has the required seven-column header, 100 records, ranks 1--100, and
100 unique nonblank source identifiers. The batch contains 1,106 unique
identifiers; its 84 repeated-identifier groups contain 178 occurrences, or 94
excess occurrences. Three blank-title records are nontechnical grants. Three
quoted titles are multiline logical records: one contains two embedded
newlines and two contain one each.

All three independent normalizations counted 1,042 unique nonblank titles
among 1,197 nonblank occurrences. The aggressive normalization applies Unicode
NFKD, case folding, combining-mark deletion, maximal nonalphanumeric-run
replacement by one space, and whitespace trimming and collapsing. It finds
120 repeated-title groups containing 275 occurrences, or 155 excess
occurrences.

All three auditors returned reopen. Reconciliation retains 15 canonical works
whose semantic objects, guarantees, program-model boundaries, or proximity
satisfy the frozen trigger:

- Abramsky generalizes the Kahn principle to abstract asynchronous and
  nondeterministic networks; Arras et al. add a hierarchical parametric
  composite dataflow/KPN execution model; Oh combines KPN and decidable
  dataflow behavior at actor ports; and Tretter et al. translate compatible
  dataflow actors into Kahn processes, the inverse direction of the retained
  Kahn-to-firing-actor translation.
- Colaco et al. carry a Kahn semantics into a multicore Scade implementation,
  while Jonsson and Kok compare two fully abstract dataflow models by an
  explicit isomorphism.
- Cao et al. prove token-sequence preservation for latency-insensitive
  dataflow buffers; Kapoor supplies a process-algebraic model with liveness,
  deadlock-freedom, and latency-equivalence checks; Singh and Theobald extend
  latency-insensitive design to conditional channel use, arbitrary network
  topologies, and multiple clocks; and Suhaib et al. validate protocol families
  dynamically and formally against latency equivalence. The 2005 Suhaib
  conference record is reconciled to the fuller 2006 journal article.
- Juhas et al. unify Petri-net semantics through token flows; Kovar and
  Bergenthum give token-trail semantics for nets and their net language; Rakow
  slices Petri nets while preserving scoped stutter-invariant safety
  properties; and Ruan et al. reconstruct unknown net structure from
  asynchronous token-change observations.
- Delpeuch gives a complete categorical language for value-routed faceted
  dataflow programs and workflow equivalence.

Complete execution-trace graphs, Tokens-vs.-Signals conformance, bounded
latency-insensitive refinement, maximal/minimal and structural Petri-net
slicing, timed aggregate graphs, Kahn-to-actor translation, fully abstract
traces, and minimal-event observation recur as already cataloged candidates.
Earlier dynamic-slicing algorithms, latency-insensitive implementation
variants, the Sears--Rudie observation survey, asynchronous trace reductions,
and dataflow causal graphs remain supporting variants and add no separate
changed boundary under this reconciliation.

The audit also repairs one pre-existing catalog duplication: the DOI
`10.1109/CSCWD68734.2026.11582111` had both `liang2026dataflow` and
`liang2026dataflowpruning`. The latter is the retained canonical key and the
former is removed. This is a one-time metadata repair, not a round-49
literature addition.

None of the additions supplies the target construction. They compare whole
network traces, translate execution models, validate channel or protocol
behavior, slice or reconstruct Petri nets, or axiomatize a different dataflow
language. All three auditors found no work combining a complete sparse
requested-site observation image, exact caller-input inverse fibers, and typed
general residuals. Round 49 therefore cannot count toward closure, and round
50 is retired unexecuted.

## Replacement round `closure-replacement-51`: Crossref

Frozen on 2026-08-04 after reconciliation of round 49, and before any round-51
or round-52 query is executed. Source: Crossref REST API. The first twelve
queries follow the changed boundaries added in round 49; the last three are
direct-target queries. Each exact phrase is searched with
`query.bibliographic`, sorted by relevance, with the first 100 records exported
unless fewer are returned. A round qualifies as no-add only if complete
screening adds neither a conceptual cluster nor a plausible close competitor.
A publication within an already represented lineage does not reopen the map
unless it changes the compared semantic object, guarantee, or program-model
boundary, or is materially closer to the target construction.

| ID | Exact query |
|---|---|
| C51-01 | `generalized Kahn principle abstract asynchronous nondeterministic event structures` |
| C51-02 | `composite parametric dataflow Kahn process network port actor model` |
| C51-03 | `latency insensitive dataflow buffer token sequence preservation backpressure` |
| C51-04 | `process algebraic latency insensitive liveness deadlock latency equivalence` |
| C51-05 | `generalized latency insensitive multi clock arbitrary topology protocol validation` |
| C51-06 | `dataflow actors as Kahn processes Scade multicore semantics implementation` |
| C51-07 | `fully abstract dataflow model isomorphism Kahn trace semantics` |
| C51-08 | `Petri net token flow token trail net language semantics` |
| C51-09 | `safety preserving Petri net slicing stutter invariant property` |
| C51-10 | `reconstruct Petri net structure asynchronous token change observations` |
| C51-11 | `complete categorical faceted dataflow workflow equivalence` |
| C51-12 | `dataflow execution model translation observation preservation guarantee` |
| C51-13 | `complete sparse requested site observation image caller input inverse fibers` |
| C51-14 | `exact internal event observation partition typed residual function` |
| C51-15 | `requested selection site outcomes input fibers symbolic residuals` |

## Replacement round `closure-replacement-52`: arXiv

Execute only if round 51 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-51
or round-52 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C52-01 | `generalized Kahn principle abstract asynchronous nondeterministic event structures` |
| C52-02 | `composite parametric dataflow Kahn process network port actor model` |
| C52-03 | `latency insensitive dataflow buffer token sequence preservation backpressure` |
| C52-04 | `process algebraic latency insensitive liveness deadlock latency equivalence` |
| C52-05 | `generalized latency insensitive multi clock arbitrary topology protocol validation` |
| C52-06 | `dataflow actors as Kahn processes Scade multicore semantics implementation` |
| C52-07 | `fully abstract dataflow model isomorphism Kahn trace semantics` |
| C52-08 | `Petri net token flow token trail net language semantics` |
| C52-09 | `safety preserving Petri net slicing stutter invariant property` |
| C52-10 | `reconstruct Petri net structure asynchronous token change observations` |
| C52-11 | `complete categorical faceted dataflow workflow equivalence` |
| C52-12 | `dataflow execution model translation observation preservation guarantee` |
| C52-13 | `complete sparse requested site observation image caller input inverse fibers` |
| C52-14 | `exact internal event observation partition typed residual function` |
| C52-15 | `requested selection site outcomes input fibers symbolic residuals` |

If round 51 reopens the map, round 52 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Complete
primary and independent audits remain mandatory before closure.

## Outcome of round 51 and retirement of round 52

Round 51 reopens the map under the frozen conservative trigger. All three
auditors parsed and title-screened the 1,500 logical occurrences. Every
snapshot has the required seven-column header, 100 records, ranks 1--100, and
100 unique nonblank source identifiers. The batch contains 1,338 unique
identifiers. Seven blank-title occurrences are nontechnical grants or versions
of one irrelevant supplemental dataset. Seven quoted titles are multiline
logical records and were parsed as single records.

All three aggressive normalizations counted 1,264 unique nonblank titles among
the 1,493 nonblank occurrences. The normalization applies Unicode NFKD, case
folding, combining-mark deletion, maximal nonalphanumeric-run replacement by
one space, and whitespace trimming and collapsing.

Conservative reconciliation retains one canonical work:

- Bergenthum, Mauser, Lorenz, and Juhas's 2009 *Unfolding Semantics of Petri
  Nets Based on Token Flows* introduces token-flow and reduced-token-flow
  unfoldings. Both preserve complete partial-order behavior; the first avoids
  isomorphic process representations and the second also reduces processes
  with isomorphic underlying runs. This changes the represented Petri-net
  semantic object and completeness/redundancy guarantee.

The remaining candidates add no separate catalog boundary. Skelin's parametric
SADF throughput analysis was screened in the earlier C3 lineage; Rafique's KPN
framework, Sirdey's LP verification, and Dardaillon's parametric compiler are
model, analysis, or implementation variants of represented KPN and parametric
dataflow boundaries. Sluice, Superconnectors, KAIROS, hardware/software
interfaces, multi-clock wrappers, backpressure, functional validation, and
LID-1ss circuits stay inside represented latency-insensitive program and
guarantee boundaries. Gold's compositional Petri/dataflow semantics is already
cataloged, while collective-token comparison, Token Trail I, PPPA book
fragments, invariant-preserving reductions, and transition-preserving
reductions are predecessors or previously screened variants inside represented
Petri-net lineages. Li and Hadjicostis's firing-sequence reconstruction remains
forward observation/state estimation in the represented Giua lineage, and the
dataflow-to-Petri-net property mapping is a cross-model analysis variant.

None of the records supplies the target construction. The retained unfolding
represents complete Petri-net partial-order behavior, not a complete sparse
image for a requested internal program site. All three auditors found no work
combining that image with exact inverse caller-input fibers and typed general
residuals. Round 51 therefore cannot count toward closure, and round 52 is
retired unexecuted.

## Replacement round `closure-replacement-53`: Crossref

Frozen on 2026-08-04 after reconciliation and independent adjudication of
round 51, and before any round-53 or round-54 query was executed. Source:
Crossref REST API. The first five queries follow the changed token-flow
unfolding object and its completeness and redundancy guarantees; the final
three are direct-target queries. Each exact phrase is searched with
`query.bibliographic`, sorted by relevance, with the first 100 records exported
unless fewer are returned. A round qualifies as no-add only if complete
screening adds neither a conceptual cluster nor a plausible close competitor.
A publication within an already represented lineage does not reopen the map
unless it changes the compared semantic object, guarantee, or program-model
boundary, or is materially closer to the target construction.

| ID | Exact query |
|---|---|
| C53-01 | `token flow unfolding Petri net complete partial order behavior` |
| C53-02 | `reduced token flow unfolding avoid isomorphic processes` |
| C53-03 | `complete finite prefix bounded Petri nets token flow` |
| C53-04 | `prime event structure token flow unfolding canonical prefix` |
| C53-05 | `compact Petri net unfolding semantics redundant events` |
| C53-06 | `complete sparse requested site observation image caller input inverse fibers` |
| C53-07 | `exact internal event observation partition typed residual function` |
| C53-08 | `requested selection site outcomes input fibers symbolic residuals` |

## Replacement round `closure-replacement-54`: arXiv

Execute only if round 53 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-53
or round-54 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C54-01 | `token flow unfolding Petri net complete partial order behavior` |
| C54-02 | `reduced token flow unfolding avoid isomorphic processes` |
| C54-03 | `complete finite prefix bounded Petri nets token flow` |
| C54-04 | `prime event structure token flow unfolding canonical prefix` |
| C54-05 | `compact Petri net unfolding semantics redundant events` |
| C54-06 | `complete sparse requested site observation image caller input inverse fibers` |
| C54-07 | `exact internal event observation partition typed residual function` |
| C54-08 | `requested selection site outcomes input fibers symbolic residuals` |

If round 53 reopens the map, round 54 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Complete
primary and independent audits remain mandatory before closure.

## Outcome of round 53 and retirement of round 54

Round 53 reopens the map under the frozen conservative trigger. All three
auditors parsed and title-screened the 800 logical occurrences. Every snapshot
has the required seven-column header, 100 records, ranks 1--100, and 100 unique
nonblank source identifiers. The batch contains 743 unique identifiers. Seven
blank-title occurrences are two nontechnical grants and five versions of one
irrelevant supplemental dataset. Nine quoted titles are multiline logical
records and were parsed as single records.

All three aggressive normalizations counted 708 unique nonblank titles among
the 793 nonblank occurrences. The normalization applies Unicode NFKD, case
folding, combining-mark deletion, maximal nonalphanumeric-run replacement by
one space, and whitespace trimming and collapsing.

Conservative reconciliation retains four canonical works:

- Madalinski and Fabre construct a modular finite complete prefix from
  component interface summaries passed between neighbors, without constructing
  the global distributed-system prefix. The 2008 conference article is
  reconciled to the fuller 2009 journal publication.
- Würdemann et al. define complete finite prefixes for symbolic unfoldings of
  safe high-level Petri nets and extend the construction to a class with
  infinitely many reachable markings for which the represented ordinary P/T
  net cannot use the original algorithm. The 2023 chapter is reconciled to the
  fuller 2024 journal publication.
- Baldan et al. construct complete prefixes directly for contextual nets,
  retaining concurrent read-only accesses instead of first encoding them as
  consume-and-reproduce loops in ordinary nets.
- Chatain and Jard construct complete finite prefixes of safe Time-Petri-net
  symbolic unfoldings using bounded symbolic token-age information, preserving
  the dense-time behavior represented by extended processes.

The remaining candidates add no separate catalog boundary. Bergenthum's 2008
*Faster Unfolding* article is the conference predecessor of the retained 2009
token-flow journal article. The earlier read-arc unfolding supports the retained
contextual-prefix construction. Process-versus-unfolding comparison,
compositional and operational component semantics, finite unfoldings for
unbounded nets, token-history nets, inhibitor-net processes, occurrence nets,
pomset semantics, and event-structure variants remain supporting or inside
represented Petri-net semantic boundaries after conservative adjudication.
Timed or output-synchronized state estimators, diagnosability unfoldings,
deadlock replay, control, planning, partial-order reduction, and circuit
verification likewise remain within represented observer or verification
boundaries.

None of the additions supplies the target construction. They preserve complete
Petri-net behaviors across modular, high-level, contextual, or timed models;
they do not construct a sparse requested-site observation image or exact
inverse caller-input fibers with typed residuals. Round 53 therefore cannot
count toward closure, and round 54 is retired unexecuted.

## Replacement round `closure-replacement-55`: Crossref

Frozen on 2026-08-04 after reconciliation and independent adjudication of
round 53, and before any round-55 or round-56 query was executed. Source:
Crossref REST API. The first four queries follow the changed complete-prefix
objects retained from round 53, the fifth crosses their compositional and
completeness guarantees, and the final three are direct-target queries. Each
exact phrase is searched with `query.bibliographic`, sorted by relevance, with
the first 100 records exported unless fewer are returned. A round qualifies as
no-add only if complete screening adds neither a conceptual cluster nor a
plausible close competitor. A publication within an already represented
lineage does not reopen the map unless it changes the compared semantic object,
guarantee, or program-model boundary, or is materially closer to the target
construction.

| ID | Exact query |
|---|---|
| C55-01 | `modular finite complete prefix Petri net interface summaries message passing` |
| C55-02 | `symbolic unfolding high level Petri net complete finite prefix infinite markings` |
| C55-03 | `contextual read arc Petri net complete prefix concurrent reads` |
| C55-04 | `safe Time Petri net symbolic unfolding complete finite prefix` |
| C55-05 | `compositional symbolic unfolding complete prefix Petri net preservation` |
| C55-06 | `complete sparse requested site observation image caller input inverse fibers` |
| C55-07 | `exact internal event observation partition typed residual function` |
| C55-08 | `requested selection site outcomes input fibers symbolic residuals` |

## Replacement round `closure-replacement-56`: arXiv

Execute only if round 55 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-55
or round-56 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C56-01 | `modular finite complete prefix Petri net interface summaries message passing` |
| C56-02 | `symbolic unfolding high level Petri net complete finite prefix infinite markings` |
| C56-03 | `contextual read arc Petri net complete prefix concurrent reads` |
| C56-04 | `safe Time Petri net symbolic unfolding complete finite prefix` |
| C56-05 | `compositional symbolic unfolding complete prefix Petri net preservation` |
| C56-06 | `complete sparse requested site observation image caller input inverse fibers` |
| C56-07 | `exact internal event observation partition typed residual function` |
| C56-08 | `requested selection site outcomes input fibers symbolic residuals` |

If round 55 reopens the map, round 56 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Complete
primary and independent audits remain mandatory before closure.

## Outcome of round 55 and retirement of round 56

Round 55 reopens the map under the frozen conservative trigger. All three
auditors parsed and title-screened the 800 logical occurrences. Every snapshot
has the required seven-column header, 100 records, ranks 1--100, and 100 unique
nonblank source identifiers. The batch contains 699 unique identifiers and 656
unique nonblank titles under the recorded aggressive normalization. Eight
blank-title occurrences are one grant and seven versions of irrelevant
supplemental datasets. Six quoted titles are multiline logical records and were
parsed as single records.

Conservative reconciliation retains two canonical works:

- Jard et al. construct symbolic unfoldings for safe parametric stopwatch
  Petri nets, retaining time, stopwatch, and parameter constraints. Their
  finite-complete-prefix result is deliberately narrower: it applies only to
  the ordinary safe Time-Petri-net subclass. The 2010 conference chapter is
  reconciled to the expanded 2013 journal article.
- Adobbati et al. construct a finite full prefix of the maximal-step
  computation tree for 1-safe free-choice nets. It is adequate for reveals and
  excludes analysis, and a terminating algorithm computes exactly the sets of
  transition labels occurring in all maximal runs. Those footprints discard
  event order and multiplicity and have an exponential worst-case computation
  bound.

The earlier Time-Petri-net prefix is a predecessor represented alongside the
changed parametric-stopwatch symbolic boundary. Other finite-prefix algorithms,
symbolic reachability graphs, component semantics, process-at-a-time variants,
and language encodings remain supporting or within represented Petri-net
semantic lineages. None of the additions supplies the target construction:
their domains are whole-net processes or runs, not caller inputs to a requested
pure-program result, and neither emits exact caller-input guards with typed
residual values. Round 55 therefore cannot count toward closure, and round 56
is retired unexecuted.

## Replacement round `closure-replacement-57`: Crossref

Frozen on 2026-08-04 after reconciliation and independent adjudication of
round 55, and before any round-57 or round-58 query was executed. Source:
Crossref REST API. The first four queries follow the two changed semantic
objects and their observer guarantees, the fifth crosses symbolic prefix and
observer terminology, and the final three are direct-target queries. Each
exact phrase is searched with `query.bibliographic`, sorted by relevance, with
the first 100 records exported unless fewer are returned. A round qualifies as
no-add only if complete screening adds neither a conceptual cluster nor a
plausible close competitor. A publication within an already represented
lineage does not reopen the map unless it changes the compared semantic object,
guarantee, or program-model boundary, or is materially closer to the target
construction.

| ID | Exact query |
|---|---|
| C57-01 | `symbolic unfolding parametric stopwatch Petri nets parameter valuations` |
| C57-02 | `finite full prefix free choice net transition information flow footprints` |
| C57-03 | `reveals excludes transition relations finite prefix maximal step` |
| C57-04 | `exact maximal run footprint enumeration free choice Petri net` |
| C57-05 | `compositional symbolic observer finite prefix transition footprints` |
| C57-06 | `complete sparse requested site observation image caller input inverse fibers` |
| C57-07 | `exact internal event observation partition typed residual function` |
| C57-08 | `requested selection site outcomes input fibers symbolic residuals` |

## Replacement round `closure-replacement-58`: arXiv

Execute only if round 57 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-57
or round-58 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C58-01 | `symbolic unfolding parametric stopwatch Petri nets parameter valuations` |
| C58-02 | `finite full prefix free choice net transition information flow footprints` |
| C58-03 | `reveals excludes transition relations finite prefix maximal step` |
| C58-04 | `exact maximal run footprint enumeration free choice Petri net` |
| C58-05 | `compositional symbolic observer finite prefix transition footprints` |
| C58-06 | `complete sparse requested site observation image caller input inverse fibers` |
| C58-07 | `exact internal event observation partition typed residual function` |
| C58-08 | `requested selection site outcomes input fibers symbolic residuals` |

If round 57 reopens the map, round 58 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Complete
primary and independent audits remain mandatory before closure.

## Outcome of round 57, forward reconciliation, and retirement of round 58

Round 57 reopens the map under the frozen conservative trigger. All three
auditors parsed and title-screened the 800 logical occurrences. Each snapshot
has the required seven-column header, 100 records, exact ranks, and 100 unique
nonblank identifiers. The batch contains 782 unique identifiers and 721 unique
nonblank titles under the frozen normalization. Six blank-title occurrences
are a nontechnical grant and five versions of an irrelevant supplement. Eight
quoted titles are multiline logical records.

The independent audits agreed on the decisive bounded equal-conflict result
and disagreed conservatively over three supporting branches. Reconciliation
retains two canonical works directly from the batch:

- Bernardinello et al. define reveals, excludes, extended reveals, and
  occurrence-count-sensitive repeated reveals over maximal Petri-net runs.
  The 2015 workshop paper is reconciled to the canonical 2016 chapter. It
  changes the observer semantics but supplies no decision algorithm.
- Adobbati et al. extend the information-flow model from 1-safe free-choice
  nets to bounded equal-conflict weighted systems, replace set footprints with
  multiplicity-sensitive parametric reveals, prove correctness and
  termination, and in the final treatment use a smaller query-relative
  reduced-marking structure. The 2022 workshop paper is its preliminary
  version.

Directed unfolding and BNDC noninterference checking are recorded as close
supporting boundaries, not independent additions: the former primarily orders
exploration or prunes sound dead ends, and the latter decides one Boolean
security property atop a complete prefix. A complete 41-record OpenAlex
forward neighborhood from directed unfolding was then frozen and screened.
That follow-up retains two additional canonical works:

- Bonet et al. parameterize complete unfolding prefixes by a user-declared
  configuration equivalence and cutting context, weaken adequate orders to
  proof-only well-founded relations, and separate event selection from cutoff
  correctness.
- Chatain and Paulevé compute a finite goal-driven prefix for a finite safe net
  that omits transitions outside every minimal configuration to one requested
  marking while preserving all such configurations.

Unbounded-deadlock unfoldings, lazy reachability-query schemes, planning and
alignment applications, parametric state reachability, stopwatch state spaces,
flow unfoldings, free-choice observability, maximal-step state generation,
and compositional symbolic-execution variants remain within represented or
supporting model, property, and search boundaries after target-focused
adjudication. The direct-target queries contain no work that partitions caller
inputs by a sparse requested internal-site observer and attaches exact guards
and typed residuals. Round 57 therefore cannot count toward closure, and round
58 is retired unexecuted.

## Replacement round `closure-replacement-59`: Crossref

Frozen on 2026-08-04 after reconciliation and independent adjudication of
round 57 and its forward neighborhood, and before any round-59 or round-60
query was executed. Source: Crossref REST API. The first five queries follow
the changed observer and preservation objects, and the final three are direct-
target queries. Each exact phrase is searched with `query.bibliographic`,
sorted by relevance, with the first 100 records exported unless fewer are
returned. A round qualifies as no-add only if complete screening adds neither
a conceptual cluster nor a plausible close competitor. A publication within
an already represented lineage does not reopen the map unless it changes the
compared semantic object, guarantee, or program-model boundary, or is
materially closer to the target construction.

| ID | Exact query |
|---|---|
| C59-01 | `parametric reveals bounded equal conflict Petri net multiplicity threshold full prefix` |
| C59-02 | `repeated reveals excludes occurrence counts noninterference Petri net` |
| C59-03 | `goal driven unfolding minimal configurations requested marking Petri net` |
| C59-04 | `user specified preserved information unfolding prefix cutoff well founded relation` |
| C59-05 | `query directed Petri net unfolding observer preservation configuration equivalence` |
| C59-06 | `complete sparse requested site observation image caller input inverse fibers` |
| C59-07 | `exact internal event observation partition typed residual function` |
| C59-08 | `requested selection site outcomes input fibers symbolic residuals` |

## Replacement round `closure-replacement-60`: arXiv

Execute only if round 59 adds neither a conceptual cluster nor a plausible
close competitor. Source: arXiv API. Frozen on 2026-08-04 before any round-59
or round-60 execution. Each phrase is submitted as the conjunction of all
alphanumeric terms across arXiv's `all` field, sorted by relevance, with at
most the first 100 records and abstracts exported.

| ID | Exact query |
|---|---|
| C60-01 | `parametric reveals bounded equal conflict Petri net multiplicity threshold full prefix` |
| C60-02 | `repeated reveals excludes occurrence counts noninterference Petri net` |
| C60-03 | `goal driven unfolding minimal configurations requested marking Petri net` |
| C60-04 | `user specified preserved information unfolding prefix cutoff well founded relation` |
| C60-05 | `query directed Petri net unfolding observer preservation configuration equivalence` |
| C60-06 | `complete sparse requested site observation image caller input inverse fibers` |
| C60-07 | `exact internal event observation partition typed residual function` |
| C60-08 | `requested selection site outcomes input fibers symbolic residuals` |

If round 59 reopens the map, round 60 is retired unexecuted. If both qualify,
they establish the required two-round no-add sequence only for the recorded
sources, exact queries, captured rankings, date, and frozen trigger. Complete
primary and independent audits remain mandatory before closure.

## Outcome of round 59 and authorization of round 60

Round 59 qualifies as a no-add round under the frozen conservative trigger.
All three auditors independently parsed and title-screened all 800 logical
occurrences rather than a sample. Every snapshot has the required seven-column
header, 100 records, ranks 1--100, and 100 unique nonblank identifiers. Across
the batch there are 648 unique identifiers and 610 unique nonblank titles under
the frozen aggressive normalization. Twelve blank-title occurrences are
nontechnical grants or versions of irrelevant supplemental datasets. Six
quoted titles contain embedded newlines and parse as single logical records.

The highest-ranked technical results recur from the reconciled neighborhood:
parametric and repeated reveals, finite Time-Petri-net prefixes, directed
unfolding, adequate-order theory, query-driven net reduction, observation-
structure equivalence, diagnosability, and dynamic Petri-net slicing. Logic-
program unfolding and partial deduction also appear through the well-founded-
relation query. These works construct or preserve whole-net processes,
markings, run relations, program specializations, or selected analysis
properties. None enumerates the finite image of a caller-requested internal
dataflow-site observer, its exact inverse caller-input fibers, and typed
residual values. The three direct-target queries contain only already
represented testing boundaries and lexical homonyms.

Round 59 therefore adds neither a conceptual cluster nor a plausible close
competitor. Its predeclared condition is satisfied, so round 60 is authorized
without changing its source, queries, ranking, depth, or trigger.

## Outcome of round 60 and mapping closure

Round 60 qualifies as the second consecutive no-add round. Each of the eight
frozen phrases was translated mechanically into the conjunction of every
alphanumeric term over arXiv's `all` field, with relevance-descending order and
a 100-record limit. The original API responses reported zero hits and zero
exports for every query. The eight retained snapshots consequently contain the
exact eight-column header and no data records.

Three independent audits verified the complete file set, byte-identical
headers, zero logical records, and the query-construction code. Each auditor
also replayed all eight queries read-only and again obtained zero hits and zero
exports. There was therefore no candidate to add, exclude, or chase. The
search-log rows preserve the original hit metadata because a header-only TSV
alone proves zero exported records, not the API's `totalResults` value.

Rounds 59 and 60 are consecutive, predeclared, independently audited no-add
rounds. The map is therefore **closed under the recorded protocol as of 4
August 2026**: the exact Crossref and arXiv queries, their ranking and depth,
the conservative reopening trigger, the reconciled critical sources, and the
separate citation chases. The zero-hit arXiv conjunctions are deliberately
reported as narrow source/query saturation. They do not establish global
literature completeness, statistical independence of retrieval systems, or a
priority claim. Later work, a different index, or a newly exposed conceptual
cluster reopens the map.
