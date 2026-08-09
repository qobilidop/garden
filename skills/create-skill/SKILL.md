---
name: create-skill
description: Create or revise a skill — scope its boundary, write the triggering description, shape SKILL.md and its assets/references/scripts to the Agent Skills format, deploy the repo symlinks, and verify it triggers. Use when asked to create, write, restructure, split, or consolidate a skill, whether ad hoc or out of an /evolve retrospective. /evolve decides when a skill should exist; this skill is the how.
---

# Create a skill

The format baseline is the Agent Skills spec (agentskills.io); this
skill carries only its hard constraints, the field-tested craft on
top, and this repository's own conventions. Annotated sources with
the evidence behind each rule: `references/prior-arts.md`.

## Scope before writing

- One skill per repeatable procedure, named by purpose. If the
  boundary against a neighboring skill can't be stated in one
  sentence, the split is wrong — merge or re-cut.
- A skill is for what will recur. One-shot procedures stay in
  `scratch/`; /evolve stages lessons until they're earned.
- Agents only consult skills for tasks they can't handle unaided —
  a skill wrapping a trivial task never triggers, however good its
  description.

## Name

Lowercase alphanumerics and hyphens, ≤64 chars, no leading/trailing
or doubled hyphens, must not contain "claude" or "anthropic", and
**must equal the directory name**. House style: imperative
verb-object (`run-survey`, `ingest-paper`, `create-skill`) — a
declared divergence from the spec's gerund examples. Never vague
(`helper`, `utils`) or generic (`documents`, `data`).

## Description — the triggering contract

The description alone decides loading: it is the only part always
in context, and matching is model judgment, not keyword search.
≤1024 chars, non-empty, imperative or third person — never
first/second person ("I can help…", "You can use…" break catalog
injection).

- Shape: **what** (intent level) + **when** (explicit trigger
  contexts, including ones where the user doesn't name the domain)
  + **boundary** ("For X use Y instead") against sibling skills.
- Name the what at intent level only — never summarize the
  procedure's steps. A description that sketches the workflow
  invites the model to wing it from the description instead of
  reading the body (measured failure in the superpowers
  collection).
- Err pushy on the when: models under-trigger; list concrete
  phrasings and situations. But every description shares one
  silently-capped budget (~15k chars across all skills in Claude
  Code) — trigger breadth earns its length, filler doesn't.

## Body discipline

- Under 500 lines / ~5k tokens; the whole body loads on every
  activation, competing with the conversation.
- Add what the agent lacks, omit what it knows — the reader is
  already very smart. Content the agent would do correctly unaided
  is dead weight.
- Match freedom to fragility: multiple valid approaches → state
  intent and let the agent choose; a preferred pattern → give it,
  with the escape hatch named; fragile operations → exact commands
  or a bundled script, no deviation invited.
- Explain why over shouting: all-caps ALWAYS/NEVER and rigid
  structure are yellow flags — a stated reason generalizes,
  a bare prohibition invites rationalization. Prefer positive
  recipes ("do this") to prohibition lists ("never do that");
  measured head-to-head, prohibitions leak more.
- Commit to one default per choice point rather than listing
  options.
- Ground rules in earned incidents, one line each — evidence
  anchors survive rewrites; war stories don't belong.

## Progressive disclosure

Three tiers, two on-demand moments: name+description (always
loaded, ~100 tokens) → body (on activation) → resources (only when
a step reaches for them).

- `assets/` — templates and boilerplate the agent instantiates.
- `references/` — documentation read on demand. Flat, one level
  deep, each file linked from the body with an "open when" reason;
  files over ~100 lines open with a table of contents (partial
  reads must still reveal scope).
- `scripts/` — executables; self-contained, real error messages,
  no undocumented magic constants. A script agents keep rewriting
  across uses is a script the skill should bundle.
- Split body content to `references/` when a mode or subset of
  invocations stops paying for the rest (this repo's threshold in
  practice: a ~600-token mode used by a minority of campaigns).

## Deploy (this repository)

Canonical home `skills/<name>/`; deploy by committed relative
symlinks in both client directories:

```console
ln -s ../../skills/<name> .claude/skills/<name>
ln -s ../../skills/<name> .agents/skills/<name>
```

## Check before shipping

- Baseline evidence: name the concrete moment an agent failed or
  floundered without this skill. No failing case, no skill —
  imagined gaps produce imagined documentation.
- Trigger sanity: read the name+description fresh, against both a
  should-trigger and a genuinely-near-miss task (obvious misses
  test nothing). Would it load at the right moment and stay quiet
  otherwise?
- After creating or heavily revising alongside reference
  implementations, run /evolve's two-direction audit
  (spec→instance conformance, instance→spec coverage).
- For high-stakes skills, escalate to same-turn A/B: spawn
  with-skill and without-skill subagents on the same task and
  compare — the pattern anthropics/skills' skill-creator automates.
- Then watch the first real use: files read in unexpected order,
  references never followed, sections repeatedly re-read — each is
  a structure finding, not reader error.

## Lifecycle

- Revise in place; the name is stable and git is the version
  history — never `-v2` names.
- Consolidate when descriptions crowd the shared budget or two
  skills' boundaries blur; every revision looks for a subtraction.
- Skills co-evolve with their reference implementations: a change
  that retires an alternative updates the skill in the same change.
