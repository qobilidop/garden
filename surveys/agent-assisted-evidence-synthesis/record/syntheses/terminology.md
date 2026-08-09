# The genre nouns are contested; the stage names are not

Status: drafted 2026-08-09 against the post-update note set.

## Current conclusion

The field's vocabulary is unstable at the level of *what a secondary
study is called* and stable at the level of *what its stages are
called*. Across the 25 deep reads and the four method-canon library
pages, the object noun varies by community, by decade, and by
institution — systematic review, systematic literature review (SLR),
systematic mapping study, scoping review, rapid review, living
evidence synthesis — and so does the umbrella above them: at least
four umbrella nouns are in live use (evidence synthesis, knowledge
synthesis, secondary studies, systematic literature studies). But the
stage names are close to shared. Every source names search,
screening/selection, extraction, appraisal, synthesis, and reporting
recognizably. Where sources genuinely disagree about stages, they
disagree about *how many there are and where the boundaries fall*
(4, 5, 6, 8, 9, and 12 stage counts appear across the set), not about
what the shared ones are called.

One real term split survives that test, and it sits at appraisal:
"quality assessment" (SE canon), "risk of bias" (Cochrane line), and
"evidence appraisal instrument scoring" (woelfle2024) name three
overlapping but non-identical tasks that this survey's single
`appraise` facet currently glosses.

The manuscript's uncited assertion that "the literature's vocabulary
is inconsistent across its three home communities" is therefore
partly right for the wrong reason and must be softened and recited:
the inconsistency is real but it is *genre-level and
granularity-level*, not a medicine-vs-SE dictionary of different
words for the same stage.

## (a) The genre nouns, per source

What each source calls its own object, as recorded in the notes and
library pages (read off titles, abstracts, and note prose — not from
a term-frequency study of full texts):

**Method canon.** kitchenham2007 names the genre "systematic
literature review" (SLR) and defines mapping studies only by contrast
in §8 — broader questions, classification not extraction,
summary not synthesis. petersen2008 makes "systematic mapping study"
a genre in its own right and argues explicitly against the narrow
niche kitchenham2007 had assigned it. wohlin2014's title reaches for
a neutral umbrella — "systematic literature *studies*" — precisely
because its procedure serves both. page2021 governs "systematic
reviews", states that it applies with or without meta-analysis and to
updated and living reviews, and anchors a family of extensions
including one for scoping reviews and PRISMA-S for search reporting.
So the canon itself already carries three object nouns and one
umbrella, and the SE and medicine branches solve the umbrella problem
differently.

**Medicine and EBM.** gartlehner2025's object is the *rapid review*;
its venue is *Cochrane Evidence Synthesis and Methods*, it endorses
RAISE ("Responsible AI use in Systematic Evidence Synthesis"), and it
sits beside a joint statement from Cochrane, Campbell, JBI, and the
Collaboration for Environmental Evidence — "evidence synthesis" is
the umbrella throughout that line. hamel2021, from the same
Canadian/EBM neighborhood four years earlier, uses a *different*
umbrella in its title: "knowledge syntheses". luo2024 uses the
medicine compound "systematic reviews and meta-analyses".
oconnor2024 reports ICASR (Automation of Systematic **Reviews**)
while relaying Bond et al.'s coinage "digital evidence synthesis
tools" (DESTs). song2026's object is "living evidence synthesis".
arno2022, gargari2023, oami2025, fagerberg2025, and barsby2024 all
say plainly "systematic reviews".

**Software engineering.** vandinter2021 is an SLR of SLR automation
and inherits kitchenham2007's 12 SLR steps wholesale. napoleao2021 is
a "systematic mapping" over "secondary studies". felizardo2024's
object is a "systematic mapping study (SMS)" and its conclusion
reaches for the medicine umbrella anyway — "evidence synthesis in
SMS". huotala2025 says "systematic reviews" in its title and
"secondary studies" for its corpus. syriani2023 says "systematic
reviews" while its five corpora are described as
systematic-review/mapping-study projects. mughal2026 and
brincoveanu2025 both say "systematic literature review".
safarpour2026 — an SE-venue paper (SANER-C) — asks whether LLMs are
trustworthy tools for **scoping reviews**, importing a genre noun
from outside SE (abstract-only; the full text may or may not run a
scoping review in the methodological sense).

