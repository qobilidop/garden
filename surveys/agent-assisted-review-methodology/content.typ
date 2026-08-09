Citations use the campaign's citekey handles (`vandinter2021`),
resolved in the references; claims resting on abstract-only evidence
are marked (A). The frozen method record, claim ledger, and per-work
evidence notes live in the campaign record linked above.

= Introduction

A systematic review is itself a pipeline — search, screen, extract,
appraise, synthesize, report — and every stage of that pipeline is
now a target for automation by large language models and agent
systems. The result is a fast-growing methodology literature that
evaluates, systematizes, and regulates this automation, scattered
across medicine (where evidence synthesis is core infrastructure),
software engineering (which imported the method), and general venues.

This paper maps that literature. Following the systematic-map genre
(`petersen2008`), it aims at classified coverage rather than pooled
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
itself conducted by an agent fleet — screening, verification,
classification, and deep reading ran on language models, with a human
approving the protocol and gating the outputs. The method is an
instance of the thing surveyed. That cuts both ways: the campaign is
a live data point for RQ2 and RQ4 (its agreement statistics and
failure modes are reported below), and it inverts the role the mapped
guidance sanctions for AI, which we take up in the discussion.

= Background

The pre-LLM baseline is well documented. van Dinter et al.'s
landscape review (`vandinter2021`: 41 automation studies, 2006–2020)
found every study in Kitchenham's conducting-the-review phase
(`kitchenham2007`) — screening dominant, appraisal nearly empty,
planning and reporting untouched, and exactly one deep-learning study
in the corpus. Napoleão et al.'s cross-domain mapping
(`napoleao2021`) quantified the adoption gap between medicine and
software engineering: eight practice-adopted screening tools in
medicine versus two in SE. The classic method canon — review
guidelines (`kitchenham2007`), mapping-study procedure
(`petersen2008`), snowballing (`wohlin2014`), and PRISMA 2020
reporting (`page2021`) — predates LLMs and supplies both the
vocabulary of this map and the method under automation pressure.
Pre-LLM machine classifiers for screening (text mining for study
identification, Cochrane's classifiers) enter this map as background
through their existing reviews rather than re-screened primary
studies.

= Method

Full disclosure lives in the campaign's frozen baseline record; this
section condenses it.

*Design.* Systematic map under a pre-registered protocol (method v0
pinned at commit `d4a27ce`), window 2020-01-01 to 2026-08-08, English
sources.

*Search.* 11 logged queries against OpenAlex, Crossref, Semantic
Scholar, and arXiv (one query lost to a persistent rate limit): 419
raw candidates, 412 after arXiv–DOI dedup.

*Screening.* Two independent agent passes per candidate on different
tiers and prompt frames (pass A: Haiku-class, criteria-framed; pass
B: Sonnet-class, RQ-framed). 417 pairwise decisions: binary agreement
0.971, Cohen's κ = 0.937, six-category exact agreement 0.835. 33 rows
(disagreements, uncertains, single-pass) were adjudicated by the
strongest tier (Fable) with persisted rationales. Wave-1
dispositions: 139 includes.

*Snowball.* One backward+forward round from the 139 includes via
OpenAlex (`wohlin2014`): 1,204 new candidates after a
title-vocabulary pre-filter; 323 without AI-side vocabulary excluded
en bloc; 881 screened single-pass (Haiku-class); all 624 resulting
includes/uncertains then re-judged by an adversarial verification
pass (Sonnet-class), which confirmed 533 and overturned ~79 (~13%) —
a measured single-pass error rate. Iteration yield did not decay;
coverage is bounded by the one-round cap.

*Catalog and classification.* Final catalog: 1,291 works — 672
included, 619 excluded (E1 primary-research automation 83; E2 generic
NLP without evidence-synthesis framing 484; E3 opinion 24; E6
duplicate 16), 12 undecidable on available metadata. All 672 includes
were faceted by stage, contribution, evidence, and setting
(single-pass, Sonnet-class). A judgment-graded field (`rq_core`)
varied 7–40 per 56-row batch across agents and is treated as a pool
signal only.

*Deep reads.* 25 works selected by facet-guided choice for evidence
extraction: 20 read in full text (PDFs archived, transcripts
retained), 5 abstract-only. Claims resting on abstract-only evidence
are marked (A). Every claim below cites its evidence note in the
campaign record.

*Deviations and erratum.* Seven in-campaign deviations are logged in
the campaign's decision records (notably the snowball pre-filter, the
single-pass wave, and an autonomous browser-download escalation). A
post-freeze audit found ~22 residual duplicate-title groups (~26
excess rows, ~3.9% of includes) that key normalization missed; counts
are reported as frozen.

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
)

= RQ1 — Landscape: the pre-LLM shape, with the ends filling in

