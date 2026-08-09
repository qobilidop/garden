---
citekey: madeyski2025-llm4screenlit
work:
  title: "LLM4SCREENLIT: Recommendations on Assessing the Performance of Large Language Models for Screening Literature in Systematic Reviews"
  author: "Lech Madeyski, Barbara Kitchenham, Martin Shepperd"
  venue: "Information and Software Technology 198 (2026) 108204"
  date: 2025-11-16  # arXiv v1; version of record IST 2026
  doi: 10.1016/j.infsof.2026.108204
  arxiv: 2511.12635 v2 (2026-04-25, post-acceptance revision — the captured artifact)
sources:
  pdf:
    url: https://arxiv.org/pdf/2511.12635v2
    archived: https://web.archive.org/web/20260809053017/https://arxiv.org/pdf/2511.12635v2
retrieved: 2026-08-08
notes-by: Claude Fable 5 (claude-fable-5)
notes-date: 2026-08-08
synthesis: "Under screening's extreme class imbalance Accuracy rewards rejecting everything and even chance-anchored MCC still picks models that lose half the evidence — so publish the full confusion matrix, headline Lost Evidence, and rank by cost-weighted WMCC with the FN:FP weight declared and justified."
---

# LLM4SCREENLIT: Recommendations on Assessing the Performance of Large Language Models for Screening Literature in Systematic Reviews

Measurement-reform paper from the Kitchenham/Shepperd school of SE
measurement discipline (with Madeyski; IST version of record, 2026) —
a recommendations paper, not a new screening system. Context: LLM
title/abstract screening evaluations are proliferating in SE and
biomedicine, almost all scored with off-the-shelf confusion-matrix
metrics. The paper's move is to derive metric choice from the domain's
four features — extreme class imbalance, asymmetric misclassification
costs (a false negative destroys evidence, a false positive only wastes
effort), limited resources, and the need to show a black-box beats
guessing — then demonstrate, via one motivating benchmark
(Delgado-Chaves et al. 2025, PNAS, "DC+": 18 LLMs x 3 biomedical SRs), a
29-paper practice review, and three SE reanalyses with public replication
data (Felizardo 2024, Syriani 2024, Huotala 2025's SESR-Eval: 9
LLMs x 24 SE secondary studies, 34,528 articles), that standard practice
selects the wrong models. Contributions: the diagnosis; a Weighted MCC
(WMCC) folding FN:FP cost asymmetry into MCC's chance-anchored frame;
ten researcher/practitioner recommendations (R1–R10) split by study type
(benchmarking vs deployment), eight policymaker counterparts
(R1PM–R8PM), a reviewer/editor checklist, a minimum reporting template,
and empirical MCC/WMCC performance terciles. The evidence for the
metric-failure claims is strong (recomputed from primary confusion
matrices, replication package on figshare); the practice review is a
self-acknowledged convenience sample with one extractor. Clearly
organized around two decision trees; dense but navigable.

## Why the standard metrics mislead

The core arithmetic: in DC+'s SR-I (~4,500 articles, ~4% positive),
gemma:7b scores 96.17% Accuracy with TP = 0 — it found *none* of the
relevant studies — and mistral-nemo:12b 96.11%, also TP = 0. Reject-all
is near-Accuracy-optimal under imbalance, and both TP = 0 models get
perfect Specificity. So optimizing Accuracy or Specificity can select
completely ineffectual screeners over models that actually find
positives. Their metric triage:

- **Lost Evidence (1 − Recall)** is the fundamental screening metric,
  because FNs remove evidence from the review, potentially
  irretrievably. Across DC+'s three SRs it ranged 14–100%, with 46 of
  54 LLM x SR classifications missing more than half the positives — a
  headline the original Accuracy-framed report never surfaced.
- **PABAK** is algebraically a centred version of Accuracy (2*Acc − 1),
  so "prevalence-adjusted" is no rescue; they judge it useful in no
  circumstances. Precision, F1, and Specificity are all imbalance-biased.
