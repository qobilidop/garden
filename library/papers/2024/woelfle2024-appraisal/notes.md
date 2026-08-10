---
citekey: woelfle2024-appraisal
work:
  title: "Benchmarking Human–AI collaboration for common evidence appraisal tools"
  author: "Tim Woelfle, Julian Hirt, Perrine Janiaud, Ludwig Kappos, John P.A. Ioannidis, Lars G. Hemkens"
  venue: "Journal of Clinical Epidemiology 175 (2024) 111533"
  date: 2024-09-12  # published online; November 2024 issue
  doi: 10.1016/j.jclinepi.2024.111533
sources:
  pdf: https://www.jclinepi.com/article/S0895-4356(24)00289-0/pdf
retrieved: 2026-08-08
notes-by: Claude Fable 5 (claude-fable-5)
notes-date: 2026-08-08
synthesis: "Put the human gate at human–LLM disagreement: scoring only items where one human rater and an LLM agree beat both solo humans and LLM ensembles on PRISMA/AMSTAR, but on PRECIS-2 — where humans themselves barely agree — the same design deferred three-quarters of the work, so the collaboration pattern, not the model, carries the result, and human inter-rater reliability bounds it."
---

# Benchmarking Human–AI collaboration for common evidence appraisal tools

Clinical-epidemiology benchmark study (Basel Pragmatic Evidence Lab +
Stanford METRICS — Ioannidis and Hemkens among the authors) asking not
"can LLMs appraise evidence?" but "where exactly should a human sit in
the loop?". Five 2023–24 LLMs (Claude-3-Opus, Claude-2, GPT-4-32k,
GPT-3.5-turbo-16k, Mixtral-8x22B) rate 112 pediatric-surgery systematic
reviews on PRISMA (27 reporting items) and AMSTAR (11 methodological-rigor
items) and 56 randomized trials from the authors' PragMeta database on
PRECIS-2 (9 pragmatism domains, ordinal 1–5), against a reference of
two-human-rater consensus from previously published datasets. The
contribution is the four-arm design that isolates collaboration structure
from model capability, plus the honest reporting frame it forces: every
ensemble or collaboration score is a pair (accuracy, deferring fraction),
never accuracy alone. Methods are transparent — bootstrap 95% CIs,
Cohen's kappa (weighted for ordinal PRECIS-2), temperature-0 duplicate
runs for intrarater reliability, quote-extraction audits, open code/data
and an interactive dashboard. Headline: LLMs alone are worse than humans
everywhere; agreement-gated human–AI collaboration beats humans alone on
PRISMA and AMSTAR; on PRECIS-2 nothing works well — including humans.

## The four arms

All arms are scored against the two-rater human consensus:

1. **Individual human rater** — rater 1 (or 2) alone vs the consensus
   they later co-formed. The baseline to beat: 89%/90% (PRISMA),
   89%/89% (AMSTAR), 75%/73% (PRECIS-2).
2. **Individual LLM** — one model, one run, full text (only
   Claude-3-Opus got page images and did its own OCR; the rest got
   extracted text). Prompts require 1–3 supporting quotes per item plus
   a reasoning paragraph before the score.
3. **Combined LLMs (consistency ensemble)** — nine assessments
   (2×Claude-3-Opus, 2×Claude-2, 1×GPT-4 for cost, 2×GPT-3.5,
   2×Mixtral); an item is scored only if ≥k of 9 runs agree
   (k = 5…9), otherwise deferred to humans. Consistency doubles as an
   uncertainty estimate.
4. **Human–AI collaboration** — human rater 1 paired with a single
   LLM; items where they agree are accepted, disagreements are deferred
   to a second human rater who would then run the normal consensus
   process on just those items.

Arm 4 is the design finding: the LLM never decides anything alone — it
acts as a cheap second reader whose only power is to *confirm* the first
human or escalate.

## Results: a complexity gradient, then the collaboration jump

Individual LLMs (arm 2) lose to humans on every tool, and degrade with
task complexity: PRISMA 63% (GPT-3.5) to 70% (Claude-3-Opus); AMSTAR
53% (GPT-3.5) to 74% (Claude-3-Opus); PRECIS-2 38% (GPT-4) to 55%
(GPT-3.5) — kappas near zero for PRECIS-2 (0.01–0.12), i.e. barely
above chance. Averaged across tools: Claude-3-Opus 63% > Claude-2 ≈
GPT-4 59% > Mixtral ≈ GPT-3.5 57%; the open-source Mixtral beat
proprietary GPT-3.5. The ranking *inverts* on PRECIS-2 (the small cheap
models win), which the authors attribute to class imbalance — the
PRECIS-2 corpus is mostly pragmatic trials, and simpler models may skew
toward pragmatic scores.

The same gradient shows up in humans: inter-rater reliability falls
91% (κ 0.84) → 88% (κ 0.77) → 57% (κ 0.29) across
PRISMA → AMSTAR → PRECIS-2. Their reading: PRISMA is nearly pure
text/language assessment (an LLM-shaped task), AMSTAR is
keyword-indicative checklists ("systematic search", "gray literature"),
PRECIS-2 requires judging design features that no signal phrase carries.

