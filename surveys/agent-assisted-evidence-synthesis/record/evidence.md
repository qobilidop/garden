# Evidence ledger

This file owns the bindings between literature findings, survey claims, and
manuscript use. Each `Exxx` record contains one checkable finding, links
downward to source-note anchors, upward to supported `Cxx` claims, and across
to manuscript sections that cite on its strength. It does not replace the full
reading notes in `sources/`, the survey propositions in `claims.md`, or the
interpretation in `syntheses/`. Scope, caveat, and certainty remain attached to
the finding, and `check.py` enforces the bindings.

## Record schema

- **Finding** — one checkable statement of what the cited literature shows.
- **Works** — comma-separated citekeys, each with a note in `sources/`; a
  `secondary-only` note cannot support an evidence record unless the survey
  explicitly registers a secondhand-evidence exemption in `check.py`.
- **Anchors** — semicolon-separated source-note locations, written as
  `sources/<citekey>.md#<heading>`.
- **Supports** — comma-separated `Cxx` claim identifiers; omitted when the
  finding supports no registered claim.
- **Manuscript** — comma-separated section labels where the finding is used;
  omitted when it is not cited in the manuscript.
- **Scope** — the population, task, comparison, or source region to which the
  finding applies.
- **Caveat** — the limits on what may be inferred from the finding.
- **Certainty** — `high`, `moderate`, or `low`, based on source-note read depth
  and evidence limits using a GRADE-inspired scale; reassessed whenever the
  finding or its evidence changes.


### E001

- **Finding:** In van Dinter et al.'s pre-LLM automation review, all 41 studies from 2006–2020 fell within conducting-the-review: screening dominated, appraisal appeared once, planning and reporting were untouched, and one study used deep learning.
- **Works:** vandinter2021
- **Anchors:** sources/vandinter2021.md#evidence
- **Supports:** C01
- **Manuscript:** sec-background,sec-landscape
- **Scope:** Pre-LLM baseline; searches through 2020, SE and medicine venues.
- **Caveat:** The search is venue/domain-scoped, so absence elsewhere is a search-scope artifact; the counts describe selected publications, not practice at large.
- **Certainty:** high

### E002

- **Finding:** In a living-evidence inventory of 34 tools across 24 studies, exactly one tool (RobotReviewer LIVE) served the publication-update phase, and the authors state their "living evidence" search vocabulary may undercount that phase.
- **Works:** song2026
- **Anchors:** sources/song2026.md#evidence;sources/song2026.md#evidence-limits
- **Supports:** C01,C05
- **Manuscript:** sec-landscape,sec-synthesis
- **Scope:** Living evidence synthesis, medicine; tool counts by phase.
- **Caveat:** Review-of-reviews with a terminology-bounded search; itself a living review (v1, cutoff April 2025), so counts change on update.
- **Certainty:** moderate

### E003

- **Finding:** Luo et al. characterize PRISMA 2020's automation coverage as screening-only; Holst et al. describe PRISMA-AI as announced but unpublished, whereas Fernandes et al. say it was never developed, and the latter two accounts imply that no usable PRISMA-AI instrument was available.
- **Works:** luo2024,holst2025,fernandes2026
- **Anchors:** sources/luo2024.md#evidence;sources/holst2025.md#evidence;sources/fernandes2026.md#evidence
- **Supports:** C03
- **Manuscript:** sec-norms
- **Scope:** Reporting-standard landscape through the deep reads' publication dates.
- **Caveat:** Luo's screening-only characterization is narrower than PRISMA 2020 items 8–9, which cover study selection and data collection. The two PRISMA-AI histories are source characterizations, not an independent registry check.
- **Certainty:** low

### E004

- **Finding:** Independently derived stage vocabularies in the deep reads are non-equivalent: Kitchenham's twelve SLR steps in three categories, luo's nine-stage LLM role map (which splits question, registration, criteria, and search and adds submission), and song's four-phase living-evidence model partition the same pipeline differently.
- **Works:** vandinter2021,luo2024,song2026
- **Anchors:** sources/vandinter2021.md#evidence;sources/luo2024.md#evidence;sources/song2026.md#evidence
- **Supports:** C05
- **Manuscript:** sec-background,sec-taxonomy
- **Scope:** Stage-vocabulary comparison across three deep reads.
- **Caveat:** Divergence motivates but does not validate the survey's own scheme; the cross-vocabulary correspondence is our reading.
- **Certainty:** moderate

