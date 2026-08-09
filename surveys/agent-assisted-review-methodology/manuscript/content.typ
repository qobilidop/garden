= Introduction

A systematic review is itself a pipeline — search, screening, data
extraction, quality appraisal, synthesis, and reporting — and every
stage of that pipeline is now a target for automation by large
language models (LLMs) and agent systems. The result is a
fast-growing methodology literature that evaluates, systematizes, and
regulates this automation, scattered across medicine (where evidence
synthesis is core infrastructure), software engineering (SE, which
imported the method), and general venues.

This paper surveys that literature as an exploratory systematic map
@petersen2008. The search was LLM-motivated but admitted the broader
AI/ML automation lineage; the result aims at consistent vocabulary and
classified coverage of the retained catalog, not exhaustive retrieval
or pooled effect estimates. It asks four questions:

- *RQ1 (landscape):* What AI-assisted methods, systems, and workflows
  appear at each stage of secondary studies in the retained map?
- *RQ2 (reliability):* How do the selected deep reads measure model
  performance, and what do those measurements show?
- *RQ3 (norms):* What guidance, reporting, or disclosure standards
  exist for AI assistance in evidence synthesis?
- *RQ4 (exploratory design gap):* Among the selected deep reads, which
  designs address reviewer independence and multi-model ensembling?

The paper contributes:

+ a consistent terminology and a four-dimensional taxonomy for the
  field (@sec-taxonomy);
+ a faceted map of 646 included works (2020–2026), after resolving
  known version aliases and retractions in the campaign catalog
  (@sec-rq1);
+ a scoped synthesis of what the selected evidence shows about reliability
  (@sec-rq2), norms (@sec-rq3), and multi-model design (@sec-rq4);
  and
+ a curated, annotated reading list of the works that anchor the
  field, organized by the taxonomy and maintained on the survey's
  landing page.

@sec-background positions the survey against prior reviews.
@sec-taxonomy fixes terminology and the taxonomy. @sec-method
describes how the survey was made. Four sections then answer the
RQs, @sec-discussion collects the findings and open problems, and
@sec-threats states limitations.

= Background and Related Surveys <sec-background>

