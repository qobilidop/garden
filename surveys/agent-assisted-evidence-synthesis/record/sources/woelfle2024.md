---
citekey: woelfle2024
work:
  title: "Benchmarking Human–AI collaboration for common evidence appraisal tools"
  author: "Tim Woelfle, Julian Hirt, Perrine Janiaud, Ludwig Kappos, John P.A. Ioannidis, Lars G. Hemkens"
  venue: "Journal of Clinical Epidemiology"
  date: 2024
  doi: 10.1016/j.jclinepi.2024.111533
read: full-text
source: "shadow/library/papers/2024/woelfle2024-appraisal/"
facets:
  stage: "appraise"
  contribution: "evaluation"
  evidence: "human-agree"
  setting: "med"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "Benchmarking Human–AI collaboration for common evidence appraisal tools"
---

# Benchmarking Human–AI collaboration for common evidence appraisal tools

## Evidence
- Benchmarks 5 LLMs (Claude-3-Opus, Claude-2, GPT-4 [gpt-4-32k-0613], GPT-3.5-turbo-16k, Mixtral-8x22B-instruct) against human consensus on 3 appraisal tools of increasing complexity: PRISMA (27 items, reporting quality, 112 pediatric-surgery systematic reviews), AMSTAR (11 items, methodological rigor, same 112 reviews), and PRECIS-2 (9 domains, ordinal 1–5 pragmatism rating, 56 RCTs from the PragMeta database). Human data (2 independent raters + consensus) sourced from prior published datasets (Cullis et al. for PRISMA/AMSTAR; PragMeta for PRECIS-2), not newly collected.
- Four comparison arms per tool: (1) individual human rater vs. consensus; (2) individual LLM vs. consensus; (3) "combined LLMs" — 9 total LLM runs (2×Claude-3-Opus, 2×Claude-2, 1×GPT-4, 2×GPT-3.5, 2×Mixtral) combined via a consistency-threshold vote (5/9 to 9/9 agreement required), inconsistent items deferred; (4) "human–AI collaboration" — human rater 1 paired with one LLM, items where they agree are scored, disagreements deferred to a second human rater.
- Individual human rater accuracy (rater 1 vs. consensus): 89% PRISMA (κ=0.81), 89% AMSTAR (κ=0.80), 75% PRECIS-2 (κ=0.57). Human inter-rater reliability (raters 1 vs. 2): 91% PRISMA (κ=0.84), 88% AMSTAR (κ=0.77), 57% PRECIS-2 (κ=0.29) — reliability itself drops sharply as task complexity rises.
- Individual LLM accuracy vs. consensus: PRISMA 63% (GPT-3.5) to 70% (Claude-3-Opus, κ=0.51); AMSTAR 53% (GPT-3.5) to 74% (Claude-3-Opus, κ=0.56); PRECIS-2 38% (GPT-4) to 55% (GPT-3.5) — all individual LLMs performed significantly worse than either human rater on every tool, and worse as task complexity increased. Average accuracy across tools ranked Claude-3-Opus (63%) > Claude-2 (59%) ≈ GPT-4 (59%) > Mixtral-8x22B (57%) ≈ GPT-3.5 (57%); average κ 0.40/0.30/0.31/0.27/0.24 respectively. Notably, model ranking inverted for PRECIS-2 (GPT-3.5/Mixtral beat Claude-3-Opus/Claude-2/GPT-4), attributed to class imbalance (dataset skewed pragmatic) interacting with model "personality."
- Combined-LLMs consistency approach: accuracy rose with consistency threshold at the cost of deferring more items — PRISMA 75%→88% accuracy (4%→74% deferred), AMSTAR 74%→89% (6%→84% deferred), PRECIS-2 64%→79% (29%→88% deferred). At the highest thresholds (9/9 for PRISMA/AMSTAR, ≥8/9 for PRECIS-2), accuracy CIs statistically overlapped human performance, but only for a small, heavily filtered subset of items.
- Human–AI collaboration (best condition overall): PRISMA 89%–96% accuracy (25%–35% deferred to 2nd human rater), best pair human+Claude-2 at 96% (κ=0.92) deferring 35%. AMSTAR 91%–95% accuracy (27%–30% deferred), best human+Claude-3-Opus at 95% (κ=0.92) deferring 30%. PRECIS-2 80%–86% accuracy (71%–76% deferred), best human+GPT-3.5 at 86% deferring 71%. For PRISMA/AMSTAR, 8 of 10 possible human–LLM pairs (across 2 human raters × 5 LLMs) gave significantly higher accuracy than either human rater alone; for PRECIS-2 only 1 of 10 pairs was significantly better than human alone.
- Framed as workload reduction: accepting 96% accuracy on PRISMA via human+Claude-2 collaboration spares the second rater ~65% of items (1 wrong response per ~25 spared); AMSTAR spares ~70% (1 wrong per ~20 spared); PRECIS-2 spares only ~29% (1 wrong per ~7 spared) — the tradeoff degrades sharply with task complexity.
- LLM intrarater reliability (duplicate runs, temperature=0) compared to human inter-rater reliability: mixed by model/tool — e.g., for PRISMA, GPT-3.5 reliability (94%, κ=0.90) exceeded human reliability (91%, κ=0.84), while Claude-3-Opus (80%, κ=0.68) and Mixtral (67%, κ=0.46) fell short.
- Cost/speed (Table 1, per 100 papers): Mixtral-8x22B cheapest ($1.20/100 papers), GPT-4 most expensive ($115/100 papers); response times ~10s (GPT-3.5) to ~2min (GPT-4) per paper.
- Quote-grounding check: LLMs were required to extract 1–3 supporting quotes per item; median quote-to-source-text similarity was 99% (rapidfuzz/parasail alignment), i.e., LLMs rarely fabricated quotes, though some models (Claude-3-Opus, Claude-2, Mixtral) occasionally quoted the instruction briefing instead of the target full text.

