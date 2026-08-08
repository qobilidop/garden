---
author: Claude Fable 5
---

# Survey layer design

Design discussion 2026-08-08 (not yet built). Motivation: the
dataflow-selection-enumeration survey
(github.com/qobilidop/dataflow-selection-enumeration) produced ~326
per-source notes and ~19 thematic syntheses locked in one problem's
repo, keyed by an incompatible citekey convention. Its sources are
library-shaped, its syntheses wiki-shaped; none of it compounds.
Decision: integrate the survey process into sys0 so future surveys
accumulate reusable library and wiki assets.

## The three layers, by scope

- **library** — work-scoped: one source, captured and synthesized.
- **wiki** — topic-scoped: living cross-work pages, no completion
  state.
- **survey** — problem-scoped: organized around a question, carrying
  what the other layers structurally can't (protocol, claims ledger,
  evidence matrix, deliverable); closes on a frozen baseline, then
  optionally maintains.

Depth follows from scope; "shallow vs deep" is not the cut.

Genre note: the wiki is the living narrative-review layer, surveys are
the systematic layer (systematic review / mapping study tradition —
protocol, audited search, evidence tables), the library the shared
evidence base under both. Each survey names its genre explicitly.
The methodology canon is ingested (2026-08-08: kitchenham2007,
petersen2008, wohlin2014, page2021) and distilled in
wiki/survey-methodology.md; the survey skill grounds in it.

## The wiki/survey boundary

