# Baseline v1 — frozen 2026-08-08

Systematic map, conducted 2026-08-08 under method v0 (protocol.md +
survey-layer-design.md at commit d4a27ce). Human trigger and protocol
approval: Bili Dong. Execution: Claude Fable 5 (orchestrator and
adjudicator) with subagent fleets as disclosed below — reported in the
spirit of PRISMA 2020 items 8–9 and the convergent disclosure content
this survey itself mapped (RQ3).

## Flow

- Searches: 11 logged queries, 4 sources (OpenAlex, Crossref, Semantic
  Scholar, arXiv), window 2020-01-01→2026-08-08; one persistent
  rate-limit failure logged (s23). Raw responses retained (shadow at
  freeze; gitignored during campaign per decision 0001).
- 419 raw → 412 after arXiv-DOI dedup (7 merged).
- Wave 1 screening: dual independent passes on all 412 — pass A haiku
  (criteria-framed prompts), pass B sonnet (RQ-framed prompts), 12
  batches each. 417 pairwise decisions (417 of 419 pre-merge keys dual-
  screened; 2 single-pass). Binary include agreement 0.971, Cohen's
  κ=0.937; 6-category exact agreement 0.835. 33 rows adjudicated by
  Fable (12 binary disagreements, 19 uncertain, 2 single-pass);
  rationales in catalog-adjudicated.tsv. Dispositions: I=139, E1=54,
  E2=213, E3=4, E6=2.
- Snowball: one backward+forward round from the 139 includes via
  OpenAlex (logs/snowball.tsv); 1,204 new candidates after the
  review-vocabulary title pre-filter (decision 0004). 323 without
  AI-side vocabulary excluded en bloc; 881 screened single-pass (haiku,
  15 batches; decision 0005), then all includes/uncertains (624)
  verified by an adversarial sonnet pass (11 batches): 533 confirmed,
  ~79 overturned (~13%), 12 unresolved (U). Iteration yield did NOT
  decay — coverage is bounded by the one-round cap, a real limitation.
- Final catalog: 1,291 works — I=672, E1=83, E2=484, E3=24, E6=16,
  U=12. Committed record: catalog-included.tsv + catalog-adjudicated.tsv
  (decision 0006); full catalog in shadow.
- Classification: 12 sonnet batches faceted all 672 includes (map.tsv).
  Known weakness: judgment-graded fields (rq_core) varied 7–40 per
  56-row batch across agents — treated as a candidate-pool signal only.
  One facet row (oconnor2024) known inconsistent with its deep-read
  note; the note is authoritative.
- G1: 25 works selected by facet-guided manual choice (g1-selection.tsv),
  deep-read by 25 sonnet pipelines: 20 with PDF captured (store) +
  transcript (shadow); 5 abstract-only (safarpour2026, arno2022,
  felizardo2024, brincoveanu2025 confirmed closed-access;
  barsby2024 is a no-abstract letter — its note is secondhand and
  excluded from quantitative claims).

## Models and tooling

Orchestration/adjudication/synthesis: Claude Fable 5 (claude-fable-5).
Screening pass A + snowball wave: Claude Haiku-class. Screening pass B,
verification, classification, G1 pipelines: Claude Sonnet-class. All
same-vendor (Anthropic) — the independence caveat is analyzed in
syntheses/rq4-independence.md. Prompts for every fleet are recorded in
the session transcript; scripts in scripts/. APIs: OpenAlex, Crossref,
Semantic Scholar, arXiv, Unpaywall.

## Deviations

decisions/0001–0007. Notable: 0004/0005 (snowball pre-filter and
single-pass wave — recall risks); 0007 (three G1 pipelines used the
user's browser to pass OA bot-challenges; flagged).

## Limitations

Same-vendor dual screening (κ=0.937 may overstate independence);
snowball capped at one non-decayed round; title-vocabulary pre-filter
reintroduces the terminology dependence snowballing exists to escape;
wave-2 excludes carry single-pass recall risk; abstract-truncation
(600–900 chars) during screening/classification; classification facets
are abstract-level and single-pass; G1 evidence notes are agent-written
from transcripts without a second extraction pass (kappa for extraction
unmeasured — the exact gap claim 11 names in the literature); English
sources only; 12 U-rows unresolved. Living maintenance: NOT registered
(closed baseline; revival criteria = skill v1 extraction or a v2
cross-vendor campaign).

Erratum (2026-08-08, post-freeze): a duplicate audit found ~22
duplicate-title groups (~26 excess rows, ~3.9%) among the 672 includes
— preprint↔published and versioned pairs the key normalization missed.
Counts above are as-frozen, not recomputed; see decisions/0008.
