= Synthesis and Open Problems <sec-discussion>

#figure(
  table(
    columns: (2.2em, 27em, 12em),
    align: (left, left, left),
    table.header([RQ], [Finding], [Evidence]),
    [1], [Single-pass primary-focus coding assigns 256 of 776 works to
      screening; appraisal (33) and reporting (23) are smallest], [map],
    [1], [The retained map is medicine-heavy (463 rows) relative to SE
      (23); this is not an adoption-trend measure], [map;
      @napoleao2021],
    [1], [One end-to-end preprint uses decomposition, structured
      artifacts, human review, and no redundancy; extraction, reranking, and
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
    [3], [Four deep-read instruments across two genres — three
      disclosure checklists and one reproducible-storage checklist —
      coexist without reported validation or adoption evidence],
      [@holst2025 @degen2024 @fernandes2026 @lombaers2024],
    [3], [In the one consensus exercise the map contains, the panel's
      own account places its weakest agreement on actionable automation
      use], [@golob2025],
    [4], [A cross-vendor OR ensemble preprint reports 99.7% sensitivity
      on author-adjudicated labels and 94.0–94.5% on original labels;
      family diversity was not isolated], [@fagerberg2025],
    [4], [Human–LLM deferral outperformed comparison arms on two easier
      retrospective appraisal instruments, not as a general law],
      [@woelfle2024],
    [4], [None of 31 selected deep reads defines agent-reviewer
      independence; neither wave searched or coded the question
      exhaustively], [deep-read subset; @hamel2021],
    [4], [The one independence construct in the set is procedural —
      two human operators running one model — not architectural],
      [@rose2025],
    [§3], [The field's genre nouns and stage granularity are contested
      while its stage names are not; an earlier claim of a
      medicine-versus-SE stage-vocabulary split did not survive
      testing], [deep reads; canon],
  ),
  caption: [Summary of findings with their evidence. The final row
    answers no research question; it reports the terminology result
    from @sec-taxonomy.],
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
studies for the four instruments; and norms for agent-primary
configurations. The Cochrane-family guidance keeps AI as a secondary
checker, while HAICO-SLR sanctions first-pass roles under human
validation @fernandes2026.