**General / cross-domain.** holst2025's object is the SLR but its
acronym expands to "…in Comprehensive Evidence **Synthesis**", and it
carefully distinguishes itself from PRISMA-AI, which covers SLRs
*studying* AI as a subject. fernandes2026's object is the SLR and it
distinguishes PRISMA-S and PRISMA-ScR as extensions specifying review
*type* rather than who executes each step. degen2024's object is the
"systematic review", and it builds its eight canonical stages by
synthesizing Arksey & O'Malley 2005 (the scoping-review methodology
paper), Newman & Gough 2020, and Petticrew & Roberts 2008 — genres
merged into one stage model without the difference being flagged.
huang2026 puts both nouns in one title: "Medical Systematic Reviews
and Evidence Synthesis".

**The survey's adopted resolution** (already decided; recorded here,
not argued): "evidence synthesis" is the umbrella covering reviews,
maps, scoping reviews, rapid reviews, and living reviews; this survey
is an *updatable systematic map* in petersen2008's sense. The
campaign was retitled on 2026-08-09 from "Agent-Assisted Systematic
Review Methodology" to "Agent-Assisted Evidence Synthesis" for
exactly this reason — the declared scope was always secondary studies
broadly while the executed query vocabulary was review-centric, and
the update added mapping-study, scoping-review, and living-review
qids under `queries.tsv` theme `genre-gap` (status.md method-change
log, 2026-08-09).

**A naming collision worth recording, not evidenced by the selected
set.** "Survey methodology" in the wider literature denotes
questionnaire and sampling research, not literature surveys. No
source read here addresses the collision; it is recorded because this
repository's own topic page is named `survey-methodology` and the
manuscript's own genre noun is "survey".

## (b) The community split in stage vocabulary: thinner than claimed

Tested term by term against the notes:

