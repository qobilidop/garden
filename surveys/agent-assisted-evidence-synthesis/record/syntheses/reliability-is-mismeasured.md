# Reliability is real but mismeasured

Status: current through the 2026-08-09 update batch.

## Current conclusion

Three claims survive cross-reading of the selected evidence. (1)
Screening performance is heterogeneous, and the heterogeneity is
dominated by the dataset/review, not the model: in the one systematic
SE benchmark, study effects exceed differences among the larger tested
models. (2) The field's common metrics misstate performance under the
class imbalance that defines screening: accuracy-style reporting can
crown a model that loses most of the relevant evidence. (3) The right
comparator is the imperfect human baseline (single-reviewer screening
sensitivity ~87–92%, human extraction errors reported up to 50% — both
secondhand estimates), not an idealized perfect reviewer; against that
baseline the strongest configurations are competitive, but no selected
single-model result meets a stated deployment bar.

The 2026-08-09 update sharpens claim (2) and constrains what the map's
evidence labels are worth. hirt2021 is the sharpest demonstration of
metric-dependent reliability the set contains: one tool, one
comparison, one corpus, and a verdict ranging from moderate agreement
to near-chance depending only on which risk-of-bias domain and which
metric is reported — no model comparison involved, so nothing but the
measurement choice produces the swing. rose2025 constrains the map
itself: it is a study protocol with zero results whose catalog row is
coded `evidence=human-agree` for a comparison that has not been
performed. The appraisal stage grew this batch (25 → 33 rows) without
its evidence base growing at all; arno2022 remains the only RCT-grade
appraisal-automation study in the selected set, exactly as before.

## Strongest supporting results

- **Metric choice changes rankings.** madeyski2025 (29-paper
  convenience sample, single-extractor): 7/29 (24%) report complete
  confusion matrices, 3/29 (10%) report MCC, 17/29 (59%) use accuracy;
  none of 5 workload-savings papers priced false-negative cost. In one
  9,695-article reanalysis the accuracy-best, MCC-best, and WMCC-best
  models are three different LLMs, losing 63.3%, 43.9%, and 5.8% of
  relevant evidence respectively. On SESR-Eval data, MCC and WMCC
  disagree on the best LLM in 55% of evaluable studies.
- **Stratum and metric change the verdict with no model comparison at
  all.** hirt2021 (abstract-only; Wiley paywall, Europe PMC
  `isOpenAccess:N`) compares RobotReviewer against the human Cochrane
  risk-of-bias judgments already recorded for 190 nursing RCTs
  (1958–2016) drawn from 23 `nurs*`-titled Cochrane reviews — a
  retrospective diagnostic-accuracy design, not an RCT. Cohen's κ by
  domain: allocation concealment 0.60, random sequence generation
  0.52, blinding of personnel/participants 0.43, blinding of outcome
  assessors 0.04 — moderate down to chance. Across domains sensitivity
  spans 0.44–0.88, specificity 0.48–0.95, PPV 0.25–0.79. Every one of
  those numbers describes the same tool on the same corpus. This is
  the survey's "measured heterogeneously" thesis in its purest form:
  where madeyski2025 shows metric choice reordering *different
  models*, hirt2021 shows metric-and-stratum choice reversing the
  verdict on *one* model, which is the harder case to dismiss because
  there is no model ranking to blame it on. It also shows what
  aggregation costs: a single overall accuracy figure of the kind
  arno2022 reports (88.8% vs 90.2%) would have absorbed a
  chance-level domain without trace. Caveats: abstract-only, so the
  full methods (per-domain sample sizes, handling of missing
  judgments) were not read; a single-specialty convenience sample the
  authors themselves flag as novel-population rather than
  general-medicine; and RobotReviewer is a pre-LLM fine-tuned
  classifier, so this bounds a baseline rather than an agent.
- **Aggregation choice changes rankings too.** huotala2025 reports
  results at pooled primary-study level and per-review level and the
  best model differs between them (GPT-4.1 mini best pooled accuracy,
  Llama 4 Maverick best per-review) — same data, different comparison.
- **Study effect > model effect.** huotala2025 (34,528 labeled
  records, 24 SE reviews, 9 models): per-review accuracy ranges
  0.34–0.85 and F1 0.07–0.92 — wider than the spread across the seven
  larger models; logistic-regression study odds ratios range far wider
  than model odds ratios. No nondegenerate operating point met the
  authors' bar of recall ≥ 0.95 at precision ≈ 0.50.