The pre-LLM baseline is well documented. van Dinter et al.'s
landscape review (#cite(<vandinter2021>, form: "year")#[;] 41
automation studies, 2006–2020) found every study in Kitchenham's
conducting-the-review phase (#cite(<kitchenham2007>, form: "year")) —
screening dominant, appraisal nearly empty, planning and reporting
untouched, and exactly one deep-learning study in the corpus.
Napoleão et al.'s cross-domain mapping
(#cite(<napoleao2021>, form: "year")) quantified the adoption gap
between medicine and software engineering: eight practice-adopted
screening tools in medicine versus two in SE. The classic method
canon — review guidelines @kitchenham2007, mapping-study procedure
@petersen2008, snowballing @wohlin2014, and PRISMA 2020 reporting
@page2021 — predates LLMs and supplies both the vocabulary of this
survey and the method now under automation pressure. Earlier primary
classifiers are covered mainly through those reviews, but the broad
automation vocabulary also admitted several 2020–2022 primary ML works
and a 2022 RobotReviewer RCT. The map is therefore neither LLM-only nor
a comprehensive search of pre-LLM primary studies.

Four deep-read secondary sources illustrate narrower views of the field.
#cite(<luo2024>, form: "prose") survey potential LLM roles stage by
stage as a viewpoint; the International Collaboration for the
Automation of Systematic Reviews reports community progress and
evaluation threads @oconnor2024; #cite(<song2026>, form: "prose")
inventory tools for living evidence synthesis; and
#cite(<madeyski2025>, form: "prose") review 29 LLM-screening
evaluations with a methodological focus. Among these four sources, each
centers one stage, community, or lifecycle; this survey instead uses one
vocabulary to organize stages, settings, and norms. This is a framing
difference among the deep reads, not a literature-wide novelty claim.

= Terminology and Taxonomy <sec-taxonomy>

The literature's vocabulary is inconsistent across its three home
communities; we fix the following usage for this survey.

*Secondary studies and stages.* A _secondary study_ is a systematic
review, systematic map, or related evidence synthesis over primary
studies. Its pipeline stages, in the canonical vocabulary
@kitchenham2007 @page2021: _search_ (query design and study
identification), _screening_ (title/abstract and full-text
selection), _extraction_ (structured data capture from included
studies), _appraisal_ (quality and risk-of-bias assessment),
_synthesis_ (qualitative or quantitative aggregation), and
_reporting_ (writing and disclosure).

*Assistance configurations.* We use _LLM assistance_ for a single
model performing a bounded task under prompting, and _agent_ loosely
for an LLM-based system acting with some autonomy inside the
pipeline. Multi-model designs occurring in the literature: _ensembles_
(multiple models vote, or a union/OR rule pools their includes),
_agreement-gated deferral_ (decisions where model and human agree are
accepted; disagreements go to a second human), and _end-to-end
systems_ (agentic pipelines spanning most or all stages, typically
with task decomposition and human gates). The guidance literature
distinguishes the AI-as-_secondary-reviewer_ role (quality-assurance
checks on human decisions — a repeatedly sanctioned configuration in
the selected guidance) from
AI-as-_primary-reviewer_ (the model makes first-pass decisions a
human oversees).

*Taxonomy.* The map assigns each row one abstract-level primary-focus
value on four dimensions (@tab-scheme). The scheme was built by
keywording — extracting candidate facet values from abstracts
@petersen2008 — and allowed to evolve during classification. Stage uses
the primary objective or evaluation endpoint; _meta_ takes works about
the review process or field, and _end-to-end_ requires at least four
operational stages. The evidence facet records the comparison described
in an abstract, not study quality or certainty.

#figure(
  table(
    columns: (auto, 24em),
    align: (left, left),
    table.header([Dimension], [Values]),
    [Primary-focus stage], [search, screen, extract, appraise, synthesize, report;
      _end-to-end_ for whole-pipeline systems; _meta_ for works about
      the process or field as a whole (surveys, guidance, community
      reports)],
    [Contribution], [method, system/tool, evaluation/benchmark,
      guideline/norms, position],
    [Evidence label], [human/reference-label agreement, benchmark-only,
      none; not a quality rating],
    [Setting], [medicine and evidence-based medicine, software
      engineering, general],
  ),
  caption: [The four-dimensional, single-valued abstract-coding scheme.],
) <tab-scheme>

= How This Survey Was Made <sec-method>

The survey was compiled with LLM-agent assistance under human
direction: agent passes performed search, screening, classification,
and deep reading; the author set the protocol, approved the scheme,
and gated every stage. Eleven logical queries ran against OpenAlex,
Crossref, Semantic Scholar, and arXiv (window 2020-01-01 to
2026-08-08, English); ten succeeded and one Semantic Scholar query
ended in a persistent 429. Results were relevance-sorted with a cap of
50 records. Review-side vocabulary such as "systematic review" and
"evidence synthesis" was paired with model-side vocabulary spanning
LLMs, agents, automation, AI, and ML.

The first 412 candidates received two agent screening passes with
adjudication. A single backward+forward snowball round @wohlin2014 then
used a title-vocabulary pre-filter; its 881 retained candidates received
one screening pass and a verification pass over included decisions. The
wave was not iterated to saturation. Facets were assigned once from
truncated abstracts. A post-campaign integrity pass resolved 24
version/duplicate rows and removed two retracted works, leaving 646
included works; this corrected classified catalog is the map.
@tab-funnel separates the historical campaign funnel from the current
record.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, right, right),
    table.header([Phase], [In], [Out]),
    [Search (11-query set; 10 succeeded)], [—], [419 unique],
    [Dedup (arXiv–DOI)], [419], [412],
    [Dual-pass screen + adjudication], [412], [139 includes],
    [Snowball round (pre-filtered)], [139 seeds], [1,204 new],
    [Vocabulary pre-screen], [1,204], [881],
    [Wave-2 screen + verification], [881], [533 includes],
    [Campaign close], [1,291 rows], [672 included rows],
    [Integrity correction], [672 included rows], [*646 works*],
    [Current unresolved park], [646 non-included rows], [12 U rows],
    [Facet classification], [646], [the map],
    [Deep reads], [646], [25 notes],
  ),
  caption: [Identification and selection funnel. Phase quantities are
    retained historical aggregates: candidate-level wave/source
    provenance was pruned and cannot regenerate them. The 323
    vocabulary rejects were not cataloged; two of 881 screened rows
    merged on entry (412 + 879 = 1,291). The integrity pass resolved 24
    version aliases and removed two retracted works. A later publication
    migration leaves the current identifier ledger at 1,292 rows.],
) <tab-funnel>

