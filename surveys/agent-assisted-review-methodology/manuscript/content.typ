= Introduction

A systematic review is itself a pipeline — search, screening, data
extraction, quality appraisal, synthesis, and reporting — and every
stage of that pipeline is now a target for automation by large
language models (LLMs) and agent systems. The result is a
fast-growing methodology literature that evaluates, systematizes, and
regulates this automation, scattered across medicine (where evidence
synthesis is core infrastructure), software engineering (SE, which
imported the method), and general venues. Throughout, we use
_secondary studies_ for systematic reviews, systematic maps, and
related evidence syntheses, and _agent_ loosely for an LLM-based
system acting with some autonomy inside the pipeline.

This paper maps that literature. Following the systematic-map genre
@petersen2008, it aims at classified coverage rather than pooled
effect estimates, asking four questions:

- *RQ1 (landscape):* What methods, systems, and workflows exist for
  LLM/agent assistance at each stage of secondary studies?
- *RQ2 (reliability):* How is agent performance measured, and what do
  the measurements show?
- *RQ3 (norms):* What guidance, reporting, or disclosure standards
  exist for AI assistance in evidence synthesis?
- *RQ4 (design gap):* Which designs address independence and
  ensembling across model families, and what remains open?

One feature distinguishes this map from its subject matter: it was
itself conducted by an agent fleet. Screening, verification,
classification, and deep reading ran on language models, with a human
approving the protocol and gating the outputs. The method is an
instance of the thing surveyed. That cuts both ways: the campaign is
a live data point for RQ2 and RQ4, and it inverts the role the mapped
guidance sanctions for AI — a departure we disclose and analyze
rather than leave implicit.

The paper contributes:

+ a faceted map of 672 included works (2020–2026), classified by
  pipeline stage, contribution type, evidence type, and setting, from
  a catalog of 1,291 candidates (@sec-rq1);
+ a synthesis of the reliability evidence showing that measurement
  practice, not evidence volume, is the field's weak point
  (@sec-rq2);
+ an analysis of the norms landscape — convergent disclosure content,
  fragmenting instruments, lagging practice (@sec-rq3);
+ the identification of _reviewer independence for agents_ as an
  undefined and unmeasured concept, together with the designed
  cross-vendor experiment it motivates (@sec-rq4); and
+ a reflexive case study: the campaign's own execution, disclosed
  per stage and analyzed against the norms it mapped
  (@sec-discussion).

