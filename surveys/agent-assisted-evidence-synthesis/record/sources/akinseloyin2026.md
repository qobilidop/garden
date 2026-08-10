---
citekey: akinseloyin2026
work:
  title: "Large language model-based multiagent collaboration for abstract screening toward automated systematic reviews"
  author: "Opeoluwa Akinseloyin, Xiaorui Jiang, Vasile Palade"
  venue: "Biology Methods and Protocols"
  date: 2026
  doi: 10.1093/biomethods/bpag006
read: full-text
source: "https://academic.oup.com/biomethods/article/doi/10.1093/biomethods/bpag006/8460762 (Oxford Academic, gold OA)"
facets:
  stage: "screen"
  contribution: "method"
  evidence: "human-agree"
  setting: "med"
retrieved: 2026-08-09
notes-by: "Claude Sonnet 5"
notes-date: 2026-08-09
synthesis: "The set's only deep read that measures an inter-agent correlation statistic and names model heterogeneity as the causal driver of ensemble gains — but the three agents are confounded on vendor, size, and training data at once, so nothing isolates which factor produced the measured decorrelation"
---

# Large language model-based multiagent collaboration for abstract screening toward automated systematic reviews

## Evidence
- Four models total. Three primary agents independently answer PICO-style inclusion-criteria QA prompts on each abstract: GPT-4o Mini (gpt-4o-mini-2024-07-18), Claude 3 Haiku (claude-3-haiku-20240307), Gemini 1.5 Flash (gemini-1.5-flash-preview-0514). A fourth, separate and more powerful model — Gemini 1.5 Pro (gemini-1.5-pro-preview-0514) — serves only as adjudicator in the adjudication strategy.
- Three collaboration strategies compared, all mechanically resolved (no human escalation in any):
  - **Soft-Vote**: parallel independent QA; ensemble score = "the average of the scores for each primary model." No agent-to-agent interaction.
  - **Multiagent Debate (MAD)**: one refinement round — "each agent is presented with the answers and reasoning of other agents for the same question on an abstract, and is prompted to reconsider its initial answer"; ties broken by the debating agent's confidence value.
  - **Adjudication**: primary agents answer in parallel, then Gemini 1.5 Pro either picks a single best answer (Adj-Judge) or grades each primary answer's quality and computes a quality-weighted average (Adj-Rank).
- **Independence/diversity is measured, not just asserted.** The paper reports Spearman rank correlations directly between the three primary agents' QA scores: "moderate correlations between the QA models (Spearman's rank correlations: 0.48–0.56 on DTA and 0.49–0.52 on intervention)." Soft-Vote's own score correlates 0.71–0.86 (DTA) / 0.68–0.87 (Intervention) with each individual model. Under MAD, the same statistic is tracked again and rises: "correlations among the three debating models have become much stronger than the correlations among the QA models" — i.e., the one-round debate measurably erodes the inter-agent diversity the paper credits for ensemble gains.
- **Verbatim causal claim** (Conclusion): "Analysis demonstrated the core role of model diversity (i.e. model heterogeneity) on the success of aggregating relatively weaker screening models." Results/Discussion: "Model diversity plays a central role in ensemble performance... benefits from a 'healthy' inter-model disagreement (i.e. model heterogeneity), enabling it to balance strengths and mitigate weaknesses."
- **No same-family control arm.** The three primary agents differ simultaneously in vendor, model family, parameter scale, and training data/cutoff. Nothing in the design varies one of these factors while holding the others fixed (e.g., three same-vendor models with different prompts, or three runs of one model with different seeds, as a decorrelation baseline), so the 0.48–0.56 correlation range cannot be attributed to any one of those confounded factors.
- **Adjudicator same-family bias, acknowledged but not corrected**: "This potential bias is a critical consideration... This is also reflected by the fact that the correlations between Gemini and the adjudicator[s] is often stronger" — the Gemini 1.5 Pro adjudicator shows elevated agreement specifically with the Gemini 1.5 Flash primary agent, a same-vendor correlation effect that the adjudication strategies do not correct for.
- Dataset: CLEF eHealth 2019 Task 2 (TAR2019) — 28 Cochrane systematic reviews: 20 clinical-intervention reviews (39,792 documents) + 8 diagnostic-technology-assessment (DTA) reviews (26,830 documents); 66,622 documents total; inclusion rate 0.2%–36.1% (mean 5.8%). Gold labels are the Cochrane reviews' own inclusion decisions (the standard TAR2019 reference standard). Titles concatenated with abstracts; ~2–3% title-only records.
- Metrics: MAP, Recall@k% (top-k% of ranked documents), LRel (rank of last relevant document), WSS@R% (work saved over sampling at recall level R). Soft-Vote (best overall) — DTA: MAP 0.341±0.166, R@10% 64.67%±28.37, WSS@95% 0.680±0.228, WSS@100% 0.667±0.266; Intervention: MAP 0.462±0.262, R@10% 66.71%±25.78, WSS@95% 0.606±0.219, WSS@100% 0.527±0.270. Individual-agent baselines (DTA MAP): GPT 0.271, Gemini 0.266, Haiku 0.182 — Soft-Vote (0.341) beats the best individual agent (Gemini) by +25.5%. Paired t-test and Wilcoxon signed-rank: Soft-Vote significantly beats all baselines (P < .001 MAP, P < .01 WSS@95%). MAD: Haiku-MAD MAP 0.286 (+57.1% vs Haiku alone 0.182); GPT-MAD and Gemini-MAD show modest/mixed gains. Adjudication (DTA): Adj-Rank MAP 0.345 (≈Soft-Vote), Adj-Judge MAP 0.284. Re-ranking add-on: Soft-Vote+rerank DTA MAP 0.360 (+5.6%), WSS@95% 0.708.
- Cost/runtime (DTA, 26,830 docs): GPT-4o Mini alone $11.08/100.6h; Gemini 1.5 Flash alone $5.44/39.32h; Claude 3 Haiku alone $27.90/62.5h; Soft-Vote (3 models) $44.43/202.42h; MAD (Haiku debating) $90.31/280.26h; MAD-Soft-Vote $211.84/462.24h; Adjudication (Gemini 1.5 Pro) $653.15/906.32h. Soft-Vote costs <1/14 of adjudication and is estimated at ~1/186 of a human reviewer's cost (British academic salary-scale estimate). Intervention (39,792 docs): Soft-Vote $66.21/299.8h; Adjudication $959.90/1342.8h.
- Authors' own limitation: evaluation "confined to the biomedical TAR2019 benchmark"; generalization "to other domains such as social sciences, environmental studies, education research, or humanities... remains to be validated," and structured IMRAD biomedical-abstract format is flagged as possibly making these abstracts unusually amenable to LLM classification in a way that won't transfer.