### E005

- **Finding:** In a 29-paper convenience sample of LLM-screening evaluations, 7/29 (24%) reported complete confusion matrices, 3/29 (10%) reported MCC, and 17/29 (59%) used accuracy.
- **Works:** madeyski2025
- **Anchors:** sources/madeyski2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-background,sec-performance,sec-synthesis
- **Scope:** Measurement practice in LLM title/abstract-screening evaluations.
- **Caveat:** Convenience sample with single-researcher extraction; numbers are from the arXiv version, not line-checked against the 2026 journal publication.
- **Certainty:** moderate

### E006

- **Finding:** Across nine LLMs and 24 SE reviews (34,528 records), no nondegenerate operating point met the authors' proposed bar of recall ≥ 0.95 at precision ≈ 0.50.
- **Works:** huotala2025
- **Anchors:** sources/huotala2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance
- **Scope:** Zero-shot title/abstract screening on SE secondary studies.
- **Caveat:** Zero-shot prompting only; ground truth reverse-engineered from heterogeneous research artifacts; 13.6% of records dropped for missing abstracts.
- **Certainty:** high

### E007

- **Finding:** Holding prompt and pipeline fixed across five highly imbalanced sepsis questions (41/16,669 human-included), upgrading GPT-3.5 Turbo to GPT-4 Turbo moved pooled specificity from 0.51 to 0.98 (significant) while sensitivity changed from 0.83 to 0.85 (no significant difference).
- **Works:** oami2025
- **Anchors:** sources/oami2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance
- **Scope:** Same-prompt model-upgrade comparison in one clinical-guideline setting.
- **Caveat:** Post hoc research letter, single domain and institution, both models superseded; absolute FP/FN counts not reported.
- **Certainty:** moderate

### E008

- **Finding:** Eight sequential prompt variants on one insomnia review (330 citations) moved GPT-3.5 Turbo screening from 62% sensitivity (80% accuracy) to a highest-sensitivity variant the authors described as similar to a junior reviewer and surpassing a senior reviewer.
- **Works:** gargari2023
- **Anchors:** sources/gargari2023.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance
- **Scope:** Single-review prompt-sensitivity case study.
- **Caveat:** Most per-prompt metrics are directional prose with the full table in an unverified supplement; prompt wording is not isolated from iteration/order effects, and the human comparison is qualitative.
- **Certainty:** low

### E009

- **Finding:** GPT-3.5 Turbo screening recall was 0.327 on the corpus with 52.7% recorded human conflict (MobileMDE) versus 0.738–0.947 on the other four corpora, while run-to-run Fleiss κ was 0.821 and 0.973 on the two corpora tested for consistency.
- **Works:** syriani2023
- **Anchors:** sources/syriani2023.md#evidence
- **Supports:** C02,C04
- **Manuscript:** sec-performance,sec-independence
- **Scope:** Five SE review corpora, one model; stability-versus-validity contrast.
- **Caveat:** The conflict–recall association is not established as causal; consistency was measured on only two of five corpora; numbers are from the arXiv-version transcript.
- **Certainty:** moderate

### E010

- **Finding:** Across three appraisal instruments, every individual LLM scored below every individual human rater, and human inter-rater κ itself fell from 0.84 (PRISMA) to 0.29 (PRECIS-2) as instrument complexity rose.
- **Works:** woelfle2024
- **Anchors:** sources/woelfle2024.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance
- **Scope:** Five 2023–2024 LLMs, appraisal stage, published human-rated datasets.
- **Caveat:** The human reference is two-rater consensus, not adjudicated ground truth; prompts were engineered per model, confounding cross-model ranking.
- **Certainty:** high

### E011

- **Finding:** A 9-run consistency ensemble matched human appraisal accuracy only on items surviving near-unanimous agreement, deferring 74–88% of items at the highest thresholds.
- **Works:** woelfle2024
- **Anchors:** sources/woelfle2024.md#evidence
- **Supports:** C04
- **Manuscript:** sec-independence
- **Scope:** Retrospective appraisal across PRISMA, AMSTAR, and PRECIS-2.
- **Caveat:** Accuracy is conditional on the nondeferred subset; the result does not establish performance at full coverage.
- **Certainty:** high

### E012