@sec-background positions the map against prior surveys.
@sec-method details the protocol, funnel, and deviations. Four
findings sections answer the RQs, @sec-discussion turns the method on
itself, and @sec-threats states threats to validity.

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
map and the method now under automation pressure. Pre-LLM machine
classifiers for screening (text mining for study identification,
Cochrane's classifiers) enter as background through their existing
reviews rather than re-screened primary studies.

LLM-era secondary literature exists but is narrower than this map.
Luo et al. @luo2024 survey potential LLM roles stage by
stage as a viewpoint; the International Collaboration for the
Automation of Systematic Reviews reports community progress and
evaluation threads @oconnor2024; Song et al. @song2026
inventory tools for living evidence synthesis; and
Madeyski et al. @madeyski2025 review 29 LLM-screening
evaluations with a methodological focus. Each covers one stage, one community, or one
lifecycle; none spans stages, settings, and norms together, and none
examines the agent-primary configuration this campaign embodies. To
our knowledge this is the first secondary study of the field that is
itself agent-conducted and discloses that execution as data.

= Method <sec-method>

Full disclosure lives in the campaign's frozen baseline record; this
section condenses it.

*Design.* Systematic map under a pre-registered protocol (method v0
pinned at commit `d4a27ce`), window 2020-01-01 to 2026-08-08, English
sources.

*Search.* 11 logged queries against OpenAlex, Crossref, Semantic
Scholar, and arXiv paired review-side vocabulary ("systematic
review", "literature review", "evidence synthesis", "citation
screening", "data extraction") with model-side vocabulary ("large
language model", LLM, agent, automation) over titles and abstracts,
plus targeted probes for reporting guidance (PRISMA-family AI
extensions, RAISE-type guidelines, Cochrane positions). One Semantic
Scholar query was lost to a persistent rate limit and is logged as
such. Yield: 419 raw candidates, 412 after arXiv–DOI deduplication.
Exact query strings, dates, and per-query counts are in the campaign
record (`logs/searches.tsv`).

*Selection.* Included: works — peer-reviewed or preprint — whose
subject is methods, systems, evaluations, benchmarks, or guidance for
automating or assisting secondary-study stages with LLMs or agents.
Exclusion codes: E1 primary-research automation only; E2 generic
NLP/RAG without evidence-synthesis framing; E3 opinion without
guidance content; E4 pre-window; E5 inaccessible; E6 duplicate or
superseded version. A `U` disposition (insufficient metadata to
decide) was introduced during execution; 12 rows carry it in the
final catalog.

*Screening.* Two independent agent passes per candidate on different
model tiers and prompt frames (pass A: Haiku-class, criteria-framed;
pass B: Sonnet-class, framed by the research questions). 417 pairwise
decisions: binary inclusion agreement 0.971, Cohen's κ = 0.937,
six-category exact agreement 0.835. 33 rows (disagreements,
uncertains, single-pass) were adjudicated by the strongest tier
(Fable-class) with persisted rationales. Wave-1 dispositions: 139
includes.

*Snowball.* One backward+forward round from the 139 includes via
OpenAlex @wohlin2014: 1,204 new candidates after a title-vocabulary
pre-filter; 323 without AI-side vocabulary excluded en bloc; 881
screened single-pass (Haiku-class); all 624 resulting
includes/uncertains re-judged by an adversarial verification pass
(Sonnet-class), which confirmed 533 and overturned \~79 (\~13%) — a
measured single-pass error rate. Iteration yield did not decay;
coverage is bounded by the one-round cap.

*Catalog.* Final catalog: 1,291 works — 672 included, 619 excluded
(E1: 83; E2: 484; E3: 24; E6: 16), 12 undecidable (@tab-funnel).

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, right, right),
    table.header([Phase], [In], [Out]),
    [Search (11 queries, 4 indexes)], [—], [419],
    [Dedup], [419], [412],
    [Dual-pass screen + adjudication], [412], [139 includes],
    [Snowball round (pre-filtered)], [139 seeds], [1,204 candidates],
    [Wave-2 screen + adversarial verify], [1,204], [533 includes],
    [Final catalog], [1,291], [*672 included*],
    [Facet classification], [672], [map],
    [Deep reads (G1)], [672], [25 notes],
  ),
  caption: [Identification and selection funnel.],
) <tab-funnel>

*Classification.* All 672 includes were faceted single-pass
(Sonnet-class) on four dimensions, built by keywording and allowed to
evolve during extraction @petersen2008: *stage* (search, screen,
extract, appraise, synthesize, report; _end-to-end_ for whole-pipeline
systems; _meta_ for works about the process or field as a whole —
surveys, guidance, community reports); *contribution* (method,
system/tool, evaluation/benchmark, guideline/norms, position);
*evidence* (human-agreement measured, benchmark-only, none); and
*setting* (medicine/evidence-based medicine, SE, general). A
judgment-graded auxiliary field (`rq_core`) varied 7–40 per 56-row
batch across agents and is treated as a candidate-pool signal only.

*Deep reads.* 25 works selected by facet-guided choice for evidence
extraction: 20 read in full text (PDFs archived, transcripts
retained), 5 abstract-only. Citations resting on abstract-only
evidence carry an "abstract-only" marker. Every claim below cites its
per-work evidence note in the campaign record.

*Deviations and erratum.* Seven in-campaign deviations are logged as
decision records — notably the snowball pre-filter, the single-pass
snowball wave, and an autonomous browser-download escalation by three
deep-read pipelines. A post-freeze audit found \~22 residual
duplicate-title groups (\~26 excess rows, \~3.9% of includes) that
key normalization missed; counts are reported as frozen.

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
(109), positions (60), and guidelines (36). Appraisal remains the
thinnest evaluated stage, consistent with it also being the hardest
@woelfle2024.