- **Model capability moves specificity more than sensitivity.**
  oami2025 (five sepsis questions, 0.24% positive rate, one fixed
  sensitivity-optimized prompt): GPT-3.5→GPT-4 Turbo left sensitivity
  statistically unchanged (0.83 → 0.85) while specificity rose 0.51 →
  0.98 (significant). Under extreme imbalance that specificity move is
  the workload story, yet absolute FP/FN counts were not reported.
- **Prompt sensitivity is real but poorly quantified.** gargari2023
  (single review, N=330, letter format): eight prompt variants moved
  GPT-3.5 from 62% sensitivity (prompt 1) to a level the authors
  compare with a junior reviewer (prompt 5) — but most per-prompt
  numbers are directional prose in an unverified supplement, with no
  significance testing and possible order effects.
- **Corpus character predicts failure.** syriani2023: recall 0.327 on
  the one corpus with 52.7% recorded human conflict (MobileMDE) vs
  0.738–0.947 on the other four; only balanced accuracy generalized
  across the five corpora (mean 70.3%). The conflict–recall
  association is observational, not causal.
- **Appraisal is harder than screening for both humans and models.**
  woelfle2024: every individual LLM scored below every individual
  human on all three instruments, and human inter-rater κ itself fell
  from 0.84 (PRISMA) to 0.29 (PRECIS-2) — the reference standard
  degrades exactly where the models do.

## Ensemble gains arrive in incommensurable metric vocabularies

The batch adds two ensemble performance results. Both are real gains
over their own best constituent; neither is expressible in the
sensitivity/specificity/κ vocabulary the rest of this synthesis uses,
which is itself the point. (Their bearing on independence and
diversity is held in `independence-undefined.md`; here they are
measurement evidence only.)

- **akinseloyin2026** (peer-reviewed, gold OA): three cross-vendor
  agents (GPT-4o Mini, Claude 3 Haiku, Gemini 1.5 Flash) answer
  inclusion-criteria questions independently; Soft-Vote averages their
  scores. On the DTA half of CLEF eHealth 2019 TAR2019, Soft-Vote
  reaches MAP 0.341 ± 0.166 against constituents at 0.271, 0.266, and
  0.182 — +25.5% over the best single agent — with WSS@95% 0.680 ±
  0.228. Significance by paired t-test and Wilcoxon signed-rank
  (P < .001 for MAP, P < .01 for WSS@95%). The metrics are
  rank-based, not threshold-based: MAP is mean average precision over
  a ranked document list, and WSS@95% is work saved over random
  sampling at 95% recall — a screening-effort measure that presumes an
  operating point defined by recall rather than a decision rule. There
  is no confusion matrix to compare against oami2025 or huotala2025,
  and none is derivable from what is reported. Reference standard is
  the benchmark's original Cochrane inclusion decisions, not
  re-adjudicated; biomedical only, with the authors flagging IMRAD
  abstract structure as a possible reason the results will not
  transfer; 2–3% of records were processed title-only and not
  separately reported.
- **knafou2023** (peer-reviewed, *Systematic Reviews*): five
  BERT-family classifiers differing only in pretraining corpus and (for
  one) parameter count, combined by probability sum. Binary
  ORIGINAL/NON-ORIGINAL class-level F1 89.16% for the ensemble against
  88.53% for the best standalone member (PubMedBERT), significant by
  McNemar — a 0.63-point gain. AUC-ROC 94.33 (93.70–94.88) against the
  best standalone's 91.77 (90.95–92.50), non-overlapping CIs. Single
  dataset (COVID-19 COAP living-evidence database, 6,365 publications
  labeled Jan–Dec 2020), titles and abstracts only, reference labels
  from a single crowdsourced annotation team with no described dual
  coding or adjudication.

Read as measurement evidence, the pair is a caution rather than a
result. "Ensembling helps" is supported in both, but the two effect
sizes — +25.5% relative MAP and +0.63 F1 points — are not on a common
scale, not on a common task, and not on a common label standard, so
they cannot be pooled, ranked, or averaged into a field-level estimate
of what ensembling buys. This is madeyski2025's complaint reproduced
one level up: the heterogeneity is now across metric *families*, not
just metric choices within a family.

## Accuracy bought with deferred coverage, now twice

knafou2023's voting variants trace the trade explicitly at the class
level: plain majority vote reaches roughly 93% F1 while deciding 100%
of the corpus; static unanimity (5 of 5 models agreeing) reaches
about 97% F1 on roughly 80%; unanimity plus a 0.99 per-vote
probability threshold reaches about 98.5% F1 and about 99% recall
while deciding only about half. Near-perfect screening is available at
the cost of routing half the corpus to a human.

