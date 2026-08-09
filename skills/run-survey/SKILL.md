---
name: run-survey
description: Run a survey campaign in surveys/<slug>/ — search and catalog a field, build its terminology and taxonomy, curate a reading list, and write a Typst manuscript, leaving a minimal resumable record. Use when asked to run, resume, update, or close a survey, systematic map, or review campaign. For ingesting a single work outside a campaign, use ingest-paper or ingest-post instead.
---

# Run a survey campaign

Goals first: a survey exists for learning, published as a garden
artifact — not research. It contributes terminology, a taxonomy, and
synthesis of others' work; it makes no new empirical claims and never
uses its own execution as a data point (claiming a data point is a
research commitment that must then be defended). The bar is
*traceability*, not reproducibility: every claim cites its source,
every map number traces to the catalog, and caveats travel with a
number everywhere it appears — a survey about a field's evidence
cannot launder its own. Campaigns are human-triggered. Use this
workflow as guidance rather than pinning a skill or repository commit,
and log material method changes in plain language in the record's
`status.md` Method changes section. Use the post-campaign /evolve when execution exposes a
durable harness lesson. This method was reshaped from the
agent-assisted-evidence-synthesis campaign and its review rounds,
then united with the dataflow-selection-enumeration living-survey
method; those two records are the reference implementations.

## 1. Shape

Three surfaces in `surveys/<slug>/`:

- `index.md` — the landing page and `[[slug]]` backlink target. Fixed
  skeleton: H1 `<title>: <subtitle>`, one abstract-like paragraph
  carrying the funnel counts and closure status, then `**Read:**`
  (HTML · PDF), `**Survey record:**` (GitHub tree URL) `— searched
  through <date>` (the coverage-date stamp §7 closure checks), and
  `**Topic context:** [[<wiki-topic>]]` — the survey↔wiki join —
  followed by the curated reading list as the body.
- `record/` — the minimal resumable state (§7).
- `manuscript/` — the Typst paper (§5).

