---
citekey: fernandes2026
work:
  title: "HAICO-SLR Guide: Conducting and Reporting Human-AI Collaboration in Systematic Literature Reviews"
  author: "Bernardo Fernandes, Mariana Oliveira Schleder, Otávio Costa de Oliveira, Roger  de Bem Jaeger, Leandro Nascimento, Fernanda dos Santos de Oliveira"
  venue: "Elsevier BV"
  date: 2026
  doi: 10.2139/ssrn.7048543
read: full-text
source: "https://papers.ssrn.com/sol3/papers.cfm?abstract_id=7048543 (SSRN, \"Download This Paper\" delivery link; author-posted preprint, no journal venue yet)"
facets:
  stage: "meta"
  contribution: "guideline"
  evidence: "none"
  setting: "general"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "HAICO-SLR: stage-typed human/AI role guide + dual-reporting checklist"
---

# HAICO-SLR Guide: Conducting and Reporting Human-AI Collaboration in Systematic Literature Reviews

## Evidence

- Basis: an SLR-of-SLRs — 124 papers (Scopus/WoS/PubMed, 2023–2025) on
  generative-AI use in SLRs, Bardin qualitative content analysis (a priori
  categories, AI-assisted pre-analysis via the authors' own "FullCorpus
  AI" tool + Gemini, then human re-verification, researcher triangulation).
  HAICO-SLR is synthesized from this evidence, not a Delphi/consensus
  process (§2.2, §7).
- **Conducting (Table 4):** classifies 9 SLR stages (ideation;
  search-string generation; screening; discrepancy resolution; data
  extraction; coding; analysis/interpretation; RoB assessment;
  synthesis/writing) by human vs. AI role — every stage gets *both* roles
  (no stage AI-only). Pattern: AI generates/accelerates/drafts, humans
  refine/validate/decide. Two exclusivity calls: research-question
  formulation and final synthesis stay human; manual screening stays
  human-led with AI as "initial filter" only.
- **Database search flagged unreliable, not just hybrid:** a worked
  comparison (§6) has ChatGPT and Gemini each fabricate their own search
  yield when asked to replicate the authors' Scopus query (Scopus:
  10,132 hits; GPT reported an internally-invented PRISMA flow that
  doesn't match). Table 4 carries an explicit **Alert** that "several
  leading GenAI systems are not yet able to consistently produce reliable
  database search results"; §7 repeats this as a standalone
  recommendation to keep search/metadata retrieval human-led with all
  outputs verified. A follow-up test (Claude in Chrome, June 2026) could
  type Scopus queries and download real metadata, while an autonomous
  mode reportedly could not, "as reported by the AI itself" (self-report,
  unverified) (§6).
- **Reporting (Table 5):** a parallel 10-stage table listing what to
  disclose about human vs. AI-assisted activity per stage — a
  **"dual-reporting mechanism"** (Abstract) elevating disclosure to
  "shared methodological co-responsibility." Complementary to PRISMA 2020
  (no item numbering/scoring); orthogonal to PRISMA-S/PRISMA-ScR, which
  specify review *type* rather than *who executes each step* (§8).
- Positioned beyond Holst et al.'s PRISMA-trAIce (this survey:
  `holst2025-...`) by adding human-role reporting and grounding items in
  a systematic review rather than a synthesis of existing AI-reporting
  standards; and beyond Cacciamani et al.'s PRISMA-AI proposal, which the
  authors say was never actually developed (§8).
- Authorship stance: AI should not be credited as author; "co-intelligence"
  framing (citing Ong et al. 2026) casts AI as "epistemic co-agent" and
  human-skill amplifier, but accountability stays with named human
  authors throughout Table 4 (§5.2, §8).
- Reproducibility reframe: since LLM non-determinism makes exact-output
  replication "impossible" (citing Petersen 2024), HAICO-SLR targets
  *procedural* reproducibility — same prompts/models/supervision
  steps/audit trail re-executable by an independent team (§8).

## Bearing on RQs

- **RQ3 (norms):** Core hit — a disclosure standard (Table 5) paired with
  a *conduct* standard (Table 4), which most guidance in this survey
  treats separately. Treats AI as a tool needing disclosure and human
  oversight, not an independent reviewer with standing — every stage
  keeps a human decision-maker; the "co-agent" language is rhetorical but
  cashes out operationally as tool-with-audit-trail.
- **RQ4 (design gap):** Tangential. No design treatment of
  independence/ensembling across model families — the one boundary case
  (browser-agent vs. autonomous-mode search) is an anecdotal capability
  comparison, not a designed independence mechanism, and self-reported.
- **RQ2 (reliability):** Indirect. §5–§6 aggregate reliability figures
  from the *reviewed* corpus (e.g. hallucination-in-references >25% per
  Chelli et al. 2024; screening sensitivity 95–100% per Issaiy/Kim et
  al.) rather than the authors' own new measurements, except the
  search-replication anecdote in §6, a single worked example.

## Evidence limits

- No piloting, field-testing, or adoption evidence for HAICO-SLR itself —
  called a "preliminary, evidence-informed step" (§9, author-stated);
  future-work explicitly includes testing it across domains.
- SSRN preprint, not peer-reviewed (posted 23 Jul 2026 per SSRN page); no
  independent citations yet (OpenAlex cited_by_count: 0).
- Search-tool comparison (§6) is a single trial per tool, no stated
  reproducibility method; mixes vendor terminology loosely ("Cowork
  mode" is not a documented Claude product name).