25 works were selected facet-guided for deep reads as candidate
anchors: 20 read in full text, 5 abstract-only (one with no
retrievable text at all, reconstructed secondhand). 23 of the 25
cleared the curation bar and anchor the reading list and the
citations below; citations resting on abstract-only evidence carry
an "abstract-only" marker. The survey record linked in the title note
holds the update contract, search-attempt log, corrected catalog, and
per-work evidence notes. It is a minimal public record; process history
remains in git.

= RQ1 — Landscape: primary-focus coding of the retained map <sec-rq1>

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    align: (left, right, right, right, right, right, right, right),
    table.header(
      [Stage], [Med], [SE], [Gen], [Total],
      [Hum], [Bench], [None],
    ),
    [Search], [26], [1], [21], [48], [11], [16], [21],
    [Screen], [134], [8], [74], [216], [113], [62], [41],
    [Extract], [82], [1], [24], [107], [54], [38], [15],
    [Appraise], [22], [0], [3], [25], [15], [5], [5],
    [Synthesize], [18], [1], [17], [36], [9], [9], [18],
    [Report], [12], [3], [7], [22], [8], [4], [10],
    [End-to-end], [48], [1], [36], [85], [30], [10], [45],
    [Meta], [52], [2], [53], [107], [9], [8], [90],
    [*Total*], [*394*], [*17*], [*235*], [*646*], [*249*], [*152*],
    [*245*],
  ),
  caption: [Single-pass abstract coding: primary-focus stage × setting
    (medicine, SE, general) and stage × evidence label
    (human/reference-label agreement, benchmark-only, none). The
    evidence labels are not quality assessments.],
) <tab-map>

@tab-map summarizes the corrected map. Screening is the primary-focus
label for 216 of 646 works, about a third; reporting (22) and appraisal
(25) are the smallest categories. The map also contains 34
guideline-contribution works and 85 end-to-end rows, categories absent
from van Dinter et al.'s 2006–2020 corpus @vandinter2021. By primary
contribution, evaluation/benchmark works are most common (324), followed
by methods (127), systems/tools (105), positions (56), and guidelines
(34). These are unvalidated abstract-level labels, so their exact
differences describe the retained coding rather than population
prevalence.

Among the deep reads, MedSR-Copilot @huang2026 is a preprint evaluated
on its authors' own benchmark. Its four subagents, fine-tuned
risk-of-bias model, and deterministic synthesis engine reached 63.6%
end-to-end conclusion accuracy against a 45.3% best baseline on 100
reviews. The system uses task decomposition, structured intermediate
artifacts, and human review, with no debate, voting, or agent redundancy.
Its tested ablations attribute −14.9 percentage points to removing
two-stage extraction and −3.3 points to removing retrieval augmentation;
human review and redundancy were not ablated, so the study does not
establish either as the causal source of reliability. Its screening F1
of about 0.44–0.51 also qualifies the meaning of "end-to-end." In Song
et al.'s 34-tool living-evidence inventory, one tool served the
publication-update phase; the authors warn that their "living evidence"
terminology may undercount that phase @song2026.

The setting facet assigns 394 works to medicine and 17 to software
engineering. These incommensurable publication counts do not show that
the practice-adoption gap measured by Napoleão et al. has widened
@napoleao2021; they show only this map's medicine-heavy distribution.
No included row is jointly coded `setting=se` and
`contribution=guideline`. Mapping relayed by the field's coordination
body found AI use rarely disclosed in the education and climate/health
domains it covered @oconnor2024. Mughal et al. provide one detailed
disclosed-adoption exemplar among the deep reads @mughal2026.

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

= RQ3 — Norms: shared content, coexisting proposals <sec-rq3>