Every survey is an *updatable systematic map* (the established
genre noun; see `references/terminology.md` for how house terms map
to the field's): it closes on bounded mapping closure (§7) and
promises no maintenance cadence — but the
update infrastructure stays standing, so that when an update is
wanted, staging it is one command and the record README's procedure
carries it to reconciliation.

The record's spine is one ledger and one log, the same grammar at
every scale. `catalog.tsv` holds the current state: one row per
surfaced work, ever — `key`, `status`, `code` (exclusion code when
excluded), then survey-declared columns (facets, cluster, priority,
display title). The status vocabulary is declared in the README from
one scrutiny scale — `candidate` (surfaced, unjudged) → `screened`
(judged from metadata) → `included`/`deep-read` — with terminal
`excluded` (coded) and `parked` (undecidable now, re-screened on
update). A minimal survey declares `{included, excluded, parked}`;
a discovery-heavy one adds the earlier states rather than switching
systems. `log.tsv` holds history (§2). Dedup goes through the
normalized identifier grammar of §2 whatever the key column shows.
Every record file gets a stated purpose and update rule in the
README; layers beyond the minimal shape are declared there in a
Shape note, as intent rather than drift.

## 2. Search, catalog, screen

- Protocol before search — the canon's core bias control: write and
  human-gate the protocol (scope, research questions, selection
  criteria, facet plan, source list) before the first logged search,
  as `record/protocol.md` (a thin survey may fold it into the record
  README's contract). The protocol always reads as the current
  rules: a material method change updates it in place and is logged,
  dated and append-only, in `status.md`'s Method changes section as
  it happens — never applied silently. The log is campaign-scoped:
  it dissolves at campaign close (§7), its content by then absorbed
  into the protocol's final state, the log's audit rows, and the
  manuscript's disclosures.
- One append-only event log (`record/log.tsv`; the engine enforces
  its schema) with four kinds: `search` (an executed
  query), `snowball` (a citation chase, direction backward/forward),
  `audit` (corrections and campaign events — alias resolutions,
  retractions, migrations), and `exploratory` (early non-replayable
  discovery, retained as history but counting toward nothing).
  Queries run against OpenAlex / Crossref / Semantic Scholar /
  arXiv via the shared clients in this skill's `scripts/` —
  `search_<source>.py` for query-driven discovery (snowballing is a
  search method, so citation chases are their `snowball`
  subcommands), `fetch_*` for identifier-driven retrieval; caps and
  retry conventions are documented
  in the protocol — the logged search rows are the query set,
  rerun verbatim on update. Search and snowball rows record their
  decided keys per row, not only counts.
- One key grammar, documented in the protocol: `doi:`/`arxiv:`
  normalized (arXiv-DOIs collapse, versions stripped, lowercase),
  `t:<title-slug>` fallback, `legacy:` reserved for rows whose
  identifier and title are both unrecoverable; a published version
  of an included preprint replaces its key, the superseded key
  staying as an excluded catalog row under the survey's
  superseded-version code. Citekeys are minted only for works that
  acquire a note or citation; `references.tsv` and note frontmatter
  identifiers bridge them to catalog keys.
- Before deriving counts, run a catalog-integrity pass: one work has
  one canonical catalog row; adjudicate suspected aliases from full
  registrar metadata and authorship, never title similarity alone;
  retain superseded identifiers under the superseded-version code and
  formally retracted works under the retraction code.
- Log invariants: append-only — a disposition change is a new
  `audit` row plus a catalog update, never a rewrite; every published
  number derives from the audited kinds. The audit row names the keys
  it moves so the engine can reconcile a wave's historical decision
  with current state: `promoted-key:`/`superseded-key:` for a version
  replacement, `reclassified-key:` when later evidence (a deep read,
  a re-screen) overturns what an earlier wave decided. A search or
  snowball row keeps the decision it recorded at the time; only the
  audit row carries the correction. Two further `notes` markers are
  engine- or convention-level and belong in the same grammar: a
  snowball row names its seed as `seed-key:<catalog-key>` (the engine
  requires it on any backward row marked defective, and uses it to
  bind chases to their critical work), and any row may list
  undecided rows as `parked-keys:<key>,<key>`. Semicolons separate
  markers; commas separate keys within one. Result sets are staged in scratch during
  screening and discarded after reconciliation — the log row (date,
  verbatim query, counts, decided keys, notes) is the audit unit;
  the bar is traceability, and result sets are re-derivable by
  rerunning the logged query. (This consciously deviates from
  Kitchenham's save-unfiltered-results-for-reanalysis practice —
  disclose it in the method section.)
- Index defects are recorded, not repaired: note unresolved
  identifiers and wrong registrar metadata in the log row, and let
  primary/publisher records control bibliographic and technical
  claims — indexes are discovery aids only.
- Evidence-support hierarchy: abstract- or metadata-level records
  support scope and chronology statements only; theorem, algorithm,
  and guarantee claims require a deep-read note with pinpoint
  anchors.
- Declare a bounded `critical` set — the closest-work candidates.
  Every critical work is deep-read and gets separate backward and
  forward citation chases immediately; forward neighborhoods are
  refreshed as part of any substantial update batch.
- Snowball one backward+forward round via citation indexes; record
  the pre-filter vocabulary verbatim; a verification pass re-judges
  everything the wave screens in. When an index returns a truncated,
  unresolved, or implausibly empty bibliography, chase from the
  primary version's printed reference list and mark the log row
  `primary-complete`.
- New vocabulary discovered while reading lands in the query set in
  its own commit — never silently edit an executed search.
- Screening: two agent passes on different model tiers and prompt
  framings, disagreements adjudicated by the strongest available
  model, a human gating the result; single-pass waves only with a
  verification pass. Expect the exclusion-first/smaller-tier pass to
  over-code exclusions (one batch measured ~4× vs the mid tier);
  label-only disagreements lean drop-unless-both-coded, and the
  catalog-memory bar belongs to the adjudicator, not the passes.
  Passes emit
  `{"decision", "reason", "confidence"}`; the adjudicated one-line
  reason is kept in the catalog row when the survey declares a
  rationale column, not discarded. Exclusion codes are
  survey-declared in the protocol and validator-enforced, slugged to
  be self-documenting (dse's `E6-out-of-scope-model` form is the
  reference); every vocabulary includes
  superseded-version and formal-retraction codes; undecidable
  candidates take the `parked` status instead of a code, re-screened
  each update; the load-bearing code gets boundary examples. No
  query left `FAILED` at close without a recorded reason. Update log
  rows reuse the `queries.tsv` `query_id` as their log `id`; empty
  decided-key cells are empty strings (`-` accepted as legacy).
- A campaign whose subject or stakes demand formal validity
  apparatus may escalate campaign-wide — not by default: cross-vendor
  passes with a declared independence axis (the Codex mirror when
  available), Cohen's κ, committed fleet prompts, and a frozen
  disclosure baseline (PRISMA 2020 items 8–9 in spirit) — the v1
  agent-assisted-evidence-synthesis campaign's git history is the
  reference.

## 3. Terminology, taxonomy, classification

- The survey's centerpiece: fix the field's vocabulary explicitly,
  then build a facet scheme by keywording and classify every include
  under it. Prefer few, mechanical facets; cut judgment-heavy fields
  rather than classify them noisily (v1's judgment field varied 5.7×
  across passes and was unusable). A formal-subject survey builds a
  unified theoretical framework on top of the taxonomy — load
  `references/theory-mode.md`.
- Deep-read the anchor candidates into `record/sources/` notes,
  each named `<citekey>.md`. The note contract is this skill's
  `assets/source-note-template.md`; surveys declare extra fields in
  their README Shape note rather than forking the template. Note
  facets from full text are authoritative for
  that work but never silently overwrite the abstract-level map —
  disagreements stand, disclosed in the manuscript's limitations.
- On a material evidence or synthesis revision, preserve every existing
  `notes-by` writer and append the reviser (human name or agent + model),
  where the note template carries authorship.
  Mechanical edits do not add authorship — but a migration that
  distills, splits, or authors any prose (a synthesis one-liner, an
  evidence-limits line) is material, not mechanical.
- The syntheses layer (`record/syntheses/`) is the survey's
  understanding, between evidence and presentation: thematic living
  documents comparing definitions and results across works — never
  concatenated paper summaries — with `current-position.md` as the
  compact entry point. Three layers, one direction: `sources/` holds
  evidence, `syntheses/` holds cross-source understanding, the
  manuscript presents it. Understanding changes land in syntheses
  first, never manuscript-first; each reading batch names the
  syntheses it affects; a manuscript claim with no synthesis home is
  a review finding. A synthesis update states the current conclusion,
  the strongest supporting and limiting results, scope conditions,
  and any consequence for `claims.md`/the manuscript — never
  chronological reading notes. Git keeps superseded interpretations.
  (This is the survey-local instance of the library → wiki pattern.)
- `record/claims.md` — the synthesis claims as a statused ledger:
  each claim carries a status on the survey's declared scale (the
  reference lifecycle: `hypothesis` → `supported` / `known-result` /
  `rejected`, declared in the preamble), explicit scope, and its
  closest established result; ids are `Cxx`, epistemically neutral
  so they survive status transitions.
- `record/evidence.md` — the binding layer: one record per evidence
  item (`Exxx`) stating one checkable finding from the literature
  (findings support claims; never two senses of "claim"), linked
  downward to citekeys and source-note anchors, upward to the `Cxx`
  claims it supports, across to the manuscript sections that cite on
  its strength, with scope and caveat riding the row. The validator
  enforces the bindings — every active claim has evidence rows,
  every technical manuscript citation is registered at its section
  label; an optional GRADE-inspired **Certainty** grade
  (`high`/`moderate`/`low`) rides the record, graded against the
  source notes' read depth and evidence limits. A survey whose
  manuscript asserts nothing beyond catalog-derived counts may omit
  it, like `check.py`. The genre rule: token-celled ledgers are TSV
  (catalog, log, queries); prose-celled ledgers are markdown records
  (claims, evidence), each opening with a preamble that declares its
  id scheme, field list, and delimiter grammar.
- Per-paper definition of done: a work is integrated only when its
  disposition is recorded, any required source note is anchored in
  the primary work, affected syntheses and claims are updated, and
  every resulting manuscript change is reflected in the evidence
  surfaces. Merely adding bibliography entries or notes is not
  integration.

## 4. Curate the reading list

- The landing page's body: taxonomy-sectioned tables
  (Paper | What | Venue · Year | Notes) — linked original titles,
  one-line annotations distilled from the evidence notes, internal
  links (library wikilink where ingested, record note otherwise).
- Curated, not exhaustive: works that anchor a section — strongest
  evidence, defining system, guidance of record. Deep-read does not
  imply listed; sections stay small; a new anchor joins or displaces.
  Annotations carry the same caveats as the manuscript's claims.

## 5. Manuscript

- Typst, split for drift-freedom: `meta.typ` (exports `title`,
  `subtitle`, `byline`, `author-note`, `draft` — the
  "Draft YYYY-MM-DD" stamp — `landing`, `record`, `abstract-body`)
  + `content.typ` (body; a long manuscript may split into
  `sections/*.typ` files it includes) + `manuscript.typ` (paged
  entrypoint, imports `surveys/style.typ`) + `manuscript-html.typ`
  (HTML wrapper, `html.elem` title block). The byline names the
  accountable human author; the `author-note` title-page footnote
  carries the four-part disclosure: human accountability, the named
  system/model and its scope of assistance, "AI output is not
  treated as evidence", and the public-record pointer.
- Shape: introduction with explicit contributions; background and
  related surveys; terminology and taxonomy; an honest, brief "how
  this survey was made" with the flow table (PRISMA's flow diagram
  in table form) or a reconciled prose funnel — either way the
  arithmetic must reconcile, stating merges and uncataloged
  exclusions; findings
  sections; synthesis and open problems with a findings table;
  a validity-threats passage stating what the AI-assisted passes are
  and are not (repeated checks, not independent human reviewers);
  limitations; conclusion. Numbers only from the record; superlatives
  scoped ("among the deep reads"); preprint and adjudication caveats
  attached wherever the number appears, including the abstract.
