# Evidence ledger

One record per evidence item: a single checkable finding from the
literature, bound downward to source-note anchors, upward to the
`Cxx` claims it supports, and across to the manuscript sections
that cite on its strength. Scope and caveat ride the record. Keys
are comma-separated, anchors semicolon-separated. Anchors point
into `sources/` notes, whose headings are `Evidence`,
`Bearing on RQs`, and `Evidence limits`.

Fields: **Finding** (what the literature shows), **Works**
(citekeys, each a note in `sources/`), **Anchors**
(`sources/<citekey>.md#<heading>`), **Supports** (`Cxx`, omitted
when none), **Manuscript** (section labels, omitted when none),
**Scope**, **Caveat**, and optional **Certainty**
(`high`/`moderate`/`low`, GRADE-inspired; grading deferred to the
next evidence touch).


### E001

- **Finding:** Pre-LLM automation sat entirely in conducting-the-review — all 41 studies in the 2006–2020 corpus, screening dominant, appraisal nearly empty (one study), planning and reporting untouched, one deep-learning study — and medicine had eight practice-adopted screening tools to SE's two.
- **Works:** vandinter2021,napoleao2021
- **Anchors:** sources/vandinter2021.md#evidence;sources/napoleao2021.md#evidence
- **Supports:** C01
- **Manuscript:** sec-background,sec-rq1,sec-discussion
- **Scope:** Pre-LLM baseline; searches through 2020, SE and medicine venues.
- **Caveat:** Both searches are venue/domain-scoped, so absence elsewhere is a search-scope artifact; the counts describe publications and selected studies, not practice at large.

### E002

- **Finding:** In a living-evidence inventory of 34 tools across 24 studies, exactly one tool (RobotReviewer LIVE) served the publication-update phase, and the authors state their "living evidence" search vocabulary may undercount that phase.
- **Works:** song2026
- **Anchors:** sources/song2026.md#evidence;sources/song2026.md#evidence-limits
- **Supports:** C01,C05
- **Manuscript:** sec-rq1,sec-discussion
- **Scope:** Living evidence synthesis, medicine; tool counts by phase.
- **Caveat:** Review-of-reviews with a terminology-bounded search; itself a living review (v1, cutoff April 2025), so counts change on update.

### E003

- **Finding:** No comprehensive AI-disclosure guideline existed as of the deep reads: PRISMA 2020 addresses automation only for study selection/screening, and the PRISMA-AI extension announced in 2022 remains unpublished.
- **Works:** luo2024,holst2025
- **Anchors:** sources/luo2024.md#evidence;sources/holst2025.md#evidence
- **Supports:** C03
- **Manuscript:** sec-rq3
- **Scope:** Reporting-standard landscape through the deep reads' publication dates.
- **Caveat:** luo2024 is a viewpoint with narratively gathered citations; the PRISMA-AI status is holst2025's characterization of an announcement, not an independent registry check.

### E004

- **Finding:** Independently derived stage vocabularies in the deep reads are non-equivalent: Kitchenham's twelve SLR steps in three categories, luo's nine-stage LLM role map (which splits question, registration, criteria, and search and adds submission), and song's four-phase living-evidence model partition the same pipeline differently.
- **Works:** vandinter2021,luo2024,song2026
- **Anchors:** sources/vandinter2021.md#evidence;sources/luo2024.md#evidence;sources/song2026.md#evidence
- **Supports:** C05
- **Manuscript:** sec-background,sec-taxonomy
- **Scope:** Stage-vocabulary comparison across three deep reads.
- **Caveat:** Divergence motivates but does not validate the survey's own scheme; the cross-vocabulary correspondence is our reading.

### E005

- **Finding:** In a 29-paper convenience sample of LLM-screening evaluations, 7/29 (24%) reported complete confusion matrices, 3/29 (10%) reported MCC, and 17/29 (59%) used accuracy; in a 9,695-article reanalysis the accuracy-best model lost 63.3% of relevant evidence where the WMCC(w=10)-best model lost 5.8%.
- **Works:** madeyski2025
- **Anchors:** sources/madeyski2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-background,sec-rq2,sec-discussion
- **Scope:** Measurement practice in LLM title/abstract-screening evaluations.
- **Caveat:** Convenience sample with single-researcher extraction; numbers are from the arXiv version, not line-checked against the 2026 journal publication.

### E006

