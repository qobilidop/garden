# RQ4 — Ensembles work for recall, agreement-gating for precision; "independent agent reviewers" remains undefined

## The direct evidence, all of it

RQ4 evidence is the map's scarcest class — four designed data points and
one negative case:

- **Cross-family OR-ensemble (fagerberg2025):** GPT-5 Thinking + Gemini
  2.5 Pro, union rule, 736 Cochrane citations: 99.7% sensitivity (GUI) /
  99.1% (API) at 49.3% specificity, against individual-model sensitivity
  of 86–88% (GPT-5) and 94–98% (Gemini). The mechanism argument is the
  valuable part: complementary error profiles (Gemini sensitive, GPT
  specific) and a concrete blind-spot catch — GPT-5 failed one review's
  vaccine-subgroup criterion at 43% sensitivity while Gemini flagged the
  same records for full-text. Family diversity caught what redundancy
  within a family would not.
- **Consistency-vote vs deferral (woelfle2024):** a 9-run LLM consistency
  ensemble reached human-level appraisal accuracy only on the small
  fraction of items surviving 9/9 agreement (74–88% deferred). The
  human+single-LLM *deferral* design — score where they agree, send
  disagreements to a second human — beat both humans-alone and
  LLM-ensembles: 95–96% accuracy while sparing ~65–70% of second-reviewer
  workload on PRISMA/AMSTAR. Agreement-gating, not voting, is the
  evidence-backed pattern.
- **Open-vs-proprietary patterns (safarpour2026, abstract-only):** Mistral
  and Llama screen "more conservatively" than GPT-4.1 across 25k titles —
  a family-diversity signal awaiting full-text numbers.
- **Self-consistency ≠ correctness (syriani2023):** GPT-3.5's run-to-run
  Fleiss κ of 0.82–0.97 (far above traditional classifiers) coexists with
  mediocre accuracy on hard corpora — high self-agreement is a stability
  property, not a validity one.
- **The negative case (huang2026):** the best-performing end-to-end system
  uses no redundancy at all — one model per stage, reliability from
  decomposition and human-inspectable artifacts. Independence mechanisms
  are not (yet) how the strongest pipelines buy their reliability.

## The undefined middle

No source defines what makes two agent passes *independent* in the sense
dual human review requires: different prompts? different tiers? different
vendors? different training corpora? The correlated-error question —
shared training data producing shared blind spots — is unmeasured
everywhere; fagerberg2025's vaccine-subgroup case is the closest thing to
evidence that vendor diversity decorrelates errors. hamel2021 shows the
pre-LLM guidance thought carefully about *human* reviewer independence
(compatibility, conflict schedules) and simply has no agent analogue.

## This campaign as a data point

Our own dual-pass screening (haiku criteria-framed vs sonnet RQ-framed,
same vendor) produced binary κ=0.937 over 417 candidates — but the
facet-classification stage showed judgment-heavy fields (rq_core) varying
7–40 per 56-row batch across same-tier agents. Both observations match
the literature: high same-family agreement on bounded binary tasks
(syriani2023), degradation on judgment-graded tasks (woelfle2024's
complexity gradient). What this campaign could not measure — and what v2
should — is a cross-vendor pass (the mirrored Codex config exists for
exactly this) with disagreement analyzed by error type, which would be
among the first designed cross-family independence measurements in the
literature this survey mapped.