- Bibliography: `references.tsv` (citekey → identifier) →
  `scripts/make_references.py --manuscript <dir>` (registrar BibTeX
  via DOI content negotiation and arXiv; repairs live in the
  generator; output carries a generated-file marker) →
  `references.bib`; author-year citations; hand entries in
  `references-manual.bib` — including pins for entries whose
  registrar record is defective (missing year, surname-only author),
  caught by diffing regenerated output before accepting it. The bib
  holds exactly the cited works; evidence-only works are located by
  their notes' frontmatter, not bib entries.
- Build: `./dev.sh python3 site/scripts/build-manuscripts.py` (typst
  pinned in the dev image) → `site/public/surveys/<slug>/`.
- Typst gotchas (all earned) live in `references/typst.md` —
  consult on any build or render misbehavior.

## 6. Review panel

Before calling the piece done, spawn an adversarial subagent panel
over the whole survey directory and iterate to closure:

- *Consistency auditor* — recompute every number mechanically across
  manuscript, landing page, and record; hunt cross-artifact
  disagreement.
- *Cold referee* — claims versus the syntheses and evidence notes:
  overreach, unscoped superlatives, uncaveated preprint numbers,
  manuscript claims with no synthesis home, structure and prose a
  hostile methodologist would flag.
- *Resumability stress-test* — execute the record README as a
  stranger with only the survey directory; every ambiguity is a
  finding.