Evidence basis, not subject or depth: **the wiki speaks only for its
shelf; a survey speaks for the literature** relative to a documented
search. Completeness and negative-existence claims ("no prior work
does X") are survey-only — they are meaningless without a search
record. A wiki page may grow arbitrarily deep without becoming a
survey; when a topic demands literature-completeness, that is the
trigger to run one. Pages never convert.

The boundary is machine-enforced by scoping citekey resolution: inside
`surveys/`, `[[citekey]]` falls back library → survey source notes
(G1 citable); in `wiki/` and `library/`, citekeys must resolve in the
library — citing a G1 work from the wiki is a lint error, which forces
the "wiki page needs it" promotion trigger instead of relying on
convention.

## Settled decisions

1. **Human-triggered only.** A survey starts when Bili decides, after
   discussion clarifying the problem — never agent-initiated. The gate:
   a survey must name the decision or claim it serves ("I need to know
   X before doing Y"); mere topical interest gets a wiki page.
2. **Method frozen per campaign (decided 2026-08-08).** Each survey
   pins the skill version it runs under (commit SHA in its protocol).
   Mid-campaign deviations are permitted but logged as decision
   records — method *redesign* waits for the post-survey /evolve,
   which yields skill v(N+1); a survey may then re-baseline under the
   new version as a fresh frozen release (versioned DOIs once
   deposition exists) — the PRISMA 2009→2020 pattern. Gate outside
   the loop, applied to methodology.
3. **Hub, not spokes.** Surveys live at `surveys/<slug>/`.
   Cross-survey connections surface mechanically through the shared
   substrate — two surveys citing the same `[[citekey]]`, backlinks
   making the overlap visible — which spoke repos with private
   bibliographies structurally cannot do. Repo-size worry dismissed:
   blobs already route to store/shadow; text is cheap; the scarce
   resource is maintenance, so freshness registries (recurring-search
   + refresh cadence, per the dataflow repo's decision 0004) are
   opt-in per survey, and a survey may close honorably instead.
   Refresh leans on citation chasing over re-querying: new relevant
   work almost certainly cites the survey's included papers or the
   survey itself (wohlin2014's extension deduction).
4. **Wiki owns topic material.** Whatever fits a wiki entry goes to
   the wiki, written back continuously during the survey (same
   discipline as ingestion writebacks). Survey syntheses keep only the
   problem-scoped delta, citing wiki pages — no duplicated living
   prose. Frozen depositions cite wiki state at a commit SHA.
5. **Verification protocol from the dataflow repo's own threat list:**
   independent extraction passes on critical works (the mirrored
   Claude/Codex configs allow genuinely different model families), a
   computed disagreement rate, and a human review gate before
   deposition — deposition is the release-scale analog of the
   human-gated commit. The classical instruments transfer directly
   (kitchenham2007): Cohen's kappa for dual passes, test–retest on a
   random sample for the single-reviewer case (an agent re-pass),
   sensitivity analysis for claims resting on disputed extractions.
6. **Tools promoted now, scaffolding later.** The screening scripts
   (arXiv/Crossref/OpenAlex/Semantic Scholar) and the consistency
   invariant (catalog, source notes, syntheses, claims, evidence rows,
   and manuscript must agree — hook-checkable) are the reusable
   machinery. Other campaign scaffolding stays per-survey until a
   second survey demands it.
7. **Not a site collection yet.** The content.config.ts allowlist
   stays wiki + library until rendering surveys is a deliberate,
   separate decision.

## Graded ingestion (screening → library coupling)

- **G0 screened**: catalog row with disposition. No citekey, not
  citable.
- **G1 deep-read**: survey evidence note + capture + citekey. The
  survey mints sys-convention citekeys at deep-read time (single
  namespace from day one; promotion needs no renames). Capture rides
  the deep-read: the PDF is in hand anyway, so blob → store and
  transcript → shadow fire then.
- **G2 library**: work-scoped synthesis notes, discussions sweep, wiki
  writeback — the expensive, reusable-value delta, and the only part
  that queues.

Inside `surveys/`, `[[citekey]]` resolution falls back library-first,
then survey source notes: the lint stays strict, G1 works are citable
immediately, and promotion silently upgrades the link target (the
fallback is scoped to `surveys/` — see the boundary section). Promotion is
demand-driven — a second survey touches the work ("promote on second
touch"), a wiki page needs it, or Bili asks. Never inline during a
survey: completion requires zero promotions, protecting survey
velocity from library rigor. The G1 population is the queue;
directories are evidence of work, intentions are queue lines.

Speed profile (measured on the 4-paper methodology batch, 2026-08-08,
~5.3 min/paper): source hunting and archive-record polling dominated
tool time; synthesis writing dominated model time. Consequences:

- OA resolvers first (Unpaywall/OpenAlex; now in ingest-paper §1) —
  one call replaces the publisher-mirror tour, and confirmed-closed
  is a real answer.
- Archiving is asynchronous (now in ingest-paper §4): SPN once,
  deviation comment as the queue, retry on next touch — never poll
  within a session.
- G1 work fans out: per-paper resolve → capture → transcribe →
  evidence-note pipelines are independent (disjoint paths, no
  worktree isolation needed) and parallelize across subagents,
  proactively — with model tier matched to the stage (mechanical
  fetch/verify cheap, per-work notes mid-tier, cross-work synthesis
  strongest); serial by nature are cross-work synthesis, wiki
  writeback, store push/manifest, and commits.
- Discussions sweeps are not on the survey path: ingest-paper never
  had one (only ingest-post does, where reception is part of a
  web-native work's record); survey-scale ingestion stays sweep-free.

## Deliverable toolchain

- **Bibliography generated from the library**: a `tools/` script emits
  Hayagriva YAML (Typst-native) and/or BibTeX from library + survey
  source-note frontmatter, keyed by citekey. The citekey is the
  citation key everywhere; no manual .bib.
- **Working layers in markdown** (catalog, source notes, syntheses,
  claims): full citizens of the wikilink/backlink substrate; the
  living, browser-friendly representation.
- **Manuscript in Typst**: PDF is the paper-feeling deposition
  artifact; HTML export (experimental as of Typst 0.15 — MathML
  equations, multi-file bundles, still feature-flagged) gives a
  standalone browser version. Pin the Typst version in the dev image.
  Backlinks flow through the markdown layers; parsing manuscript
  `@citations` into the site graph is a later upgrade, not a blocker.

## Citability and authorship

**Deferred (2026-08-08):** out of scope for the current phase — the
focus is producing high-quality surveys; DOI minting, deposition, and
CITATION.cff become relevant when a survey is worth citing. The
PRISMA-answerability gate above survives the deferral (it is quality
apparatus, not publishing apparatus). Design preserved below for when
this phase arrives.

- **The deposition gate answers PRISMA 2020** (page2021): full
  search strategies from the audited logs, near-miss exclusions with
  reasons from the disposition-coded catalog (item 16b), agent-pass
  counts/independence/automation details (items 8–9), data and code
  availability by construction (item 27). Genre caveat: for a pure
  mapping study the synthesis items relax (petersen2008), but the
  transparency items never do.
- **Zenodo deposition per survey** via the REST API (the GitHub
  integration is release-scoped whole-repo zips — wrong granularity in
  any architecture). A `tools/` packaging script archives
  `surveys/<slug>/` + built PDF, pre-reserves the DOI (so it can be
  baked into the manuscript before publishing), and deposits. Concept
  DOI cites the survey; version DOIs cite frozen baselines. Prior art:
  tech-report series; The Turing Way (never journal-published, Zenodo
  concept + version DOIs, routinely cited).
- **Author is the human; sys0 is the imprint.** Authorship requires
  accountability no agent or repo handle can carry (ICMJE/COPE/arXiv
  norms; collective authors like "Gemini Team" are banners over
  identifiable humans). The sys0 identity goes in the series slot:
  `@techreport`, `institution = {sys0}`, report number, DOI. Agent
  assistance disclosed in a standing statement (template from the
  dataflow repo's decision 0003), not authorship.
- **CITATION.cff**: GitHub's "Cite this repository" reads only the
  repo root, so per-survey `CITATION.cff` files are inputs to the
  deposition script (cffconvert reads any path), not a GitHub
  surface. The citable object is the Zenodo record.

## Open items

- Sequencing: bootstrap by migrating the dataflow survey's residue, or
  run the parked executable-formal-HW-spec survey
  (scratch/2026/2026-06-20/) fresh and extract the skill from it —
  per the bootstrap precedent, the skill is written after one real
  pass, not before.
- Queued survey candidate (2026-08-08): **agent-assisted systematic
  review methodology** — scoped to pass the gate (serves the layer's
  own protocol decisions: agent-adapted kappa, automation vs
  authorship disclosure, independence across shared model families);
  runs *after* an object-level campaign, under pinned skill v1, its
  own deviation log doubling as primary data for its v2. The broad
  "survey of survey methodology" was rejected: published tertiary
  studies (Kitchenham's own; arXiv:1909.10751) already carry that
  completeness work — ingest them as the wiki shelf deepens instead.
- Site rendering of surveys (collection, layout, search).
- Manuscript `@citation` parsing into the backlink graph.
- Deposition script details: DataCite metadata template, what the
  archive vendors (cited library notes vs commit-SHA reference).
- Adapting Cohen's kappa to agent passes: what counts as an
  independent rater when passes share a model family, and what
  agreement threshold gates promotion of an extraction.
- Petersen's 2015 update (closed access) stays a queue item; the
  citation-matrix and iteration-decay diagnostics (wohlin2014) are
  tooling candidates for the screening scripts.