- **Finding:** A cross-vendor OR ensemble (GPT-5 Thinking + Gemini 2.5 Pro, two runs each, 736 Cochrane citations) reached 99.7% sensitivity and 49.3% specificity on author-adjudicated labels and 94.0–94.5% sensitivity against the original Cochrane labels; in a post-hoc subgroup with seven positives, GPT-5 single-run sensitivity was 43% while Gemini flagged the same records as ambiguous.
- **Works:** fagerberg2025
- **Anchors:** sources/fagerberg2025.md#evidence
- **Supports:** C04
- **Manuscript:** sec-independence,sec-synthesis
- **Scope:** One multi-domain medicine screening preprint, zero-shot, OR rule.
- **Caveat:** No matched same-family arm isolates family diversity from model identity, run count, or the OR rule; the 18-record adjudication was in-team and moved all changes in the models' favor; unreviewed preprint.
- **Certainty:** moderate

### E013

- **Finding:** Prior estimates relayed by selected sources put single-human screening sensitivity at about 87–92% (range 42–100%) and human extraction errors at up to 50% of data elements.
- **Works:** fagerberg2025,gartlehner2025
- **Anchors:** sources/fagerberg2025.md#evidence;sources/gartlehner2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance
- **Scope:** Human-baseline calibration for reading agent results.
- **Caveat:** These are secondhand citations of prior literature within the selected sources, not measurements made by them.
- **Certainty:** low

### E014

- **Finding:** Selected extraction evidence is heterogeneous in kind: an SE proof-of-concept reports 87.83% accuracy on one mapping study, a 23-study social-science living review computes no pooled benchmark (0 studies applied a tool in a real review; 1 of 23 tools live), and the Cochrane-family statement relays secondhand AI-extraction error rates of 4–31% (median 14%).
- **Works:** felizardo2024,legate2024,gartlehner2025
- **Anchors:** sources/felizardo2024.md#evidence;sources/legate2024.md#evidence;sources/gartlehner2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance
- **Scope:** Extraction stage across SE, social science, and medicine.
- **Caveat:** felizardo2024 is abstract-only with no metric breakdown; the 4–31% ranges are Clark et al.'s figures cited secondhand, not gartlehner2025's own measurements.
- **Certainty:** low

### E015

- **Finding:** Across three disclosure proposals, tool identity/version, stage or task, human role, configuration, and verification recur but do not form a common intersection: FRAISR specifies only stage, tool name/version, and input parameters, while PRISMA-trAIce and HAICO-SLR add human-role and oversight fields.
- **Works:** holst2025,degen2024,fernandes2026
- **Anchors:** sources/holst2025.md#evidence;sources/degen2024.md#evidence;sources/fernandes2026.md#evidence
- **Supports:** C03
- **Manuscript:** sec-norms
- **Scope:** Content comparison of the three disclosure proposals.
- **Caveat:** This is a qualitative element comparison, not a formal item-level alignment; recurrence does not mean that every proposal contains every element.
- **Certainty:** moderate

### E016

- **Finding:** The three proposals are structurally distinct instruments — a 14-item PRISMA 2020 extension with a human/AI-split flow diagram, a machine-readable per-stage table (tool name, version, input parameters), and dual conduct-and-reporting tables — and each note records no piloting, validation, or adoption evidence for its instrument.
- **Works:** holst2025,degen2024,fernandes2026
- **Anchors:** sources/holst2025.md#evidence-limits;sources/degen2024.md#evidence-limits;sources/fernandes2026.md#evidence-limits
- **Supports:** C03
- **Manuscript:** sec-norms,sec-synthesis
- **Scope:** Instrument design and validation status of the three proposals.
- **Caveat:** Coexistence without validation does not establish a standards race; absence of adoption evidence in the notes is not proof of non-adoption.
- **Certainty:** moderate

### E017

- **Finding:** Hamel et al. distinguish fully autonomous score-threshold screening, which they call an inappropriate use, from handling records left after a human-chosen truncation point, where their risk-ranked options place AI-only exclusion at the highest-risk end.
- **Works:** hamel2021
- **Anchors:** sources/hamel2021.md#evidence;sources/hamel2021.md#bearing-on-rqs
- **Supports:** C03,C04
- **Manuscript:** sec-norms,sec-independence,sec-synthesis
- **Scope:** Pre-LLM title/abstract-screening conduct guidance and human-reviewer independence.
- **Caveat:** Normative framework, not an evaluation of autonomous exclusion; the post-truncation ladder does not license fully autonomous thresholding, and its independence construct applies to human reviewers.
- **Certainty:** moderate