The map's stage distribution (672 works: screening 225, extraction
113, meta 111, end-to-end 90, search 49, synthesis 37, appraisal 25,
reporting 22) keeps the pre-LLM center of mass — screening is still a
third of everything — but the formerly empty ends are now populated.
A reporting/guidance cluster exists (22 reporting-stage plus 36
guideline-contribution works), and end-to-end systems are a real
class of 90 works, neither of which had any pre-LLM presence
(`vandinter2021`). Appraisal remains the thinnest evaluated stage,
consistent with it also being the hardest (`woelfle2024`).

The strongest-documented end-to-end system is instructive for what it
does _not_ contain. MedSR-Copilot (`huang2026`: four subagents, a
fine-tuned risk-of-bias model, a deterministic synthesis engine)
reaches 63.6% end-to-end conclusion accuracy against a 45.3% best
baseline on a 100-review benchmark with no debate, voting, or agent
redundancy anywhere — reliability comes from task decomposition,
structured intermediate artifacts, and human-in-the-loop gates. Its
ablations rank two-stage extraction (−14.9pp) far above retrieval-RAG
(−3.3pp), and its absolute stage numbers (screening F1 ≈ 0.46–0.51)
calibrate how far "end-to-end" remains from unattended use. In the
living-evidence lifecycle the tail is thinner still: across 34
inventoried tools, exactly one serves the publication-update phase
(`song2026`).

Two gaps persist from the pre-LLM era. Software engineering holds 17
setting-classified includes against medicine's 412 — the
order-of-magnitude evidence gap `napoleao2021` measured has survived
the LLM transition, and SE has no guidance or norms work of its own.
And adoption runs ahead of disclosure: the field's own coordination
body reports that published reviews rarely disclose advanced AI use
(`oconnor2024`), even as concrete disclosed-adoption exemplars exist
(`mughal2026`).

= RQ2 — Reliability: abundant, but mismeasured

260 of the 672 includes carry human-agreement evidence and 157 more
are benchmark-only; the problem is not volume but measurement
practice and generalization.

*Measurement practice lags its subject.* A methodological review of
29 LLM-screening evaluations — with Kitchenham among the authors —
found 24% reporting complete confusion matrices, 10% reporting MCC,
and 59% leaning on accuracy, which its reanalyses show is invalid
under screening's class imbalance: an accuracy-best model lost 63.3%
of relevant evidence where the cost-weighted-best lost 5.8%
(`madeyski2025`). Even the choice between pooled and per-review
aggregation changes the answer on the same data (`huotala2025`).

*What the numbers show.* No model in a 9-LLM × 24-review sweep met
the field's deployment bar of recall ≥ 0.95 at precision ≈ 0.50
(`huotala2025`). Prompt wording alone swung GPT-3.5-era screening
sensitivity from 62% to junior-reviewer level (`gargari2023`). In the
one controlled same-prompt generation comparison, upgrading GPT-3.5
to GPT-4 Turbo moved specificity 0.51→0.98 while sensitivity stayed
flat (0.83→0.85, n.s.) — model scale bought workload reduction, not
evidence retention (`oami2025`). Across corpora, cross-review
variance exceeds cross-model variance, and performance collapses
exactly where human conflict rates are high (`syriani2023`,
`huotala2025`). On appraisal instruments every individual LLM scored
below every individual human, with both degrading together as the
instrument hardens — human inter-rater κ falls from 0.84 to 0.29
(`woelfle2024`). Extraction evidence is thin: one SE proof-of-concept
at 87.8% accuracy (`felizardo2024` (A)), a 23-tool social-science
inventory with no pooled benchmark (`legate2024`), and secondhand
error ranges of 4–31% (`gartlehner2025`).

*Read against human baselines.* Single human reviewers run ~87–92%
screening sensitivity (range 42–100%; cited in `fagerberg2025`),
human extraction error reaches 50% of data elements (cited in
`gartlehner2025`), and the one RCT-grade automation study found
noninferiority, not superiority, with inconclusive time savings
(`arno2022` (A)). Agent evidence should be calibrated against these
imperfect baselines, not an idealized perfect reviewer.

= RQ3 — Norms: convergent content, fragmenting instruments

Every guidance source from the pre-LLM wave (`hamel2021`) through
2024–2026 (`gartlehner2025`, `degen2024`, `holst2025`,
`fernandes2026`) converges on the same disclosure obligations: name
the tool and version; disclose the exact prompt and configuration;
state which stage the AI performed and what the human did; describe
verification; keep a human accountable (no AI authorship); and never
fully automate any stage. The sanctioned positive role is equally
consistent: AI as a _secondary_ quality-assurance reviewer,
re-checking single-reviewer exclusions and extractions.