The guidance sources share a disclosure core: name the tool and
version, state which stage the AI performed and what the human did,
and describe verification. The PRISMA-trAIce checklist @holst2025 and
FRAISR @degen2024 add the exact prompt and configuration; the conduct
guidance — the pre-LLM screening guidance
@hamel2021, the Cochrane-family statements @gartlehner2025, and
HAICO-SLR @fernandes2026 — keeps a human decision in every stage,
and its LLM-era members add human accountability (no AI
authorship). In the
Cochrane-family guidance the sanctioned role for AI is a _secondary_
quality-assurance reviewer, re-checking single-reviewer exclusions
and extractions; HAICO-SLR goes further, sanctioning AI first-pass
filtering and drafting under human validation @fernandes2026.

Three unvalidated deep-read proposals coexist: PRISMA-trAIce's 14 items and
human/AI-split flow diagram @holst2025, FRAISR's per-stage
machine-readable table @degen2024, and HAICO-SLR's dual
conduct-and-reporting tables @fernandes2026. A layer of position
statements sits beside them: the Cochrane-family statements endorse the
RAISE guidance @gartlehner2025, while the officially announced PRISMA-AI
remains unpublished and PRISMA 2020 itself covers automation only at the
selection items @luo2024. The three proposals'
evidence notes report no validation or adoption evidence; coexistence
alone does not establish a standards race. O'Connor et al. relay rare
disclosure in the education and climate/health domains they discuss
@oconnor2024. One detailed practice exemplar among the deep reads names
the model, cites a PRISMA item, publishes a validation table beside the
flow diagram, and revisits residual risk in limitations @mughal2026.

= RQ4 — Independence: an exploratory deep-read gap <sec-rq4>

The 25 selected deep reads contain two designed multi-model or
human–model comparisons, two indirect signals, and one system with no
redundancy. This is an exploratory subset, not an exhaustively searched
class:

- A cross-vendor OR ensemble (GPT-5 Thinking + Gemini 2.5 Pro, two runs
  each, 736 Cochrane citations) reached 99.7% sensitivity and 49.3%
  specificity on the authors' adjudicated labels; against the original
  Cochrane labels its sensitivity was 94.0–94.5% @fagerberg2025. The
  preprint's post-hoc vaccine subgroup had seven positives: GPT-5
  sensitivity was 43% while Gemini flagged the same ambiguous records.
  The design has no matched same-family arm and does not isolate model
  family, model identity, duplicate runs, and the OR rule as causes.
- A 9-run consistency ensemble reached human-level appraisal accuracy
  only on items surviving near-unanimous agreement, deferring 74–88%
  of items; the _deferral_ design — human + LLM score, send
  disagreements to a second human — beat both humans-alone and
  ensembles at 95–96% accuracy while sparing \~65–70% of
  second-reviewer item count on the two easier retrospective appraisal
  instruments; on PRECIS-2 it reached 80–86% while sparing about 29%
  @woelfle2024. The reference was two-rater consensus, prompts differed
  by model, and time savings were not measured. This supports deferral
  for these instruments, not a general design law.
- An abstract reports that open-weight models screened more
  conservatively than GPT-4.1 across 25k titles — a model-behavior
  contrast awaiting full-text numbers
  @safarpour2026[abstract-only].
- High self-consistency coexists with mediocre accuracy — run-to-run
  Fleiss κ 0.82–0.97 on the two corpora tested @syriani2023 —
  stability is not validity.
- One selected end-to-end preprint uses no redundancy @huang2026; that
  architecture is descriptive and supplies no comparison of independence
  mechanisms.

None of the 25 selected deep reads explicitly defines what makes two
agent passes _independent_ in the sense dual human review requires —
different prompts, tiers, vendors, or training corpora — or measures
correlated error from shared training data. The campaign had no targeted
independence/ensemble query and no independence facet, so this observation
cannot establish a literature-wide absence. It motivates a targeted
follow-up to the human-independence concerns in earlier guidance
@hamel2021.

= Synthesis and Open Problems <sec-discussion>

