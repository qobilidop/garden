= Introduction

A systematic review is itself a pipeline — search, screening, data
extraction, quality appraisal, synthesis, and reporting — and every
stage of that pipeline is now a target for automation by large
language models (LLMs) and agent systems. The result is a
fast-growing methodology literature that evaluates, systematizes, and
regulates this automation, scattered across medicine (where evidence
synthesis is core infrastructure), software engineering (SE, which
imported the method), and general venues.

This paper surveys that literature as a systematic map
@petersen2008: it aims at consistent vocabulary and classified
coverage rather than pooled effect estimates, asking four questions:

- *RQ1 (landscape):* What methods, systems, and workflows exist for
  LLM/agent assistance at each stage of secondary studies?
- *RQ2 (reliability):* How is agent performance measured, and what do
  the measurements show?
- *RQ3 (norms):* What guidance, reporting, or disclosure standards
  exist for AI assistance in evidence synthesis?
- *RQ4 (design gap):* Which designs address independence and
  ensembling across model families, and what remains open?

The paper contributes:

+ a consistent terminology and a four-dimensional taxonomy for the
  field (@sec-taxonomy);
+ a faceted map of 672 included works (2020–2026), classified under
  that taxonomy from a catalog of 1,291 candidates (@sec-rq1);
+ a synthesis of what the evidence shows about reliability
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
survey and the method now under automation pressure. Pre-LLM screening classifiers (text mining for study
identification, Cochrane's classifiers) are covered through their
existing reviews; their primary studies were not re-screened.

LLM-era secondary literature exists but is narrower than this map.
#cite(<luo2024>, form: "prose") survey potential LLM roles stage by
stage as a viewpoint; the International Collaboration for the
Automation of Systematic Reviews reports community progress and
evaluation threads @oconnor2024; #cite(<song2026>, form: "prose")
inventory tools for living evidence synthesis; and
#cite(<madeyski2025>, form: "prose") review 29 LLM-screening
evaluations with a methodological focus. Each covers one stage, one
community, or one lifecycle; none spans stages, settings, and norms
together under one vocabulary, which is the gap this survey fills.

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
checks on human decisions — the most commonly sanctioned
configuration) from
AI-as-_primary-reviewer_ (the model makes first-pass decisions a
human oversees).

*Taxonomy.* The map classifies each work on four dimensions
(@tab-scheme). The scheme was built by keywording — extracting candidate facet
values from abstracts @petersen2008 — and allowed to evolve during
classification.

#figure(
  table(
    columns: (auto, 24em),
    align: (left, left),
    table.header([Dimension], [Values]),
    [Stage], [search, screen, extract, appraise, synthesize, report;
      _end-to-end_ for whole-pipeline systems; _meta_ for works about
      the process or field as a whole (surveys, guidance, community
      reports)],
    [Contribution], [method, system/tool, evaluation/benchmark,
      guideline/norms, position],
    [Evidence], [human-agreement measured, benchmark-only, none],
    [Setting], [medicine and evidence-based medicine, software
      engineering, general],
  ),
  caption: [The four-dimensional classification scheme.],
) <tab-scheme>

= How This Survey Was Made <sec-method>

The survey was compiled with LLM-agent assistance under human
direction: agent passes performed search, screening, classification,
and deep reading; the author set the protocol, approved the scheme,
and gated every stage. Searches ran against OpenAlex, Crossref,
Semantic Scholar, and arXiv (window 2020-01-01 to 2026-08-08,
English), pairing review-side vocabulary ("systematic review",
"evidence synthesis", "citation screening", …) with model-side
vocabulary ("large language model", agent, automation). Candidates
were screened by two agent passes on different model tiers and
prompt framings, with disagreements adjudicated; one
backward+forward snowball round @wohlin2014 followed, with a
title-vocabulary pre-filter and a verification pass over what it
screened in. All 672 included works ("includes" below) were
classified under the taxonomy of @sec-taxonomy; we call the
resulting classified catalog the map. @tab-funnel summarizes the
funnel.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, right, right),
    table.header([Phase], [In], [Out]),
    [Search (11 queries, 4 indexes)], [—], [419 unique],
    [Dedup (arXiv–DOI)], [419], [412],
    [Dual-pass screen + adjudication], [412], [139 includes],
    [Snowball round (pre-filtered)], [139 seeds], [1,204 new],
    [Vocabulary pre-screen], [1,204], [881],
    [Wave-2 screen + verification], [881], [533 includes],
    [Final catalog], [1,291], [*672 included*],
    [Facet classification], [672], [the map],
    [Deep reads], [672], [25 notes],
  ),
  caption: [Identification and selection funnel. Snowball candidates
    are new records after deduplication against the catalog; the 323
    pre-screen exclusions (no model-side vocabulary) were not
    cataloged, and two of the 881 screened records merged with
    existing rows on entry (412 + 879 = 1,291).],
) <tab-funnel>

