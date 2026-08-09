= Terminology and Taxonomy <sec-taxonomy>

The field's vocabulary is unstable in a specific place. What the
stages of a secondary study are *called* is close to shared; what the
study itself is called, and how many stages it has, is not. We fix the
following usage for this survey and mark where the literature diverges.

*The umbrella and the object.* We use _evidence synthesis_ as the
umbrella genre — covering systematic reviews, systematic maps, scoping
reviews, rapid reviews, and living reviews alike — and _secondary
study_ for an individual work of that kind, over primary studies. The
literature supplies at least four competing umbrellas: evidence
synthesis in the Cochrane-adjacent line @gartlehner2025, knowledge
synthesis @hamel2021, secondary studies in software engineering
@napoleao2021, and systematic literature studies @wohlin2014. The
object nouns vary as much: @kitchenham2007 governs the systematic
literature review and admits mapping studies only by contrast, while
@petersen2008 argues the systematic map is a genre in its own right;
@page2021 governs systematic reviews and treats *living* as a mode
rather than a genre. This survey is itself an updatable systematic
map in @petersen2008's sense, and it was retitled during its
2026-08-09 update to name the umbrella rather than the dominant genre
under it.

*Stages.* We use six: _search_ (query design and study
identification), _screening_ (title/abstract and full-text selection),
_extraction_ (structured data capture), _appraisal_ (quality and
risk-of-bias assessment), _synthesis_ (qualitative or quantitative
aggregation), and _reporting_ (writing and disclosure). This six-stage
set is our collapse of the canon rather than any source's own scheme:
@kitchenham2007 specifies twelve steps in three phases, @petersen2008
five steps — one of them, keywording of abstracts, with no counterpart
in review vocabulary — and the LLM-era stage models run from four
phases @song2026 to eight @degen2024 and nine @fernandes2026. The
substantive disagreements are boundary questions — whether protocol
development, registration, discrepancy resolution, or publication
update are stages of their own — not disputes about what the shared
stages are named.

One genuine term split survives that test, and it sits at appraisal.
The software-engineering canon says quality assessment
@kitchenham2007 @vandinter2021; the Cochrane line says risk of bias
@arno2022 @huang2026; and a third sense scores appraisal instruments
on reviews and trials rather than judging bias at all — PRISMA,
AMSTAR, and PRECIS-2 in @woelfle2024. Our single `appraise` facet
spans all three, so a row coded `appraise` should not be read as a
risk-of-bias judgment specifically.

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