#figure(
  table(
    columns: (2.2em, 27em, 12em),
    align: (left, left, left),
    table.header([RQ], [Finding], [Evidence]),
    [1], [Single-pass primary-focus coding assigns 216 of 646 works to
      screening; appraisal (25) and reporting (22) are smallest], [map],
    [1], [The retained map is medicine-heavy (394 rows) relative to SE
      (17); this is not an adoption-trend measure], [map;
      @napoleao2021],
    [1], [One end-to-end preprint uses decomposition, structured
      artifacts, human review, and no redundancy; only extraction and
      retrieval contributions were ablated], [@huang2026],
    [1], [One of 34 tools in a living-evidence inventory served the
      publication-update phase; terminology may undercount it], [@song2026],
    [2], [In SESR-Eval, no nondegenerate operating point among nine
      models × 24 SE reviews met the authors' proposed recall/precision
      bar], [@huotala2025],
    [2], [Within SESR-Eval, study effects exceeded differences among the
      larger tested models], [@huotala2025],
    [2], [Across five imbalanced sepsis questions, a model upgrade changed
      specificity much more than sensitivity], [@oami2025],
    [2], [In a 29-paper convenience sample, confusion-matrix and
      imbalance-aware reporting were uncommon], [@madeyski2025],
    [3], [Three deep-read disclosure proposals coexist without reported
      validation or adoption evidence], [@holst2025 @degen2024
      @fernandes2026],
    [4], [A cross-vendor OR ensemble preprint reports 99.7% sensitivity
      on author-adjudicated labels and 94.0–94.5% on original labels;
      family diversity was not isolated], [@fagerberg2025],
    [4], [Human–LLM deferral outperformed comparison arms on two easier
      retrospective appraisal instruments, not as a general law],
      [@woelfle2024],
    [4], [None of 25 selected deep reads defines agent-reviewer
      independence; the campaign did not search or code the question
      exhaustively], [deep-read subset; @hamel2021],
  ),
  caption: [Summary of findings with their evidence.],
) <tab-findings>

@tab-findings condenses descriptive, differently scoped findings. The
selected studies show heterogeneous absolute performance, several
workflow structures (decomposition, human review, deferral, OR
ensembling), and recurring measurement deficiencies under class
imbalance. Their designs and datasets are not commensurate enough to rank
structure, scale, redundancy, and methodology as causal bottlenecks.

Priorities suggested by the retained map, rather than demonstrated
literature absences, include: a targeted definition and measurement
study of reviewer _independence_ for agents (@sec-rq4); deeper evidence
for the small appraisal, synthesis, and reporting categories; work in
the map's underrepresented SE setting; publication-update tools beyond
the terminology-sensitive inventory @song2026; validation and adoption
studies for the three disclosure proposals; and norms for agent-primary
configurations. The Cochrane-family guidance keeps AI as a secondary
checker, while HAICO-SLR sanctions first-pass roles under human
validation @fernandes2026.

= Limitations <sec-threats>

Search coverage is bounded by relevance-sorted top-50 caps, one failed
query in an 11-query set, English-only retrieval, and one snowball round
not iterated to saturation. The title pre-filter reintroduces the
terminology dependence snowballing exists to escape @wohlin2014; the
initial model-vocabulary list and candidate-level wave provenance were
not retained. Twelve records remain unresolved as U.

Screening and classification read truncated abstracts (600–900
characters); the second wave and every facet were single-pass, with no
retained model/prompt-level audit trail. The integrity review resolved
24 known version aliases and removed two retracted rows, but cannot prove
that no semantically renamed duplicate remains. The facet labels are not
quality assessments. For 8 of 25 deep reads, full-text notes disagree
with abstract-level facets; the map remains as coded and notes are
authoritative for those works. Deep-read extraction had no second pass,
and its 25 facet-guided selections do not support literature-wide absence
claims. RQ4 had no targeted query or coding facet. Medicine accounts for
394 of 646 rows, so selected thresholds and examples are
medicine-calibrated.

= Conclusion

In this corrected exploratory map, screening is the most common
primary-focus label, appraisal and reporting are the smallest, and the
catalog is medicine-heavy. The selected reliability studies report
heterogeneous performance and show that metric choice under class
imbalance can change model rankings. Three deep-read disclosure
proposals share a core but lack validation or adoption evidence. The
selected multi-model studies document specific ensemble and deferral
configurations without isolating a general independence mechanism. None
of the 25 deep reads defines independent agent reviewers; establishing
whether the wider literature does so requires a targeted search.

The map data behind this survey, the per-work evidence notes, and a
curated reading list organized by the taxonomy of @sec-taxonomy are
maintained on the survey's landing page and in the public survey
record.

#bibliography(
  "references.bib",
  full: true,
  style: "apa",
  title: [References],
)
