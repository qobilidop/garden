---
citekey: wohlin2014-snowballing
work:
  title: Guidelines for Snowballing in Systematic Literature Studies and a Replication in Software Engineering
  author: Claes Wohlin
  venue: EASE 2014 (ACM)
  date: 2014-05-13
  doi: 10.1145/2601248.2601268
sources:
  pdf:  # → store
    url: http://www.wohlin.eu/ease14.pdf
    archived: https://web.archive.org/web/20251118132102/https://www.wohlin.eu/ease14.pdf
    # author-hosted version (ACM version-of-record gated); verified byte-identical to the archive record
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "The snowballing canon: citation edges beat search strings because authors cite each other across terminology drift — one found paper suffices to reach the connected cluster, and for extending an existing study snowballing wins by deduction."
---

# Guidelines for Snowballing in Systematic Literature Studies and a Replication in Software Engineering

The reference procedure for citation-based search in systematic
literature studies (8 pages, EASE 2014). Where
[[kitchenham2007-slr]]
takes database search strings as the first step and lists reference
lists among "complementary searches" that most studies skip, Wohlin
inverts the strategy: start from a small included set and traverse
citation edges. The core argument is terminological — search strings
fail because SE vocabulary is not standardized (his running example:
a relevant paper saying "cross-continent development" that no "global
software engineering" query catches), but authors in an area cite
each other *across* terminology drift, so the citation graph finds
what the keyword index cannot.

## The procedure

Start set: identified via Google Scholar (explicitly to avoid
publisher bias), sized to the area's breadth, diverse in venues,
years, and author clusters — the known threat is an unreached
independent cluster of papers that don't cite the included ones.
Iterations then alternate:

- **Backward**: work the reference list *before* fetching anything —
  exclude on year/language/type, then title, then examine the place
  and context of the citation in the referring paper; only then
  retrieve the candidate and read (abstract first, browsing not
  linear reading) to a definitive decision.
- **Forward**: work the citing papers via Google Scholar, same
  escalation ladder.

Two discipline rules carry the procedure: a paper's
inclusion/exclusion is finalized *before* it is snowballed from
(else later exclusion forces a rollback of everything found through
it), and iterations are kept distinct for traceability. The loop ends
when an iteration finds nothing new; author contact is the
recommended closer. Instrumentation: track per-iteration inclusion
frequency (should decay — if not, a missed cluster is likely; search
again with synonyms), and build a **citation matrix** plus timeline —
many blank cells suggest missed papers.

## The replication

The procedure is evaluated by replicating MacDonell et al.'s
reliability study (cross- vs within-company effort estimation,
1995–2005): snowballing from a 3-paper start set found the same
papers as the two original database-driven reviews, with comparable
detailed-review effort (38 papers examined in depth vs 24 and 38).
Raw efficiency is 3.7% (11 included / 294 examined), rising to 6.8%
when trivial year/title exclusions are discounted — backward
snowballing was very effective, forward was noise-heavy (1 included
from 133 citations). The closing deduction is the paper's most-quoted
claim: for *extending* an existing systematic study, snowballing
dominates database search, because new relevant work almost
certainly cites either the prior study or its included papers.

## Assessment

- **Durable:** the citation-graph-beats-terminology argument; the
  examine-in-context-before-fetching economy; include-before-
  snowball; decay tracking and the citation matrix as completeness
  diagnostics; the extension deduction.
- **Era-bound:** Google Scholar as the mechanism — today's
  instantiation is citation-index APIs (Semantic Scholar, OpenAlex,
  Crossref), which is exactly what the dataflow survey's forward
  chases used; Scholar itself now resists systematic use.
- **Caveats:** the evidence is one replication by one researcher who
  had read the original study (memory contamination acknowledged —
  he remembered the expected paper-count range); the case was
  ideally suited (a tight citation cluster where any one paper
  reaches all others); the extension claim is argued by deduction,
  its empirical support explicitly left to future work.
- **In this library:** the procedural spec for the survey layer's
  snowballing stages — the dataflow repo's separate backward and
  forward chases per critical work implement this paper, and its
  registered recurring citation refreshes operationalize the
  extension deduction on a schedule. The citation matrix is a
  concrete tooling candidate the layer has not yet built.
