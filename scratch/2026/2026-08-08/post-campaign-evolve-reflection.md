---
author: Claude Fable 5
---

# Post-campaign /evolve: survey skill v1 extracted

The designated post-campaign retrospective for
`surveys/agent-assisted-review-methodology/`. Evidence mined in
parallel from the campaign artifacts (16 mechanism-level lessons, 7
decision records, 4 explicit skill-v1 flags), the week's scratch
reflections, and the session transcripts. Headline data claims
(residual duplicates, U-row counts, overturn rate) verified against
the committed catalogs before proposing.

## Proposal outcomes

- P1 applied: `skills/run-survey/` (skill v1), deployed via both
  symlink dirs. Codifies the pipeline as executed plus twelve
  failure-earned fixes; numbers stated as defaults with escape
  hatches; campaigns pin the skill SHA.
- P2 applied: campaign `status.md` rewritten to CLOSED (this round's
  subtraction — the stale next-steps epoch deleted).
- P3 applied: `decisions/0008-residual-duplicates.md` + dated erratum
  in the frozen `baseline.md` (disclosure only; counts not
  recomputed). Bili approved touching the frozen artifact.
- P4 applied, amended in placement: Bili asked whether the fan-out
  permission rule belonged at `surveys/` level; argued for root
  `AGENTS.md` since the skill already covers survey pipelines and the
  rule's marginal value is every *other* fan-out. New `## Fan-out`
  section.
- P5 applied: HW-spec survey memory updated to the revised sequencing.
- P6: this note.
- Rejected: none this round.

## Principles that emerged

- Decision records need a forward-pointer to be harvestable: 6 of 7
  v0 records had none, making this retrospective archaeology. The
  mandatory `Skill implication:` field is the fix — each campaign
  becomes self-mining.
- Reliability instrumentation scales with judgment-load, not stage
  order: v0 measured κ where the task was most mechanical (binary
  screening) and nowhere judgment lived (classification 5.7× spread,
  extraction unmeasured).
- Deviations compound silently: title pre-filter (0004) × single-pass
  wave (0005) × non-decayed yield put 79% of the map on the
  lowest-rigor path; each was individually reasonable.
- Fixes that live in one script don't exist: the `keyof()`
  normalization was correct in `snowball.py` and absent in
  `search.py`. Shared tooling, not per-script copies.

## Staged / deferred (awaiting recurrence or v2)

- Cross-vendor pass B (Codex mirror) is written into the skill as the
  default-when-available; the agent-adapted kappa methodology (what
  counts as an independent rater within a model family) stays an open
  design item for v2.
- Truncation sensitivity testing and citation-matrix /
  iteration-decay diagnostics: named in the skill as obligations,
  tooling not yet built.
- Transcript timing analysis: still staged (no second occurrence this
  session).
- Task-notification staging (P8 from the self-evolve reflection): the
  campaign and this session used background notifications throughout
  without orphaned waiters — the practice held; no rule needed.

## Open threads

- Next campaign (dataflow residue migration or the HW-spec survey)
  runs under run-survey v1 — its first real test; expect v1→v2 deltas
  from its decision records' `Skill implication:` fields.
- Site rendering of `surveys/`, deposition script, manuscript
  `@citation` parsing: carried from the survey-layer design note,
  untouched this round.
- `skills-ref validate` was not found on the host PATH this session;
  the skill was checked against house conventions manually. Verify
  via dev image on next skill touch.
