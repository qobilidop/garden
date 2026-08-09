# Independence is undefined for agents

Status: current through the 2026-08-09 update batch.

## Current conclusion

Dual independent review is the method's core error-control mechanism,
and no selected deep read says what its analogue is for agents. No
work in the set offers a definition — a criterion for when two agent
reviewers count as independent of each other. That claim survives the
2026-08-09 update intact.

What no longer survives is the stronger sub-claim that the evidence
documents configurations *without ever measuring the mechanism*. The
update's akinseloyin2026 measures inter-agent rank correlation
directly, argues in its own conclusion that model heterogeneity is
what makes weak-model aggregation work, and — most usefully — shows
the correlation *rising* when its agents are allowed to debate, which
it offers as the reason debate underperformed independent voting. That
is a mechanism argument, not a definition, and it is uncontrolled
(three agents differing simultaneously in vendor, size, and training
corpus, with no same-family arm). The accurate current position is
therefore narrower than before: independence is measured once, by
proxy, and defined never.

Scope condition on the whole thesis, unchanged: neither campaign ran a
targeted independence query nor coded an independence facet, so this
remains an observation about a facet-guided deep-read selection, not a
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
- **Cross-vendor voting with a measured diversity claim**
  (akinseloyin2026): three primary agents (GPT-4o Mini, Claude 3
  Haiku, Gemini 1.5 Flash) answer inclusion-criteria questions
  independently; a fourth model (Gemini 1.5 Pro) adjudicates. Score-
  averaged Soft-Vote beat every constituent (DTA MAP 0.341 against
  0.271/0.266/0.182; WSS\@95% 0.680) and beat both debate and
  adjudication variants, at roughly 1/186 of estimated human cost.
  Its independence content is the reportable part: Spearman rank
  correlations *between agents* of 0.48–0.56 (DTA) and 0.49–0.52
  (Intervention), a conclusion asserting "the core role of model
  diversity (i.e. model heterogeneity) on the success of aggregating
  relatively weaker screening models", and a same-vendor bias flagged
  but uncorrected (the Gemini adjudicator correlates more strongly
  with the Gemini agent). No same-family control arm, so vendor,
  size, and corpus remain confounded.
- **Same-family ensemble, no mechanism** (knafou2023): five
  BERT-family classifiers differing only in pretraining corpus and
  size, combined by probability sum or voting. Ensemble F1 89.16%
  against the best standalone member's 88.53%; no correlation,
  agreement, or error-overlap statistic between any pair appears
  anywhere in the paper. Its unanimity-plus-threshold setting reaches
  ~98.5% F1 and ~99% recall while deciding only about half the
  corpus — a second, non-LLM instance of woelfle2024's
  accuracy-for-coverage trade.

## What the two new ensembles suggest, and why it is not yet evidence

Read together, akinseloyin2026 and knafou2023 sit at opposite ends of
the diversity axis, and their margins over their own best members
differ in the direction an independence theory predicts: the
cross-vendor ensemble improves on its best constituent substantially
(MAP 0.341 against 0.271, a ~26% relative gain), while the
same-family ensemble improves on its best constituent marginally
(F1 89.16% against 88.53%). It is tempting to read that as the
within-family versus cross-family contrast the set has been missing.
It is not. The two studies differ in corpus, task, metric, model era,
and architecture class, and neither was designed as an arm of the
other; the comparison is confounded in every way a matched ablation
would control. It is recorded here as a hypothesis worth a targeted
design, explicitly not as a result — and the survey should resist
printing it as anything stronger.

akinseloyin2026's debate finding is the more solid contribution,
because it is internal to one study: allowing the agents to see each
other's reasoning raised their inter-agent correlation and lowered
ensemble performance relative to independent voting. Interaction
consumed the diversity the ensemble was exploiting. That is a
mechanism observation with a within-study comparison behind it, and
it is the closest thing in the set to evidence that independence —
whatever its eventual definition — is the thing doing the work.

## Two opposite ensemble mechanics