The strongest-documented end-to-end system is instructive for what it
does _not_ contain. MedSR-Copilot @huang2026 — four subagents, a
fine-tuned risk-of-bias model, a deterministic synthesis engine —
reaches 63.6% end-to-end conclusion accuracy against a 45.3% best
baseline on a 100-review benchmark with no debate, voting, or agent
redundancy anywhere; reliability comes from task decomposition,
structured intermediate artifacts, and human-in-the-loop gates. Its
ablations rank two-stage extraction (−14.9pp) far above retrieval
augmentation (−3.3pp), and its absolute stage numbers (screening F1 ≈
0.46–0.51) calibrate how far "end-to-end" remains from unattended
use. In the living-evidence lifecycle the tail is thinner still:
across 34 inventoried tools, exactly one serves the
publication-update phase @song2026.

Two gaps persist from the pre-LLM era. Software engineering holds 17
setting-classified includes against medicine's 412 — the
order-of-magnitude evidence gap Napoleão et al. @napoleao2021
measured has survived the LLM transition, and SE has no guidance or
norms work of its own. And adoption runs ahead of disclosure: the
field's own coordination body reports that published reviews rarely
disclose advanced AI use @oconnor2024, even as concrete
disclosed-adoption exemplars exist @mughal2026.

= RQ2 — Reliability: abundant, but mismeasured <sec-rq2>

260 of the 672 includes carry human-agreement evidence and 157 more
are benchmark-only (@tab-map); the problem is not evidence volume but
measurement practice and generalization.

*Measurement practice lags its subject.* A methodological review of
29 LLM-screening evaluations — with Kitchenham among the authors —
found 24% reporting complete confusion matrices, 10% reporting the
Matthews correlation coefficient (MCC), and 59% leaning on accuracy,
which its reanalyses show is invalid under screening's class
imbalance: an accuracy-best model lost 63.3% of relevant evidence
where the cost-weighted-best lost 5.8% @madeyski2025. Even the choice
between pooled and per-review aggregation changes the answer on the
same data @huotala2025.

*What the numbers show.* No model in a 9-LLM × 24-review sweep met
the field's deployment bar of recall ≥ 0.95 at precision ≈ 0.50
@huotala2025. Prompt wording alone swung GPT-3.5-era screening
sensitivity from 62% to junior-reviewer level @gargari2023. In the
one controlled same-prompt generation comparison, upgrading GPT-3.5
to GPT-4 Turbo moved specificity 0.51→0.98 while sensitivity stayed
flat (0.83→0.85, not significant) — model scale bought workload
reduction, not evidence retention @oami2025. Across corpora,
cross-review variance exceeds cross-model variance, and performance
collapses exactly where human conflict rates are high @syriani2023 @huotala2025. On appraisal instruments every individual LLM scored
below every individual human, with both degrading together as the
instrument hardens — human inter-rater κ falls from 0.84 to 0.29
@woelfle2024. Extraction evidence is thin: one SE proof-of-concept at
87.8% accuracy @felizardo2024[abstract-only], a 23-tool
social-science inventory with no pooled benchmark @legate2024, and
secondhand error ranges of 4–31% @gartlehner2025.

*Read against human baselines.* Single human reviewers run \~87–92%
screening sensitivity (range 42–100%; cited in Fagerberg et al.
@fagerberg2025), human extraction error
reaches 50% of data elements (cited in Gartlehner et al.
@gartlehner2025), and the one RCT-grade
automation study found noninferiority, not superiority, with
inconclusive time savings @arno2022[abstract-only]. Agent evidence
should be calibrated against these imperfect baselines, not an
idealized perfect reviewer.

= RQ3 — Norms: convergent content, fragmenting instruments <sec-rq3>

Every guidance source from the pre-LLM wave @hamel2021 through
2024–2026 @gartlehner2025 @degen2024 @holst2025 @fernandes2026
converges on the same disclosure obligations: name the tool and
version; disclose the exact prompt and configuration; state which
stage the AI performed and what the human did; describe verification;
keep a human accountable (no AI authorship); and never fully automate
any stage. The sanctioned positive role is equally consistent: AI as
a _secondary_ quality-assurance reviewer, re-checking single-reviewer
exclusions and extractions.

