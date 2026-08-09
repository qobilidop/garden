---
citekey: mughal2026-llm-based-test-oracles
work:
  title: "LLM-Based Test Oracles: Source-of-Authority Taxonomy -- A Systematic Literature Review"
  author: "Ali Hassaan Mughal, Muhammad Bilal"
  date: 2026
  arxiv: 2607.05031
read: full-text
source: "shadow/library/papers/2026/mughal2026-llm-based-test-oracles/transcript.md"
facets:
  stage: "screen"
  contribution: "evaluation"
  setting: "se"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "LLM-Based Test Oracles: Source-of-Authority Taxonomy — A Systematic Literature Review"
---

# LLM-Based Test Oracles: Source-of-Authority Taxonomy -- A Systematic Literature Review

## Evidence

Application exemplar: this is a domain SLR (54 included studies, from 2,436 records) that taxonomizes LLM-based test oracles by *source of authority* rather than by oracle form or LLM technique — the taxonomy itself is out of scope here; this note covers only the paper's own screening pipeline.

- **Pre-filter mechanics (Stage 1):** an LLM (Claude Opus 4.8) classified all 2,245 deduplicated title/abstract records against the written eligibility criteria, assigning include/maybe/exclude plus an exclusion-reason code (E1–E6) where applicable. Ambiguous cases were forced to *maybe* and retained — an explicit retain-on-uncertainty, recall-oriented design. Stage 1 retained 178, excluded 2,067. No prompt text or classification threshold is reproduced in the paper body; both are pointed to the released replication package (Zenodo, CC BY 4.0) rather than disclosed inline.
- **Composition with dual-human screening (Stage 2):** two authors independently screened a 385-record *verification set* — blind to both the model's labels and to each other — comprising all 178 model-retained records plus a fixed-seed, reason-stratified 10% sample (207) of the 2,067 model-excluded records. This is a full-audit-of-retained + stratified-audit-of-excluded design, not screening of the whole 2,245-record corpus by hand. Reconciliation rule: Include-vs-Maybe splits retained; Exclude-vs-Maybe splits excluded; the 8 direct Include-vs-Exclude conflicts were resolved individually against full text.
- **Reported reliability/performance (Table I):** Cohen's κ = 0.79 on the binary retain-vs-exclude decision (95% CI [0.72, 0.85], 90.4% raw agreement); κ = 0.64 on the three-level scale (95% CI [0.57, 0.71], 81.6% agreement). Pre-filter recall vs. human consensus: 99.1% (114/115; the single miss was itself borderline, reconciled to include only after full-text discussion). Pre-filter false-omission rate on the stratified exclusion sample: 0.48% (1/207) — projected to ≈9 missed relevant records across the 1,860 unaudited model-exclusions if the rate held uniformly; authors flag the CI around this single-observation estimate as wide and carry it forward as a named threat to validity (their §VIII). Over-inclusion: the model retained 64 records the human consensus excluded, i.e., precision is supplied entirely by the human stage — the LLM stage is tuned for recall only.
- **Workload effect:** manual dual-screening volume was reduced from the full 2,245-record corpus to a 385-record verification set (~17%), by fully auditing the model's positive class and stratified-sampling its negative class, rather than double-screening everything.
- **Disclosure:** an explicit acknowledgments-section sentence states the LLM (Anthropic Claude) was used as "the recall-oriented screening pre-filter... disclosed under PRISMA 2020 item 8" (the PRISMA item governing reporting of automation tools). The methods section frames the two-stage design explicitly as a disclosed departure from all-manual screening ("an arrangement disclosed in accordance with PRISMA 2020 item 8"). A dedicated limitations subsection ("B. Automation-assisted screening," their §VIII-B) restates the false-omission-rate estimate and its wide CI as residual risk, and states it is judged unlikely to change taxonomy-level findings. Protocol (search query frozen 31 May 2026, criteria fixed in writing before screening) was archived openly in the replication package rather than registered in a public registry.

## Bearing on RQs

- **RQ1 (adoption evidence):** a concrete, dated (2026) instance of a published SE SLR adopting an LLM pre-filter ahead of dual human screening in practice, not merely evaluating the pattern in the abstract — evidence that the "automated recall-oriented pre-filter + full-audit-of-retained + stratified-audit-of-excluded" design is a real, used adoption pattern, with a specific model (Claude Opus 4.8) and specific validation numbers attached.
- **RQ3 (disclosure-in-practice exemplar):** a reusable disclosure template — explicit acknowledgment naming the model and citing the specific PRISMA 2020 item, a dedicated reliability/validation table (κ, recall, false-omission rate, over-inclusion count) sitting alongside the PRISMA flow diagram, and a limitations subsection that revisits the automation stage's residual risk rather than treating validation as one-off. Useful as a positive disclosure exemplar independent of any evaluation-study finding.

## Evidence limits

Self-reported and self-validated: the authors are both the ones deploying the pre-filter and the ones auditing it, with no independent/external replication of the screening pipeline. The headline false-omission-rate (0.48%) rests on a single observed miss out of 207 sampled exclusions — the authors themselves flag the resulting confidence interval as wide. Only one LLM/version (Claude Opus 4.8) was used for the pre-filter; the paper reports no comparison against other models or against a no-pre-filter baseline. Exact prompt text and any explicit confidence threshold are not reproduced in the paper body, only in an external replication package this note did not fetch.