- *Link checker* — repo URLs mapped to local files, external
  identifiers resolved, bib ↔ citations ↔ notes closed.

Fix, then send reviewers the delta for per-finding verdicts (FIXED /
PARTIAL / NOT ADDRESSED); adjudicate reviewer disagreements on
primary evidence, never on authority; verify every fresh quantity a
fix introduces before persisting it.

## 7. Record and close

- Close on *bounded mapping closure*, not exhaustion of energy:
  every surfaced work has a disposition; every critical work is
  deep-read and chased in both directions; all searches due for the
  snapshot are adjudicated; two predeclared, independently checked
  no-add rounds find neither a new theme nor a plausible close
  competitor; and manuscript, record, and landing page agree on the
  coverage date. State closure as relative to the named sources,
  exact queries, result depths, and date — never as completeness.
- Update infrastructure, standing but unscheduled: the standing
  queries in `record/queries.tsv`, each row carrying its
  `last_reconciled` date. Updates are human-triggered and the
  registry carries no schedule — staging is one command
  (`scripts/update.py --record surveys/<slug>/record fetch --all`),
  triggered by a close competitor, a new theme, or simply wanting
  fresher coverage. Fetches stage into
  scratch and never advance state; the record README's numbered
  procedure carries a batch from staging through reconciliation —
  one audited-log row per executed query — to advancing state and a
  clean validator run, and no state advances before the human gate,
  whose approval lands in the README's update ledger (one row per
  reconciled batch over survey-declared count columns with a Human
  gate cell, column semantics stated beside the table). A plausible
  close competitor or new mechanism is always grounds to update now.
