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
