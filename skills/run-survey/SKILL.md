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
and describe material method changes in the record README in plain
language. Use the post-campaign /evolve when execution exposes a
durable harness lesson. This method was reshaped from the
agent-assisted-review-methodology campaign and its review rounds,
then united with the dataflow-selection-enumeration living-survey
method; those two records are the reference implementations.

## 1. Shape

Three surfaces in `surveys/<slug>/`:

- `index.md` — the landing page and `[[slug]]` backlink target:
  short description, links to both manuscript renders, the record
  link, and the curated reading list as its body.
- `record/` — the minimal resumable state (§7).
- `manuscript/` — the Typst paper (§5).

Every survey is an *updatable closed map*: it closes on bounded
mapping closure (§7) and promises no maintenance cadence — but the
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

- One append-only event log (`record/log.tsv`: date, kind, id,
  source, query_or_seed, direction, hits, screened, included_keys,
  excluded_keys, notes) with four kinds: `search` (an executed
  query), `snowball` (a citation chase, direction backward/forward),
  `audit` (corrections and campaign events — alias resolutions,
  retractions, migrations), and `exploratory` (early non-replayable
  discovery, retained as history but counting toward nothing).
  Queries run against OpenAlex / Crossref / Semantic Scholar /
  arXiv via the shared fetchers in this skill's `scripts/` (query,
  date bounds, and limits are arguments; the snowball procedure is
  `snowball_openalex.py`); caps and retry conventions are documented
  in the record README — the logged search rows are the query set,
  rerun verbatim on update. Search and snowball rows record their
  decided keys per row, not only counts.
- One key grammar, documented in the README: `doi:`/`arxiv:`
  normalized (arXiv-DOIs collapse, versions stripped, lowercase),
  `t:<title-slug>` fallback; a published version of an included
  preprint replaces its key, the superseded key staying as an
  excluded catalog row (E6).
- Before deriving counts, run a catalog-integrity pass: one work has
  one canonical catalog row; adjudicate suspected aliases from full
  registrar metadata and authorship, never title similarity alone;
  retain superseded identifiers as E6 and move formally retracted or
  withdrawn works to E7.
- Log invariants: append-only — a disposition change is a new
  `audit` row (`promoted-key:`/`superseded-key:` in notes) plus a
  catalog update, never a rewrite; every published number derives
  from the audited kinds. Result sets are staged in scratch during
  screening and discarded after reconciliation — the log row (date,
  verbatim query, counts, decided keys, notes) is the audit unit;
  the bar is traceability, and result sets are re-derivable by
  rerunning the logged query.
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
  verification pass. Passes emit
  `{"decision", "reason", "confidence"}`; the adjudicated one-line
  reason is kept in the catalog row when the survey declares a
  rationale column, not discarded. Exclusion codes E1–E7 (undecidable candidates
  take the `parked` status instead of a code, re-screened each
  update); E7 means formally retracted or withdrawn,
  and the load-bearing code gets boundary examples in the README. No
  query left `FAILED` at close without a recorded reason.

## 3. Terminology, taxonomy, classification

- The survey's centerpiece: fix the field's vocabulary explicitly,
  then build a facet scheme by keywording and classify every include
  under it. Prefer few, mechanical facets; cut judgment-heavy fields
  rather than classify them noisily (v1's judgment field varied 5.7×
  across passes and was unusable). A formal-subject survey builds a
  unified theoretical framework on top of the taxonomy — see Theory
  mode.
- Deep-read the anchor candidates into `record/sources/` notes:
  library-note frontmatter (citekey, registrar work metadata,
  `synthesis:` one-liner) over an extraction body (`## Evidence`
  anchored to sections/tables, `## Bearing on RQs`, `## Evidence
  limits`). Note facets from full text are authoritative for that
  work but never silently overwrite the abstract-level map —
  disagreements stand, disclosed in the manuscript's limitations.
- On a material evidence or synthesis revision, preserve every existing
  `notes-by` writer and append the reviser (human name or agent + model).
  Mechanical edits do not add authorship.
