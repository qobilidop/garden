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
cannot launder its own. Campaigns are human-triggered, pin this
skill's commit SHA in `record/README.md`, and redesign the method
only through the post-campaign /evolve. Method v2, reshaped from the
agent-assisted-review-methodology campaign and its review round.

## 1. Shape

Three surfaces in `surveys/<slug>/`:

- `index.md` — the landing page and `[[slug]]` backlink target:
  short description, links to both manuscript renders, the record
  link, and the curated reading list as its body.
- `record/` — the minimal resumable state (§7).
- `manuscript/` — the Typst paper (§5).

## 2. Search, catalog, screen

- Logged queries (`record/searches.tsv`: date, qid, source, query,
  results) against OpenAlex / Crossref / Semantic Scholar / arXiv;
  per-source request templates, caps, and retry conventions are
  documented in the record README — the logged rows are the query
  set, rerun verbatim on update.
- One key grammar, documented in the README: `doi:`/`arxiv:`
  normalized (arXiv-DOIs collapse, versions stripped, lowercase),
  `t:<title-slug>` fallback; a published version of an included
  preprint replaces its key, superseded key to `excluded.tsv` as E6.
- One included-works table (`included.tsv`; year-at-screening,
  truncated display titles) that classification extends with facet
  columns; `excluded.tsv` (key + code) is permanent screening memory.
- Snowball one backward+forward round via citation indexes; record
  the pre-filter vocabulary verbatim; a verification pass re-judges
  everything the wave screens in.
- Screening: two agent passes on different model tiers and prompt
  framings, disagreements adjudicated by the strongest available
  model, a human gating the result; single-pass waves only with a
  verification pass. Exclusion codes E1–E6 plus `U` (parked,
  re-screened each update); the load-bearing code gets boundary
  examples in the README. No query left `FAILED` at close without a
  recorded reason.

## 3. Terminology, taxonomy, classification

- The survey's centerpiece: fix the field's vocabulary explicitly,
  then build a facet scheme by keywording and classify every include
  under it. Prefer few, mechanical facets; cut judgment-heavy fields
  rather than classify them noisily (v1's judgment field varied 5.7×
  across passes and was unusable).
- Deep-read the anchor candidates into `record/sources/` notes:
  library-note frontmatter (citekey, registrar work metadata,
  `synthesis:` one-liner) over an extraction body (`## Evidence`
  anchored to sections/tables, `## Bearing on RQs`, `## Evidence
  limits`). Note facets from full text are authoritative for that
  work but never silently overwrite the abstract-level map —
  disagreements stand, disclosed in the manuscript's limitations.

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
- *Cold referee* — claims versus the evidence notes: overreach,
  unscoped superlatives, uncaveated preprint numbers, structure and
  prose a hostile methodologist would flag.
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

- Prune `record/` to the minimal resumable state: `README.md` (the
  contract: scope, search parameters, snowball spec, selection rules
  with examples, key grammar, facet tokens, curation bar, numbered
  update procedure, rebuild instructions), `searches.tsv`,
  `included.tsv`, `excluded.tsv`, `sources/`. Everything else —
  protocols, intermediate syntheses, work sheets — lives on in git
  history and the shadow mirror.
- Updates follow the record README's own procedure; this skill defers
  to it. Its last step syncs counts and dates in the README and the
  landing page.
- Verify builds, propose commits with the attribution trailer, commit
  on the user's word; the post-campaign /evolve harvests lessons.

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
