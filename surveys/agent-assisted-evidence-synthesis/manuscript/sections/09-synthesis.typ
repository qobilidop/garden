= Synthesis and open problems <sec-synthesis>

#figure(
  table(
    columns: (2.2em, 27em, 12em),
    align: (left, left, left),
    table.header([RQ], [Finding], [Evidence]),
    [1], [The retained coding is screening-heavy, medicine-heavy, and thin in
      appraisal and reporting; these are map counts, not adoption measures],
      [map; @napoleao2021],
    [2], [Metric choice, aggregation, and study effects materially change
      performance verdicts; one benchmark found study effects larger than
      differences among its larger models], [@madeyski2025 @huotala2025],
    [3], [Disclosure elements recur without a common item set; four
      unvalidated instruments divide reporting and reproducible storage],
      [@holst2025 @degen2024 @fernandes2026 @lombaers2024],
    [4], [Selected OR-ensemble and human–LLM-deferral results do not supply a
      matched causal account or a definition of agent-reviewer independence],
      [@fagerberg2025 @woelfle2024 @hamel2021],
    [§3], [Genre nouns and stage granularity vary more than the recognizable
      shared stage names; appraisal has the clearest terminology split],
      [registered comparison; canon],
  ),
  caption: [One bounded synthesis per research question, plus the terminology
    result from @sec-taxonomy.],
) <tab-findings>

@tab-findings condenses descriptive, differently scoped findings. The
selected studies show heterogeneous absolute performance, several
workflow structures (decomposition, human review, deferral, OR
ensembling), and recurring measurement deficiencies under class
imbalance. Their designs and datasets are not commensurate enough to rank
structure, scale, redundancy, and methodology as causal bottlenecks.

Priorities suggested by the retained map, rather than demonstrated
literature absences, include: a targeted definition and measurement
study of reviewer _independence_ for agents (@sec-independence); deeper evidence
for the small appraisal, synthesis, and reporting categories; work in
the map's underrepresented SE setting; publication-update tools beyond
the terminology-sensitive inventory @song2026; validation and adoption
studies for the four instruments; and norms for agent-primary
configurations. The Cochrane-family guidance keeps AI as a secondary
checker, while HAICO-SLR sanctions first-pass roles under human
validation @fernandes2026.
