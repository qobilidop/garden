= RQ1 — Landscape: primary-focus coding of the retained map <sec-rq1>

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto),
    align: (left, right, right, right, right, right, right, right),
    table.header(
      [Stage], [Med], [SE], [Gen], [Total],
      [Hum], [Bench], [None],
    ),
    [Search], [32], [2], [30], [64], [15], [19], [30],
    [Screen], [153], [10], [93], [256], [141], [64], [51],
    [Extract], [90], [2], [29], [121], [61], [39], [21],
    [Appraise], [30], [0], [3], [33], [21], [5], [7],
    [Synthesize], [25], [2], [22], [49], [14], [9], [26],
    [Report], [12], [3], [8], [23], [9], [4], [10],
    [End-to-end], [54], [2], [40], [96], [32], [10], [54],
    [Meta], [67], [2], [65], [134], [10], [8], [116],
    [*Total*], [*463*], [*23*], [*290*], [*776*], [*303*], [*158*],
    [*315*],
  ),
  caption: [Single-pass abstract coding: primary-focus stage × setting
    (medicine, SE, general) and stage × evidence label
    (human/reference-label agreement, benchmark-only, none). The
    evidence labels are not quality assessments.],
) <tab-map>

@tab-map summarizes the map after both waves. Screening is the
primary-focus label for 256 of 776 works, about a third; reporting (23)
and appraisal (33) remain the smallest categories. The map also contains
47 guideline-contribution works and 96 end-to-end rows, categories
absent from van Dinter et al.'s 2006–2020 corpus @vandinter2021. By
primary contribution, evaluation/benchmark works are most common (363),
followed by methods (171), systems/tools (132), positions (63), and
guidelines (47). These are unvalidated abstract-level labels, so their
exact differences describe the retained coding rather than population
prevalence.

The 2026-08-09 update grew the map by about a fifth without changing
its shape: every stage grew, the ordering is unchanged, and screening's
share moved from 33.4% to 33.0%. We do not read the per-cell growth
rates as signal. The update's searches were directed — new genre
vocabulary, citation chases seeded from twelve designated works, and a
re-screen of parked rows — so a cell's growth measures where we looked,
not what the field produced. One shift is worth naming against
ourselves: rows coded `none` on the evidence facet grew far faster than
rows recording any comparison, so the enlarged map records
proportionally *less* comparison evidence than before, not more.

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

The setting facet assigns 463 works to medicine and 23 to software
engineering. These incommensurable publication counts do not show that
the practice-adoption gap measured by Napoleão et al. has widened
@napoleao2021; they show only this map's medicine-heavy distribution.
Exactly one included row is jointly coded `setting=se` and
`contribution=guideline`, and it is a practitioner experience report
rather than an instrument; no software-engineering row is coded
`appraise` at all. Mapping relayed by the field's coordination
body found AI use rarely disclosed in the education and climate/health
domains it covered @oconnor2024. Mughal et al. provide one detailed
disclosed-adoption exemplar among the deep reads @mughal2026.