- **Finding:** Across nine LLMs and 24 SE reviews (34,528 records), no nondegenerate operating point met the authors' proposed bar of recall ≥ 0.95 at precision ≈ 0.50; pooled versus per-review aggregation changed model comparisons on the same data, and per-study spread (accuracy 0.34–0.85) exceeded differences among the larger models.
- **Works:** huotala2025
- **Anchors:** sources/huotala2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-rq2,sec-discussion
- **Scope:** Zero-shot title/abstract screening on SE secondary studies.
- **Caveat:** Zero-shot prompting only; ground truth reverse-engineered from heterogeneous research artifacts; 13.6% of records dropped for missing abstracts.

### E007

- **Finding:** Holding prompt and pipeline fixed across five highly imbalanced sepsis questions (41/16,669 human-included), upgrading GPT-3.5 Turbo to GPT-4 Turbo moved pooled specificity from 0.51 to 0.98 (significant) while sensitivity changed from 0.83 to 0.85 (no significant difference).
- **Works:** oami2025
- **Anchors:** sources/oami2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-rq2,sec-discussion
- **Scope:** Same-prompt model-upgrade comparison in one clinical-guideline setting.
- **Caveat:** Post hoc research letter, single domain and institution, both models superseded; absolute FP/FN counts not reported.

### E008

- **Finding:** Eight sequential prompt variants on one insomnia review (330 citations) moved GPT-3.5 Turbo screening from 62% sensitivity (80% accuracy) to a highest-sensitivity variant the authors described as similar to a junior reviewer and surpassing a senior reviewer.
- **Works:** gargari2023
- **Anchors:** sources/gargari2023.md#evidence
- **Supports:** C02
- **Manuscript:** sec-rq2
- **Scope:** Single-review prompt-sensitivity case study.
- **Caveat:** Most per-prompt metrics are directional prose with the full table in an unverified supplement; prompt wording is not isolated from iteration/order effects, and the human comparison is qualitative.

### E009

- **Finding:** GPT-3.5 Turbo screening recall was 0.327 on the corpus with 52.7% recorded human conflict (MobileMDE) versus 0.738–0.947 on the other four corpora, while run-to-run Fleiss κ was 0.821 and 0.973 on the two corpora tested for consistency.
- **Works:** syriani2023
- **Anchors:** sources/syriani2023.md#evidence
- **Supports:** C02,C04
- **Manuscript:** sec-rq2,sec-rq4
- **Scope:** Five SE review corpora, one model; stability-versus-validity contrast.
- **Caveat:** The conflict–recall association is not established as causal; consistency was measured on only two of five corpora; numbers are from the arXiv-version transcript.

### E010

- **Finding:** Across three appraisal instruments, every individual LLM scored below every individual human rater, and human inter-rater κ itself fell from 0.84 (PRISMA) to 0.29 (PRECIS-2) as instrument complexity rose.
- **Works:** woelfle2024
- **Anchors:** sources/woelfle2024.md#evidence
- **Supports:** C02
- **Manuscript:** sec-rq2
- **Scope:** Five 2023–2024 LLMs, appraisal stage, published human-rated datasets.
- **Caveat:** The human reference is two-rater consensus, not adjudicated ground truth; prompts were engineered per model, confounding cross-model ranking.

### E011

- **Finding:** A 9-run consistency ensemble matched human appraisal accuracy only on items surviving near-unanimous agreement (deferring 74–88% of items at the highest thresholds), while human–LLM agreement-gated deferral reached 95–96% accuracy sparing about 65–70% of second-reviewer items on PRISMA/AMSTAR and 80–86% sparing about 29% on PRECIS-2.
- **Works:** woelfle2024
- **Anchors:** sources/woelfle2024.md#evidence
- **Supports:** C04
- **Manuscript:** sec-rq4,sec-discussion
- **Scope:** Retrospective appraisal on two easier instruments plus PRECIS-2.
- **Caveat:** Supports deferral for these instruments, not a general design law; human time savings were not measured, only item-count deferral fractions.

### E012

- **Finding:** A cross-vendor OR ensemble (GPT-5 Thinking + Gemini 2.5 Pro, two runs each, 736 Cochrane citations) reached 99.7% sensitivity and 49.3% specificity on author-adjudicated labels and 94.0–94.5% sensitivity against the original Cochrane labels; in a post-hoc subgroup with seven positives, GPT-5 single-run sensitivity was 43% while Gemini flagged the same records as ambiguous.
- **Works:** fagerberg2025
- **Anchors:** sources/fagerberg2025.md#evidence
- **Supports:** C04
- **Manuscript:** sec-rq4,sec-discussion
- **Scope:** One multi-domain medicine screening preprint, zero-shot, OR rule.
- **Caveat:** No matched same-family arm isolates family diversity from model identity, run count, or the OR rule; the 18-record adjudication was in-team and moved all changes in the models' favor; unreviewed preprint.