- The syntheses layer (`record/syntheses/`) is the survey's
  understanding, between evidence and presentation: thematic living
  documents comparing definitions and results across works — never
  concatenated paper summaries — with `current-position.md` as the
  compact entry point. Three layers, one direction: `sources/` holds
  evidence, `syntheses/` holds cross-source understanding, the
  manuscript presents it. Understanding changes land in syntheses
  first, never manuscript-first; each reading batch names the
  syntheses it affects; a manuscript claim with no synthesis home is
  a review finding. Git keeps superseded interpretations. (This is
  the survey-local instance of the library → wiki pattern.)
- `record/claims.md` — the synthesis claims as a statused ledger:
  each claim carries status, explicit scope, anchored evidence, and
  its closest established result; no item is novel merely because it
  is listed. The evidence surfaces and manuscript cite claims by
  their stable ids.
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

- Typst, split for drift-freedom: `meta.typ` (title, byline,
  abstract) + `content.typ` (body) + `manuscript.typ` (paged
  entrypoint, imports `surveys/style.typ`) + `manuscript-html.typ`
  (HTML wrapper, `html.elem` title block). The byline names the
  accountable human author; the agent contribution is a title-page
  footnote (`author-note` in `meta.typ`).
- Shape: introduction with explicit contributions; background and
  related surveys; terminology and taxonomy; an honest, brief "how
  this survey was made" with the funnel table (arithmetic must
  reconcile — state merges and uncataloged exclusions); findings
  sections; synthesis and open problems with a findings table;
  limitations; conclusion. Numbers only from the record; superlatives
  scoped ("among the deep reads"); preprint and adjudication caveats
  attached wherever the number appears, including the abstract.
- Bibliography: `references.tsv` (citekey → identifier) →
  `make-references.py` (registrar BibTeX via DOI content negotiation
  and arXiv; repairs live in the generator; output carries a
  generated-file marker) → `references.bib`; author-year citations;
  hand entries in `references-manual.bib`.
- Build: `./dev.sh python3 site/scripts/build-manuscripts.py` (typst
  pinned in the dev image) → `site/public/surveys/<slug>/`.
- Typst gotchas (all earned): `~` is a non-breaking space — escape
  literal tildes; a `;` directly after `#cite(...)` is parsed away —
  use `#[;]`; `fr` table columns collapse inside figures — use
  explicit widths for wrapping columns; `#cite(form: "prose")`
  under numeric CSL styles expands full author lists — hand-write
  "Author et al. @key" there, and grep for that residue when
  switching styles back; unbraced name particles (`van X`) drop in
  author-year rendering — brace them in the bib; typst's BibTeX
  parser rejects `month=July` — normalize to three-letter forms;
  the HTML export silently drops `align`/`block` title content —
  build HTML title blocks from `html.elem`; typst embeds Libertinus
  Serif and DejaVu Sans Mono (no font packages needed for those).

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
  scratch and never advance state. An update batch: fetch the
  registered queries over the inclusive interval since last
  reconciliation → dedup against the catalog and screen every row →
  promote the frozen snapshot with one matching audited-log row →
  deep-read and snowball new critical works → reconcile syntheses,
  claims, terminology, evidence rows, and affected manuscript text →
  only then advance state and run the record validator. A plausible
  close competitor or new mechanism is always grounds to update now.
