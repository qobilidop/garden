# Norms converge on content, fragment on instruments

Status: current through the 2026-08-09 update batch.

## Current conclusion

Across every selected guidance source the disclosure content is the
same: name the tool and version, state which stage/task the AI
performed and what the human did, describe verification, and keep
accountability human (no AI authorship). What differs — and is not
converging — is the instrument and, more substantively, the
sanctioned AI role: secondary quality-assurance checker in the
Cochrane-family line versus sanctioned first-pass worker under human
validation in HAICO-SLR. Coexistence of proposals is not evidence of a
standards race: none reports validation or adoption, and the field's
official instrument (PRISMA-AI) remains unpublished since its 2022
announcement.

The 2026-08-09 update sharpens the fragmentation claim in two ways.
The instrument count is genre-dependent, not simply three: three
*disclosure-reporting* instruments (holst2025, degen2024,
fernandes2026) are joined by a fourth in a different sub-genre,
lombaers2024's reproducibility and data-storage checklist, which
prescribes artifacts none of the disclosure instruments name. And the
difficulty is now measured rather than inferred: in the first
consensus exercise the map contains (golob2025), agreement was
*lowest* precisely on the actionable use of automation and digital
tools, and highest on general statements. The field is not merely
slow to converge on AI norms; it demonstrably converges least where
the norms would bind.

## The convergent core, per source

- hamel2021 (pre-LLM, active-ML screening): documented tool use,
  graded human-oversight ladder, audit checks; flags fully autonomous
  include/exclude as inappropriate use.
- gartlehner2025 (Cochrane Rapid Reviews Methods Group position):
  never fully automate any step; specify tools/tasks/verification in
  the protocol; record model version and prompts in an "AI Use
  Disclosure" section; authors fully accountable; endorses RAISE.
- fernandes2026 (HAICO-SLR; SSRN preprint): dual conduct + reporting
  tables, every stage keeps both a human and an AI role; AI never an
  author; procedural (not exact-output) reproducibility.
- holst2025 (PRISMA-trAIce): 14 items including full prompts and
  parameters, human-oversight item (reviewer count, % manually
  verified), AI-vs-human exclusion counts in an adapted flow diagram.
- degen2024 (FRAISR): tool name, version, and input parameters
  (verbatim prompt) per stage, plus a machine-readable CSV emission.
- golob2025 (living evidence synthesis Delphi; medRxiv preprint): 29
  experts, three rounds, ≥80% consensus threshold; 19 of 23
  statements reached consensus. Its one automation statement — any
  software or automation should be validated and justified — is
  role-neutral, and AI otherwise appears only in a forward-looking
  discussion favouring human-in-the-loop over full automation for
  current LLMs.
- lombaers2024 (RDAL checklist, active-learning screening): 15 items
  splitting what authors pre-register (team and roles, inclusion
  criteria, stopping rule) from what software must store (software
  and version, model components, feature matrix, random seeds,
  labeling order, per-iteration model identity and training-set size).

## The fragmentation, precisely

The three instruments differ in unit and scope, not just detail:
holst2025 is an enumerated PRISMA-2020 extension (14 items mapped to
manuscript sections); degen2024 is a stage×field table with exactly
three disclosure fields and no human-role attribution; fernandes2026
alone pairs a reporting table with a conduct table (who may do what,
per stage). Their development methods are also all non-consensus:
holst2025 synthesizes existing AI reporting guidelines (explicitly not
a Delphi), degen2024 is an author-authored conceptual synthesis,
fernandes2026 derives from a 124-paper SLR-of-SLRs. None reports
piloting, field-testing, or adoption. Meanwhile luo2024 (mid-2024)
documents the gap they all fill: PRISMA 2020 covers automation only at
the selection items, and no comprehensive guideline existed — a call
corroborating, independently, why three proposals appeared at once.

The proposals also disagree about PRISMA-AI's status: holst2025 treats
it as announced-but-unpublished; fernandes2026's authors say it "was
never actually developed." Both agree it is not available to use.

lombaers2024 fragments the picture along a second axis rather than
adding a fourth competitor on the first. Its unit is the stored
artifact, not the reported item: seeds, labeling order, and
per-iteration training-set size are things no disclosure checklist
asks for, and its motivation is technical — storing every relevance
score scales quadratically with corpus size (terabytes at ~10^6
records), so it prescribes storing model type and training-set size
per iteration and reconstructing the rest. It is equally unvalidated:
its sole application is a worked example against ASReview v1.0, two
of its three authors are ASReview core developers, and by its own
table that tool stores 11 of the 15 items — the four it misses
(team and roles, inclusion criteria, stopping rule, random seeds) are
left to author pre-registration. A conformance self-check is not
field-testing.

## The real normative disagreement: the sanctioned role

- Cochrane-family line (gartlehner2025, with hamel2021 as its pre-LLM
  ancestor): AI's sanctioned configuration is *secondary reviewer* —
  QA on human decisions (re-checking single-reviewer exclusions,
  double-checking extraction), justified against imperfect-human
  evidence (crowd RCT misses; up-to-50% extraction-error reports, both
  secondhand citations).