## Bearing on RQs
Directly targets RQ4 (multi-agent/ensemble design) and is a materially different data point than the other two ensemble deep reads: it is the only selected evidence record that reports a quantitative inter-agent correlation statistic (Spearman rank correlation among the three agents' QA scores, 0.48–0.56/0.49–0.52) and an explicit causal attribution — quoted verbatim in its Conclusion — of ensemble success to "model diversity (i.e. model heterogeneity)." fagerberg2025 and woelfle2024 report configurations and aggregate performance with no comparable correlation figure between constituent members. But the measurement here is observational, taken across three simultaneously-varying agents (vendor, size, training data all differ at once) — nothing isolates which of those factors produced the observed decorrelation, and the paper's own MAD result (debate raises accuracy modestly for some models while measurably raising inter-agent correlation, i.e., reducing the very diversity the paper credits) is offered as the explanation for why MAD underperforms Soft-Vote. This sharpens rather than resolves the reviewer-independence synthesis: it is evidence that at least one deep-read author operationalizes "diversity" as a measurable, trackable quantity and links it causally to ensemble success in prose, without ever running the matched/same-family ablation that would let the claim support a general independence criterion. Also bears on RQ2 (metrics): reports MAP/Recall@k/WSS/LRel, a TAR-style metrics stack distinct from the sensitivity/specificity/κ vocabulary used by the medicine-domain screening papers in this set.

## Evidence limits
- Single benchmark (CLEF eHealth 2019 TAR2019, 28 Cochrane reviews), biomedical domain only; authors explicitly flag generalization to other domains as unvalidated.
- Reference standard is the benchmark's original Cochrane inclusion decisions, not independently re-adjudicated by these authors.
- The three primary agents are confounded on vendor, model family, parameter scale, and training data/cutoff simultaneously; no same-family or matched-model control arm exists to isolate which of these produced the measured 0.48–0.56 correlation range.
- The Spearman-correlation analysis is a post hoc observational statistic on decision scores, not a designed independence experiment, and the paper offers no formal threshold or criterion for when two agents count as "independent enough."
- The adjudicator (Gemini 1.5 Pro) shares vendor family with one of the three primary agents (Gemini 1.5 Flash); the paper's own noted elevated Gemini–adjudicator correlation is a same-family confound specific to the adjudication strategies, acknowledged in text but not corrected for.
- ~2–3% of records were processed title-only; this subset's performance is not separately reported.
- Cost/runtime figures reflect 2024-generation model API pricing and are provider- and time-specific.
