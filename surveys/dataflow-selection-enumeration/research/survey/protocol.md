# Survey protocol

## Objective

Determine how prior work represents and exhaustively enumerates the distinct
selection observations of finite pure dataflow graphs, identify the closest
established formalisms and algorithms, and select terminology and theorem
obligations that make the formal synthesis precise. The synthesis defines a
selection observation as the partial map of site outcomes reached from the
requested result by following strict operands and input-selected case edges.
Constructing one monolithic symbolic expression or SMT encoding is a baseline,
not the target enumeration problem.

This is a systematic mapping study with backward and forward snowballing. It is
not a systematic literature review: the objective is to map neighboring
semantic objects and algorithms, not to estimate effects over a population of
empirical studies. Reproducibility claims apply only to rows in the audited
search log; the earlier exploratory record is retained separately and does not
count toward closure.

## Research questions

- **RQ1:** What mathematical program models are used for symbolic evaluation
  without conventional control-flow paths?
- **RQ2:** What objects are enumerated: paths, traces, cases, configurations,
  models, implicants, cubes, guarded values, or input regions?
- **RQ3:** Which approaches enumerate partial rather than total decisions, and
  how do they treat inactive or irrelevant choices?
- **RQ4:** Which soundness, completeness, uniqueness, coverage, disjointness,
  or minimality properties are defined and proved?
- **RQ5:** How are residual symbolic values, witnesses, and graph sharing
  represented?
- **RQ6:** Which algorithms avoid redundant products of choices, and what
  complexity or output-sensitivity results are known?
- **RQ7:** Which assumptions are made about purity, totality, effects, cycles,
  time, and solver completeness?
- **RQ8:** Which motivating examples best expose the distinction between merged
  symbolic values, global decision assignments, and demanded choices?

## Search clusters

1. Foundational and formal semantics of symbolic execution.
2. Multi-path symbolic execution, state merging, guarded values, variational
   execution, and veritesting.
3. Symbolic simulation, symbolic trajectory evaluation, circuits, mux networks,
   and RTL symbolic execution.
4. Synchronous and dataflow-language verification and test generation,
   including Lustre, SCADE, SIGNAL, GATeL, and Lurette.
5. Dataflow-program example and test generation, including relational and
   MapReduce systems.
6. AllSAT, AllSMT, projected enumeration, disjoint partial models, implicants,
   and cube enumeration.
7. Trace/state partitioning in abstract interpretation.
8. Decision diagrams, conditional values, partial evaluation, residualization,
   program slicing, and demand or cone-of-influence analysis.

## Discovery sources

Search ACM Digital Library, IEEE Xplore, SpringerLink, USENIX proceedings,
conference proceedings, DBLP, author publication pages, and scholarly search
engines. Search engines and indexes are discovery aids; substantive conclusions
must be checked against the primary paper or its author-hosted version.

For auditable searches, record the database or API by name, the exact query or
seed identifier, direction, filters, hit count, screened identifiers, included
keys, excluded keys, and execution date. A query that cannot expose a stable
result set may discover candidates but cannot establish closure.

## Initial search expressions

Queries combine terms from the following groups:

```text
"symbolic execution" AND (denotational semantics OR input partition)
"symbolic evaluation" AND (dataflow graph OR term graph OR expression DAG)
(multipath OR "multi-path") AND "symbolic execution"
(guarded value OR value summary) AND symbolic
(AllSAT OR AllSMT) AND (partial OR projected OR disjoint) AND enumeration
"trace partitioning" AND abstract interpretation
(symbolic simulation OR symbolic execution) AND (circuit OR mux OR RTL)
(Lustre OR SCADE OR SIGNAL) AND (symbolic OR test generation OR coverage)
dataflow AND (symbolic execution OR symbolic test generation)
(demand OR relevance OR cone-of-influence) AND symbolic evaluation
```

Every closure query is recorded in `search-log.tsv`; useful synonyms discovered
during reading are added in later rounds rather than silently changing this
protocol. Non-replayable searches made before this rule was adopted remain in
`exploratory-search-log.tsv` and are not used to claim saturation.

The exact final no-add batches, their execution order, screening depth, and
reopening rule are frozen in `closure-audit.md` before execution.

## Inclusion criteria

Include a work when it makes a technical contribution to at least one research
question and provides enough detail to compare semantics, guarantees, or
algorithmic behavior. Foundational technical reports and theses may be included
when they are the primary or most complete source of an influential result.

