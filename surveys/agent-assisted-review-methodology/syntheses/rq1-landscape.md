# RQ1 — The landscape repeats its pre-LLM shape, with the ends filling in

Map basis: 672 included works (map.tsv). Stage distribution: screen 225,
extract 113, meta 111, end2end 90, search 49, synthesize 37, appraise 25,
report 22. Setting: med 412, general 243, se 17.

## The skew is inherited, not new

The pre-LLM baseline (vandinter2021: 41 studies, 2006–2020) had **every**
automation study in Kitchenham's conducting-the-review category — screening
dominant, appraisal n=1, planning and reporting zero, one deep-learning
study in the whole corpus. The LLM-era map keeps the same center of mass
(screening 33% of includes) but the formerly empty ends are now populated:
a reporting/guidance cluster exists (22 report-stage + 36 guideline works),
and end-to-end systems are a real class (90 works). Appraisal remains the
thinnest evaluated stage (25), consistent with woelfle2024's finding that
it is also the hardest.

## End-to-end systems get reliability from decomposition, not redundancy

The strongest-documented system (huang2026, MedSR-Copilot: 4 subagents +
fine-tuned RoB model + deterministic synthesis engine, 63.6% end-to-end
conclusion accuracy vs 45.3% best baseline on a 100-SR benchmark) contains
no multi-agent debate or voting anywhere — reliability comes from task
decomposition, structured intermediate artifacts, and human-in-the-loop
gates, with its ablation ranking two-stage extraction (−14.9pp) above
retrieval-RAG (−3.3pp). Its absolute numbers (screening F1 ~0.46–0.51,
extraction accuracy ~63%) also calibrate how far "end-to-end" still is
from unattended use. song2026 adds the lifecycle view: across 34 tools in
living-evidence synthesis, publication-update is served by exactly one.

## Adoption runs ahead of disclosure

mughal2026 is a dated, concrete adoption exemplar (recall-oriented LLM
pre-filter + full audit of retained + stratified audit of excluded, κ=0.79
vs humans, disclosed under PRISMA 2020 item 8), but the field's own
coordination body reports that published SRs rarely disclose advanced AI
use (oconnor2024, ICASR), echoing the pre-LLM adoption gap napoleao2021
quantified (8 practice-adopted screening tools in medicine vs 2 in SE).

## SE is an order of magnitude behind medicine in evidence

17 SE-setting includes vs 412 medical — the cross-domain gap napoleao2021
measured pre-LLM persists in the LLM era. The SE evidence that exists
(syriani2023, huotala2025, felizardo2024, safarpour2026) is screening- and
extraction-stage evaluation; SE has no guidance/norms work of its own.
For sys0 this means the methodology it imports is medicine-calibrated:
prevalence, criteria complexity, and ground-truth conventions differ.