### E013

- **Finding:** The selected evidence's calibrating baselines are imperfect humans: prior estimates put single-human screening sensitivity at ~87–92% (range 42–100%), human extraction errors at up to 50% of data elements, and the one RCT-grade automation study found ML-assisted risk-of-bias assessment noninferior (88.8% vs 90.2%) with inconclusive time savings.
- **Works:** fagerberg2025,gartlehner2025,arno2022
- **Anchors:** sources/fagerberg2025.md#evidence;sources/gartlehner2025.md#evidence;sources/arno2022.md#evidence
- **Supports:** C02
- **Manuscript:** sec-rq2
- **Scope:** Human-baseline and RCT calibration for reading agent results.
- **Caveat:** The human-baseline figures are secondhand citations of prior literature within these sources; arno2022 is abstract-only with more than half of recruited teams not completing.

### E014

- **Finding:** Selected extraction evidence is heterogeneous in kind: an SE proof-of-concept reports 87.83% accuracy on one mapping study, a 23-study social-science living review computes no pooled benchmark (0 studies applied a tool in a real review; 1 of 23 tools live), and the Cochrane-family statement relays secondhand AI-extraction error rates of 4–31% (median 14%).
- **Works:** felizardo2024,legate2024,gartlehner2025
- **Anchors:** sources/felizardo2024.md#evidence;sources/legate2024.md#evidence;sources/gartlehner2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-rq2
- **Scope:** Extraction stage across SE, social science, and medicine.
- **Caveat:** felizardo2024 is abstract-only with no metric breakdown; the 4–31% ranges are Clark et al.'s figures cited secondhand, not gartlehner2025's own measurements.

### E015

- **Finding:** The three deep-read disclosure proposals share a content core — name the tool and version, state the stage and task the AI performed and the human oversight, and describe verification — with PRISMA-trAIce (item M6) and FRAISR both requiring the exact prompt and configuration.
- **Works:** holst2025,degen2024,fernandes2026
- **Anchors:** sources/holst2025.md#evidence;sources/degen2024.md#evidence;sources/fernandes2026.md#evidence
- **Supports:** C03
- **Manuscript:** sec-rq3
- **Scope:** Content comparison of the three disclosure proposals.
- **Caveat:** The shared-core reading is our cross-work synthesis; the instruments' item-level mappings differ and were not formally aligned.

### E016

- **Finding:** The three proposals are structurally distinct instruments — a 14-item PRISMA 2020 extension with a human/AI-split flow diagram, a machine-readable per-stage table (tool name, version, input parameters), and dual conduct-and-reporting tables — and each note records no piloting, validation, or adoption evidence for its instrument.
- **Works:** holst2025,degen2024,fernandes2026
- **Anchors:** sources/holst2025.md#evidence-limits;sources/degen2024.md#evidence-limits;sources/fernandes2026.md#evidence-limits
- **Supports:** C03
- **Manuscript:** sec-rq3,sec-discussion
- **Scope:** Instrument design and validation status of the three proposals.
- **Caveat:** Coexistence without validation does not establish a standards race; absence of adoption evidence in the notes is not proof of non-adoption.

### E017

- **Finding:** Selected conduct guidance keeps a human decision in every stage: the pre-LLM seven-step screening framework orders oversight from dual-independent down to single-reviewer and flags fully autonomous exclusion as inappropriate; the Cochrane-family statement sanctions AI as a secondary quality-assurance reviewer, requires disclosure, and bars AI authorship; HAICO-SLR assigns every stage both roles and sanctions AI first-pass filtering and drafting under human validation — and the independence it manages is human-reviewer independence only.
- **Works:** hamel2021,gartlehner2025,fernandes2026
- **Anchors:** sources/hamel2021.md#evidence;sources/hamel2021.md#bearing-on-rqs;sources/gartlehner2025.md#evidence;sources/fernandes2026.md#evidence
- **Supports:** C03,C04
- **Manuscript:** sec-rq3,sec-rq4,sec-discussion
- **Scope:** Conduct norms in the selected guidance, pre-LLM through 2026.
- **Caveat:** gartlehner2025 and hamel2021 are normative documents, not evaluations; fernandes2026 is an unreviewed SSRN preprint with no piloting of its own guide.

### E018

