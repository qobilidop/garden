# Agent-Assisted Systematic Review Methodology: A Survey

A systematic map of the LLM-era literature on automating systematic
reviews: 1,291 works cataloged, 672 included and classified under a
four-dimensional taxonomy, with the works that anchor the field
curated into the reading list below.

**Read:** [manuscript (HTML)](manuscript.html) ·
[manuscript (PDF)](manuscript.pdf)

**Survey record:**
[method, searches, catalog, evidence notes](https://github.com/qobilidop/sys0/tree/main/surveys/agent-assisted-review-methodology/record)
— searched through 2026-08-08.

**Topic context:** [[survey-methodology]]

## Reading list

The works that anchor the field, curated from the 672-work map and
organized by the survey's taxonomy. Entries link the original paper
(where a stable public link exists) and our notes on it (library pages where ingested, our
evidence notes in the record otherwise).

### Method foundations

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| Guidelines for Performing Systematic Literature Reviews in Software Engineering | The SLR method canon for SE | EBSE Report · 2007 | [[kitchenham2007-guidelines-for-performing-systematic-literature-reviews-in-software-engineering]] |
| [Systematic Mapping Studies in Software Engineering](https://doi.org/10.14236/ewic/EASE2008.8) | Defines the systematic-map genre | EASE · 2008 | [[petersen2008-systematic-mapping-studies-in-software-engineering]] |
| [Guidelines for Snowballing in Systematic Literature Studies](https://doi.org/10.1145/2601248.2601268) | Snowballing search guidelines | EASE · 2014 | [[wohlin2014-guidelines-for-snowballing-in-systematic-literature-studies-and-a-replication-in-software-engineering]] |
| [The PRISMA 2020 Statement](https://doi.org/10.1136/bmj.n71) | The reporting standard for systematic reviews | BMJ · 2021 | [[page2021-the-prisma-2020-statement]] |

### Landscape and lineage

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Automation of Systematic Literature Reviews](https://doi.org/10.1016/j.infsof.2021.106589) | Pre-LLM landscape of SLR automation (41 studies, 2006–2020) | IST · 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/vandinter2021-automation-of-systematic-literature-reviews.md) |
| [Automated Support for Searching and Selecting Evidence in Software Engineering](https://doi.org/10.1109/seaa53835.2021.00015) | The medicine-vs-SE adoption gap, measured pre-LLM | SEAA · 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/napoleao2021-automated-support-for-searching-and-selecting-evidence-in-software-engineering.md) |
| [Potential Roles of Large Language Models in the Production of Systematic Reviews and Meta-Analyses](https://doi.org/10.2196/56780) | Stage-by-stage map of where LLMs can assist | JMIR · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/luo2024-potential-roles-of-large-language-models-in-the-production-of-systematic-reviews-and-meta-analyses.md) |
| [Large Language Models, Updates, and Evaluation of Automation Tools for Systematic Reviews](https://doi.org/10.1186/s13643-024-02666-2) | ICASR community report on tools and evaluation | Syst Rev · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/oconnor2024-large-language-models-updates-and-evaluation-of-automation-tools-for-systematic-reviews.md) |
| [The Phases of Living Evidence Synthesis Using AI](https://doi.org/10.2196/76130) | Phase model and tool inventory for living evidence | JMIR · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/song2026-the-phases-of-living-evidence-synthesis-using-ai.md) |

### Screening

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Enhancing Title and Abstract Screening with GPT-3.5 Turbo](https://doi.org/10.1136/bmjebm-2023-112678) | Prompt wording alone swings screening sensitivity | BMJ EBM · 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/gargari2023-enhancing-title-and-abstract-screening-for-systematic-reviews-with-gpt-35-turbo.md) |
| [Assessing the Ability of ChatGPT to Screen Articles for Systematic Reviews](https://arxiv.org/abs/2307.06464) | Early cross-corpus screening evaluation; stability is not validity | arXiv · 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/syriani2023-assessing-the-ability-of-chatgpt-to-screen-articles-for-systematic-reviews.md) |
| [GPT-3.5 Turbo and GPT-4 Turbo in Title and Abstract Screening](https://doi.org/10.2196/64682) | Controlled same-prompt comparison: scale bought specificity, not sensitivity | JMIR Med Inform · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/oami2025-gpt-35-turbo-and-gpt-4-turbo-in-title-and-abstract-screening-for-systematic-reviews.md) |
| [SESR-Eval: Dataset for Evaluating LLMs in Title-Abstract Screening](https://doi.org/10.1109/esem64174.2025.00053) | 9-LLM × 24-review benchmark; no model meets a proposed deployment bar | ESEM · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/huotala2025-sesr-eval.md) |
| [Empirical Evaluation of Open-Source LLMs for Paper Selection](https://doi.org/10.1109/saner-c67878.2026.00047) | Open-weight models screen more conservatively than GPT | SANER-C · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/safarpour2026-empirical-evaluation-of-open-source-large-language-models-for-paper-selection.md) |
| [LLM-Based Test Oracles: Source-of-Authority Taxonomy](https://arxiv.org/abs/2607.05031) | A disclosed-adoption exemplar: LLM pre-filter with audits, reported under PRISMA | arXiv · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/mughal2026-llm-based-test-oracles.md) |

### Extraction and appraisal

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Accuracy and Efficiency of Machine Learning–Assisted Risk-of-Bias Assessments](https://doi.org/10.7326/m22-0092) | A rare RCT-grade automation study: noninferiority, not superiority | Ann Intern Med · 2022 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/arno2022-accuracy-and-efficiency-of-machine-learning-assisted-risk-of-bias-assessments-in-real-world-systematic-reviews.md) |
| [(Semi)automated Approaches to Data Extraction for Systematic Reviews](https://doi.org/10.12688/f1000research.151493.2) | Living review of extraction approaches in social science (23 studies) | F1000Research · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/legate2024-semiautomated-approaches-to-data-extraction-for-systematic-reviews-and-meta-analyses-in-social-sciences.md) |
| [Data Extraction for Systematic Mapping Study Using a Large Language Model](https://doi.org/10.1145/3674805.3690743) | LLM extraction proof-of-concept in SE | ESEM · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/felizardo2024-data-extraction-for-systematic-mapping-study-using-a-large-language-model-a-proof-of-concept-study-in-software-engineering.md) |
| [Benchmarking Human–AI Collaboration for Common Evidence Appraisal Tools](https://doi.org/10.1016/j.jclinepi.2024.111533) | Agreement-gated deferral beats humans-alone and LLM ensembles on the easier instruments | J Clin Epi · 2024 | [[woelfle2024-benchmarking-humanai-collaboration]] |

### Ensembles and end-to-end systems

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Dual-Model LLM Ensemble Reaches Near-Perfect Sensitivity for Screening](https://doi.org/10.1101/2025.11.03.25339455) | Cross-family OR-ensemble; family diversity catches family blind spots | openRxiv · 2025 | [[fagerberg2025-dual-model-llm-ensemble-via-web-chat-interfaces-reaches-near-perfect-sensitivity-for-systematic-review-screening]] |
| [A PRISMA-Aligned Agentic Framework for Medical Systematic Reviews](https://doi.org/10.64898/2026.07.30.26359375) | MedSR-Copilot: reliability from decomposition and human gates, not redundancy | openRxiv · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/huang2026-a-prisma-aligned-agentic-framework-for-medical-systematic-reviews-and-evidence-synthesis.md) |

### Norms, reporting, and evaluation methodology

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Guidance for Using AI for Title and Abstract Screening](https://doi.org/10.1186/s12874-021-01451-2) | Pre-LLM guidance; the AI-as-secondary-reviewer role | BMC Med Res Methodol · 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/hamel2021-guidance-for-using-artificial-intelligence-for-title-and-abstract-screening-while-conducting-knowledge-syntheses.md) |
| [Responsible Integration of AI in Rapid Reviews](https://doi.org/10.1002/cesm.70063) | Cochrane Rapid Reviews position statement, endorsing RAISE | Cochrane Ev Synth · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/gartlehner2025-responsible-integration-of-artificial-intelligence-in-rapid-reviews.md) |
| [Leveraging AI for Systematic Reviews: The FRAISR Framework](https://doi.org/10.31219/osf.io/ju8dk) | Per-stage machine-readable reporting framework | OSF · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/degen2024-leveraging-artificial-intelligence-for-systematic-reviews.md) |
| [Transparent Reporting of AI in SLRs: PRISMA-trAIce](https://doi.org/10.2196/80247) | Checklist proposal with human/AI-split flow diagram | JMIR AI · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/holst2025-transparent-reporting-of-ai-in-systematic-literature-reviews.md) |
| [HAICO-SLR: Conducting and Reporting Human-AI Collaboration in SLRs](https://doi.org/10.2139/ssrn.7048543) | Stage-typed human/AI role guide with dual reporting tables | SSRN · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-review-methodology/record/sources/fernandes2026-haico-slr-guide.md) |
| [LLM4SCREENLIT: Assessing LLM Performance for Screening](https://arxiv.org/abs/2511.12635) | Measurement reform: why accuracy misleads under class imbalance | IST · 2026 | [[madeyski2025-llm4screenlit]] |
