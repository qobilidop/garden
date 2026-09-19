---
author: Claude Fable 5.1
---

# AGENTS.md goes native; evolve pass over 09-07 → 09-19

Written after the shim removal (`d0fc77c`) and the /evolve pass that
followed it in the same session.

## What changed

Claude Code 2.1.277 reads `AGENTS.md` when no `CLAUDE.md` or
`CLAUDE.local.md` sits in the working directory or above
(code.claude.com/docs/en/memory, AGENTS.md section). The six
`@AGENTS.md` shims are gone, the setting is pinned explicitly to
`claude-md-or-agents-md`, both agents' global rules say "AGENTS.md
alone", and `hooks/lint.sh` fails on any `CLAUDE.md` on disk, tracked
or not.

Bili's two rulings, both against the agent's recommendation: drop the
shims rather than keep them for robustness; the explicit `or` value
rather than `and`. Neither value ignores a stray `CLAUDE.md` — `or`
makes it loud (AGENTS.md vanishes), `and` makes it silent. The lint
check is the guard; the setting is the visibility.

## Rules that worked

- A subagent's report is a claim: the docs were re-read before acting
  on the feature report, and three transcript-mining reports were
  checked against files and transcripts — one had read nothing in
  full, one covered the wrong window, one reported mid-session states
  as outcomes.
- The check shipped with the rule, and was seen to fail (six shims,
  then an untracked `CLAUDE.local.md`) before being trusted.

## Evolve outcome

No session between 09-07 and 09-19 left a reflection, so the pass
read the user's messages in the local transcripts directly.

Accepted and applied, all eight: (P1) the Codex global rule no longer
permits a `CLAUDE.md` — the first edit had touched only the Claude
mirror; (P2) memory: explicit and fail-loud; (P3) subtraction — the
agents-md-first memory points at the docs instead of restating four
of their rows; (P4) the staged items below; (P5) this note; (P6) the
pushback memory gains the long-session failure — in the P4NAH design
session Bili asked three times for fresh, first-principles thinking
("not merely agreeing with whatever I say") while the agent opened
replies with agreement and accreted dated sections until "Completely
rewrite from scratch"; (P7) memory: new ideas stand alone, and
Eprouvette marked not started — "this is an independent project, not
for pakeles", then "don't assume Eprouvette exists"; (P8) the evolve
skill says how to mine transcripts when reflections are missing.

Declined by the agent, not to be re-proposed without new evidence:

- "Settle constraints before fanning out research" (raised by two
  mining reports): Bili objected to the fan-outs in neither
  transcript, and it contradicts his standing preferences for
  proactive delegation and research-backed recommendations.
- A "ready to commit" closing pattern and an anchored-edit skill:
  existing rules already cover both.

## Open threads

- The next session's `no CLAUDE.md found; AGENTS.md loaded` line is
  the only end-to-end test of the shim removal; this session loaded
  its instructions before the change.
- Other repositories still carry shims (they keep working), and a
  survey repository scaffolded from an existing one would copy one.
- Lint runs at commit time; a stray `CLAUDE.md` created mid-session
  shadows `AGENTS.md` until then.

## Process residue for /evolve

Staged (single occurrence each):

- A global rule changed in one agent's mirror is checked against the
  other's in the same change. The evolve skill says so, but only
  binds during /evolve; this edit happened outside it, and a name
  search could not find the Codex copy because it used other words.
- The global "never `cd` to shorten a path" rule was broken about
  nine times this session (`cd <repo> && …`), harmlessly. Text has
  not held; if a harmful recurrence comes, the promotion path is a
  hook that rejects a leading `cd` and allows `(cd … && …)`.
- A layer contract written before the layer has content
  over-prescribes: the notebook's "H1 states the claim" came from an
  older design and was rejected the same evening ("too restrictive…
  a clear goal or boundary"). Codify what the seed content shows.
- A flake-reference error surfaced during the first hand-run host
  update; `config/nix/update.sh` removed the hand-typed step the next
  day. Nothing further needed unless it recurs elsewhere.
