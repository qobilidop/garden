# Current position

Status: current through the 2026-08-08 deep-read baseline (25 notes,
23 clearing the curation bar; 5 abstract-only, one of those
reconstructed secondhand).

## Survey question

An exploratory systematic map of the methodology literature on
LLM/agent assistance in secondary studies (systematic reviews, maps,
evidence synthesis), across medicine, software engineering, and general
venues. Four questions: RQ1 what the landscape looks like by stage; RQ2
how reliability is measured and what the measurements show; RQ3 what
guidance/reporting norms exist; RQ4 (exploratory) which designs address
reviewer independence and multi-model ensembling. The map is a
corrected catalog of 646 included works (2020–2026) coded single-pass
from truncated abstracts; the deep reads are a facet-guided selection,
not a random or exhaustive sample. Findings about the map describe the
retained coding, not population prevalence.

## The four organizing findings

1. **Screening still dominates; the empty categories moved**
   (`screening-still-dominates.md`). The pre-LLM corpus (vandinter2021:
   41 studies, 2006–2020) sat entirely in the conducting phase —
   screening leading, appraisal n=1, planning and reporting untouched.
   The LLM-era map keeps screening on top (216 of 646) and keeps
   appraisal (25) and reporting (22) smallest, but now contains
   categories the pre-LLM corpus had zero of: 85 end-to-end rows and 34
   guideline contributions. The medicine-vs-SE split (394 vs 17 rows)
   is a property of this map, not an adoption-trend measurement.

2. **Reliability is real but mismeasured** (`reliability-is-mismeasured.md`).
   The selected evidence shows heterogeneous screening performance in
   which dataset/study effects exceed model effects (huotala2025), and
   measurement practice that hides the operative failure mode: under
   extreme class imbalance, accuracy-style metrics can rank a model
   best while it loses 63.3% of relevant evidence (madeyski2025).
   No tested operating point in the one SE benchmark met its authors'
   deployment bar (recall ≥ 0.95 at precision ≈ 0.50). Human baselines
   are themselves imperfect (single-reviewer sensitivity estimates
   ~87–92%, extraction error reports up to 50% — both secondhand
   citations, not measurements by the selected works).

3. **Norms converge on content, fragment on instruments**
   (`norms-converge-instruments-fragment.md`). Every guidance source
   shares a disclosure core (tool + version, stage and task, human
   role, verification) and human accountability. But three unvalidated
   instruments coexist (holst2025's 14-item checklist, degen2024's
   machine-readable table, fernandes2026's dual conduct/reporting
   tables), the announced PRISMA-AI remains unpublished, and the
   sanctioned AI role genuinely differs between sources: the
   Cochrane-family statements keep AI as a secondary QA reviewer;
   HAICO-SLR sanctions AI first-pass work under human validation.
   Disclosure in practice is reported as rare (secondhand, two domains).

4. **Independence is undefined for agents** (`independence-undefined.md`).
   None of the 25 deep reads defines what makes two agent passes
   independent, and the campaign had no targeted query or facet, so
   this is a deep-read observation, not a literature-wide absence
   claim. The ensemble evidence documents configurations without
   isolating mechanisms: a cross-vendor OR ensemble reached 99.7%
   sensitivity on author-adjudicated labels (94.0–94.5% on the original
   labels; preprint, no same-family arm — fagerberg2025), and
   human–LLM deferral beat both humans-alone and LLM-only ensembles on
   two easier appraisal instruments (woelfle2024). High run-to-run
   self-consistency coexists with mediocre validity (syriani2023).

## What would change these

- A saturation-iterated snowball or validated dual-pass facet coding
  could move the map's distributions (finding 1 rests on single-pass
  truncated-abstract coding; notes disagree with abstract-level facets
  for 8 of 25 deep reads).
- Full text of safarpour2026 (open-vs-proprietary screening contrast)
  and brincoveanu2025 (threshold-gated human–AI split) — both currently
  abstract-only — could strengthen or complicate findings 2 and 4.
- A published, validated PRISMA-AI or adoption evidence for any of the
  three instruments would collapse the fragmentation claim in finding 3
  into a settled-standard story.
- A designed independence study (matched same-family vs cross-family
  ensemble arms, correlated-error measurement) would convert finding 4
  from gap-observation to result.
- Peer-reviewed publication or independent replication of the two load-
  bearing preprints (fagerberg2025, huang2026) would firm up the RQ4
  and end-to-end evidence; failure to replicate would weaken it.

## Maintenance implication

A new work changes the survey when it defines or measures agent
independence, validates a disclosure instrument, supplies a
population-representative stage distribution, or reports screening
evidence with confusion-matrix-complete, imbalance-aware metrics at
deployment-relevant operating points. Such a finding updates the source
note, the affected thematic synthesis, and the manuscript; adding a
catalog row alone does not complete the update.