### E018

- **Finding:** Mapping relayed by the field's coordination body found only a very small percentage of reviews openly disclosing advanced AI tools in the education and climate/health domains covered, and no governing body for evaluation standards.
- **Works:** oconnor2024
- **Anchors:** sources/oconnor2024.md#evidence
- **Supports:** C03
- **Manuscript:** sec-background,sec-landscape,sec-norms
- **Scope:** Disclosure in practice in the two domains covered by the relayed mapping.
- **Caveat:** Meeting-report relay of the Bond et al. project; secondhand and domain-limited, not a field prevalence estimate.
- **Certainty:** low

### E019

- **Finding:** MedSR-Copilot — four subagents, a fine-tuned risk-of-bias model, and a deterministic synthesis engine, with human review and no debate, voting, or agent redundancy — reached 63.6% end-to-end conclusion accuracy versus a 45.3% best baseline on 100 reviews.
- **Works:** huang2026
- **Anchors:** sources/huang2026.md#evidence
- **Supports:** C01,C04
- **Manuscript:** sec-landscape,sec-independence
- **Scope:** One end-to-end system evaluated on its authors' own benchmark.
- **Caveat:** Unreviewed preprint with author-built benchmark and author-run baselines; the score does not establish which architectural element caused the improvement.
- **Certainty:** moderate

### E020

- **Finding:** In an abstract-only record, open-weight models (Mistral v2 7B, Llama 3.3 70B) screened more conservatively than GPT-4.1 across 25,149 titles in three SE domains, with no numeric performance reported.
- **Works:** safarpour2026
- **Anchors:** sources/safarpour2026.md#evidence
- **Supports:** C04
- **Manuscript:** sec-independence
- **Scope:** Title-only screening for SE scoping reviews, open-weight versus proprietary.
- **Caveat:** Abstract-only — no accuracy or agreement numbers can be extracted; a directional model-behavior contrast awaiting full text.
- **Certainty:** low

### E021

- **Finding:** One tool assessed against Cochrane human risk-of-bias judgments on 190 nursing trials agreed at Cohen's kappa 0.60 (allocation concealment), 0.52 (randomization), 0.43 (blinding of personnel), and 0.04 — near chance — for blinding of outcome assessors, with sensitivity 0.44–0.88, specificity 0.48–0.95, and positive predictive value 0.25–0.79 across the same four domains.
- **Works:** hirt2021
- **Anchors:** sources/hirt2021.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance
- **Scope:** One pre-LLM appraisal tool, one nursing-trial corpus, and four RoB-1 domains; domain choice changes the agreement verdict, while sensitivity, specificity, and predictive value expose different failure modes.
- **Caveat:** Abstract-only; nursing convenience sample drawn from 23 Cochrane reviews of trials published 1958–2016; the tool is a pre-LLM classifier, so this bounds neither LLM appraisal nor current tooling.
- **Certainty:** low

### E022

- **Finding:** A registered protocol for a ChatGPT-versus-human risk-of-bias interrater pilot on 75 Cochrane trials reports no empirical results, and operationalizes independence as two different human operators each running the model rather than any model-level control.
- **Works:** rose2025
- **Anchors:** sources/rose2025.md#evidence;sources/rose2025.md#evidence-limits
- **Supports:** C02,C04
- **Manuscript:** sec-performance,sec-independence
- **Scope:** A design to watch, not a result; the only appraisal-stage independence construct identified in the selected evidence records.
- **Caveat:** Protocol with no findings — citing it for any agreement figure would be an error. Its catalog row is coded `evidence: human-agree` from the abstract, describing a planned comparison; the note is authoritative and records the disagreement.
- **Certainty:** moderate

### E023

