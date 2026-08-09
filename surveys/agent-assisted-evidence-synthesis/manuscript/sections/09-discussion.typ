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