## Bearing on RQs
Central evidence for RQ2 (appraisal reliability / agreement metrics): a rigorously designed, multi-tool, multi-model benchmark with accuracy, Cohen's κ (weighted for ordinal PRECIS-2), 95% bootstrap CIs, and both inter-rater and intra-rater reliability reported throughout — one of the more statistically complete human-AI agreement studies in this survey's domain (appraisal, not screening). Directly informative for RQ4 (collaboration designs): explicitly operationalizes and contrasts two distinct human-AI collaboration modes — a fully automated "combined LLMs" consistency-vote ensemble vs. a "human+single-LLM" deferral-based collaboration — and shows the latter dominates, motivating a deferred-item / active-learning-style triage design as a concrete, evaluated pattern for RQ4. Also bears on RQ1 (system design) via the deferral/triage workflow: LLM-human agreement gates which items get a second human look, a design pattern generalizable beyond appraisal to screening/extraction pipelines. The finding that agreement (both human-human and human-LLM) degrades monotonically with task complexity (PRISMA > AMSTAR > PRECIS-2) is a reusable framing device for comparing across studies in this survey that test appraisal vs. screening vs. extraction tasks.

## Evidence limits
- All 5 LLMs are 2023–2024 vintage (GPT-3.5/GPT-4-32k, Claude-2/Claude-3-Opus, Mixtral-8x22B); none are reasoning models or 2025-era frontier models — authors' own outlook section flags this and calls for testing newer/open models (e.g., Llama-3).
- Human "ground truth" is only 2 raters' consensus per dataset, not adjudicated by a larger panel; authors explicitly decline to call it a true "ground truth" and acknowledge this as a limitation (their Limitation #5).
- PRECIS-2 dataset is class-imbalanced (mostly pragmatic trials), which the authors identify as a likely driver of the counterintuitive finding that smaller/cheaper models outperformed larger ones on that tool — a dataset artifact rather than a general capability finding.
- No "time on task" data for human raters were available, so the paper cannot quantify actual time/efficiency savings from the proposed workload-reduction scheme, only item-count-based deferral fractions (explicitly flagged as Limitation #6).
- Two of the three tools (PRISMA, AMSTAR) have since been superseded by updated versions (PRISMA 2020, AMSTAR-2); authors argue differences are minor but this was not empirically verified in this study.
- Single domain per tool (pediatric surgery reviews for PRISMA/AMSTAR; PragMeta multiple-sclerosis-adjacent RCT corpus for PRECIS-2), limiting generalizability across medical subfields.
- Prompts differed across models (each LLM's prompt was individually engineered), so cross-model comparisons of raw accuracy are confounded by prompt-engineering effort, a limitation the authors themselves note when interpreting the individual-LLM ranking.