- fernandes2026: sanctions AI *first-pass* screening filtering and
  drafting, with humans validating — a primary-role grant the
  Cochrane-family line withholds. Two stages stay human-exclusive
  (question formulation, final synthesis), and database search is
  specifically flagged unreliable after a worked example in which two
  chat systems fabricated search yields.

A nuance the manuscript's grouping compresses: hamel2021 does not
categorically keep a human decision on every record — its Table 1
*ranks* post-truncation options for the unscreened remainder from
AI-only exclusion (highest risk) downward, each with mitigations. It
governs by graded risk tied to the stopping decision, which is a
different normative shape than gartlehner2025's flat "never fully
automate any step." The pre-LLM guidance was in this one respect more
permissive than its LLM-era descendant.

## Practice lags the norms

oconnor2024 relays (secondhand, from Bond et al.'s mapping work) that
a "very small percentage" of reviews in the education and
climate/health domains disclose advanced-AI use — the only
disclosure-prevalence signal in the selected set, domain-limited and
not independently verified. Against it stands one detailed positive
exemplar: mughal2026 names the model (Claude Opus 4.8), discloses the
pre-filter under PRISMA 2020 item 8, publishes a validation table
(κ = 0.79 binary, 99.1% recall vs human consensus, 0.48% false-omission
rate on a stratified sample) beside the flow diagram, and revisits the
residual risk in a dedicated limitations subsection. One exemplar and
one secondhand prevalence estimate do not measure the field; they
bound it anecdotally from both ends.

Between those bounds sits a third, weaker form the update surfaced
incidentally. A domain meta-analysis screened out of this map for
being about automation-and-judgment rather than evidence synthesis
(doi:10.2139/ssrn.7244698) nonetheless discloses in its methods that
"screening and extraction were duplicated by language-model
reviewer-agents with human adjudication," and lists LLM reviewer-agents
among its keywords — while reporting no agreement statistic, recall,
or validation for that step. Naming the technique and evidencing it
are separable practices, and the instruments above conflate them: a
review disclosing at this level satisfies the tool-and-stage core of
every checklist here while supplying nothing a reader could use to
judge the automated step. The observation is anecdotal (one work,
found opportunistically, outside the map) and is offered as a
distinction the instruments do not draw, not as prevalence evidence.

golob2025 supplies the mechanism behind the lag, in the one place the
map can watch norms actually being made. Its panel reached consensus
on 19 of 23 statements, but the discussion records that agreement ran
lowest on objective, actionable use of automation and digital tools
and highest on general or subjective statements. The four
non-consensus statements are where operational commitment would have
been. That is a measured instance of the pattern the rest of this
synthesis infers from instrument proliferation: the closer a norm
gets to binding practice, the less agreement it commands. The finding
rests on the authors' own characterisation of their round data
(the statement tables render as images and were not machine-readable)
and the work is an unrefereed preprint.

## Scope conditions

- fernandes2026 is an SSRN preprint (0 citations at retrieval);
  degen2024 is an OSF preprint; holst2025 is peer-reviewed (JMIR AI)
  but single-institution with no external field-testing.
- The secondary-reviewer sanction rests on secondhand effectiveness
  figures (screening incorrect-inclusion 0–29%, median 10%; extraction
  error 4–31%, median 14% — gartlehner2025 citing Clark et al.).
- The update falsifies this synthesis's earlier claim that no map row
  is jointly SE + guideline: `doi:10.1145/3786149.3788298` (2026) is
  coded `se` + `guideline`. It is a practitioner experience report on
  using an LLM to support a systematic mapping study, not an
  instrument, so the surviving and narrower claim is that SE has no
  native norms *instrument* in this map — every disclosure or
  reproducibility instrument here remains medicine-rooted or
  general-purpose. SE × appraise is still empty.

## Consequences for the manuscript

RQ3's "shared content, coexisting proposals" framing is supported.
Two things this synthesis holds beyond the manuscript: the
hamel2021 graded-ladder nuance (the manuscript's "keeps a human
decision in every stage" grouping reads slightly stronger for
hamel2021 than its Table 1 supports), and the PRISMA-AI status
discrepancy between holst2025 and fernandes2026.

## What would change this

- Publication of PRISMA-AI, or formal PRISMA endorsement of any
  extension — would end the instrument fragmentation story.
- Any validation, piloting, or adoption study of PRISMA-trAIce,
  FRAISR, or HAICO-SLR (all three name this as future work).
- A measured disclosure-prevalence study beyond the two domains Bond
  et al. covered.
- Guidance sanctioning agent-primary configurations with evidence
  behind it — would turn the secondary-vs-first-pass disagreement into
  a settled progression.
- Journal or funder mandates operationalizing any instrument (the
  policymaker recommendations in madeyski2025 are a candidate vector
  on the metrics side).
