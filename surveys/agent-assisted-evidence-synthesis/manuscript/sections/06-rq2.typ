= RQ2 — Reliability: common labels, heterogeneous evidence <sec-rq2>

The abstract-coded map labels 303 of 776 works `human-agree` and 158
`benchmark` (@tab-map). These labels record the comparison a work
*claims or plans*, not one verified to have been performed: one deep
read coded `human-agree` turns out to be a protocol whose comparison
has not yet been run @rose2025. They record comparison type, not
risk-of-bias or certainty, and the survey performed no formal quality
appraisal. The deep reads support narrower claims about measurement
practice and generalization.

*Measurement practice in the selected evidence.* Madeyski et al.'s
convenience sample of 29 LLM-screening evaluations found 24% reporting
complete confusion matrices, 10% reporting the Matthews correlation
coefficient (MCC), and 59% reporting accuracy. In one 9,695-record
reanalysis, the accuracy-best model lost 63.3% of relevant evidence
where the authors' cost-weighted choice lost 5.8% @madeyski2025. Within
SESR-Eval, pooled versus per-review aggregation also changed model
comparisons on the same data @huotala2025. The starkest demonstration
needs no model comparison at all: assessing 190 nursing trials with one
tool against Cochrane judgments, Hirt et al. report Cohen's κ of 0.60
for allocation concealment, 0.52 for randomization, 0.43 for blinding
of personnel, and 0.04 — near chance — for blinding of outcome
assessors, alongside sensitivity spanning 0.44–0.88 and positive
predictive value 0.25–0.79 @hirt2021[abstract-only]. Which stratum and
which metric a study reports can therefore move the verdict from
near-chance to moderate agreement within a single tool and corpus.

*What individual studies show.* In SESR-Eval, no nondegenerate operating
point among nine tested models across 24 SE reviews met the authors'
proposed bar of recall ≥ 0.95 at precision about 0.50 @huotala2025. In
one Gargari et al. review, prompt variants moved GPT-3.5 sensitivity
from 62% to a level the authors compared with a junior reviewer
@gargari2023. Across five highly imbalanced sepsis questions under one
prompt, Oami et al. found GPT-4 Turbo specificity of 0.98 versus 0.51
for GPT-3.5, while sensitivity changed from 0.83 to 0.85 without a
significant difference @oami2025. Within SESR-Eval, study effects
exceeded differences among the larger tested models @huotala2025. In
Syriani et al.'s high-conflict MobileMDE corpus (52.7% recorded human
conflict), recall was 0.327 versus 0.738–0.947 in the other four
corpora; the association does not establish conflict as the cause
@syriani2023. Across Woelfle et al.'s three appraisal instruments, each
individual LLM scored below each individual human and human inter-rater
κ ranged from 0.84 to 0.29 @woelfle2024. Among the selected extraction
deep reads are an SE proof-of-concept reporting 87.8% accuracy
@felizardo2024[abstract-only], a 23-study social-science inventory with
no pooled benchmark @legate2024, and secondhand error ranges of 4–31%
@gartlehner2025.

*Read against human baselines.* #cite(<fagerberg2025>, form: "prose")
summarize prior estimates of single-human-reviewer screening sensitivity
at \~87–92% (range 42–100%). #cite(<gartlehner2025>, form: "prose") cite
prior reports that human extraction errors reach 50% of data elements.
A rare RCT-grade automation study found noninferiority, not superiority,
with inconclusive time savings @arno2022[abstract-only]; it remains the
only such study in the map after the 2026-08-09 update, which added
appraisal-stage works but no further randomized evidence. Agent evidence
should be calibrated against these imperfect baselines, not an idealized
perfect reviewer.

*Ensemble gains, in incommensurable units.* Two update deep reads
report ensembles beating their own best member, and their effect sizes
cannot be placed on one scale. A cross-vendor three-agent vote reached
mean average precision 0.341 against constituents at 0.271, 0.266, and
0.182, with WSS\@95% of 0.680 @akinseloyin2026; a five-model
same-family BERT ensemble reached F1 89.16% against a best standalone
88.53% @knafou2023. Relative gain, absolute F1 points, and
ranking-based precision are different measurement families, and the
metric-fragmentation problem this section documents within studies
recurs between them.

The second of those studies also repeats a pattern first visible in
appraisal: requiring unanimity plus a probability threshold lifts
screening performance to about 98.5% F1 at roughly 99% recall while
deciding only about half the corpus @knafou2023, just as
consistency-gated appraisal reached human-level accuracy only on the
items it did not defer @woelfle2024. Accuracy bought with deferred
coverage now appears at two stages and in two technology generations,
which makes it a shape worth naming — though the two designs share no
corpus, metric, or model family, so this is a recurring pattern rather
than a replication.