- **MCC** is the one deployed metric that is chance-anchored (zero =
  random) and imbalance-robust, since it uses all four cells
  symmetrically — but that symmetry is exactly why it cannot price
  FN > FP cost asymmetry.
- **Kappa variants** answer a different question: kappa assumes two
  fallible raters, standard metrics assume a gold standard; using both
  on the same matrix is incoherent.
- Piling on many metrics adds little: all derive from four non-independent
  cells (given P, N, n, and TN you can reconstruct the rest), so report
  the cells themselves plus a few question-mapped metrics.
- **Unclassifiable outputs must not be dropped** (DC+ dropped them). In
  real SRs, hard papers are referred back to humans, i.e. treated as
  positives in the next round; evaluations should count referred-back
  items that way, not shrink N.

## The field as measured

The 29-paper review (28 papers from two prior SRs — Kim, Sandner —
plus the authors' informal search, including 6 SE papers): only 3/29
(10%) report MCC (DC+ and Syriani's two — and Syriani rescales it to
[0,1], inflating apparent performance); only 7/29 (24%) report complete
confusion matrices, with 4 more reconstructible; 22 use Recall but
rarely with any chance-anchored companion; 17 use Accuracy; 4 use
Balanced Accuracy; and none of the five papers claiming workload
savings priced the cost of false negatives — the savings claims count
only avoided TN work and extra FP work. Ten papers acknowledged FN/FP
asymmetry at all, with wildly inconsistent operationalizations (Khraisha:
FN weighted 30x; Wang: mandatory 95% recall floor; Syriani: F2 and
lenient-inclusion prompts; Huotala: 95% recall / ~50% precision target).
Nine good practices (P1–P9) are distilled from the same pool: full
confusion matrices, non-LLM baselines where the design supports them,
metric variability, output consistency, null-outcome reporting,
misclassification analysis, prospective designs, contamination
statements, explicit FN/FP costing — each observed somewhere, none
observed widely (Figure 3's grid is mostly crosses).

## WMCC and the three reanalyses

WMCC = MCC computed on a reweighted matrix: each positive-class item
(TP, FN) counts w times, negatives count 1, then apply the standard MCC
formula. It keeps chance-anchoring and imbalance-robustness while
encoding the cost ratio; the sacrifice is MCC's significance tests.
Choosing w: stakeholder elicitation for deployments; sensitivity
analysis across w as the *primary* result for benchmarks; w = 10 as a
conservative cross-study default. The empirical support for "conservative":
in every observed MCC-vs-WMCC ranking flip, the crossover w is well
below 10 (SESR-Eval median ≈ 2.7, range 1.1–6.4; Syriani RL4SE ≈ 6) —
valuing missed evidence even ~3x over wasted effort already changes
model selection. WMCC is explicitly a complement, not a replacement:
MCC stays for meta-analysis because it is weight-free.

The reanalyses escalate in scale and force:

1. **Felizardo (ESEM'24, ChatGPT-4, two SE SLRs, two Likert
   thresholds):** for SLR2, Accuracy *and MCC* both prefer the stricter
   threshold, which loses 23.6% of evidence vs 13.5%; WMCC flips to the
   inclusive threshold. MCC's chance-anchoring is not enough — its
   FN/FP symmetry picks the wrong operating point. Conversely on SLR1,
   WMCC prefers a threshold with two *more* FNs because eighteen more
   correct exclusions pay for them — cost asymmetry acts through the
   whole matrix, so WMCC is not naive FN-minimization.
2. **Syriani (five SE datasets, ChatGPT vs trained non-LLM
   baselines):** their rescaled MCC[0,1] of 0.638–0.767 reads as
   moderate-to-good; unrescaled it is 0.276–0.534 — modestly above
   chance. On RL4SE, MCC prefers the logistic-regression baseline
   (which loses 40% of evidence) over ChatGPT (18%); WMCC flips it, and
   the flip is robust for any w ≥ 7 and across all ±1 reconstruction
   perturbations (81/81).
3. **SESR-Eval (9 LLMs x 24 SE studies; 183 of 216 cells have defined
   MCC):** Accuracy and MCC disagree on the best LLM in 50% of
   evaluable studies, MCC and WMCC in 55% — the flip is pervasive, and
   WMCC always sides with the lower-Lost-Evidence model. The
   signature 9,695-article study has a three-way split: Accuracy-best
   (Claude 3.7 Sonnet, 94.4%) loses 63.3% of the evidence, MCC-best
   (GPT-4.1 mini, 0.481) loses 43.9%, WMCC-best (GPT-4o, 0.724) loses
   5.8%. And WMCC is not recall-maximization: gpt-4.1-nano's higher
   recall (0.981) buys ~5,900 extra FPs and scores WMCC 0.228 vs
   GPT-4o's 0.724; Ministral 8B's include-everything 100% recall yields
   undefined MCC.

A contamination sensitivity check reruns the analysis on DC+ (different
domains, mostly local open-weight models): MCC/WMCC flips *concentrate*
in the SR published before nearly every tested LLM's training cutoff —
the highest-leakage-risk review. Leakage would erase the asymmetric
error profiles flips require, not produce them, so the flip pattern is a
property of the metrics, not a contamination artifact.

## The recommendations

Two study types anchor applicability: *benchmarking* (retrospective,
"how well do LLMs screen?") vs *deployment* ("should this LLM screen my
SR?" — an operational go/no-go on a validation sample).

- **R1** Standardize on Lost Evidence (Recall), MCC (unrescaled, in
  [−1,1]), and WMCC with the FN:FP cost ratio justified; avoid
  Accuracy/PABAK as primary metrics. [Both]
- **R2** Base comparative conclusions on cost-sensitive analysis (WMCC),
  not Recall-maximization; benchmarks report a sensitivity analysis
  across w as the primary result, w = 10 as a cross-study reference.
  [Both]
- **R3*** Predefine an acceptable Lost Evidence (minimum Recall)
  threshold matched to review type and domain. [Deployment; optional]
- **R4** Publish complete confusion matrices for every model x dataset x
  prompt — the primitive from which everything else (MCC, WMCC,
  cost-benefit, meta-analysis) is recomputable, and which makes
  degenerate cases visible (two SESR-Eval studies with zero excluded
  papers make Precision trivially 1.0 and MCC undefined, silently
  inflating aggregates). [Both]
- **R5** For sample-based validation, report CIs and the estimation
  method; to extrapolate a validation sample to the remaining
  abstracts, use resampling *without replacement* — binomial CIs and
  bootstrapping both assume iid, which abstracts are not. On a full
  retrospective population, per-SR CIs are meaningless. [Conditional]
- **R6** Quantify output consistency and null/invalid outputs (rate,
  suspected cause, handling rule); count referred-back items as
  positives. [Both]
- **R7** Release open artifacts: prompts, seeds, code, data. [Both]
- **R8** Prevent train–test overlap: prospective designs, or documented
  temporal/contamination safeguards plus an explicit leakage statement.
  Only 1 of 29 reviewed papers (Tran) verified post-cutoff data. [Both]
- **R9** Non-LLM baselines when the study aims to inform SR practice
  and labels exist for training; pure LLM-vs-LLM or prompt comparisons
  don't need them. [Conditional, optional]
- **R10** If observed Lost Evidence exceeds the predefined threshold,
  escalate to human review or revise prompts/models. [Deployment]

The deployment decision rule composes these: predefine the threshold
(R3); validate on a random sample with resampling-based CIs (R5);
deploy only processes whose Lost Evidence is acceptable at the CI bound
*and* whose MCC 95% lower bound clears zero (a genuine-prediction
check); rank survivors by WMCC; if nothing passes and prompts can't be
refined, humans screen. (§4.1's "Lost Evidence... Lower Confidence
interval >0.8" example only parses as a Recall lower bound — i.e. Lost
Evidence under 20% — which the Figure 6 decision tree confirms:
Lost Evidence > threshold → escalate.)

The policymaker mirror (R1PM–R8PM) turns each into a venue requirement
(require confusion matrices as supplementary material at submission;
reject accuracy/PABAK-only submissions; require a w declaration — w = 1
acceptable only with justification; require leakage statements and
replication URLs; encourage pre-registered thresholds), backed by a
PRISMA/SEGRESS-style author checklist and a minimum reporting template
(one row per model x prompt x SR: TP/FP/FN/TN, Recall, Lost Evidence,
MCC, WMCC, Null%, CI). For calibration, terciles over the 183 evaluable
SESR-Eval configurations: MCC small < 0.21 / medium 0.21–0.38 / large
> 0.38; WMCC(w=10) < 0.19 / 0.19–0.42 / > 0.42 — explicitly a 2025
snapshot, not fixed thresholds; ~8% of configurations were below
chance. Extension to full-text screening (still binary: transfers
directly) and data extraction (needs per-field analogues; MCC
generalizes multi-class via Gorodkin, WMCC via a K x K cost matrix) is
argued as principled but rests on two and one non-SE studies
respectively — hypotheses, not validated results.

## Assessment

- **Durable:** deriving metrics from domain structure (imbalance +
  asymmetric costs + chance-anchoring) rather than convention; the
  confusion matrix as the reporting primitive everything else is
  recomputable from; Lost Evidence as the headline screening number;
  the demonstrated insufficiency of chance-anchoring alone — MCC picks
  evidence-losing models in half the studied cases; the
  benchmarking/deployment split with pre-registered thresholds and
  escalation; count-the-unclassifiable-as-positive; the
  leakage-erases-asymmetry argument form for separating metric
  properties from contamination artifacts.
- **Era-bound:** every specific number (Lost Evidence ranges, flip
  rates, the Table 5 three-way split); the model roster; the Table 7
  terciles (authors' own "2025 snapshot" label); the checklist's
  figshare artifacts; arguably the binary include/exclude prompt regime
  that makes single-operating-point metrics the norm — confidence-scored
  outputs would shift evaluation toward Lost Evidence–workload curves,
  which the paper acknowledges.
- **Weaknesses:** the 29-paper review is a convenience sample with
  single-researcher extraction (both self-acknowledged), so adoption
  percentages are indicative, not estimates; w = 10 has "no independent
  rationale" beyond the crossover analysis — the sensitivity evidence
  shows rankings flip *by* w≈7, not that 10 is right, and eliciting
  real FN:FP costs remains open; parts of the Syriani reanalysis rest
  on approximated (±1) and synthetic CV-averaged confusion matrices —
  handled candidly, but the RL4SE flip is by their own labeling
  illustrative; WMCC surrenders MCC's significance testing; the §4.1
  ">0.8" wording slip (above) survives into the revision; later-stage
  extension is argument, not evidence.
- **In this library:** the measurement-reform anchor of
  [[agent-assisted-evidence-synthesis]] — and a rubric this repo's own
  survey screening should be scored against: keep per-decision
  include/exclude counts so a full confusion matrix is reconstructible
  (R4), report Lost Evidence against the abstract-level catalog rather
  than any accuracy-flavored agreement number (R1), treat
  can't-classify items as referred-back positives (R6), state the
  contamination exposure of screening with an LLM whose training data
  includes the surveyed literature (R8), and declare an FN:FP stance
  explicitly instead of inheriting one from a metric (R2).

The lasting lesson generalizes past screening: when classes are
imbalanced and error costs are asymmetric, any single scalar silently
encodes a cost model — this paper's discipline is to publish the raw
cells, name the weight, and show your ranking survives varying it.
