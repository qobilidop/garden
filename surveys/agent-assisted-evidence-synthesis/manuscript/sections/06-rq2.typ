= RQ2 — Reliability: common labels, heterogeneous evidence <sec-rq2>

The abstract-coded map labels 249 of 646 works `human-agree` and 152
`benchmark` (@tab-map). These labels record comparison type, not
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
comparisons on the same data @huotala2025.

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
with inconclusive time savings @arno2022[abstract-only]. Agent evidence
should be calibrated against these imperfect baselines, not an idealized
perfect reviewer.
