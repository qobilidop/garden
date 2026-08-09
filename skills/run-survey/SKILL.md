---
name: run-survey
description: Run a survey campaign in surveys/<slug>/ — protocol, logged searches, fleet screening, snowball, classification, graded deep-reads, syntheses, and a frozen disclosure baseline. Use when asked to run, resume, or close a survey, systematic map, or review campaign. For ingesting a single work outside a campaign, use ingest-paper or ingest-post instead.
---

# Run a survey campaign

Campaigns are human-triggered, never agent-initiated. Each campaign
pins the commit SHA of this skill in its protocol and runs under it;
mid-campaign deviations go to `decisions/`, and method redesign happens
only in the post-campaign /evolve (skill vN+1) — a later skill version
never invalidates an earlier frozen baseline. Method v1 distilled from
the agent-assisted-review-methodology campaign (2026-08-08) and the
literature it mapped.

## 1. Protocol and scaffold

- Scaffold `surveys/<slug>/` up front with its three surfaces:
  `index.md` (landing page, written at §8), `campaign/` (the record:
  `protocol.md`, `prompts/`, `decisions/`, `sources/`, `syntheses/`,
  `logs/`, `scripts/`, catalogs, `status.md`, `baseline.md`), and
  `manuscript/` (the paper, §8). `campaign/.gitignore` covers
  `logs/raw/`, `work/`, `candidates.tsv`, `catalog.tsv`,
  `snowball-candidates.tsv`. Commit contract: curated dispositions
  (included + adjudicated), notes, syntheses, claims, decisions,
  baseline, search logs; intermediates stay local and mirror to shadow
  at freeze, after which the local copies are deleted. (Both gitignore
  and catalog split were mid-campaign retrofits in v0 — decisions
  0001, 0006.)
- The included-works record is one table, `included.tsv` (key, via,
  year, title), which classification later extends with facet columns
  — v0 split identity (`catalog-included.tsv`) from facets (`map.tsv`)
  into two tables with identical key sets, an accident of stage
  ordering.
- The protocol states: RQs; genre and window; disposition codes;
  scale as a fan-out budget (batches × tier), applied to the
  *post-snowball* pool; the independence axis of every dual-pass stage
  (vendor / tier / prompt-frame); abstract-truncation lengths for each
  screening input; the skill commit SHA. Project catalog size (rows ×
  ~230B) against the repo file-size guard now, not at freeze.
- Disposition codes: `I`, `E1`–`E6` per protocol, `E7` non-study
  document (letters, peer-review records, editorials — pre-filter on
  Crossref `type` where available), `U` insufficient metadata to
  decide. `U` is a to-do, not a disposition: fetch the abstract from a
  second source or escalate a tier before freeze; surviving `U` rows
  are counted and disclosed. Any code invented mid-campaign gets a
  decision record at first use (v0 invented `U` silently, 12 rows).
- Stated departure: the agent-primary / human-gate stance inverts the
  mapped guidance (gartlehner2025 principle 1: never fully automate).
  Declare it in the protocol with its compensating controls — dual
  pass, adjudication, overturn-rate reporting, human freeze gate.
- Fleet prompts are committed files in `prompts/` (screen pass A/B,
  verify, classify, G1 pipeline), dispatched by path so the baseline
  cites file + SHA. Transcript-only prompts made v0 unreproducible,
  while its own mapped literature found wording alone swings screening
  sensitivity drastically (gargari2023).

## 2. Search

- Scripted queries against OpenAlex / Crossref / Semantic Scholar /
  arXiv; every query logged to `logs/searches.tsv`, raw responses to
  `logs/raw/`.
- One shared `keyof()` normalization for every script that mints keys,
  with the ladder applied in order: arXiv-DOI (`10.48550/arxiv.X`) →
  `arxiv:X`; strip version suffixes (`vN`, F1000 `.N`); preprint-server
  DOIs to base form; lowercase. v0 wrote the fix in `snowball.py` and
  never backported it to `search.py` — fake `doi:` keys minted from
  arXiv ids let the same work into the include set twice.
- Completeness gate: no query may remain FAILED when the pool freezes.
  Retry with longer backoff or an API key, switch source, or write a
  decision record dropping it (v0 silently lost 1 of 11 queries to a
  persistent 429).
- Post-search checkpoint: report the pool size against the protocol's
  budget; widen the budget explicitly or tighten queries before any
  screening runs (v0 overshot 4.3× and reinterpreted the ceiling).

## 3. Screen and adjudicate

- Dual independent passes over every candidate, differing on a declared
  independence axis: cheap tier criteria-framed vs mid tier RQ-framed
  worked; run pass B cross-vendor (the Codex mirror) when available —
  same-vendor κ overstates independence, v0's own headline finding.
- Report binary agreement, Cohen's κ, and category-exact agreement,
  annotated with the axis actually varied. Adjudicate disagreements,
  uncertains, and single-pass rows with the strongest tier; rationales
  persist in the adjudicated catalog.
- Duplicate audit before classification: cluster normalized titles
  across the whole catalog and resolve clusters to E6. Screeners see
  one row at a time and structurally cannot catch duplicates; v0
  shipped ~22 duplicate-title groups in its final include set
  (decision 0008).

## 4. Snowball

- One backward+forward round from the includes via citation indexes;
  log per-iteration yield.
- Any pre-filter (title vocabulary) reintroduces the terminology
  dependence snowballing exists to escape (wohlin2014) — if used, it
  gets a decision record and a recall probe.