**"Screening" vs "selection" — not a community split.** Both
communities use both words, and the split that exists is
stage-vs-operation, not medicine-vs-SE. SE selection usage:
vandinter2021's step is "Selection of Primary Studies (SLR6)" and the
note glosses it as screening in the same sentence; napoleao2021's
object is "searching and selecting evidence"; safarpour2026 says
"paper selection"; brincoveanu2025 says "automated selection". SE
screening usage, equally native: huotala2025 ("title-abstract
screening"), syriani2023 ("screening articles"), mughal2026
("screening pre-filter"), madeyski2025 ("screening literature").
Medicine screening usage: hamel2021, oami2025, gargari2023,
fagerberg2025. Medicine *selection* usage: luo2024 (the "literature
selection process"), huang2026 (mapping its stages to PRISMA
study-selection items). The stable pattern is that "selection" names
the stage by its outcome and "screening" names the operation on
titles/abstracts and full texts — a distinction internal to
kitchenham2007 and page2021, not indexed to a community.

**"Data extraction" vs "data collection" — no live dispute in the
selected evidence.** "Data extraction" is near-universal:
kitchenham2007, legate2024, felizardo2024, luo2024, huang2026,
madeyski2025, degen2024, holst2025, fernandes2026. The single
exception is song2026, whose phase 2 carries the doublet "data
extraction/collection" — inherited with the rest of its phase model
from Thomas et al. 2017, not asserted as a distinction. Nothing in
the page2021 library page records a competing term. On the evidence
read here, this strand does not support a vocabulary claim.

**"Quality assessment" vs "risk of bias" — a real split, and the one
worth printing.** The SE and general line says quality assessment:
kitchenham2007 assesses quality via bias/validity checklists and
explicitly *softens* the medical hierarchy of evidence; vandinter2021
names the step "Study Quality Assessment (SLR7)"; degen2024's
eight-stage model has "Quality Assessment". petersen2008 defines its
genre partly by the *absence* of the stage — a map does no quality
assessment, and its argument is that quality-filtering biases an
overview. The Cochrane line says risk of bias: arno2022 (Cochrane RoB
1, abstract-only), huang2026 (five Cochrane RoB-1 domains, a
dedicated fine-tuned SR-RoB-7B), song2026 (phase 2), luo2024
("assess risk of bias"), fernandes2026 (an "RoB assessment" stage),
barsby2024 (the older Cochrane RoB tool — reconstructed secondhand,
no abstract of that paper exists). And a *third* sense sits under the
same facet: woelfle2024's "evidence appraisal tools" are PRISMA,
AMSTAR, and PRECIS-2 — reporting quality of reviews, methodological
rigor of reviews, and pragmatism of trials — none of which is a
risk-of-bias judgment. song2026 runs both senses at once, grading
study quality with QUADAS-2/JBI/AMSTAR 2 while calling phase 2's task
risk-of-bias assessment. "Critical appraisal" as a term appears in
none of the 25 notes; it should not be asserted as a third community
usage.

**The granularity disagreement is where the real inconsistency
lives.** Stage counts across the set: song2026 has 4 phases (from
Thomas et al. 2017), petersen2008 has 5 steps — one of which,
*keywording of abstracts*, has no counterpart in any review
vocabulary — this survey has 6 (plus `end2end` and `meta`),
degen2024 has 8, luo2024 has 9 rows, fernandes2026 has 9 stages, and
kitchenham2007/vandinter2021 have 12 steps in 3 phases. The
substantive disagreements are about whether protocol development,
registration, criteria specification, ideation, discrepancy
resolution, coding, submission/publication, and publication update
are stages of their own. luo2024 splits question, registration,
criteria, and search strategy apart and adds submit/publish;
fernandes2026 adds ideation, discrepancy resolution, and coding;
song2026 adds publication update; degen2024 adds protocol development
and dissemination. None of these is a *renaming* of a stage this
survey codes — each is a boundary the survey draws elsewhere.

**Where a community difference is actually measured, it is in
metrics, not stage names.** napoleao2021's pre-LLM cross-domain
mapping (66 studies, 33 SE / 33 medicine) found WSS@95% in 11
medicine studies versus 1 SE study, with AUC, Burden, Yield, and
Utility appearing only in medicine studies. That is the
community-indexed vocabulary split this survey can support with a
count, and it is already held in `screening-still-dominates.md`.

## (c) Living evidence: a label claimed at declaration, not earned

What the selected sources actually require of a "living" synthesis:

- **song2026** is the only source that operationalizes it. Its phase
  model (adopted from Thomas et al. 2017, not new) makes *publication
  update* phase 4 — the phase that distinguishes the genre. Its own
  protocol declares a 12-month living-update registration, monthly
  database subscriptions via Covidence, dual independent reviewers
  with third-reviewer adjudication throughout, and four explicit
  retirement triggers: evidence reaches conclusiveness; evidence
  loses decision-making value; no new eligible studies in a 12-month
  window; funding unavailable. It labels itself "Version 1" with an
  April 2, 2025 search cutoff.
- **legate2024** calls itself a living review while reporting its
  *baseline (first) iteration* — no update has yet occurred, and it
  explicitly defers its own inter-rater-reliability assessment to
  future updates. Its methodology is adapted from a sibling clinical
  living review (Schmidt et al.). The label is worn from the start.
- **page2021** treats living as a *mode* of a systematic review, not
  a genre: PRISMA 2020 states it applies to updated and living
  reviews, and imposes no cadence, no standing-search requirement,
  and no update-history requirement.
- **holst2025** applies "living" to a *guideline* rather than a
  review — a "Rationale for a Living Guideline" with a GitHub
  repository as version-controlled source of truth, a Discord hub,
  and planned annual reviews pending handoff to a future steering
  committee. Its own note records this as stated intention, not
  evidence of uptake.

The sources therefore do **not** agree on what "living" requires.
Only song2026 states a cadence with a number and a mechanism, and
only song2026 states retirement triggers. No source in the read set
requires a *published* update history for the label — legate2024
demonstrates that it does not, holding the label at iteration zero.
The label marks an intention to re-run, and the strength of that
intention is disclosed inconsistently.

Two further limits on this strand. First, the one inventory that
measures automation of the update phase found exactly **1 of 34
tools** serving phase 4 (RobotReviewer LIVE, also the only tool
spanning all four phases), with no efficiency, accuracy, or utility
evidence at that phase — and song2026's own stated limitation is that
its search was bounded by "living evidence" terminology, which would
specifically undercount phase 4. The survey's manuscript already
carries this caveat in its discussion. Second, oconnor2024's title
names *updates* as one of three ICASR themes, but the deep-read note
records four sessions and none of them is the updates session — the
selected evidence carries no ICASR position on updating.

**Where this survey sits.** It declares itself *updatable*, not
living, and the word is the honest one. It has the mechanisms:
a standing query set with per-query `last_reconciled` dates, an
append-only method-change log, a human-gated update ledger, and
snowball rules that operationalize wohlin2014's extension deduction
(for *extending* an existing systematic study, snowballing dominates
database search, because new relevant work almost certainly cites the
prior study or its included papers — argued by deduction, with
empirical support explicitly left to future work). napoleao2021
independently frames the SLR-update scenario as the most promising
near-term case for automation, since the original review's
included/excluded set is ready-made training data. What the survey
lacks against song2026's operationalization is a declared cadence and
retirement triggers; its maintenance state is "updates on demand"
with one reconciled batch (2026-08-09). Measured against
legate2024's usage, it would already qualify as living — which is the
point of this section rather than an argument for adopting the label.

## Scope conditions

- Genre-noun and stage-noun usage here is read off titles, abstracts,
  and the notes' own prose. No source was re-read to count term
  frequency, and no full text was searched for a term this synthesis
  says is absent. "The selected notes do not use X" is a claim about
  the notes, not about the papers.
- Five deep reads are abstract-only (arno2022, brincoveanu2025,
  felizardo2024, safarpour2026, barsby2024). barsby2024 has no
  abstract in existence and was reconstructed secondhand from a
  citing paper and search snippets — its genre and RoB-tool usage is
  provisional. safarpour2026's "scoping review" framing is likewise
  a title-and-abstract observation.
- Four load-bearing sources are preprints: fernandes2026 (SSRN),
  degen2024 (OSF), fagerberg2025 and huang2026 (medRxiv).
- The three-communities comparison is a deep-read-level observation.
  By the notes' `setting` facet the 25 reads are roughly 12 medicine,
  8 SE, 5 general — but the map itself is 463 medicine rows against
  23 SE rows among the 776 coded works, so SE vocabulary claims rest
  on a small deep-read stratum, not on the map.
- This synthesis was drafted against the 25 notes present in
  `sources/` at drafting time. At least one further note (hirt2021)
  appeared during drafting and is not incorporated; the appraisal
  strand in particular should be re-tested against it.

## Consequences for the manuscript

1. **@sec-taxonomy's opening sentence must be softened and cited.**
   "The literature's vocabulary is inconsistent across its three home
   communities" is not supported as a claim about stage names. What
   is supported, and citable: the *genre and umbrella nouns* vary
   (kitchenham2007, petersen2008, wohlin2014, page2021,
   gartlehner2025, hamel2021, song2026, safarpour2026), the *stage
   counts* vary from 4 to 12 (song2026, petersen2008, degen2024,
   luo2024, fernandes2026, kitchenham2007), and the *appraisal stage*
   genuinely carries three names for three overlapping tasks
   (kitchenham2007/vandinter2021, arno2022/huang2026, woelfle2024).
2. **The six-stage list is the survey's collapse, not kitchenham2007's
   scheme.** @sec-taxonomy cites `@kitchenham2007 @page2021` for
   "the canonical vocabulary", but kitchenham2007's own scheme is 12
   steps in 3 phases. Say that the survey collapses the canon's steps
   into six stages.
3. **State the appraisal span.** RQ2 and RQ4 evidence coded `appraise`
   spans Cochrane risk-of-bias judgment (arno2022, huang2026) and
   appraisal-instrument scoring on reviews and trials (woelfle2024).
   One sentence in @sec-taxonomy naming both under the facet prevents
   a reader from reading `appraise` as risk-of-bias only.
4. **Print the resolution and the retitle.** A manuscript titled
   "Evidence Synthesis" that declares itself a systematic map owes the
   reader the umbrella rule: evidence synthesis covers reviews, maps,
   scoping and living reviews; this work is an updatable systematic
   map. @sec-method already discloses the genre-gap qids; the noun
   rule belongs in @sec-taxonomy.
5. **Pick one umbrella and hold it.** The manuscript currently runs
   two: @sec-taxonomy defines "_secondary study_" as its term of art
   while the title, RQ3, and @sec-background use "evidence synthesis".
   Both are defensible; using both without a stated relation is the
   inconsistency this synthesis is meant to prevent.
6. **Strengthenable, with a count behind it.** The one measured
   community difference in vocabulary is napoleao2021's metric split
   (WSS@95% in 11 medicine studies vs 1 SE study; AUC, Burden, Yield,
   Utility medicine-only). If the manuscript wants a
   community-vocabulary claim, this is the one that survives.

## What would change this

- A deliberate lexical study over full texts (term frequency by
  community and year) would replace this synthesis's read-off-the-
  notes method and could overturn the screening/selection and
  extraction/collection findings in either direction.
- Full text of safarpour2026 would show whether an SE venue is
  running a scoping review methodologically or using the noun loosely
  — the single strongest test of genre-noun leakage across
  communities.
- A second living-evidence source with a *published* update history,
  or any source that makes update history a criterion for the label,
  would convert (c) from "claimed at declaration" to a real
  definitional dispute.
- A deep read of PRISMA-ScR or PRISMA-S would settle whether the
  scoping review and the systematic map are one genre under two
  communities' names — the selected evidence does not settle it, and
  degen2024's merging of Arksey & O'Malley into a generic SR stage
  model suggests the field does not treat the boundary as load-
  bearing.
- Incorporating hirt2021 and any later appraisal-stage notes could
  sharpen or complicate the quality-assessment / risk-of-bias /
  instrument-scoring split, which is this synthesis's only
  print-worthy stage-name finding.
- Publication of PRISMA-AI would add a fifth genre-adjacent term
  (reviews *of* AI versus reviews *using* AI) that holst2025 and
  fernandes2026 currently have to disambiguate by hand.