25 works were selected facet-guided for deep reads as candidate
anchors: 20 read in full text, 5 abstract-only (one with no
retrievable text at all, reconstructed secondhand). 23 of the 25
cleared the curation bar and anchor the reading list and the
citations below; citations resting on abstract-only evidence carry
an "abstract-only" marker. The survey record linked in
the title note holds the criteria, the search log, the classified
catalog, and the per-work evidence notes; the full working history is
in the repository.

= RQ1 — Landscape: the pre-LLM shape, with the ends filling in <sec-rq1>

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    align: (left, right, right, right, right, right, right, right),
    table.header(
      [Stage], [Med], [SE], [Gen], [Total],
      [Hum], [Bench], [None],
    ),
    [Search], [26], [1], [22], [49], [11], [16], [22],
    [Screen], [141], [8], [76], [225], [116], [66], [43],
    [Extract], [87], [1], [25], [113], [58], [38], [17],
    [Appraise], [22], [0], [3], [25], [15], [5], [5],
    [Synthesize], [19], [1], [17], [37], [10], [9], [18],
    [Report], [12], [3], [7], [22], [8], [4], [10],
    [End-to-end], [51], [1], [38], [90], [33], [11], [46],
    [Meta], [54], [2], [55], [111], [9], [8], [94],
    [*Total*], [*412*], [*17*], [*243*], [*672*], [*260*], [*157*],
    [*255*],
  ),
  caption: [Map distribution: stage × setting (medicine, SE,
    general) and stage × evidence type (human-agreement measured,
    benchmark-only, none).],
) <tab-map>

@tab-map summarizes the map. The stage distribution keeps the pre-LLM
center of mass — screening is a third of everything — but the
formerly empty ends are now populated. A reporting and guidance
cluster exists (22 reporting-stage works plus 36
guideline-contribution works overall), and end-to-end systems are a
real class of 90 works; neither had any pre-LLM presence
@vandinter2021. By contribution type, evaluation/benchmark work
dominates (335 of 672), followed by methods (132), systems/tools
(109), positions (60), and guidelines (36). Reporting (22 works)
and appraisal (25) remain the thinnest stages, and appraisal is also
the hardest @woelfle2024.

