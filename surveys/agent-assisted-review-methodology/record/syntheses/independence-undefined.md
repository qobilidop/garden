# Independence is undefined for agents

Status: current through the 2026-08-08 baseline.

## Current conclusion

Dual independent review is the method's core error-control mechanism,
and none of the 25 selected deep reads says what its analogue is for
agents — different prompts, tiers, vendors, training corpora — or
measures correlated error from shared training data. The available
multi-model evidence documents *configurations* (OR ensembling,
consistency-gated ensembles, human–LLM deferral) with observed
performance, never a design that isolates the independence mechanism.
Scope condition on the whole thesis: the campaign ran no targeted
independence/ensemble query and coded no independence facet, so this
is an observation about a facet-guided 25-work selection, not a
literature-wide absence claim.

## What "independence" meant before agents

hamel2021 operationalizes independence entirely between humans:
reviewer-compatibility settings, dual-independent screening as best
practice, conflict-resolution schedules. Its AI (active-ML
prioritization) is not a reviewer at all. gartlehner2025's sanctioned
AI-as-secondary-QA role is the nearest LLM-era descendant — AI
re-checks human single-reviewer decisions — which is a verification
design but again defines no criterion for when the checker counts as
independent of what it checks.

## The ensemble evidence, and what it does not establish

- **Cross-vendor OR ensemble** (fagerberg2025; preprint, not
  peer-reviewed): GPT-5 Thinking + Gemini 2.5 Pro, two runs each, OR
  rule, 736 Cochrane citations. GUI ensemble 99.7% sensitivity /
  49.3% specificity on the authors' adjudicated labels; 94.0–94.5%
  sensitivity against the original Cochrane labels. Three caveats
  travel with these numbers: (1) the 18 adjudicated relabels were all
  Include→Exclude, decided by two same-team adjudicators, and all
  moved measured sensitivity upward; (2) specificity is a stated
  conservative lower bound (reference standard is full-text
  inclusion); (3) there is no same-family arm, so model family, model
  identity, duplicate runs, and the OR rule are confounded. The
  much-cited vaccine subgroup (GPT-5 at 43% sensitivity where Gemini
  flagged the same records) is post hoc with seven positives —
  suggestive of family complementarity, evidence of nothing stronger.
- **Consistency-gated LLM ensemble vs human–LLM deferral**
  (woelfle2024): the 9-run ensemble reaches human-level appraisal
  accuracy only on items surviving near-unanimous agreement, deferring
  74–88% of items at those thresholds. The deferral design (human +
  one LLM; disagreements to a second human) reaches 95–96% accuracy on
  PRISMA/AMSTAR while sparing ~65–70% of second-reviewer items, and
  80–86% sparing ~29% on PRECIS-2. Limits: two-rater-consensus
  reference, per-model engineered prompts (confounding cross-model
  ranking), no time measurement. Supports deferral for these
  instruments; not a general design law.
- **Family-behavior contrast** (safarpour2026; abstract-only):
  Mistral 7B and Llama 3.3 70B screened "more conservatively" than
  GPT-4.1 across 25,149 titles — exactly the cross-family behavioral
  divergence an independence argument needs, with zero extractable
  numbers until full text is obtained.
- **Threshold-gated split** (brincoveanu2025; abstract-only): AI
  decides above a confidence threshold, defers below — a
  deferral-adjacent gate design with no reported figures.

## Two opposite ensemble mechanics

The two designed studies pull in opposite directions and should not be
summed into one "ensembles work" claim. fagerberg2025's OR rule buys
sensitivity by *unioning* includes — any run can force inclusion, so
specificity pays (49.3%). woelfle2024's consistency gate buys accuracy
by *intersecting* — only near-unanimous items are decided, so coverage
pays (74–88% deferred). Neither study measures the quantity an
independence theory needs: how correlated the constituent runs' errors
are, and whether cross-family correlation is lower than within-family
correlation. syriani2023 supplies the warning that stability is not
validity: run-to-run Fleiss κ of 0.821–0.973 alongside mediocre
accuracy — a single model agreeing with itself is exactly what an
independence criterion must not count.

## The strongest counterpoint: reliability without redundancy

huang2026 (MedSR-Copilot; preprint, author-built benchmark) is the
selected set's only end-to-end system, and it uses no debate, voting,
or agent redundancy at all — its gains come from task decomposition,
structured intermediate artifacts, and human gates. Its ablations test
extraction staging, reranking, and retrieval, not redundancy or human
review, so it cannot establish that redundancy is unnecessary — but it
is a live existence proof that a performing pipeline can skip
independence mechanisms entirely, which any "ensembles are the path to
reliability" claim must answer.

## Scope conditions

- No targeted query, no independence facet: the gap claim is bounded
  to the 25 deep reads by construction.
- Both quantitative multi-model studies are medicine-domain; both
  load-bearing works (fagerberg2025, huang2026) are preprints.
- The deferral result is appraisal-stage; the OR-ensemble result is
  screening-stage. No selected work tests either mechanism on the
  other's stage.

## Consequences for the manuscript

RQ4's framing — configurations documented, mechanism not isolated,
gap not literature-wide — is supported. This synthesis additionally
holds: the direction-of-adjudication caveat on fagerberg2025's
headline number (stated in the limitations-adjacent note text; the
manuscript reports both label standards but not that all 18 relabels
favored measured sensitivity), the specificity-lower-bound caveat, and
the union-vs-intersection framing of why the two ensemble results
cannot be pooled.

## What would change this

- Any work defining agent-reviewer independence operationally, or
  measuring error correlation within vs across model families — this
  would convert RQ4's gap into a literature and likely force a
  targeted follow-up search round.
- A matched ensemble study with same-family and cross-family arms
  (the ablation fagerberg2025 lacks).
- safarpour2026 full text: numeric open-vs-proprietary divergence
  would be the first quantified cross-family behavioral contrast in
  the set.
- A huang2026-style system evaluated with and without redundancy —
  directly testing whether decomposition substitutes for independence.
- Peer review outcomes for fagerberg2025 and huang2026; an
  adjudication-robust replication of the OR-ensemble result (e.g.,
  independent relabeling) would remove its largest caveat.
