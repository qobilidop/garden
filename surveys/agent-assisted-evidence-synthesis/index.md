# Agent-Assisted Evidence Synthesis: A Survey

An exploratory systematic map of AI-assisted and automated evidence
synthesis — systematic reviews, maps, and related secondary studies —
in the LLM era: 776 included works (745 included + 31 deep-read) in a
1,975-row catalog spanning the original integrity-corrected campaign
and the human-gated 2026-08-09 update batch, classified under a
four-dimensional taxonomy, with selected anchors curated below.

**Read:** [manuscript (HTML)](manuscript.html) ·
[manuscript (PDF)](manuscript.pdf)

**Survey record:**
[method, searches, catalog, evidence notes](https://github.com/qobilidop/sys0/tree/main/surveys/agent-assisted-evidence-synthesis/record)
— searched through 2026-08-09.

**Topic context:** [[survey-methodology]]

## Reading list

The works that anchor this map, curated from its 776 included works and
organized by the survey's taxonomy. Entries link the original paper
(where a stable public link exists) and our notes on it (library pages where ingested, our
evidence notes in the record otherwise).

### Method foundations

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Guidelines for Performing Systematic Literature Reviews in Software Engineering](https://legacyfileshare.elsevier.com/promis_misc/525444systematicreviewsguide.pdf) | The SLR method canon for SE | EBSE Report · 2007 | [[kitchenham2007-guidelines-for-performing-systematic-literature-reviews-in-software-engineering]] |
| [Systematic Mapping Studies in Software Engineering](https://doi.org/10.14236/ewic/EASE2008.8) | Defines the systematic-map genre | EASE · 2008 | [[petersen2008-systematic-mapping-studies-in-software-engineering]] |
| [Guidelines for Snowballing in Systematic Literature Studies](https://doi.org/10.1145/2601248.2601268) | Snowballing search guidelines | EASE · 2014 | [[wohlin2014-guidelines-for-snowballing-in-systematic-literature-studies-and-a-replication-in-software-engineering]] |
| [The PRISMA 2020 Statement](https://doi.org/10.1136/bmj.n71) | The reporting standard for systematic reviews | BMJ · 2021 | [[page2021-the-prisma-2020-statement]] |

### Landscape and lineage

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Automation of Systematic Literature Reviews](https://doi.org/10.1016/j.infsof.2021.106589) | Pre-LLM landscape of SLR automation (41 studies, 2006–2020) | IST · 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/vandinter2021.md) |
| [Automated Support for Searching and Selecting Evidence in Software Engineering](https://doi.org/10.1109/seaa53835.2021.00015) | The medicine-vs-SE adoption gap, measured pre-LLM | SEAA · 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/napoleao2021.md) |
| [Potential Roles of Large Language Models in the Production of Systematic Reviews and Meta-Analyses](https://doi.org/10.2196/56780) | Stage-by-stage map of where LLMs can assist | JMIR · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/luo2024.md) |
| [Large Language Models, Updates, and Evaluation of Automation Tools for Systematic Reviews](https://doi.org/10.1186/s13643-024-02666-2) | ICASR community report on tools and evaluation | Syst Rev · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/oconnor2024.md) |
| [The Phases of Living Evidence Synthesis Using AI](https://doi.org/10.2196/76130) | Phase model and tool inventory for living evidence | JMIR · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/song2026.md) |

### Screening

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Enhancing Title and Abstract Screening with GPT-3.5 Turbo](https://doi.org/10.1136/bmjebm-2023-112678) | In one review case, eight sequential prompt variants produced materially different reported sensitivities | BMJ EBM · 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/gargari2023.md) |
| [Screening Articles for Systematic Reviews With ChatGPT](https://doi.org/10.1016/j.cola.2024.101287) | Early cross-corpus screening evaluation; stability is not validity | J Comput Lang · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/syriani2023.md) |
| [GPT-3.5 Turbo and GPT-4 Turbo in Title and Abstract Screening](https://doi.org/10.2196/64682) | Same-prompt comparison: GPT-4 Turbo had higher specificity and similar sensitivity | JMIR Med Inform · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/oami2025.md) |
| [SESR-Eval: Dataset for Evaluating LLMs in Title-Abstract Screening](https://doi.org/10.1109/esem64174.2025.00053) | 9-LLM × 24-review benchmark; none of the tested models met the study's proposed deployment bar | ESEM · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/huotala2025.md) |
| [Empirical Evaluation of Open-Source LLMs for Paper Selection](https://doi.org/10.1109/saner-c67878.2026.00047) | Abstract-only evidence: open-weight models screened more conservatively than GPT-4.1 | SANER-C · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/safarpour2026.md) |
| [LLM-Based Test Oracles: Source-of-Authority Taxonomy](https://arxiv.org/abs/2607.05031) | A disclosed-adoption exemplar: LLM pre-filter with audits, reported under PRISMA | arXiv · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/mughal2026.md) |

### Extraction and appraisal

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Agreement in Risk-of-Bias Assessment Between RobotReviewer and Human Reviewers](https://doi.org/10.1111/jnu.12628) | Abstract-only evidence: agreement with the source Cochrane reviews' own human risk-of-bias judgments ranged from kappa 0.60 (allocation concealment) to 0.04 (blinding of outcome assessors) across domains — a per-domain spread an aggregate accuracy figure would hide; pre-LLM tool, 190 nursing trials | J Nurs Scholarsh · 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/hirt2021.md) |
| [Accuracy and Efficiency of Machine Learning–Assisted Risk-of-Bias Assessments](https://doi.org/10.7326/m22-0092) | Abstract-only evidence: a rare RCT-grade automation study found noninferiority, not superiority | Ann Intern Med · 2022 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/arno2022.md) |
| [(Semi)automated Approaches to Data Extraction for Systematic Reviews](https://doi.org/10.12688/f1000research.151493.2) | Living review of extraction approaches in social science (23 studies) | F1000Research · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/legate2024.md) |
| [Data Extraction for Systematic Mapping Study Using a Large Language Model](https://doi.org/10.1145/3674805.3690743) | Abstract-only evidence: an LLM extraction proof-of-concept in SE | ESEM · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/felizardo2024.md) |
| [Benchmarking Human–AI Collaboration for Common Evidence Appraisal Tools](https://doi.org/10.1016/j.jclinepi.2024.111533) | Retrospective benchmark: agreement-gated deferral outperformed humans alone and LLM ensembles on two easier instruments | J Clin Epi · 2024 | [[woelfle2024-benchmarking-humanai-collaboration]] |

### Ensembles and end-to-end systems

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Ensemble of Deep Learning Language Models for Living Systematic Reviews](https://doi.org/10.1186/s13643-023-02247-9) | Five same-family BERT classifiers: configuration reported, no diversity or correlation statistic measured anywhere; unanimity plus a confidence threshold trades coverage for accuracy — ~98.5% F1 on ~50% of records, against one crowdsourced annotation team's labels | Syst Rev · 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/knafou2023.md) |
| [Dual-Model LLM Ensemble Reaches Near-Perfect Sensitivity for Screening](https://doi.org/10.1101/2025.11.03.25339455) | Preprint: cross-vendor OR ensemble reached 99.7% sensitivity on author-adjudicated labels (94.0–94.5% on original labels); no family-diversity ablation | medRxiv · 2025 | [[fagerberg2025-dual-model-llm-ensemble-via-web-chat-interfaces-reaches-near-perfect-sensitivity-for-systematic-review-screening]] |
| [LLM-Based Multiagent Collaboration for Abstract Screening](https://doi.org/10.1093/biomethods/bpag006) | The set's only measured inter-agent diversity — Spearman 0.48–0.56 among three cross-vendor agents, which a debate round raised while losing the ensemble's edge; gains are over the best single agent on a benchmark's original Cochrane inclusion labels, and vendor, scale, and training data vary together, so no factor is isolated | Biol Methods Protoc · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/akinseloyin2026.md) |
| [A PRISMA-Aligned Agentic Framework for Medical Systematic Reviews](https://doi.org/10.64898/2026.07.30.26359375) | Preprint evaluated on an author-built benchmark: decomposition, structured artifacts, human review, and no redundancy | medRxiv · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/huang2026.md) |

### Norms, reporting, and evaluation methodology

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Guidance for Using AI for Title and Abstract Screening](https://doi.org/10.1186/s12874-021-01451-2) | Pre-LLM guidance; the AI-as-secondary-reviewer role | BMC Med Res Methodol · 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/hamel2021.md) |
| [Responsible Integration of AI in Rapid Reviews](https://doi.org/10.1002/cesm.70063) | Cochrane Rapid Reviews position statement, endorsing RAISE | Cochrane Ev Synth · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/gartlehner2025.md) |
| [Best Practice Methods for Living Evidence Synthesis: An International Modified Delphi](https://doi.org/10.1101/2025.11.07.25339719) | Preprint: a 29-expert, three-round Delphi on living-evidence practice; by the authors' own account consensus was lowest on actionable automation use and highest on general statements, and no voted statement adjudicates AI's reviewer role | medRxiv · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/golob2025.md) |
| [Leveraging AI for Systematic Reviews: The FRAISR Framework](https://doi.org/10.31219/osf.io/ju8dk) | Preprint: per-stage machine-readable reporting framework | OSF · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/degen2024.md) |
| [Transparent Reporting of AI in SLRs: PRISMA-trAIce](https://doi.org/10.2196/80247) | Checklist proposal with human/AI-split flow diagram | JMIR AI · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/holst2025.md) |
| [HAICO-SLR: Conducting and Reporting Human-AI Collaboration in SLRs](https://doi.org/10.2139/ssrn.7048543) | Preprint: stage-typed human/AI role guide with dual reporting tables | SSRN · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/fernandes2026.md) |
| [Reproducibility and Data Storage for Active Learning-Aided Systematic Reviews](https://doi.org/10.3390/app14093842) | What must be stored, not merely disclosed, for an active-learning screening pass to be reconstructable — a 15-item checklist, never applied to a completed review and demonstrated only against a tool two of its three authors develop | Appl Sci · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/agent-assisted-evidence-synthesis/record/sources/lombaers2024.md) |
| [LLM4SCREENLIT: Assessing LLM Performance for Screening](https://doi.org/10.1016/j.infsof.2026.108204) | Measurement reform: why accuracy misleads under class imbalance | IST · 2026 | [[madeyski2025-llm4screenlit]] |