- **Finding:** Mapping relayed by the field's coordination body found only a very small percentage of reviews openly disclosing advanced AI tools in the education and climate/health domains covered, and no governing body for evaluation standards; one deep read supplies a detailed disclosed-adoption exemplar naming the model, citing PRISMA 2020 item 8, publishing a validation table (κ = 0.79; recall 99.1%, 114/115; false-omission rate 0.48%, 1/207) beside the flow diagram, and revisiting residual risk in limitations.
- **Works:** oconnor2024,mughal2026
- **Anchors:** sources/oconnor2024.md#evidence;sources/mughal2026.md#evidence
- **Supports:** C03
- **Manuscript:** sec-background,sec-rq1,sec-rq3
- **Scope:** Disclosure in practice: the field's own diagnosis plus one exemplar.
- **Caveat:** The rare-disclosure finding is a meeting-report relay of the Bond et al. project, secondhand and domain-limited; the exemplar's pre-filter is self-validated by its own authors with a wide CI on the single observed miss.

### E019

- **Finding:** MedSR-Copilot — four subagents, a fine-tuned risk-of-bias model, and a deterministic synthesis engine, with human review and no debate, voting, or agent redundancy — reached 63.6% end-to-end conclusion accuracy versus a 45.3% best baseline on 100 reviews, with tested ablations attributing −14.9 pp to two-stage extraction and −3.3 pp to retrieval augmentation, and screening F1 of about 0.44–0.51.
- **Works:** huang2026
- **Anchors:** sources/huang2026.md#evidence
- **Supports:** C01,C04
- **Manuscript:** sec-rq1,sec-rq4,sec-discussion
- **Scope:** One end-to-end system evaluated on its authors' own benchmark.
- **Caveat:** Unreviewed preprint with author-built benchmark and baselines; human review and redundancy were not ablated, so the study does not establish either as the causal source of reliability.

### E020

- **Finding:** In an abstract-only record, open-weight models (Mistral v2 7B, Llama 3.3 70B) screened more conservatively than GPT-4.1 across 25,149 titles in three SE domains, with no numeric performance reported.
- **Works:** safarpour2026
- **Anchors:** sources/safarpour2026.md#evidence
- **Supports:** C04
- **Manuscript:** sec-rq4
- **Scope:** Title-only screening for SE scoping reviews, open-weight versus proprietary.
- **Caveat:** Abstract-only — no accuracy or agreement numbers can be extracted; a directional model-behavior contrast awaiting full text.

### E021

- **Finding:** One tool assessed against Cochrane human risk-of-bias judgments on 190 nursing trials agreed at Cohen's kappa 0.60 (allocation concealment), 0.52 (randomization), 0.43 (blinding of personnel), and 0.04 — near chance — for blinding of outcome assessors, with sensitivity 0.44–0.88, specificity 0.48–0.95, and positive predictive value 0.25–0.79 across the same four domains.
- **Works:** hirt2021
- **Anchors:** sources/hirt2021.md#evidence
- **Supports:** C02
- **Manuscript:** sec-rq2
- **Scope:** One pre-LLM appraisal tool, one nursing-trial corpus, RoB-1 domains; a within-tool, within-corpus demonstration that stratum and metric choice change the verdict.
- **Caveat:** Abstract-only; nursing convenience sample drawn from 23 Cochrane reviews of trials published 1958–2016; the tool is a pre-LLM classifier, so this bounds neither LLM appraisal nor current tooling.

### E022

- **Finding:** A registered protocol for a ChatGPT-versus-human risk-of-bias interrater pilot on 75 Cochrane trials reports no empirical results, and operationalizes independence as two different human operators each running the model rather than any model-level control.
- **Works:** rose2025
- **Anchors:** sources/rose2025.md#evidence;sources/rose2025.md#evidence-limits
- **Supports:** C02,C04
- **Manuscript:** sec-rq2
- **Scope:** A design to watch, not a result; the only appraisal-stage independence construct stated anywhere in the deep reads.
- **Caveat:** Protocol with no findings — citing it for any agreement figure would be an error. Its catalog row is coded `evidence: human-agree` from the abstract, describing a planned comparison; the note is authoritative and records the disagreement.

### E023

