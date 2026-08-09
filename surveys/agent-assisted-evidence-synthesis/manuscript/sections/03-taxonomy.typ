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