- Prune `record/` to the minimal resumable state: `README.md` (the
  operating contract — intro with the self-sufficiency statement,
  Start here commands, Shape note, Files map, update ledger,
  bibliography-and-build, numbered update procedure; the method
  rules themselves — scope, search/key/snowball/selection rules,
  facet tokens — live in `protocol.md` per §2, and build docs stay
  in AGENTS.md and this skill, pointed to rather than duplicated),
  `status.md` (H1 `# Current survey status`, a `**Coverage
  through:**` bullet, mechanical counts copied from the validator,
  the campaign-scoped `## Method changes` log — the append-only
  plain-language record of protocol amendments while a campaign is
  open, dissolved at close once absorbed into protocol, audit rows,
  and manuscript — and
  deferred work under `## Deferred to the next update` — the
  survey's todo lives here, not in a separate file),
  `catalog.tsv` and `log.tsv` per the §1 grammar, `sources/`,
  `syntheses/`, `claims.md` with `evidence.md` binding claims and
  manuscript sections to source anchors, and, when the manuscript
  publishes quantities derived from the catalog, a thin
  `record/check.py` that declares the survey's vocabularies (columns,
  statuses, codes, facets, strictness flags) and runs the shared
  engine `scripts/survey_check.py`; the source fetchers, snowball
  tool, registry-driven update tool, and bibliography generator ship
  with this skill (`scripts/`). The engine validates every record
  surface end to end and prints the derived counts for cross-surface
  reconciliation; a qualitative survey may omit the check entirely.
  A deep read that no longer supports any evidence item, manuscript
  citation, or synthesis may be demoted back to `screened` by an
  audit row, its note retiring to git history. Everything else —
  intermediate syntheses, work
  sheets — lives on in git history and the shadow mirror.
- Updates follow the record README's own procedure; this skill defers
  to it. Its last step syncs counts and dates in the README and the
  landing page.
- Verify builds, propose commits with the attribution trailer, commit
  on the user's word. A long campaign stages harness lessons in
  `scratch/` as they surface; post-campaign /evolve mines them.

## Theory mode (for formal subjects)

When the survey's subject is a formal problem and the synthesis is a
unified framework rather than only a facet taxonomy, load
`references/theory-mode.md` before designing the synthesis — the
framework moves, novelty discipline, and record layer live there;
dataflow-selection-enumeration is the reference implementation.
