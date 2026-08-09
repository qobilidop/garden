# holst2025-transparent-reporting-of-ai-in-systematic-literature-reviews — PRISMA-trAIce checklist proposal

- **Status:** deep-read
- **Work:** Transparent Reporting of AI in Systematic Literature Reviews: Development of the PRISMA-trAIce Checklist. JMIR AI, 2025. https://doi.org/10.2196/80247
- **Source:** https://ai.jmir.org/2025/1/e80247/PDF (publisher, JMIR AI gold OA, CC-BY)
- **Facets:** stage=report, contribution=guideline-norms, evidence=none, setting=general

## Evidence

- PRISMA-trAIce (PRISMA–Transparent Reporting of Artificial Intelligence in
  Comprehensive Evidence Synthesis) extends PRISMA 2020 for reporting AI
  used *as a methodological tool* in an SLR — explicitly not PRISMA-AI,
  which covers SLRs studying AI as a research subject in clinical medicine
  and (per the paper) remains unpublished since its 2022 announcement
  (Introduction, ref 15).
- Checklist comprises **14 items**, all AI-specific, across the SLR
  structure (Results / Table 1): Title (T1), Abstract (A1), Introduction
  (I1), Methods (M1–M10), Results (R1–R2), Discussion (D1–D2). Methods
  items cover: tool identification/access incl. custom-tool replicability
  (M2); SLR stage + task per tool (M3); input/output data (M4/M5); prompt
  engineering — full prompts, parameters (temperature/top-p), iterative
  refinement (M6); non-LLM operational details, e.g. algorithms/thresholds
  (M7); human-AI oversight — reviewer count, independence, qualifications,
  % manually verified, discrepancy resolution (M8); AI performance-eval
  methods, e.g. reference standard, accuracy/sensitivity/specificity/
  precision/recall/F1 (M9); data governance/ethics incl. third-party cloud
  ToS (M10). Results items: AI-vs-human exclusion counts (R1), AI
  performance results (R2). Discussion: limitations and implications of
  AI use (D1/D2).
- Companion artifact: an adapted PRISMA 2020 flow diagram (Figure 1)
  splitting "Records/Reports excluded" into "by Human" vs "by AI"
  sub-counts, distinguishing rule-based automation (e.g. deduplication)
  from evaluative AI systems.
- Development method (Methods): (1) targeted literature search via the
  EQUATOR Network for consensus-based AI reporting guidelines; (2) source
  guidelines selected — CONSORT-AI, SPIRIT-AI, TRIPOD-AI, TRIPOD-LLM,
  DECIDE-AI, GAMER; (3) qualitative content analysis of each source item
  against relevance/reproducibility/feasibility/adaptability to SLR
  context, excluding irrelevant items (e.g. patient-safety items); (4)
  thematic synthesis into core concepts mapped onto PRISMA 2020 structure.
  Explicitly **not** a Delphi study or consensus meeting — no external
  panel, no voting, no formal user study (Limitations, Methods and
  Discussion).
- Governance: GitHub repo (github.com/cqh4046/PRISMA-trAIce) as
  version-controlled source of truth, plus a Discord hub and planned
  annual reviews, pending handoff to a future steering committee
  ("Rationale for a Living Guideline").
- Authors disclose using Gemini 2.5 Pro for manuscript prep in
  Acknowledgments, noting "rare instances of erroneous outputs
  (hallucinations)" — a self-referential disclosure example, not checklist
  output.

## Bearing on RQs

- **RQ3 (norms):** Directly on point — a proposed disclosure standard for
  AI-as-tool use across SLR stages, filling a gap the authors argue
  PRISMA-AI's subject-not-tool framing leaves open. Gives a concrete
  14-item checklist plus a revised flow diagram anchoring a "what should
  be disclosed" taxonomy (full prompts + parameters, per-tool I/O data,
  AI-vs-human exclusion counts) beyond generic "we used an LLM" claims.
- **RQ2 (reliability):** Indirect only — checklist item M9/R2 *prescribes*
  reporting of performance-evaluation methods and metrics (accuracy,
  sensitivity, specificity, precision, recall, F1, agreement with human
  reviewers) but the paper itself contains no such measurements; it is a
  reporting-guideline proposal, not an evaluation study.
- **RQ4 (design gap):** Not addressed — no discussion of independence or
  ensembling across model families; M8 covers human-reviewer independence
  from AI output but not agent/model-family independence.

## Evidence limits

- No effectiveness or adoption evidence: checklist not applied to any real
  SLR, piloted, or validated by a user study (author-stated, Limitations).
- Consensus-only in a weak sense — built by synthesizing existing
  consensus guidelines via the authors' own qualitative judgment, not a
  Delphi panel or multi-stakeholder process for this checklist itself
  (author-stated, Methods/Limitations, Discussion "Limitations").
- Single-institution authorship (Hamburg University of Technology); no
  external field-testing reported; stated governance plan (GitHub +
  Discord + steering committee) is intention, not evidence of uptake.
