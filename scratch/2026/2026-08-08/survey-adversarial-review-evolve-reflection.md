---
author: Codex GPT-5.6 Sol
---

# Survey adversarial-review evolve reflection

This retrospective followed the whole-directory adversarial review of
`surveys/agent-assisted-review-methodology/`. Evidence came from the
reviewers' findings and delta verdicts, the resulting survey record and
validator, direct user corrections, the current harness, and the earlier
survey/evolve reflections. The user accepted every proposed change.

## Proposal outcomes

- P1 applied, and was the subtraction: `run-survey` no longer requires a
  skill or repository commit pin or confines method changes to `/evolve`.
  The current workflow is guidance; material deviations are described in
  the record in plain language, and `/evolve` is used when durable lessons
  actually emerge.
- P2 applied: material source-note revisions preserve existing
  `notes-by` credit and append the reviser; mechanical edits do not claim
  authorship.
- P3 applied: survey close now includes an entity-integrity pass. Aliases
  require registrar metadata and authorship adjudication, superseded
  identifiers remain as E6 memory, and formally retracted or withdrawn
  works move to E7 before counts are derived.
- P4 applied: a quantitative survey retains a campaign-local validator as
  part of its minimal record. It checks structural and citation closure
  and emits derived quantities for cross-surface reconciliation;
  qualitative surveys may omit it.
- P5 is this reflection. No proposals were amended or rejected.

## Durable lessons

- Exact process identifiers can make a garden artifact feel falsely
  frozen. Concrete retained procedures, plain-language change notes, and
  git history provide enough traceability for this setting without making
  a historical skill SHA part of the reader-facing contract.
- Revision provenance is additive. Re-reading and strengthening another
  writer's evidence note should preserve the original synthesis credit
  while making the reviser's responsibility visible.
- Identifier uniqueness is not entity uniqueness. The review found
  duplicate publication versions and retractions that had survived valid
  TSV keys; entity integrity therefore precedes every headline count.
- “Numbers trace to the catalog” is stronger when executable. The
  campaign validator made schema, taxonomy, note, bibliography, citation,
  and derived-count closure available to both reviewers and a future
  updater without retaining the campaign's discarded working files.

## Filtered observations

- No harness change was made for the earlier `/evolve` recognition
  question. Project skill discovery through `.agents/skills/` worked, and
  the explicit `$evolve` invocation activated the skill; the earlier
  slash behavior does not establish a repository-level failure.
- No duplicate npm/container rule was added to `run-survey`. The relevant
  native-module trap and the correct full-site verification loop already
  live in `tend-site`; copying them would create another drift surface.

## Open threads

- The next quantitative campaign should test whether a small
  campaign-local validator stays cheap enough to deserve its retained
  place. If it grows into generic framework code, extract only after that
  recurrence.
- If literal slash-menu skill invocations repeatedly fail to reach the
  agent while `$skill-name` succeeds, investigate client routing rather
  than adding repository instructions that cannot control it.
