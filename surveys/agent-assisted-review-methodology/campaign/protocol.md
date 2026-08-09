# Protocol — agent-assisted systematic review methodology (v0)

Status: DRAFT awaiting review — no search executed until approved.
Genre: systematic map. First campaign of the sys0 survey layer;
doubles as the survey skill's development testbed (sequencing decision
in scratch/2026/2026-08-08/survey-layer-design.md).

Serves (the entry gate): the survey layer's own protocol decisions —
agent-adapted inter-rater measurement, automation-vs-authorship
disclosure, reviewer independence when passes share model families.

## Research questions

- **RQ1 (landscape):** What methods, systems, and workflows exist for
  LLM/agent assistance at each stage of secondary studies — search,
  screening, extraction, appraisal, synthesis, reporting?
- **RQ2 (reliability):** How is agent performance measured (agreement
  with humans, benchmark recall/precision, inter-agent agreement),
  and what do the measurements show?
- **RQ3 (norms):** What guidance, reporting, or disclosure standards
  exist for AI assistance in evidence synthesis?
- **RQ4 (design gap):** Which designs address independence and
  ensembling across model families, and what remains open?

## Search strategy

- Sources: OpenAlex, Crossref, Semantic Scholar, arXiv API. Exact
  queries, dates, and counts logged per run in `logs/searches.tsv`;
  unfiltered results retained (kitchenham2007).
- Window: 2020-01-01 to search date. Pre-LLM ML-screening lineage
  (text mining for study identification, Cochrane classifiers) enters
  as background via its existing reviews, not re-screened.
- Query families (tuned at run time, logged verbatim): ("systematic
  review" | "literature review" | "evidence synthesis" | "systematic
  map" | screening | "data extraction") × ("large language model" |
  LLM | GPT | agent | automation), title/abstract; targeted probes
  for reporting guidance (AI extensions of PRISMA-family, RAISE-type
  guidelines, Cochrane positions).
- Snowballing: one backward+forward round from the included set via
  citation indexes (wohlin2014; iteration yield logged, stop on
  decay).

## Selection

- Include: works (peer-reviewed or preprint) whose subject is
  methods, systems, evaluations, benchmarks, or guidance for
  automating/assisting *secondary-study* stages with LLMs or agents.
- Exclusion codes: E1 primary-research automation only; E2 generic
  NLP/RAG without evidence-synthesis framing; E3 opinion without
  guidance content; E4 pre-window (→ background); E5 inaccessible
  (recorded, never silently dropped); E6 duplicate or superseded
  version.
- Process: two independent agent screening passes per candidate
  (different tiers/prompts), disagreements adjudicated by a
  highest-tier pass; dispositions with one-line rationale in
  `catalog.tsv`; disagreement rate and a kappa attempt reported in
  `baseline.md`.

## Classification scheme (map facets)

Built by keywording, allowed to evolve during extraction with changes
logged (petersen2008): **stage** (search / screen / extract / appraise
/ synthesize / report / end-to-end); **contribution** (method /
system-tool / evaluation-benchmark / guideline-norms / position);
**evidence** (human-agreement measured / benchmark-only / none);
**setting** (medicine-EBM / software engineering / general).

## Graded ingestion

G0: catalog row. G1 (target 15–25): works bearing on RQ2–RQ4 or
anchoring an RQ1 cluster — sys-convention citekey minted, PDF → store
and transcript → shadow at read time, evidence note in `sources/`
with section/table anchors. G2 promotion stays demand-driven per the
layer design; none required for campaign completion.

## Roles and disclosure

Screening fans out across subagents, model tier matched to stage
(cheap passes for mechanical screening, mid-tier for borderline
extraction, strongest for adjudication and synthesis). `baseline.md`
discloses pass counts, independence, models, and tooling in the
spirit of PRISMA 2020 items 8–9 (page2021).

## Artifacts

`protocol.md` (this file, versioned), `logs/searches.tsv`,
`catalog.tsv`, `sources/`, `syntheses/` (problem-scoped delta only —
topic material writes back to wiki), `claims.md`,
`decisions/` (deviations from this protocol, logged as they occur),
`baseline.md` (frozen close: counts, disagreement stats, disclosure).

## Method v0 pin and stopping

Method v0 = the survey-layer design note plus this protocol, as of
the commit introducing this file; method redesign waits for the
post-campaign /evolve (skill v1). Stopping (compact scale): screened
pool 100–300; one snowball round or earlier decay-to-zero; G1 cap 25;
synthesis and baseline freeze close the campaign.