- **Finding:** A three-agent cross-vendor screening vote (GPT-4o Mini, Claude 3 Haiku, Gemini 1.5 Flash, adjudicated by Gemini 1.5 Pro) beat every constituent, reaching mean average precision 0.341 against 0.271, 0.266, and 0.182, with WSS@95% of 0.680.
- **Works:** akinseloyin2026
- **Anchors:** sources/akinseloyin2026.md#evidence;sources/akinseloyin2026.md#bearing-on-rqs
- **Supports:** C04
- **Manuscript:** sec-performance,sec-independence
- **Scope:** Title-abstract screening on two review corpora; ensemble-versus-constituent comparison.
- **Caveat:** The three agents differ in vendor, size, and training corpus simultaneously; a same-vendor adjudicator bias is flagged by the authors but not corrected.
- **Certainty:** high

### E024

- **Finding:** A five-model same-family BERT ensemble combined by probability sum reached F1 89.16% against a best standalone member's 88.53%, while reporting no correlation, agreement, or error-overlap statistic between its members.
- **Works:** knafou2023
- **Anchors:** sources/knafou2023.md#evidence
- **Supports:** C02,C04
- **Manuscript:** sec-performance,sec-independence
- **Scope:** Screening for a living COVID-19 systematic review; a configuration documented without any independence mechanism measured.
- **Caveat:** Same-family by construction, so it cannot speak to cross-family diversity; its margin over the best member is under one F1 point, and the bioRxiv preprint could not be re-fetched to confirm it does not differ materially.
- **Certainty:** high

### E025

- **Finding:** An international modified Delphi on living evidence synthesis (29 experts, three rounds, ≥80% consensus threshold) reached consensus on 19 of 23 statements, with the authors reporting that agreement ran lowest on the objective, actionable use of automation and digital tools and highest on general statements; its one automation statement to reach consensus is role-neutral.
- **Works:** golob2025
- **Anchors:** sources/golob2025.md#evidence
- **Supports:** C03
- **Manuscript:** sec-norms
- **Scope:** Living evidence synthesis in health care; the only consensus-formation exercise in the set, and the only measurement of where norm-setting itself stalls.
- **Caveat:** medRxiv preprint, not peer reviewed. The consensus-lowest-on-automation finding rests on the authors' own characterization of their round data; the statement tables render as images and were not machine-readable.
- **Certainty:** moderate

### E026

- **Finding:** A reproducibility checklist for active-learning-aided reviews prescribes fifteen items splitting author pre-registration from software storage — including random seeds, labeling order, and per-iteration model identity and training-set size — motivated by the observation that storing every relevance score scales quadratically with corpus size; in its only worked example, ASReview stores nine items outright and one partly, leaves four to author pre-registration, and treats one as optional.
- **Works:** lombaers2024
- **Anchors:** sources/lombaers2024.md#evidence
- **Supports:** C03
- **Manuscript:** sec-norms,sec-synthesis
- **Scope:** Active-learning screening tools; a reproducible-storage instrument, a different genre from the disclosure-reporting checklists.
- **Caveat:** Unvalidated on any completed review; two of its three authors develop the tool it is checked against, making that a conformance self-check rather than field testing.
- **Certainty:** moderate

### E027

- **Finding:** Across the thirteen local sources registered below and the four method-canon works, the field uses at least four umbrella nouns for its object of study and stage models ranging from four phases to twelve steps, while naming the shared stages recognizably alike; the clearest stage-name split is at appraisal, where quality assessment, risk-of-bias judgment, and appraisal-instrument scoring name three overlapping tasks.
- **Works:** song2026,degen2024,fernandes2026,luo2024,woelfle2024,vandinter2021,gartlehner2025,hamel2021,napoleao2021,arno2022,hirt2021,rose2025,huang2026
- **Anchors:** sources/song2026.md#evidence;sources/degen2024.md#evidence;sources/fernandes2026.md#evidence;sources/luo2024.md#evidence;sources/woelfle2024.md#evidence;sources/vandinter2021.md#evidence;sources/gartlehner2025.md#evidence;sources/hamel2021.md#evidence;sources/napoleao2021.md#evidence;sources/arno2022.md#evidence;sources/hirt2021.md#evidence;sources/rose2025.md#evidence;sources/huang2026.md#evidence
- **Supports:** C06
- **Manuscript:** sec-taxonomy
- **Scope:** Read off titles, abstracts, and note prose in the thirteen local notes plus four method-canon works (Kitchenham & Charters 2007, Petersen 2008, Wohlin 2014, PRISMA 2020), whose canonical notes live in the library; not a term-frequency study over full texts.
- **Caveat:** The canon works carry no local record-note anchors. This comparison does not audit every selected note, and the software-engineering vocabulary rests on a small stratum of the medicine-heavy map.
- **Certainty:** low

