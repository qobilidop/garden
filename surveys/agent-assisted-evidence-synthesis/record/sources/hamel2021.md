---
citekey: hamel2021
work:
  title: "Guidance for using artificial intelligence for title and abstract screening while conducting knowledge syntheses"
  author: "Candyce Hamel, Mona Hersi, Shannon E. Kelly, Andrea C. Tricco, Sharon Straus, George Wells, Ba’ Pham, Brian Hutton"
  venue: "BMC Medical Research Methodology"
  date: 2021
  doi: 10.1186/s12874-021-01451-2
read: full-text
source: "shadow/store/library/papers/2021/hamel2021-aml-screening/ (publisher PDF gated by a bot/JS challenge on both BMC and PMC; retrieved as a Wayback Machine `id_` capture, timestamp 20211220175236, verified byte-identical to a live browser fetch of the same PDF)"
facets:
  stage: "screen"
  contribution: "guideline"
  evidence: "benchmark"
  setting: "med"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "seven-step AML screening framework"
---

# Guidance for using artificial intelligence for title and abstract screening while conducting knowledge syntheses

## Evidence

- Pre-LLM paradigm: "AI" means active machine-learning (AML)
  re-ranking/prioritization tools (DistillerSR, Abstrackr, EPPI-Reviewer,
  Pico Portal, Rayyan, RobotAnalyst, SWIFT-ActiveScreener) — level 2
  automation (workflow prioritization). Level 4 automation (fully
  autonomous include/exclude by score threshold) is explicitly flagged
  as an "inappropriate use" to be avoided (poor reported performance,
  refs. 10, 30).
- Seven-step framework (Fig. 1): (1) knowledge-user/expert-panel
  consultation before any stop/modified screening; (2) search strategy —
  highest-quality search regardless of yield, since unscreened records
  stay recoverable; (3) prepare the team — reviewer-compatibility so
  juniors don't screen each other; (4) prepare the database — dedup and
  3 options for title-only records so they don't corrupt the training
  signal; (5) build a high-quality initial training set (2+ independent
  pilot reviewers, an expert reviewer, seeding with known-relevant
  records); (6) ongoing screening; (7) truncation of screening.
- Step 6 human-oversight ladder, most to least robust: dual-independent
  (best practice, with periodic pace/conflict checks) > liberal
  accelerated (1 include/2 exclude) > single-reviewer. An AI audit tool
  (scores already-excluded records) is recommended at set intervals
  (5-10% or daily) to catch false negatives — treated as the primary
  risk, since false positives are caught later at full-text.
- Step 7 stopping criteria: "little empirical evidence" for any
  stop/modified-screening rule (explicit caveat). Three named approaches:
  heuristic (N consecutive irrelevant), pragmatic (time-boxed), and
  estimated-recall threshold (e.g. 95%, TP/(TP+FN) on screened records
  only — flagged as an estimate, not true recall). Table 1 then ranks 8
  post-truncation approaches for the unscreened remainder by risk, from
  AI-only exclusion to dual-independent-with-AI to reassigning spare
  reviewers to full-text screening, each paired with a mitigation
  (mainly: run the audit; resolve conflicts on a schedule).
- Evidence base: a retrospective evaluation of DistillerSR's AML across
  10 completed SRs targeting 95% recall at progression to full-text,
  summarized here as no case of a finally-included citation missed
  (detailed metrics in a companion paper, ref. 34, not in this
  transcript), plus qualitative prospective experience from ~5 later
  reviews (refs. 39-43) over the prior 24 months.
- Cites the 2020 PRISMA update's requirement to report automation-tool
  use in selection (ref. 46 → page2021, already in this library) as a
  sign of "growing acceptance" motivating the guidance.
- Author-stated limits: DistillerSR-anchored, may not transfer to other
  software; fast-moving tooling may date specific claims; stopping-rule
  evidence is a small number of case studies.

## Bearing on RQs

- **RQ3 (norms):** The clearest pre-LLM baseline here — a named, ordered
  oversight ladder tied explicitly to how far screening is truncated
  (Table 1). Later LLM-era guidance can be read against it: does it keep
  a graded-risk ladder tied to stopping decisions, or collapse to
  single-pass LLM screening without this risk bookkeeping?
- **RQ2 (reliability):** Sets 95% estimated recall as an accepted
  stop-screening threshold while cautioning estimated ≠ true recall — a
  measurement-validity caveat worth checking against later papers that
  report bare "recall." The paper's own recall evidence is qualitative
  (numbers live in a companion paper).
- **RQ4 (design gap):** "Independence" here is human-reviewer
  independence only (compatibility settings, dual-independent,
  conflict resolution) — never agent/model-family independence. A
  contrast point for later multi-agent-ensemble designs.

## Evidence limits

- Additional file 1 (the 10-SR synopsis and prospective-review list) is
  a supplementary file not captured by this PDF/transcript.
- Figs. 1-2 are transcribed as captions only, not independently reviewed.
- The "estimated recall is conservative" claim cites an external source
  (ref. 32), not verified against this paper's own data.
