# Terminology

## Current conclusion

Across the sources registered for the terminology comparison and four
method-canon library notes, genre nouns and stage granularity vary more than
the shared stage names. At least four
umbrella nouns are in use—evidence synthesis, knowledge synthesis, secondary
studies, and systematic literature studies—and stage models range from four
phases to twelve steps. Search, screening/selection, extraction, appraisal,
synthesis, and reporting remain recognizable across those schemes.

The clearest terminology split is at appraisal: _quality assessment_, _risk of
bias_, and _appraisal-instrument scoring_ name overlapping but non-equivalent
tasks. The compared sources do not support a
medicine-versus-software-engineering split in stage names.

## Adopted vocabulary

- **Evidence synthesis** — umbrella for systematic reviews, systematic maps,
  scoping reviews, rapid reviews, and living reviews.
- **Secondary study** — one work in that family, over primary studies.
- **Systematic map** — this survey's study type: broad classification and gap
  structure rather than pooled effects or a formal quality-filtered review.
- **Updatable** — standing queries and update machinery exist, with no promised
  cadence. The survey does not call itself living.
- **Stages** — search, screening, extraction, appraisal, synthesis, and
  reporting. These six are the survey's collapse of the canon, not any one
  source's scheme.
- **Meta** — work about the process or field rather than an operational stage.
- **End-to-end** — a system substantively spanning at least four operational
  stages.

## Genre and umbrella nouns

The method canon already differs. Kitchenham and Charters use _systematic
literature review_ and treat mapping studies by contrast. Petersen et al. argue
for _systematic mapping study_ as a distinct genre. Wohlin uses _systematic
literature studies_ to cover both, while PRISMA 2020 governs _systematic
reviews_ and treats living as a mode.

Medicine and evidence-based practice add _evidence synthesis_, _knowledge
synthesis_, _rapid review_, and _living evidence synthesis_. Software
engineering uses SLR, systematic mapping study, and secondary study, while also
borrowing systematic review and scoping review. The variation is real, but it
does not license treating the genres as interchangeable: each source's own
scope controls.

## Stage names and boundaries

### Screening and selection

Both medicine and software engineering use both terms. _Selection_ often names
the stage by its outcome; _screening_ names the operation over titles,
abstracts, and full texts. The distinction occurs within sources and is not a
community dictionary split.

### Extraction and collection

_Data extraction_ dominates the compared sources. Song et al. use the doublet
"data extraction/collection" inherited from their phase model, but no compared
source argues that the terms denote competing stages. The evidence does not
support a live terminology dispute here.

### Appraisal

Three meanings sit under the survey's `appraise` facet:

1. **Quality assessment** in the SE/general line (`kitchenham2007`,
   `vandinter2021`, `degen2024`), usually a study-quality or validity checklist;
2. **Risk-of-bias assessment** in the Cochrane line (`arno2022`, `hirt2021`,
   `rose2025`, `huang2026`, `song2026`, `luo2024`, `fernandes2026`); and
3. **Appraisal-instrument scoring** in `woelfle2024`, whose PRISMA, AMSTAR, and
   PRECIS-2 tasks assess reporting, review methods, or trial pragmatism rather
   than risk of bias.

The later appraisal notes reinforce rather than overturn this distinction.
`hirt2021` and `rose2025` both use risk-of-bias language; neither introduces a
new community term. A catalog row coded `appraise` must therefore not be read as
a risk-of-bias study specifically.

### Granularity

The real disagreement concerns boundaries and stage count. The compared schemes
include four phases (`song2026`), five mapping steps (`petersen2008`), six local
operational stages, eight stages (`degen2024`), nine stages (`luo2024`,
`fernandes2026`), and twelve SLR steps (`kitchenham2007`, `vandinter2021`). They
differ on whether protocol development, registration, eligibility criteria,
discrepancy resolution, coding, publication, and publication update deserve
separate stages.

## Assistance and reviewer configurations

- **LLM assistance** — one model performs a bounded task under prompting.
- **Agent** — an LLM-based system acts with some autonomy inside the pipeline;
  the term is used descriptively because the compared literature supplies no
  stable autonomy threshold.
- **Ensemble** — multiple model outputs are aggregated by voting, averaging,
  or a union/OR rule.
- **Agreement-gated deferral** — model–human agreements are accepted and
  disagreements receive further human review.
- **Secondary reviewer** — AI checks a human decision.
- **Primary reviewer** — AI makes the first-pass decision under human
  oversight.

These configuration terms describe workflow position, not reviewer
independence. No compared source defines the latter for agents.

## Living versus updatable

The compared sources do not agree on what _living_ requires. Song et al.
specify an update phase, cadence, and retirement triggers. Legate et al. call
their baseline iteration a living review before any update has occurred.
PRISMA 2020 treats living as a review mode without specifying cadence, and
Holst et al. apply living to a guideline maintained in version control.

Because no compared source requires a demonstrated update history for the
label, _living_ often states an intended maintenance mode. This survey uses the
narrower _updatable_: its query registry and update workflow remain standing,
but updates occur only when requested.

## Evidence boundary

- The synthesis reads terms from titles, abstracts, and note prose; it is not a
  full-text frequency study.
- Five notes are abstract-only; one additional note is reconstructed
  secondhand and supports no finding.
- Software-engineering terminology rests on a small stratum of a
  medicine-heavy map.
- The four method-canon works have canonical library notes rather than duplicate
  survey-local notes.
- Negative statements concern the registered comparison sources, not every
  phrase in every full paper or the worldwide literature.

## Consequence for presentation

Use one umbrella consistently, identify this work as an updatable systematic
map, state that the six stages are a local collapse, and disclose the three-way
appraisal span. Avoid community-level vocabulary claims unless the evidence
actually compares communities.