The two designed studies pull in opposite directions and should not be
summed into one "ensembles work" claim. fagerberg2025's OR rule buys
sensitivity by *unioning* includes — any run can force inclusion, so
specificity pays (49.3%). woelfle2024's consistency gate buys accuracy
by *intersecting* — only near-unanimous items are decided, so coverage
pays (74–88% deferred). Neither of those two studies measures the quantity an
independence theory needs: how correlated the constituent runs' errors
are, and whether cross-family correlation is lower than within-family
correlation. akinseloyin2026 now supplies the first half of that
quantity — inter-agent score correlation, though not error
correlation specifically — and none of the set supplies the second. syriani2023 supplies the warning that stability is not
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

## The mechanism is being built next door

Chasing akinseloyin2026 forward surfaced a clinical-AI oversight
framework (doi:10.64898/2026.02.08.26345860, SCOUT) that is out of
this survey's scope on its merits — its tasks are clinical, not
evidence-synthesis — but whose construction is precisely what this
synthesis says the evidence-synthesis literature lacks. It defers
unreliable model outputs to humans by triangulating three signals it
names as orthogonal: model heterogeneity, stochastic inconsistency,
and reasoning critique. Those are, respectively, the cross-family
diversity fagerberg2025 confounds, the run-to-run stability
syriani2023 warns is not validity, and a critique channel no selected
work uses at all — assembled into one selective-deferral design and
validated on retrospective cohorts.

The observation is a pointer, not evidence: one adjacent work, found
opportunistically, evaluated on clinical tasks, and read only at
abstract level. What it suggests is that the independence machinery
evidence synthesis is missing may not need inventing so much as
importing, and that a survey scoped to evidence-synthesis venues will
by construction not see it coming. That is a limitation of this
survey's frame as much as a finding about the field.

## Scope conditions

- No targeted query, no independence facet: the gap claim is bounded
  to the deep reads by construction.
- The adjacent-literature pointer above was found by manual
  inspection after a title-vocabulary prefilter had dropped it;
  neither the map nor its snowball rounds systematically cover
  clinical-AI oversight work.
- Both quantitative multi-model studies are medicine-domain; both
  load-bearing works (fagerberg2025, huang2026) are preprints.
- The deferral result is appraisal-stage; the OR-ensemble result is
  screening-stage. No selected work tests either mechanism on the
  other's stage.

## Consequences for the manuscript

RQ4's framing needs one substantive edit and keeps the rest. "No
selected work defines agent-reviewer independence" stands. "The
evidence documents configurations without measuring the mechanism"
does not: akinseloyin2026 measures inter-agent correlation, claims
heterogeneity as the cause of ensemble gains, and shows debate
eroding both. RQ4 should now say that the definition is still absent
while the first mechanism measurement has arrived, uncontrolled. The
within-versus-cross-family margin contrast must not be printed as a
finding. This synthesis additionally holds: the direction-of-adjudication caveat on fagerberg2025's
headline number (stated in the limitations-adjacent note text; the
manuscript reports both label standards but not that all 18 relabels
favored measured sensitivity), the specificity-lower-bound caveat, and
the union-vs-intersection framing of why the two ensemble results
cannot be pooled.

## What would change this

- Any work defining agent-reviewer independence operationally — a
  criterion, not a correlation — would convert the remaining gap into
  a literature and force a targeted follow-up search round.
- A matched ensemble study with same-family and cross-family arms
  (the ablation fagerberg2025 and akinseloyin2026 both lack). The
  akinseloyin2026 / knafou2023 margin contrast above is the shape
  such a study would test.
- An error-correlation measurement (as opposed to score correlation)
  within and across families, which would complete the quantity
  akinseloyin2026 half-supplies.
- A replication of akinseloyin2026's debate-erodes-diversity result on
  another corpus — currently a single within-study comparison
  carrying a mechanism claim.
- safarpour2026 full text: numeric open-vs-proprietary divergence
  would be the first quantified cross-family behavioral contrast in
  the set.
- A huang2026-style system evaluated with and without redundancy —
  directly testing whether decomposition substitutes for independence.
- Peer review outcomes for fagerberg2025 and huang2026; an
  adjudication-robust replication of the OR-ensemble result (e.g.,
  independent relabeling) would remove its largest caveat.