- **Finding:** A three-agent cross-vendor screening vote (GPT-4o Mini, Claude 3 Haiku, Gemini 1.5 Flash, adjudicated by Gemini 1.5 Pro) beat every constituent — mean average precision 0.341 against 0.271, 0.266, and 0.182, WSS@95% 0.680 — while reporting Spearman correlations of 0.48–0.56 between its agents' scores and concluding that model heterogeneity drives the gain; allowing the agents to debate raised their inter-agent correlation and lowered performance relative to independent voting.
- **Works:** akinseloyin2026
- **Anchors:** sources/akinseloyin2026.md#evidence;sources/akinseloyin2026.md#bearing-on-rqs
- **Supports:** C04
- **Manuscript:** sec-rq4
- **Scope:** Title-abstract screening on two review corpora; the only inter-agent correlation measurement in the deep reads, and the only within-study evidence that interaction erodes ensemble diversity.
- **Caveat:** The three agents differ in vendor, size, and training corpus simultaneously with no same-family arm, so the heterogeneity claim is correlational; a same-vendor adjudicator bias is flagged by the authors but not corrected.

### E024

- **Finding:** A five-model same-family BERT ensemble combined by probability sum reached F1 89.16% against a best standalone member's 88.53%, reporting no correlation, agreement, or error-overlap statistic between its members; requiring unanimity plus a probability threshold reached about 98.5% F1 and 99% recall while deciding roughly half the corpus.
- **Works:** knafou2023
- **Anchors:** sources/knafou2023.md#evidence
- **Supports:** C02,C04
- **Manuscript:** sec-rq2,sec-rq4
- **Scope:** Screening for a living COVID-19 systematic review; a configuration documented without any independence mechanism measured, and a second instance of accuracy bought with deferred coverage.
- **Caveat:** Same-family by construction, so it cannot speak to cross-family diversity; its margin over the best member is under one F1 point, and the bioRxiv preprint could not be re-fetched to confirm it does not differ materially.

### E025

- **Finding:** An international modified Delphi on living evidence synthesis (29 experts, three rounds, ≥80% consensus threshold) reached consensus on 19 of 23 statements, with the authors reporting that agreement ran lowest on the objective, actionable use of automation and digital tools and highest on general statements; its one automation statement to reach consensus is role-neutral.
- **Works:** golob2025
- **Anchors:** sources/golob2025.md#evidence
- **Supports:** C03
- **Manuscript:** sec-rq3
- **Scope:** Living evidence synthesis in health care; the only consensus-formation exercise in the set, and the only measurement of where norm-setting itself stalls.
- **Caveat:** medRxiv preprint, not peer reviewed. The consensus-lowest-on-automation finding rests on the authors' own characterization of their round data; the statement tables render as images and were not machine-readable.

### E026

- **Finding:** A reproducibility checklist for active-learning-aided reviews prescribes fifteen items splitting author pre-registration from software storage — including random seeds, labeling order, and per-iteration model identity and training-set size — motivated by the observation that storing every relevance score scales quadratically with corpus size; its only application is a worked example against one tool, which stores eleven of the fifteen.
- **Works:** lombaers2024
- **Anchors:** sources/lombaers2024.md#evidence
- **Supports:** C03
- **Manuscript:** sec-rq3
- **Scope:** Active-learning screening tools; a reproducible-storage instrument, a different genre from the disclosure-reporting checklists.
- **Caveat:** Unvalidated on any completed review; two of its three authors develop the tool it is checked against, making that a conformance self-check rather than field testing.

### E027

- **Finding:** Across the deep reads and the method canon the field uses at least four umbrella nouns for its object of study and stage models ranging from four phases to twelve steps, while naming the shared stages recognizably alike; the one genuine stage-name split is at appraisal, where quality assessment, risk-of-bias judgment, and appraisal-instrument scoring name three overlapping tasks.
- **Works:** song2026,degen2024,fernandes2026,luo2024,woelfle2024,vandinter2021
- **Anchors:** sources/song2026.md#evidence;sources/degen2024.md#evidence;sources/fernandes2026.md#evidence;sources/luo2024.md#evidence;sources/woelfle2024.md#evidence;sources/vandinter2021.md#evidence
- **Supports:** C06
- **Manuscript:** sec-taxonomy
- **Scope:** Read off titles, abstracts, and note prose across the deep reads plus the four method-canon works (Kitchenham & Charters 2007, Petersen 2008, Wohlin 2014, PRISMA 2020), which are held as library pages rather than record notes and so are named here rather than listed as works; not a term-frequency study over full texts.
- **Caveat:** The canon works above carry no record-note anchors, so this record binds only to the six deep reads. Software-engineering vocabulary claims rest on a 23-row stratum of a 776-row map. The negative finding — that no medicine-versus-SE stage-name split appears — is a claim about the selected notes, not about the literature.