The instruments implementing this content are fragmenting. Four
unvalidated proposals now compete — PRISMA-trAIce's 14 items and
human/AI-split flow diagram @holst2025, FRAISR's per-stage
machine-readable table @degen2024, HAICO-SLR's dual
conduct-and-reporting tables @fernandes2026, and a
position-statement layer — RAISE @gartlehner2025 and the
Cochrane-family statements — while the officially announced PRISMA-AI
remains unpublished and PRISMA 2020 itself covers automation only at
the selection items @luo2024. The map's 36 guideline works suggest
instruments are arriving faster than any accumulates adoption
evidence: a standards race. Meanwhile practice lags all of them —
disclosure in published reviews stays rare @oconnor2024 — and the
best in-practice template is an individual exemplar: name the model,
cite the specific PRISMA item, publish a validation table beside the
flow diagram, revisit the automation's residual risk in limitations
@mughal2026.

= RQ4 — Independence: the undefined middle <sec-rq4>

Direct evidence on multi-model design is the map's scarcest class —
four designed data points and one negative case:

- A cross-family OR-ensemble (GPT-5 Thinking + Gemini 2.5 Pro, union
  rule, 736 Cochrane citations) reached 99.7% screening sensitivity
  at 49.3% specificity against individual sensitivities of 86–98% —
  with a documented blind-spot catch where one family failed a
  vaccine-subgroup criterion at 43% sensitivity and the other flagged
  the same records @fagerberg2025. Family diversity caught what
  within-family redundancy could not.
- A 9-run consistency ensemble reached human-level appraisal accuracy
  only on items surviving unanimous agreement, deferring 74–88% of
  items; the _deferral_ design — human + LLM score, send
  disagreements to a second human — beat both humans-alone and
  ensembles at 95–96% accuracy while sparing \~65–70% of
  second-reviewer workload @woelfle2024. Agreement-gating, not
  voting, is the evidence-backed pattern.
- Open-weight models screen more conservatively than GPT-4.1 across
  25k titles — a family-diversity signal awaiting full-text numbers
  @safarpour2026[abstract-only].
- High self-consistency coexists with mediocre accuracy — run-to-run
  Fleiss κ 0.82–0.97 on hard corpora @syriani2023 — stability is not
  validity.
- The negative case: the best end-to-end system uses no redundancy at
  all @huang2026; independence mechanisms are not yet how the
  strongest pipelines buy reliability.

What no source provides is a definition: what makes two agent passes
_independent_ in the sense dual human review requires — different
prompts, tiers, vendors, training corpora? The correlated-error
question (shared training data producing shared blind spots) is
unmeasured everywhere; the pre-LLM guidance thought carefully about
_human_ reviewer independence and simply has no agent analogue
@hamel2021. This is the map's clearest open problem.

= Discussion: this campaign as an instance of its subject <sec-discussion>

#figure(
  table(
    columns: (2.2em, 27em, 12em),
    align: (left, left, left),
    table.header([RQ], [Finding], [Evidence]),
    [1], [Stage distribution reproduces the pre-LLM skew; screening
      dominates, appraisal and reporting stay thin], [map;
      @vandinter2021],
    [1], [SE remains an order of magnitude behind medicine (17 vs
      412 includes)], [map; @napoleao2021],
    [1], [Best end-to-end system derives reliability from
      decomposition and human gates, not redundancy], [@huang2026],
    [1], [Living/update automation nearly nonexistent (1 of 34
      tools)], [@song2026],
    [2], [No evaluated single model meets the screening deployment
      bar (recall ≥ 0.95, precision ≈ 0.50)], [@huotala2025
      @oami2025 @gargari2023],
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
      sensitivity with a documented cross-family blind-spot catch],
      [@fagerberg2025],
    [4], [Agreement-gated human–AI deferral beats humans-alone and
      LLM ensembles on appraisal], [@woelfle2024],
    [4], [No published definition or measurement of reviewer
      independence for agents], [gap; @fagerberg2025
      @safarpour2026[abstract-only] @hamel2021],
  ),
  caption: [Summary of findings. The full twelve-claim ledger with
    per-claim evidence anchors is in the campaign record.],
) <tab-findings>

@tab-findings condenses the map's findings. The map was produced by
the class of system it maps, so its own execution is fair evidence —
in both directions.