## Exclusion criteria

Exclude, with a recorded reason:

- works using *data-flow testing* solely to mean def-use coverage in an
  otherwise conventional CFG;
- works using *symbolic graph execution* solely to mean staged execution of a
  machine-learning graph;
- secondary summaries when the primary work is available;
- applications that use an off-the-shelf symbolic executor without changing or
  formalizing the relevant semantic object;
- works whose full technical content cannot be obtained after reasonable
  attempts, unless their terminology itself materially affects the survey.

Use one of these stable exclusion codes in the catalog:

- `E1-def-use-testing`: conventional CFG def-use coverage only;
- `E2-ml-graph-runtime`: execution or staging of a machine-learning graph only;
- `E3-secondary`: secondary source superseded by an available primary work;
- `E4-application-only`: applies an off-the-shelf executor without changing the
  relevant semantic object;
- `E5-unobtainable`: insufficient technical content after recorded attempts;
- `E6-out-of-scope-model`: technical contribution is real but cannot answer any
  research question under the finite pure-graph scope;
- `E7-duplicate-version`: superseded version retained only for lineage.

## Screening and deep reading

Title/abstract screening assigns taxonomy fields, priority, and status. Deep
reading uses the source-note template and must inspect definitions, the central
algorithm, theorem statements and assumptions, complexity discussion, examples,
and related work—not only the abstract and introduction. Claims used in the
manuscript must also appear in `evidence-matrix.tsv` with a source-note anchor.

The extraction taxonomy is deliberately multi-dimensional:

1. program model;
2. represented or enumerated object;
3. omission or merging mechanism;
4. representation and algorithm;
5. guarantees;
6. assumptions and semantic boundaries.

## Snowballing and saturation

For every closest work, perform backward citation chasing and forward citation
chasing as separate log rows. `search-log.tsv` records one seed, one direction,
and one stable result set per row; aggregate descriptions are invalid.

An index-provided backward neighborhood satisfies this requirement only when
it exports the seed's complete primary bibliography. If identifiers are
unresolved, the index reports zero references despite a real bibliography, or
the exported count is otherwise smaller, retain the defective snapshot and
add a separately logged complete bibliography snapshot from the primary paper.
The complete primary list—not the resolvable index subset—is screened for
closure. A wrong-DOI or surrogate-version record is likewise discovery
evidence only unless its bibliography is checked against the actual seed.

The initial mapping closes only after:

1. every work named by an exploratory row is either cataloged or explicitly
   marked `not-recorded` in that row;
2. the bounded critical reading set is complete;
3. every closest work has separately recorded backward and forward chasing;
4. two consecutive *audited* rounds add neither a conceptual cluster nor a
   plausible close competitor;
5. an independent reviewer audits borderline exclusions and the closure log.

The result is called **mapping closure**, not proof that no relevant work
exists. Later papers or a newly exposed cluster reopen the mapping.

## Search-log schema

The tab-separated audited log has these fields:

- `date`: ISO date of execution;
- `round_id`: stable identifier grouping a predeclared batch;
- `phase`: database search, backward snowballing, forward snowballing, or audit;
- `source`: database/API and, when relevant, version or access mode;
- `exact_query_or_seed`: verbatim query or persistent seed identifier;
- `direction`: `query`, `backward`, `forward`, or `audit`;
- `hits`: exact result count exposed by the source;
- `screened`: exact count screened;
- `included_keys`: comma-separated catalog keys, or `-`;
- `excluded_keys`: comma-separated catalog keys with excluded status, or `-`;
- `notes`: filters, inaccessible records, result-set artifact, or limitations.

A row with an approximate hit count, unknown screened set, or aggregated seeds
is exploratory and must not be moved into the audited log.

## Novelty test

For each closest work, restate our hypothesis in that work's notation and ask:

1. Is the desired partition already one of its semantic objects?
2. Is demand-sensitive omission merely an existing projection, slice, cube, or
   state-merging operation?
3. Do its theorems imply ours directly under a simple encoding?
4. Would our algorithm be a standard enumeration scheme applied to a new IR?
5. If so, what nontrivial theorem, representation, or complexity result remains?

A negative answer to novelty is a useful survey outcome and must be recorded in
`research/claims.md` rather than softened.

## Survey snapshot

- Protocol established: 2026-08-04
- Paper route: theory-backed survey after the novelty audit in decision 0002
- Stretch venue standard: ACM Computing Surveys
- Working language: English