That is structurally the same trade woelfle2024 reports at the
appraisal stage, where a 9-run consistency-gated LLM ensemble reaches
human-level accuracy only on the items surviving near-unanimous
agreement, deferring 74–88%. Two instances now, and they differ in
almost everything that would make one a replication of the other:
different stage (screening triage vs appraisal), different technology
(fine-tuned BERT classifiers vs prompted LLM chat agents), different
gate (vote unanimity plus probability threshold vs run-to-run
consistency), different era. What survives the difference is the
shape — accuracy is purchased with coverage, and a headline accuracy
figure quoted without its coverage denominator is uninterpretable.
Neither study measures the human cost of the deferred remainder, and
knafou2023's proposed 50%-workload-reduction workflow is explicitly a
projection, not a measured result.

## Limiting results and counter-evidence

- The pooled picture can look far rosier than the per-study picture:
  song2026's living-evidence review pools recall across 9 primary
  studies to a 96.24% mean (F1 mean 92.17%, n=6) — but these are
  unadjusted simple means over heterogeneous tools and denominators
  (precision ranged 0.2–100%), explicitly without meta-analysis. Cite
  as a secondhand aggregate, never as a field-level performance claim.
- Extraction evidence in the selected set is thin: one SE
  proof-of-concept at 87.83% accuracy (felizardo2024, abstract-only,
  single mapping study, no metric breakdown), a 23-study
  social-science inventory with no pooled benchmark and zero found
  real-review applications (legate2024), and secondhand error ranges
  of 4–31% (median 14%) relayed by gartlehner2025 from Clark et al.
- The one RCT-grade result is deflationary: arno2022 (abstract-only,
  pre-LLM RobotReviewer, 7 of 15 recruited teams completed) found
  ML-assisted risk-of-bias assessment noninferior (88.8% vs 90.2%),
  with inconclusive ~1.4-minute time savings — an equivalence result,
  not an efficiency demonstration. It is still the only one. The
  2026-08-09 batch added appraisal-stage rows (25 → 33) and two
  appraisal deep reads, and neither changes this: hirt2021 is a
  retrospective diagnostic-accuracy comparison against archival
  judgments, read at abstract level; rose2025 has no results to add.
- **A protocol counted as evidence.** rose2025 (BMC Med Res Methodol,
  peer-reviewed, read in full via PMC) is a *study protocol*, written
  entirely in future tense, reporting zero empirical numbers — no
  agreement percentage, no κ, no discordance count. Its planned
  design is well specified (75 Cochrane RCTs for analysis after 25 for
  prompt engineering, ≥90% power, ChatGPT judged against
  consensus-based overall RoB from the original review teams), and
  that is all it currently supplies. Two consequences. First, any
  future citation of this work for an agreement figure would be an
  error; the results, if they appear, will be a separate paper this
  survey does not have. Second, its catalog row is coded
  `evidence=human-agree`, which describes the planned comparison
  rather than an executed one — the note discloses the disagreement
  and the abstract-level map is left as coded per `../protocol.md`.
  This is the first demonstrated instance of that label attaching to a
  comparison that has not happened, and it is what the label's scope
  condition below now has to say. Note also a design limit relevant to
  hirt2021: rose2025 assesses *overall* RoB in three categories, so by
  construction it could not surface the domain-specific near-chance
  agreement hirt2021 found, whatever it eventually reports.
- Contamination is almost never checked: 1 of madeyski2025's 29 papers
  did; public-benchmark reuse leaves training-data leakage open across
  most of the selected evidence.

## A live metric disagreement

oami2025's authors argue specificity is the deciding metric when
sensitivities are comparable (it governs downstream workload).
madeyski2025 flags specificity as misleading under imbalance (a
degenerate exclude-everything model scores perfect specificity) and
builds WMCC to price the same trade-off inside a chance-anchored
metric. These are not reconcilable by scope alone: they are competing
prescriptions for the same decision, and the survey should present
them as such. (The positions do agree that sensitivity/recall alone is
insufficient.)

Note also a structural echo: huotala2025's own primary metrics
(accuracy/precision/recall/F1) are among those madeyski2025 deprecates
— and madeyski2025's reanalysis of SESR-Eval is the demonstration.
The benchmark and the metrics critique are entangled: the same data
underlies both, so their agreement is not independent confirmation.

## Scope conditions

- All screening thresholds and most corpora are medicine-calibrated;
  SE evidence is one benchmark (huotala2025), one early GPT-3.5 study
  (syriani2023), and abstract-only items.
- madeyski2025's 29-paper pool is a convenience sample with
  single-researcher extraction; its terciles (MCC small <0.21, etc.)
  are calibration references from SE data, not standards.