The consistency ensemble (arm 3) trades accuracy against deferral along
a curve: PRISMA 75% accurate at 4% deferred (5/9 threshold) up to 88%
at 74% deferred (9/9); AMSTAR 74%@6% up to 89%@84%; PRECIS-2 64%@29%
up to 79%@88%. At the strictest thresholds the surviving items reach
human-level accuracy (overlapping CIs) — but only by throwing away
most of the work.

Human–AI collaboration (arm 4) dominates. PRISMA: 89% (GPT-4) to 96%
(Claude-2) accuracy at 25% and 35% deferred respectively; 8 of 10
human×LLM pairs significantly beat either human rater alone. AMSTAR:
91% (GPT-4) to 95% (Claude-3-Opus) at 27% and 30% deferred; again 8 of
10 pairs significantly better. Notably the collaboration is nearly
model-agnostic on these two tools — even GPT-3.5 and Mixtral pairs hit
95–96%, just with higher deferral (40–52%): weaker models don't make
the scheme wrong, they make it defer more. PRECIS-2 breaks the pattern:
80–86% accuracy but at 71–76% deferred, and only 1 of 10 pairs
(rater 2 + GPT-3.5) significantly beat a human alone.

## The deferral–accuracy tradeoff, priced out

The paper's own workload arithmetic is the most quotable part:

- **PRISMA** (human + Claude-2): accept 96% accuracy and the second
  rater skips 65% of items — 1 wrong answer per ~25 items spared.
- **AMSTAR** (human + Claude-3-Opus): accept 95% and skip 70% —
  1 wrong per ~20 spared.
- **PRECIS-2** (best pair): accept 86% and skip only 29% —
  1 wrong per ~7 spared.

So the same collaboration design yields a good trade on the two simpler
tools and a bad one on the complex tool. The authors are careful that
even the good trade is *item counts, not time*: no time-on-task data
exists, and if the second rater must read the whole paper anyway to
handle the deferred items, real savings may be small.

Operationally: costs ranged from $1.20 (Mixtral) to $115 (GPT-4) per
100 papers, ~10s to ~2min per paper; ~3% of publications persistently
failed per model (context length for GPT-4; Anthropic content filtering
or over-long output for Claude-3-Opus); up to 13% needed reprompting.
The mandatory quote extraction audited faithfulness: median quote
similarity to source text was 99%, though Claude-3-Opus, Claude-2, and
Mixtral sometimes quoted the instruction briefing instead of the paper.

## Assessment

- **Durable:** the placement result — the human gate belongs at
  human–LLM *disagreement*, with agreement as the acceptance signal and
  deferral as the uncertainty channel; the rule that ensemble/collab
  accuracy is meaningless without its deferring fraction; human
  inter-rater reliability as the ceiling predictor (a task humans agree
  on at κ 0.29 cannot be triaged by agreement — deferral swallows it);
  weak models degrade the scheme gracefully into higher deferral rather
  than silent error; mandatory quote extraction as a cheap
  faithfulness audit.
- **Era-bound:** every accuracy number and the model roster (all
  pre-reasoning 2023–24 models, one run per item, single-prompt);
  the cost/speed table; context-length failures; the
  multimodality asymmetry (only Claude-3-Opus saw page images).
- **Weaknesses:** the benchmark is asymmetric — the consensus was
  formed by raters 1 and 2, so human and human+LLM arms are scored
  against a reference the human helped write while LLM-only arms are
  not, which inflates the human−LLM gap (the paper flags the two-rater
  benchmark generally but not this asymmetry); prompts were engineered
  per model, confounding the cross-model ranking (acknowledged);
  train/test contamination is argued away (tabular-only public data),
  not tested; one medical subfield per tool.
- **Caveats:** small internal inconsistencies — Figure 3's caption says
  "all 12 LLM ratings" where Methods specify nine; the prose AMSTAR
  collaboration range "91–95%" omits the human+GPT-3.5 pair, which
  Table 3 rounds to 96% (563/587); and the abstract's deferral ranges
  (25/35% PRISMA, 27/30% AMSTAR) are the two accuracy-endpoint pairs
  only — deferral across all five pairs actually spans 25–41% and
  27–52%. Efficiency remains a hypothesis: item-sparing is measured,
  time-sparing is not.
- **In this library:** the cleanest evidence on where to put a human
  gate in an agent-assisted review pipeline. It argues for
  agreement-gated deferral over both LLM-only ensembles and blanket
  human double-rating — and warns that the design's value is bounded by
  task complexity, measurable in advance via human inter-rater
  reliability on the same instrument.

The result to remember is structural, not a leaderboard: no model
cleared the human bar alone, yet almost every model made a human better
on the tasks humans can themselves agree on — because the collaboration
design converts model weakness into deferral instead of error, and that
conversion fails exactly where human agreement itself fails.