*As a data point.* Same-vendor dual-pass screening across a tier and
prompt-frame split produced κ = 0.937 on a bounded binary task, while
the judgment-graded classification field varied 5.7× across same-tier
single passes — matching the literature's pattern of high agreement
on bounded tasks and degradation with judgment load @syriani2023 @woelfle2024. The adversarial verification pass overturned \~13% of
single-pass decisions, a measured error rate that the protocol's cost
asymmetry (false excludes are lost; false includes get caught later)
had wagered on.

*Against the mapped norms.* The convergent disclosure content of RQ3
is implemented in the campaign's baseline record — models, pass
structure, and deviations per stage — but this campaign inverts the
one norm every guidance source shares. The sanctioned role is AI as
secondary checker of human work; here the agent is the primary
reviewer and the human is the gate. The mapped guidance has no
published norms for that mirror image. We state it as a deliberate
departure with compensating controls: dual passes, strongest-tier
adjudication, adversarial verification with reported overturn rates,
a logged deviation record, and a human freeze gate. The authorship
convention, by contrast, is followed: the byline names the
accountable human author, with the agent's primary contribution
disclosed in the title note.

*Reflexive critique.* The measurement failures RQ2 documents appear
in our own execution. We measured agreement where it was cheapest
(binary screening) and not where judgment lived — classification ran
single-pass and extraction has no second pass, the precise gap the
literature names. Key normalization bugs left \~3.9% residual
duplicates in the include set, found only by post-freeze audit. And
three deep-read pipelines autonomously escalated to a
permission-gated browser fallback, a small live instance of the
boundary problem the norms literature worries about. Each failure is
logged as a deviation and codified as a fix in the extracted method —
in this campaign the deviation log was itself primary data.

= Threats to Validity <sec-threats>

*Descriptive validity.* Screening and classification read abstracts
truncated to 600–900 characters; facets are abstract-level and
single-pass; the deep-read evidence notes are agent-written without a
second extraction pass — inter-rater agreement for extraction is
unmeasured, the exact gap the mapped literature itself names. The
judgment-graded `rq_core` field is excluded from claims.

*Theoretical validity.* Same-vendor dual screening means κ = 0.937
may overstate independence — the axis varied was tier and prompt
frame, not vendor or training corpus. Recall is bounded: one
non-decayed snowball round, a title-vocabulary pre-filter that
reintroduces the terminology dependence snowballing exists to escape
@wohlin2014, single-pass wave-2 excludes with an unquantified
false-exclusion rate, and \~3.9% residual duplicates in the frozen
include set.

*Generalizability.* English sources only; the evidence base is
medicine-dominant (412 of 672), so imported thresholds and
conventions are medicine-calibrated. 12 rows remain undecidable on
available metadata.

*Repeatability.* Scripts, catalogs, logged queries, decision records,
and per-work evidence notes are public in the campaign record; fleet
prompts, however, are recorded only in the session transcript, so the
pipeline is not fully reproducible from the record alone — a fix
adopted in the extracted method for future campaigns.

= Conclusion

The LLM era has repopulated the systematic-review automation
landscape without reshaping it: screening still dominates, the hard
stages stay thin, and the medicine–SE gap persists. The reliability
literature's headline is methodological — the field measures the
wrong things more often than it measures the right ones badly. The
norms literature agrees on what to disclose and disagrees on the
form, while practice ignores both. The open problem is independence:
the strongest ensemble result says model-family diversity buys
recall, yet no one can say what "independent agent reviewers" means.

This map, produced agent-primary under a human gate, sits exactly on
that frontier. Its next step is designed: a cross-vendor dual-pass
campaign — the mirrored second-agent configuration already exists —
with disagreement analyzed by error type, which would be among the
first designed cross-family independence measurements in the
literature this survey mapped.

*Data availability.* The campaign record — protocol, search logs,
curated catalogs, per-work evidence notes, syntheses, claim ledger,
decision records, and the frozen baseline — is public at the
repository linked in the title note. Raw search responses and
screening worksheets are preserved in a private archive and
summarized in the baseline.

#bibliography(
  "references.bib",
  full: true,
  style: "association-for-computing-machinery",
  title: [References],
)