- Non-decay clause: the stop rule "one round or decay-to-zero" needs a
  branch for yield that does not decay. Either budget a second round or
  declare bounded coverage AND dual-screen a random sample of every
  excluded set (bulk-excluded and single-pass excludes), reporting a
  measured false-exclusion rate instead of an unquantified risk. In v0,
  79% of the map came through the weakened path with a 13% measured
  single-pass error rate.
- A single-pass wave (cost-justified by asymmetric error costs) must be
  followed by an adversarial verification pass on all includes and
  uncertains; every row carries its provenance (`via`) so syntheses can
  condition on rigor.

## 5. Classify

- Calibration round before fan-out: all classifier agents label the
  same ~20-row seed; inspect disagreement, tighten facet definitions or
  cut the facet, then run the fleet.
- Reliability instrumentation scales with judgment-load, not stage
  order: mechanical facets (stage, setting) may run single-pass;
  judgment-graded facets are dual-passed on a ~10% sample with
  agreement reported, or cut. v0 measured κ only on binary screening —
  its judgment field (`rq_core`) varied 5.7× across single-pass batches
  and was unusable except as a pool signal.
- Scheme changes during classification are allowed (petersen2008) and
  each gets a decision record — v0's protocol required this and no
  record was ever written.

## 6. G1 deep-reads

- Select to the protocol's cap by facet-guided choice, recorded with
  per-work reasons plus a ranked reserve list. Admission gate: a work
  with no obtainable full text and no abstract returns to the pool and
  the slot refills from the reserve (v0 spent a slot on a secondhand
  note). Abstract-only reads are admitted but marked.
- Fan out one pipeline per work (capture → transcribe → evidence note
  with section/table anchors), tiers per ../ingest-paper/SKILL.md.
  Capture ladder: OA resolvers (Unpaywall/OpenAlex) → publisher →
  EuropePMC `europepmc.org/articles/PMC<id>?pdf=render` (passes plain
  curl) → Wayback `id_` record → abstract-only, declared.
- Pipeline prompts state permission gates explicitly — subagents
  inherit no operating rules. In v0 three pipelines autonomously used
  the user's browser to pass bot-challenges, a permission-gated
  capability (decision 0007). The prompt template forbids
  browser-mediated fallbacks without asking.

## 7. Synthesize and freeze

- Syntheses are problem-scoped delta only; topic material writes back
  to `wiki/` (skills/tend-wiki). `claims.md` numbers each claim, cites
  evidence rows, and marks abstract-resting claims `(A)`.
- `baseline.md` follows v0's disclosure shape (PRISMA 2020 items 8–9
  spirit): flow counts, per-stage models and pass counts, independence
  axes, prompts by file+SHA, deviations, limitations.
- Freeze checklist, in order: drain every deferred correction (any
  decision record saying "belongs to the freeze" — v0 deferred one and
  never applied it); resolve or count `U` rows; verify catalog ↔ notes
  ↔ syntheses ↔ claims consistency (a facet row contradicting its
  deep-read note is a freeze blocker, not a disclosure); mirror
  gitignored intermediates to shadow; rewrite `status.md` to CLOSED
  with final numbers only.

## 8. Manuscript and landing page

- The reader-facing output, distinct from `baseline.md` (the frozen
  methods record — PRISMA separates these too). Human-gated: written
  when the findings deserve a reader, not by default at freeze. Two
  artifacts with different jobs — the arXiv model:
- **Manuscript** (`manuscript/`, the paper, standalone by design — no
  wikilinks): Typst, split as `meta.typ` (title/byline/abstract,
  shared so renders can't drift) + `content.typ` (body) +
  `manuscript.typ` (paged wrapper, `surveys/style.typ`) +
  `manuscript-html.typ` (HTML wrapper, `html.elem` title block).
  The byline names the accountable human author per the
  no-AI-authorship norm, with the agent contribution disclosed in a
  title-page footnote (`author-note` in `meta.typ`).
  Shape: introduction (motivation and hook),
  background (lineage), method (condensed from `baseline.md`), one
  section per RQ grown from `syntheses/` — inverting the register from
  internal delta notes to self-contained prose — then discussion and
  conclusion. Citekeys appear as mono handles; the bibliography is
  `manuscript/references.bib`, generated by `manuscript/make-bib.py`
  from `manuscript/refs.tsv` (DOI content negotiation + arXiv bibtex;
  unresolvable entries go in `references-manual.bib`). Never restate
  numbers the catalogs don't back. Compiled to HTML+PDF by
  `site/scripts/build-manuscripts.py` (typst pinned in the dev image;
  HTML target experimental).
- **Landing page** (`index.md`, the site collection entry and the
  `[[slug]]` backlink target): links, not prose — short description,
  HTML+PDF links (relative: `manuscript.html`, `manuscript.pdf`),
  campaign-record link, wiki topic link, and a references list in
  citekey style, wikilinked only where a library page exists (G2
  promotion stays demand-driven; the list gains links as works are
  promoted).

## Decision records

`decisions/NNNN-<slug>.md`, written at the moment of deviation: title,
`Status:` line (who decided, when), the deviation and rationale, and a
mandatory closing field —

    Skill implication: none | vN+1 fix: <rule> | open question

Six of v0's seven records carried no forward-pointer, turning the
post-campaign /evolve into archaeology; this field makes each campaign
self-mining.

## Close

- Verify committed artifacts match the commit contract; propose commits
  with the attribution trailer; commit only on the user's word.
- The campaign ends closed: living maintenance is not registered unless
  the protocol says otherwise; revival criteria go in `baseline.md`.
- Post-campaign /evolve harvests `Skill implication:` fields into skill
  vN+1.