- Prune `record/` to the minimal resumable state: `README.md` (the
  contract: scope, search parameters, snowball spec, selection rules
  with examples, key grammar, facet tokens, curation bar, numbered
  update procedure — build docs stay in AGENTS.md and this skill,
  pointed to rather than duplicated), `status.md` (current coverage
  and maintenance state, with deferred work for the next update as a
  section — the survey's todo lives here, not in a separate file),
  `catalog.tsv` and `log.tsv` per the §1 grammar, `sources/`,
  `syntheses/`, `claims.md`, and, when the manuscript publishes quantities
  derived from the catalog, a campaign-local
  `record/scripts/check.py`; the source fetchers, snowball tool, and
  registry-driven update tool ship with this skill (`scripts/`). The validator checks schemas, keys, facet
  tokens, source-note and bibliography/citation closure, and prints
  the derived counts for cross-surface reconciliation; a qualitative
  survey may omit it. Everything else — protocols, intermediate syntheses, work
  sheets — lives on in git history and the shadow mirror.
- Updates follow the record README's own procedure; this skill defers
  to it. Its last step syncs counts and dates in the README and the
  landing page.
- Verify builds, propose commits with the attribution trailer, commit
  on the user's word; use post-campaign /evolve when there are durable
  lessons worth promoting into the harness.

## Theory mode (for formal subjects)

When the survey's subject is a formal problem and the synthesis is a
unified framework, not only a facet taxonomy. The reference
implementation is dataflow-selection-enumeration (manuscript §3–§6,
`record/formal-synthesis/`, `record/claims.md`). Its moves:

- **Problem before solvers.** Open with a formal model of the object
  the literatures argue about, independent of any solver or data
  structure, deliberately narrowed until the task is well-defined
  (the reference isolates the finite, acyclic, deterministic, total
  case). Separate four things and keep them separate throughout: the
  observer (what is asked), its fibers (the semantic object), the
  discovery algorithm, and the output representation — mechanism and
  representation are orthogonal to the object.
- **Coordinates plus equivalence theorems.** Give each literature's
  native object a coordinate in the framework and prove the
  coordinates induce the same partition. The equivalence results are
  what license cross-literature comparison — without them "the same
  problem" is an analogy, not a theorem.
- **Relationship taxonomy.** Classify every compared work's relation
  to the target problem — direct presentation / restricted
  specialization / adjacent comparator — with any instrumentation or
  quotient stated explicitly. Never silently transfer a theorem
  across an observer change; framework-induced misclassification is
  a named validity threat, not just a risk.
- **Contract decomposition.** Split the target guarantee into
  independent obligations (the reference: coverage, guard–fiber
  equivalence, residual correctness, witness) and assess each work
  per-obligation. No approach inherits all obligations from its
  name; similar output syntax can hide different semantics.
- **Novelty as hypothesis.** Every synthesis claim lives in a claims
  ledger with status, scope, anchored evidence, and its closest
  established result; a claim is never novel merely because no
  contradicting paper surfaced. Run an adversarial reduction audit
  (reduce each tempting "new" statement to the nearest established
  construction) and keep a counterexamples file of small models that
  falsify overclaims. A rejected hypothesis stays in the ledger as a
  guardrail until its reduction is argued in the manuscript — then
  it retires to git history, the manuscript itself becoming the
  guardrail. Label every theorem prior work / direct derivation /
  local synthesis.
- **Record layer.** `record/formal-synthesis/` holds the model,
  semantics, derivations, complexity notes, counterexamples,
  reduction audit, and open questions; `claims.md` is the ledger; an
  evidence matrix binds manuscript claims at stable section labels
  to source-note anchors. Changes propagate formal-synthesis →
  ledger → manuscript, never manuscript-first.
- **Manuscript additions.** The framework section uses the shared
  statement apparatus (`surveys/style.typ` definitions/theorems,
  target-aware for HTML); the terminology maps each literature's
  native vocabulary onto framework terms (a "known as" list per
  concept); complexity claims name their charge model — oracle-call
  accounting is not an output-sensitivity theorem.

Theory mode refines, not relaxes, the no-research rule: definitions
and connecting theorems are contributed as a unifying lens, and
anything that could read as a novel result must survive the
reduction audit first.

## Heavy mode (opt-in)

When a campaign's subject or stakes genuinely demand validity
apparatus — not by default: dual-pass screening with Cohen's κ and a
declared independence axis (cross-vendor pass B via the Codex mirror
when available), adjudicated catalogs with persisted rationales,
committed fleet prompts, decision records with a mandatory
`Skill implication:` field, and a frozen disclosure baseline in the
spirit of PRISMA 2020 items 8–9. The v1 campaign
(agent-assisted-review-methodology) ran this way; its git history is
the reference implementation.