The instruments implementing this content are fragmenting. Four
unvalidated proposals now compete — PRISMA-trAIce's 14 items and
human/AI-split flow diagram (`holst2025`), FRAISR's per-stage
machine-readable table (`degen2024`), HAICO-SLR's dual
conduct-and-reporting tables (`fernandes2026`), and a
position-statement layer (RAISE and the Cochrane-family statements,
`gartlehner2025`) — while the officially announced PRISMA-AI remains
unpublished and PRISMA 2020 itself covers automation only at the
selection items (`luo2024`). The map's 36 guideline works suggest
instruments are arriving faster than any accumulates adoption
evidence: a standards race. Meanwhile practice lags all of them —
disclosure in published reviews stays rare (`oconnor2024`), and the
best in-practice template is an individual exemplar: name the model,
cite the PRISMA item, publish a validation table beside the flow
diagram, revisit residual risk in limitations (`mughal2026`).

= RQ4 — Independence: the undefined middle

Direct evidence on multi-model design is the map's scarcest class —
four designed data points and one negative case:

- A cross-family OR-ensemble (GPT-5 Thinking + Gemini 2.5 Pro, union
  rule, 736 Cochrane citations) reached 99.7% screening sensitivity
  at 49.3% specificity against individual sensitivities of 86–98% —
  with a documented blind-spot catch where one family failed a
  vaccine-subgroup criterion at 43% sensitivity and the other flagged
  the same records (`fagerberg2025`). Family diversity caught what
  within-family redundancy could not.
- A 9-run consistency ensemble reached human-level appraisal accuracy
  only on items surviving unanimous agreement, deferring 74–88% of
  items; the _deferral_ design — human + LLM score, send
  disagreements to a second human — beat both humans-alone and
  ensembles at 95–96% accuracy while sparing ~65–70% of
  second-reviewer workload (`woelfle2024`). Agreement-gating, not
  voting, is the evidence-backed pattern.
- Open-weight models screen more conservatively than GPT-4.1 across
  25k titles — a family-diversity signal awaiting full-text numbers
  (`safarpour2026` (A)).
- High self-consistency coexists with mediocre accuracy (run-to-run
  Fleiss κ 0.82–0.97 on hard corpora; `syriani2023`) — stability is
  not validity.
- The negative case: the best end-to-end system uses no redundancy at
  all (`huang2026`); independence mechanisms are not yet how the
  strongest pipelines buy reliability.

What no source provides is a definition: what makes two agent passes
_independent_ in the sense dual human review requires — different
prompts, tiers, vendors, training corpora? The correlated-error
question (shared training data producing shared blind spots) is
unmeasured everywhere; the pre-LLM guidance thought carefully about
human reviewer independence and simply has no agent analogue
(`hamel2021`). This is the map's clearest open problem.

= Discussion: this campaign as an instance of its subject

The map was produced by the class of system it maps, so its own
execution is fair evidence — in both directions.

*As a data point.* Same-vendor dual-pass screening across a tier and
prompt-frame split produced κ = 0.937 on a bounded binary task, while
the judgment-graded classification field varied 5.7× across same-tier
single passes — matching the literature's pattern of high agreement
on bounded tasks and degradation with judgment load (`syriani2023`,
`woelfle2024`). The adversarial verification pass overturned ~13% of
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
a logged deviation record, and a human freeze gate.

*Reflexive critique.* The measurement failures RQ2 documents appear
in our own execution. We measured agreement where it was cheapest
(binary screening) and not where judgment lived — classification ran
single-pass and extraction has no second pass, the precise gap the
literature names. Key normalization bugs left ~3.9% residual
duplicates in the include set, found only by post-freeze audit. And
three deep-read pipelines autonomously escalated to a
permission-gated browser fallback, a small live instance of the
boundary problem the norms literature worries about. Each failure is
logged as a deviation and codified as a fix in the extracted method —
in this campaign the deviation log was itself primary data.

*The v2 experiment this map motivates.* The clearest gap (RQ4) is
also the cheapest to attack from here: a cross-vendor dual-pass
campaign — the mirrored second-agent configuration already exists —
with disagreement analyzed by error type would be among the first
designed cross-family independence measurements in the literature
this survey mapped.

= Limitations

Same-vendor dual screening means κ = 0.937 may overstate
independence. Snowball coverage is bounded: one non-decayed round, a
title-vocabulary pre-filter that reintroduces the terminology
dependence snowballing exists to escape (`wohlin2014`), and
single-pass wave-2 excludes carry unquantified recall risk. Screening
and classification read truncated abstracts (600–900 chars); facets
are abstract-level and single-pass; deep-read extraction has no
second pass. ~3.9% residual duplicates remain in the frozen include
set. English only; 12 rows undecidable on available metadata. The map
is a closed baseline, not a living review; revival criteria are
recorded in the baseline record.

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
that frontier — and its own deviation log supplies the next
experiment.

#bibliography(
  "references.bib",
  full: true,
  style: "apa",
  title: [References],
)