- Evidence-label counts in the map (recomputed 2026-08-09 from
  `../catalog.tsv`: 303 human-agree, 158 benchmark, 315 none, of 776
  include-level rows) record *claimed or planned* comparison type, not
  quality. rose2025 is the demonstrated case: a protocol with no
  results carries `human-agree`. No formal appraisal was done, and the
  labels are single-pass abstract coding.
- The batch moved the evidence mix in the unhelpful direction:
  `benchmark` grew 3.9% (152 → 158) while `none` grew 28.6%
  (245 → 315), so 40.6% of include-level rows now record no
  comparison at all, up from 37.9%. That reflects what the new
  genre-gap queries surfaced (position, guidance, meta-literature),
  not a decline in evaluation practice — but it does mean corpus
  growth is not evidence growth.
- gargari2023 and oami2025 are letter-format publications; several
  key numbers live in unverified supplements.
- The two ensemble results (akinseloyin2026, knafou2023) are each
  single-benchmark and single-domain, with authors in both cases
  flagging generalization as untested.

## Consequences for the manuscript

The manuscript's RQ2 section carries the load-bearing numbers with
their caveats and this synthesis confirms each against its note. The
three claims in the conclusion are unchanged; the update supplies a
better witness for claim (2) and one correction to the map figures.
Required edits to 06-rq2.typ:

1. Opening sentence: "labels 249 of 646 works `human-agree` and 152
   `benchmark`" → "303 of 776 `human-agree` and 158 `benchmark`",
   matching the rebuilt `@tab-map` (see
   `screening-still-dominates.md` for the full recomputed table).
2. The same sentence's qualifier must strengthen from "record
   comparison type, not risk-of-bias or certainty" to record a
   *claimed or planned* comparison, citing rose2025 as the
   demonstrated case of a protocol carrying `human-agree`.
3. *Measurement practice* paragraph: add hirt2021 as the within-study
   demonstration. It is the strongest single example the survey has of
   metric choice changing the reliability verdict, it is
   RobotReviewer-on-Cochrane so it pairs directly with the arno2022
   sentence already in *Read against human baselines*, and the pairing
   makes the point the manuscript currently only asserts — that an
   aggregate accuracy figure hides a chance-level stratum. Minimum
   printable form: κ 0.60 / 0.52 / 0.43 / 0.04 across four RoB
   domains on 190 nursing RCTs, `[abstract-only]`.
4. *What individual studies show*: the appraisal sentence should say
   arno2022 remains the only RCT-grade appraisal-automation study
   *after* this update, and name rose2025 as a protocol whose results
   do not yet exist. Do not cite rose2025 for any number.
5. If RQ2 prints the ensemble results at all, print each with its
   metric family attached (akinseloyin2026: MAP 0.341 vs best
   constituent 0.271 and WSS@95% 0.680, rank-based, no confusion
   matrix; knafou2023: F1 89.16% vs 88.53%, McNemar-significant) and
   do not place them on a shared scale.
6. knafou2023's coverage/accuracy trade should join woelfle2024's
   wherever the manuscript states the deferral finding, so that the
   pattern is presented as two instances across stage and technology
   rather than one appraisal-stage result.

Two things still held here but compressed there: the
specificity-vs-WMCC prescription conflict (the manuscript reports both
works without staging the disagreement), and the entanglement of
SESR-Eval with the madeyski2025 critique.

## What would change this

- Full text of safarpour2026 (25,149-title open-vs-proprietary
  comparison; abstract promises numbers it withholds).
- Full text of hirt2021 — currently the synthesis's strongest
  metric-dependence witness is read at abstract level only, which is a
  poor place for a load-bearing result to sit. The paywall is at the
  Wiley/Sigma Theta Tau host; no OA route beyond Europe PMC's flag has
  been tried.
- Publication of rose2025's results, which would be the second
  RCT-adjacent appraisal-automation data point and the first
  LLM-based one — though its overall-RoB design cannot test the
  domain-level failure hirt2021 found.
- Any prospective deployment study reporting complete confusion
  matrices at a pre-registered operating point — the evidence class
  madeyski2025 calls for and the selected set lacks entirely. The two
  ensemble works added this batch do not supply it; akinseloyin2026's
  rank-based stack cannot be converted into one.
- Independent validation (or refutation) of WMCC and its w=10 default
  outside the SESR-Eval data used to justify it.
- A screening study with contamination controls showing materially
  different results, which would undercut the retrospective corpus
  wholesale.
- An appraisal-stage study with a stronger reference standard than
  two-rater consensus (woelfle2024's own stated limit) — hirt2021
  inherits the same weakness in a different form, since its reference
  standard is the archival judgment of the original Cochrane teams.
- A deferral study that measures the cost of the deferred remainder.
  Both instances of the accuracy-for-coverage trade report the
  coverage they give up and neither reports what handling it costs.
