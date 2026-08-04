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

## Independent audit

After both rounds qualify, a reviewer who did not choose the queries receives:

1. all screened snapshots;
2. the included and excluded catalog entries;
3. every critical source note; and
4. the claimed closure conditions.

The reviewer must sample borderline exclusions, look for uncataloged plausible
titles in every audit snapshot, and either sign a dated audit row in
`search-log.tsv` or reopen the map with concrete findings.
