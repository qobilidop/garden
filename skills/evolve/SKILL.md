---
name: evolve
description: Retrospective that mines session experience for durable lessons and proposes itemized, human-gated updates to the harness — skills, agent rules (project AGENTS.md or mirrored global configs), and memory. Use when asked to evolve, reflect on, or distill a session, or to turn accumulated experience into skills, rules, or memory.
---

# Evolve the harness

Turn lived sessions into durable harness improvements. What evolves:
skills, rules, memory. What feeds it: this session's failures,
corrections, and repetitions. Where the loop closes: git, on the user's
word. The user is the regression gate — nothing persists on the
proposer's rationale alone.

## 1. Mine evidence

Reread the session (plus recent `scratch/` reflections when doing a
multi-session pass) for:

- user corrections — explicit pushback and silent rewrites of agent work;
- failures and their causes — wrong assumptions, tool misuse, guessed
  interpretations, missed context;
- repetition — any procedure performed the same way twice or more, here
  or across reflections;
- surprises — anything that contradicted a rule, memory, or expectation.

Cluster by mechanism, not symptom: two failures earn one lesson only if
the same missing rule would have prevented both. Every candidate lesson
must cite the concrete moments that motivate it — no lesson from vibes.

## 2. Filter

Drop candidates that are: one-off task difficulty or model-capability
limits (no rule fixes those); already recorded in the repo, rules, or
memory; or only relevant to this conversation. A real lesson seen only
once is usually not yet earned — stage it in the session reflection and
promote it when it recurs (ingest-post was distilled after four runs,
not one).

## 3. Route each lesson to its locus

- **Skill** (`skills/<name>/`, symlinked from `.claude/skills/`): a
  procedure that will be repeated. Name it by purpose, for retrieval.
- **Rule**: a standing constraint on behavior. Project-scoped →
  `AGENTS.md` here; global → the mirrored configs for *both* agents
  (`config/claude/user-CLAUDE.md`, `config/codex/user-AGENTS.md`),
  honoring each platform's sync discipline.
- **Memory** (auto-memory directory): a fact about the user, a project,
  or confirmed feedback — one file per fact, indexed in `MEMORY.md`.
- **Scratch** (`scratch/<year>/<date>/`): lessons not yet earned, open
  threads, and the session reflection itself.

## 4. Propose itemized deltas

One item per lesson, minimal, localized. Update an existing entry in
place over adding a near-duplicate; never rewrite a whole file to add a
line — wholesale rewrites are where accumulated detail dies. Each
proposal states: **evidence** (what happened), **change** (the delta),
**expected effect**, **regression risk** (what this could break or
over-trigger on). Prefer refinements that leave existing artifacts
already conformant; a change forcing migration needs a much higher bar.

## 5. Gate, apply, log

Present all proposals before touching anything; the user accepts,
amends, or rejects each. Apply accepted items as separate small edits.
Record rejected proposals with the reason in the session reflection —
negative results are knowledge too, and a rejected rule should not be
re-proposed next session as if new.

## 6. Hygiene

While applying: check for duplicates and contradictions against what is
already there (a contradiction is surfaced, never silently overwritten);
delete or correct memories that turned out wrong; keep `MEMORY.md` in
sync. Retention decays silently — when a memory or rule looks stale,
verify against current reality before acting on or pruning it.

## 7. Close

Write or update the session reflection in `scratch/` (principles that
emerged, errors worth remembering, open threads — including staged
lessons awaiting recurrence). Propose commits with the attribution
trailer; commit only on the user's word. Git is the audit trail and the
rollback path.

## Grounding

Design distilled from the library's self-evolving-agents shelf:

- `zhang2025-agentic-context-engineering` — itemized deltas merged
  conservatively beat monolithic rewrites (context collapse); updates
  without a reliable feedback signal go negative.
- `zhang2026-self-harness` — evidence bundle → bounded minimal proposals
  → gated promotion; every edit names its behavior, surface, evidence,
  and validation.
- `wang2023-voyager` — skills indexed by what they're for; verification,
  not the generating pass's enthusiasm, decides what persists.
- `gao2025-a-survey-of-self-evolving-agents` — approval gates, audit
  trail, rollback live outside the evolving loop; retention is the
  neglected failure mode.
- `weng2026-harness` — improvement machinery is cheap, benefiting is
  scarce: stay lightweight, log negative results, keep the evaluator
  (the user) outside the loop.
- `vincent2026-the-therapist-pattern` — a claimed lesson counts only as
  a diff in a versioned surface through the designated writer; "I'll
  remember that" is a red flag.
- `vincent2026-superpowers-6` — autonomy is earned rung by rung, by
  building eval infrastructure first — never by trusting the proposer
  more; and the gate itself is code that can be wrong.

This skill is itself harness: lessons about evolving route back into it
by its own procedure.