### E028

- **Finding:** Napoleão et al.'s pre-LLM cross-domain map identified eight practice-adopted screening tools in medicine and two in software engineering.
- **Works:** napoleao2021
- **Anchors:** sources/napoleao2021.md#evidence
- **Supports:** C01
- **Manuscript:** sec-background,sec-landscape,sec-synthesis
- **Scope:** Practice-adopted screening tools in the medicine and software-engineering studies selected by that map.
- **Caveat:** The comparison is scoped to the source's searches and adoption definition; it is not a worldwide practice census and cannot be trended against this survey's publication counts.
- **Certainty:** high

### E029

- **Finding:** In a 9,695-record reanalysis, the accuracy-best, MCC-best, and WMCC-best systems were different models; they lost 63.3%, 43.9%, and 5.8% of relevant evidence, respectively.
- **Works:** madeyski2025
- **Anchors:** sources/madeyski2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance,sec-synthesis
- **Scope:** One imbalanced screening dataset reanalyzed under three ranking metrics.
- **Caveat:** Numbers are from the arXiv version, not line-checked against the 2026 journal publication; one dataset demonstrates ranking sensitivity but not its prevalence.
- **Certainty:** moderate

### E030

- **Finding:** Human–LLM agreement-gated deferral reached 95–96% accuracy while sparing about 65–70% of second-reviewer item count on PRISMA/AMSTAR, and 80–86% accuracy while sparing about 29% on PRECIS-2.
- **Works:** woelfle2024
- **Anchors:** sources/woelfle2024.md#evidence
- **Supports:** C04
- **Manuscript:** sec-independence,sec-synthesis
- **Scope:** Retrospective appraisal on two easier instruments plus PRECIS-2.
- **Caveat:** Supports deferral for these instruments, not a general design law; human time savings were not measured, only item-count deferral fractions.
- **Certainty:** high

### E031

- **Finding:** In a randomized study, ML-assisted risk-of-bias assessment was noninferior to unassisted assessment (88.8% versus 90.2%), while the time-saving result was inconclusive.
- **Works:** arno2022
- **Anchors:** sources/arno2022.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance
- **Scope:** One real-review-team trial of a pre-LLM risk-of-bias tool.
- **Caveat:** Abstract-only; 7 of 15 recruited teams completed, and the result establishes noninferiority rather than superiority.
- **Certainty:** low

### E032

- **Finding:** One deep read reports a disclosed-adoption exemplar that names the model, cites PRISMA 2020 item 8, publishes a validation table (κ = 0.79; recall 99.1%, 114/115; false-omission rate 0.48%, 1/207), and revisits residual risk in its limitations.
- **Works:** mughal2026
- **Anchors:** sources/mughal2026.md#evidence
- **Supports:** C03
- **Manuscript:** sec-landscape,sec-norms
- **Scope:** One software-engineering systematic review's recall-oriented screening pre-filter.
- **Caveat:** Self-reported and self-validated; the false-omission estimate rests on one observed miss and therefore has a wide interval.
- **Certainty:** moderate

### E033

- **Finding:** Requiring unanimity plus a probability threshold in a five-model BERT ensemble reached about 98.5% F1 and 99% recall while deciding roughly half the corpus.
- **Works:** knafou2023
- **Anchors:** sources/knafou2023.md#evidence
- **Supports:** C02,C04
- **Manuscript:** sec-performance,sec-independence
- **Scope:** Screening/triage for one living COVID-19 systematic-review corpus.
- **Caveat:** High performance is conditional on deferring roughly half the corpus; labels came from one crowdsourced annotation team and the result does not measure human time.
- **Certainty:** high

### E034

- **Finding:** An abstract-only human–AI framework spans screening through thematic analysis, routes decisions by an AI-confidence threshold under human oversight, and proposes evaluation against a previously human-conducted review.
- **Works:** brincoveanu2025
- **Anchors:** sources/brincoveanu2025.md#evidence
- **Supports:** C04
- **Manuscript:** sec-independence
- **Scope:** One software-engineering/IS framework described in a publisher abstract; a threshold-gated collaboration design.
- **Caveat:** Abstract-only, with no extractable threshold, accuracy, error-rate, workload, or human-checkpoint values; supports a configuration description, not an effectiveness claim.
- **Certainty:** low

