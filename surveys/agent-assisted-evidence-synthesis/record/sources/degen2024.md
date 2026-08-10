---
citekey: degen2024
work:
  title: "Leveraging Artificial Intelligence for Systematic Reviews:  The FRAISR Reporting Framework and guidance for researchers"
  author: "Ben Degen, Sebastian Vogel, Daniela Rzejak"
  venue: "Center for Open Science"
  date: 2024
  doi: 10.31219/osf.io/ju8dk
read: full-text
source: "transcript at shadow/library/papers/2024/degen2024-fraisr/transcript.md"
facets:
  stage: "report"
  contribution: "guideline"
  setting: "general"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "FRAISR: a cross-disciplinary AI reporting framework for SRs"
---

# Leveraging Artificial Intelligence for Systematic Reviews:  The FRAISR Reporting Framework and guidance for researchers

## Evidence

- FRAISR's reporting unit is not an enumerated item list like PRISMA's 27
  items — it's a tabular template (Table 1) with one row per SR stage and
  three AI-disclosure fields per row: **tool name, tool version, input
  parameters** (prompt/config used), across 8 stages: Defining the Research
  Question, Developing a Protocol, Literature Search, Screening and
  Selection, Data Extraction and coding, Quality Assessment, Data Synthesis
  and Analysis, Reporting and Dissemination (lines 105–119). No model-role
  or human-vs-AI attribution field is specified beyond tool identity.
- Machine-readable extension: authors recommend also emitting the table as
  CSV (`Systematic Review Stage,Tool name,Tool version,input parameters`)
  as an attachment (lines 133, 139). Worked example reproduces one row from
  Syriani et al. (2023): stage = Screening and Selection, tool = ChatGPT,
  version = 3.5 Turbo, with the full screening prompt text verbatim as the
  input-parameters field (lines 141–143) — prompt disclosure is meant to be
  literal/complete, not summarized.
- Development method: not a Delphi/consensus-panel process (none described).
  It's an author-authored conceptual synthesis: (1) summarize existing
  generic SR-stage frameworks (Arksey & O'Malley 2005; Newman & Gough 2020;
  Petticrew & Roberts 2008) into 8 canonical stages (lines 49–75); (2)
  survey existing AI-era reporting guidelines; (3) derive FRAISR from three
  stated gaps (lines 79–87).
- Relation to PRISMA claimed explicitly: FRAISR fills a gap left by
  "current efforts to update the PRISMA guidelines (PRISMA AI reporting
  guidelines for systematic reviews and meta-analyses on AI in healthcare;
  Cacciamani et al., 2023)" — grouped with SPIRIT-AI/CONSORT-AI as
  guidelines that "focus mainly on applicability to medicine and especially
  clinical studies" (lines 77–78). Three stated gaps (82–87): (1) those
  guidelines' clinical framing (e.g. SPIRIT-AI item 6a(i)) doesn't transfer
  to fields like educational research; (2) the landscape is "piecemeal,"
  ad hoc extensions rather than one cohesive AI-focused framework; (3) none
  build in machine-readable output. FRAISR is a domain-general complement,
  not a formal PRISMA extension/checklist mapping.
- Guidance section (145–291) surveys candidate AI tools per stage with
  challenges/possible-support/limitations subsections — e.g. Elicit,
  CoQuest for question formulation; litsearchr, Rayyan, Covidence for
  protocol/search; ASReview, RobotReviewer, Abstrackr, and the Syriani et
  al. ChatGPT screening result (Fleiss' kappa 0.821–0.973 vs. traditional
  classifiers); GATE, spaCy, BioBERT for extraction/reporting — background
  landscape material, not part of the FRAISR template itself.
- General limitations (279–291): shift from careless/copy-paste errors
  toward systematic algorithmic bias inherited from training data; limited
  model memory/context; high compute requirements; technical-expertise
  barrier to adoption.

## Bearing on RQs

RQ3 primarily — FRAISR is a proposed disclosure/reporting standard for AI
use across SR stages, explicitly scoped as a cross-disciplinary alternative
to the medicine-only PRISMA-AI/SPIRIT-AI/CONSORT-AI family. Secondary
bearing on RQ1 (landscape): the guidance section is a stage-by-stage survey
of AI tools (question formulation, protocol, search, screening, extraction,
quality assessment, synthesis, reporting) with named systems and citations,
useful as a cluster-anchoring source. No bearing on RQ2 (no independent
inter-rater/agreement evaluation of FRAISR itself is reported — the single
kappa figures cited are from Syriani et al. 2023, not from validating
FRAISR).

## Evidence limits

Conceptual/guidance paper only — no empirical validation, pilot application,
or inter-rater study of FRAISR is reported in the transcript. The framework
table (Table 1) is presented as a blank template; the only filled example is
the single reproduced Syriani et al. CSV row (Table 2), not an original
worked case by the authors. All claims above are transcript-supported;
no page/table content was inferred beyond what's transcribed.