The most thoroughly documented end-to-end system among the deep
reads is instructive for what it does _not_ contain. MedSR-Copilot
(@huang2026; a preprint evaluated on its authors' own benchmark) —
four subagents, a
fine-tuned risk-of-bias model, a deterministic synthesis engine —
reaches 63.6% end-to-end conclusion accuracy against a 45.3% best
baseline on a 100-review benchmark with no debate, voting, or agent
redundancy anywhere; reliability comes from task decomposition,
structured intermediate artifacts, and human-in-the-loop gates. Its
ablations rank two-stage extraction (−14.9pp) far above retrieval
augmentation (−3.3pp), and its absolute stage numbers (screening F1 ≈
0.44–0.51) calibrate how far "end-to-end" remains from unattended
use. In the living-evidence lifecycle the tail is thinner still:
across 34 inventoried tools, exactly one serves the
publication-update phase @song2026.

Two gaps persist from the pre-LLM era. Software engineering holds 17
setting-classified works against medicine's 412 — the adoption gap
#cite(<napoleao2021>, form: "prose") measured pre-LLM has widened
into an order-of-magnitude evidence gap, and SE has no guidance or
norms work of its own. And adoption runs ahead of disclosure: mapping work relayed by the
field's coordination body found AI use rarely disclosed in the two
domains it covered @oconnor2024, even as concrete disclosed-adoption
exemplars exist @mughal2026.

= RQ2 — Reliability: abundant, but mismeasured <sec-rq2>

260 of the 672 includes carry human-agreement evidence and 157 more
are benchmark-only (@tab-map); the problem is not evidence volume but
measurement practice and generalization.

*Measurement practice lags its subject.* A methodological review of
29 LLM-screening evaluations found 24% reporting complete confusion matrices, 10% reporting the
Matthews correlation coefficient (MCC), and 59% leaning on accuracy,
which its reanalyses show is invalid under screening's class
imbalance: an accuracy-best model lost 63.3% of relevant evidence
where the cost-weighted-best lost 5.8% @madeyski2025. Even the choice
between pooled and per-review aggregation changes the answer on the
same data @huotala2025.

*What the numbers show.* No model in a 9-LLM × 24-review sweep met
a proposed deployment bar of recall ≥ 0.95 at precision ≈ 0.50
@huotala2025. Prompt wording alone swung GPT-3.5-era screening sensitivity from
62% to what the authors report as junior-reviewer level (a
single-review study) @gargari2023. In a controlled same-prompt
comparison across model generations, upgrading GPT-3.5
to GPT-4 Turbo moved specificity 0.51→0.98 while sensitivity stayed
flat (0.83→0.85, not significant) — model scale bought workload
reduction, not evidence retention @oami2025. Across corpora,
cross-review variance exceeds cross-model variance @huotala2025, and
in the one corpus with a high human conflict rate, performance
collapsed @syriani2023. On appraisal instruments every individual LLM scored
below every individual human, with both degrading together as the
instrument hardens — human inter-rater κ falls from 0.84 to 0.29
@woelfle2024. Extraction evidence is thin: one SE proof-of-concept at
87.8% accuracy @felizardo2024[abstract-only], a 23-study
social-science inventory with no pooled benchmark @legate2024, and
secondhand error ranges of 4–31% @gartlehner2025.

*Read against human baselines.* Single human reviewers run \~87–92%
screening sensitivity (range 42–100%; cited in
#cite(<fagerberg2025>, form: "prose")), human extraction error reaches 50% of data elements
(cited in #cite(<gartlehner2025>, form: "prose")), and a rare RCT-grade
automation study found noninferiority, not superiority, with
inconclusive time savings @arno2022[abstract-only]. Agent evidence
should be calibrated against these imperfect baselines, not an
idealized perfect reviewer.

= RQ3 — Norms: convergent content, fragmenting instruments <sec-rq3>

The guidance sources share a disclosure core: name the tool and
version, state which stage the AI performed and what the human did,
and describe verification. The reporting checklists (PRISMA-trAIce
@holst2025, FRAISR @degen2024) add the exact prompt and
configuration; the conduct guidance — the pre-LLM screening guidance
@hamel2021, the Cochrane-family statements @gartlehner2025, and
HAICO-SLR @fernandes2026 — keeps a human decision in every stage,
and its LLM-era members add human accountability (no AI
authorship). In the
Cochrane-family guidance the sanctioned role for AI is a _secondary_
quality-assurance reviewer, re-checking single-reviewer exclusions
and extractions; HAICO-SLR goes further, sanctioning AI first-pass
filtering and drafting under human validation @fernandes2026.

The instruments implementing this content are fragmenting. Three
unvalidated checklists now compete — PRISMA-trAIce's 14 items and
human/AI-split flow diagram @holst2025, FRAISR's per-stage
machine-readable table @degen2024, and HAICO-SLR's dual
conduct-and-reporting tables @fernandes2026 — alongside a layer of
position statements (the Cochrane-family statements @gartlehner2025,
which endorse the RAISE guidance), while the officially announced
PRISMA-AI remains unpublished and PRISMA 2020 itself covers
automation only at the selection items @luo2024. The map's 36 guideline works suggest
instruments are arriving faster than any accumulates adoption
evidence: a standards race. Meanwhile practice lags all of them —
the coordination body's relayed mapping found disclosure rare
@oconnor2024 — and the
best in-practice template is an individual exemplar: name the model,
cite the specific PRISMA item, publish a validation table beside the
flow diagram, revisit the automation's residual risk in limitations
@mughal2026.

= RQ4 — Independence: the undefined middle <sec-rq4>

Direct evidence on multi-model design is the map's scarcest class —
two designed ensembles, two indirect signals, and one negative
case:

- A cross-family OR-ensemble (GPT-5 Thinking + Gemini 2.5 Pro, union
  rule, 736 Cochrane citations) reached 99.7% screening sensitivity
  at 49.3% specificity against individual sensitivities of 86–98% —
  with a documented blind-spot catch where one family failed a
  vaccine-subgroup criterion at 43% sensitivity and the other flagged
  the same records (@fagerberg2025; a preprint, and 94.0–94.5%
  sensitivity against the original Cochrane labels before the
  authors' own adjudication). Family diversity caught what
  within-family redundancy could not.
- A 9-run consistency ensemble reached human-level appraisal accuracy
  only on items surviving near-unanimous agreement, deferring 74–88%
  of items; the _deferral_ design — human + LLM score, send
  disagreements to a second human — beat both humans-alone and
  ensembles at 95–96% accuracy while sparing \~65–70% of
  second-reviewer workload on the two easier instruments, a margin
  that collapses on the hardest (80–86%, \~29% spared) @woelfle2024.
  Agreement-gating, not voting, is the evidence-backed pattern.
- Open-weight models screen more conservatively than GPT-4.1 across
  25k titles — a family-diversity signal awaiting full-text numbers
  @safarpour2026[abstract-only].
- High self-consistency coexists with mediocre accuracy — run-to-run
  Fleiss κ 0.82–0.97 on the two corpora tested @syriani2023 —
  stability is not validity.
- The negative case: the best-documented end-to-end system uses no
  redundancy at all @huang2026; independence mechanisms are not yet
  how the strongest pipelines buy reliability.

What no source provides is a definition: what makes two agent passes
_independent_ in the sense dual human review requires — different
prompts, tiers, vendors, training corpora? The correlated-error
question (shared training data producing shared blind spots) is
unmeasured everywhere; the pre-LLM guidance thought carefully about
_human_ reviewer independence and simply has no agent analogue
@hamel2021. This is the map's clearest open problem.

= Synthesis and Open Problems <sec-discussion>

#figure(
  table(
    columns: (2.2em, 27em, 12em),
    align: (left, left, left),
    table.header([RQ], [Finding], [Evidence]),
    [1], [Stage distribution reproduces the pre-LLM skew; screening
      dominates, appraisal and reporting stay thin], [map;
      @vandinter2021],
    [1], [SE evidence lags medicine by an order of magnitude (17 vs
      412), extending the pre-LLM adoption gap], [map;
      @napoleao2021],
    [1], [Best-documented end-to-end system derives reliability
      from decomposition and human gates, not redundancy
      (preprint)], [@huang2026],
    [1], [Living/update automation nearly nonexistent (1 of 34
      tools)], [@song2026],
    [2], [No evaluated single model meets a proposed screening
      deployment bar (recall ≥ 0.95, precision ≈ 0.50)],
      [@huotala2025 @oami2025 @gargari2023],
    [2], [Task variance exceeds model variance], [@huotala2025
      @syriani2023],
    [2], [Model upgrades bought specificity (workload), not
      sensitivity (evidence retention)], [@oami2025],
    [2], [Evaluation practice systematically inadequate under class
      imbalance], [@madeyski2025],
    [3], [Disclosure norms converge on content while instruments
      fragment, unvalidated and unadopted], [@holst2025 @degen2024
      @fernandes2026 @gartlehner2025 @oconnor2024 @luo2024],
    [4], [Cross-vendor OR-ensemble reaches near-perfect screening
      sensitivity (preprint; 94.0–94.5% on unadjudicated labels)
      with a
      documented cross-family blind-spot catch], [@fagerberg2025],
    [4], [Agreement-gated human–AI deferral beats humans-alone and
      LLM ensembles on the easier appraisal instruments],
      [@woelfle2024],
    [4], [No published definition or measurement of reviewer
      independence for agents], [gap; @fagerberg2025
      @safarpour2026[abstract-only] @hamel2021],
  ),
  caption: [Summary of findings with their evidence.],
) <tab-findings>

@tab-findings condenses the findings. Two cross-cutting patterns
stand out. First, where reliability has been won, it came from
_structure_, not from scale or redundancy: task decomposition with
human gates in the best-documented end-to-end system @huang2026,
agreement-gated deferral in appraisal @woelfle2024, cost-weighted
measurement in screening evaluation @madeyski2025. Second, the
field's bottleneck is methodological rather than technical: the
dominant failure is measuring the wrong thing (accuracy under class
imbalance, pooled metrics, missing confusion matrices), not the
absence of capable models.

The open problems the map surfaces: a definition and measurement of
reviewer _independence_ for agents (@sec-rq4); evaluated evidence for
the thin stages — appraisal, synthesis, reporting; the SE evidence
gap and SE's missing norms work; the near-empty living-evidence
update tail @song2026; adoption evidence for any of the
competing disclosure instruments; and norms for fully
agent-primary configurations — the Cochrane-family guidance keeps AI
as the secondary checker, and only HAICO-SLR sanctions first-pass AI
roles under human validation @fernandes2026.

= Limitations <sec-threats>

Screening and classification read truncated abstracts (600–900
characters); facets are abstract-level and single-pass; deep-read
extraction had no second pass. Snowball recall is bounded by a
single round not iterated to saturation (yield had not decayed), a
title-vocabulary pre-filter that reintroduces the terminology
dependence snowballing exists to escape @wohlin2014, and a
single-pass second wave; a post-freeze audit found \~3.9% residual
duplicates in the include set. For 8 of the 25 deep-read works, the
full-text evidence notes disagree with the map's abstract-level
facets; the map is reported as computed, and the notes are
authoritative for those works. Coverage is English-only and
the evidence base is medicine-dominant (412 of 672), so imported
thresholds are medicine-calibrated.

= Conclusion

The LLM era has repopulated the systematic-review automation
landscape without reshaping it: screening still dominates, the hard
stages stay thin, and the medicine–SE gap persists. The reliability
literature's headline is methodological — the dominant failure is
measuring the wrong quantity, not measuring the right one
imprecisely. The
norms literature agrees on what to disclose and disagrees on the
form, while practice ignores both. And the open problem at the
frontier is independence: the strongest ensemble evidence — a preprint — suggests
model-family diversity buys recall, yet no one can say what
"independent agent reviewers" means.

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