### E035

- **Finding:** Within SESR-Eval, pooled versus per-review aggregation changed model comparisons on the same screening data.
- **Works:** huotala2025
- **Anchors:** sources/huotala2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance,sec-synthesis
- **Scope:** Nine LLMs evaluated across 24 software-engineering reviews.
- **Caveat:** Zero-shot prompting only; the reference labels were reverse-engineered from heterogeneous research artifacts.
- **Certainty:** high

### E036

- **Finding:** Within SESR-Eval, per-study performance spread exceeded differences among the larger tested models.
- **Works:** huotala2025
- **Anchors:** sources/huotala2025.md#evidence
- **Supports:** C02
- **Manuscript:** sec-performance,sec-synthesis
- **Scope:** Study effects in one multi-model, multi-review screening benchmark.
- **Caveat:** The comparison holds within this benchmark and tested model set; it is not a field-wide ranking of dataset versus model effects.
- **Certainty:** high

### E037

- **Finding:** The Cochrane-family position statement sanctions AI as a secondary quality-assurance reviewer, requires disclosure and verification, and keeps authorship and accountability human.
- **Works:** gartlehner2025
- **Anchors:** sources/gartlehner2025.md#evidence
- **Supports:** C03,C04
- **Manuscript:** sec-norms
- **Scope:** Normative guidance for rapid reviews.
- **Caveat:** Position statement, not an evaluation of the recommended reviewer configuration.
- **Certainty:** moderate

### E038

- **Finding:** HAICO-SLR assigns human and AI roles at every stage, permits AI first-pass filtering and drafting under human validation, and keeps question formulation and final synthesis human-led.
- **Works:** fernandes2026
- **Anchors:** sources/fernandes2026.md#evidence
- **Supports:** C03,C04
- **Manuscript:** sec-norms,sec-synthesis
- **Scope:** Conduct and reporting guidance for human–AI collaboration.
- **Caveat:** Unreviewed SSRN preprint whose guide has no reported piloting or field validation.
- **Certainty:** moderate

### E039

- **Finding:** MedSR-Copilot's ablations attributed losses of 14.9 percentage points to removing two-stage extraction, 7.6 points to removing tournament reranking, and 3.3 points to removing retrieval augmentation.
- **Works:** huang2026
- **Anchors:** sources/huang2026.md#evidence
- **Supports:** C01,C04
- **Manuscript:** sec-landscape
- **Scope:** Component ablations on the authors' end-to-end benchmark.
- **Caveat:** Human review and redundancy were not ablated, so the study does not establish either as a causal source of performance.
- **Certainty:** moderate

### E040

- **Finding:** MedSR-Copilot reported screening F1 of about 0.44–0.51 despite its 63.6% end-to-end conclusion accuracy.
- **Works:** huang2026
- **Anchors:** sources/huang2026.md#evidence
- **Supports:** C01
- **Manuscript:** sec-landscape
- **Scope:** Stage-versus-end-to-end performance within one system and author-built benchmark.
- **Caveat:** The two scores use different endpoints and should not be treated as a direct numerical contradiction.
- **Certainty:** moderate

### E041

- **Finding:** The three-agent screening study reported Spearman correlations of 0.48–0.56 between its agents' scores and attributed the voting ensemble's gain to model heterogeneity.
- **Works:** akinseloyin2026
- **Anchors:** sources/akinseloyin2026.md#evidence;sources/akinseloyin2026.md#bearing-on-rqs
- **Supports:** C04
- **Manuscript:** sec-independence
- **Scope:** The only inter-agent correlation measurement in the selected evidence records.
- **Caveat:** Vendor, size, and training corpus vary together with no matched same-family arm, so the causal attribution outruns the correlational design.
- **Certainty:** high

### E042

- **Finding:** In the same screening study, allowing agents to debate raised inter-agent correlation and lowered performance relative to independent voting.
- **Works:** akinseloyin2026
- **Anchors:** sources/akinseloyin2026.md#evidence;sources/akinseloyin2026.md#bearing-on-rqs
- **Supports:** C04
- **Manuscript:** sec-independence
- **Scope:** Within-study comparison of debate variants against independent voting.
- **Caveat:** Supports interaction changing diversity and performance in this design; it does not define independence or isolate which agent difference produced the original diversity.
- **Certainty:** high
