# Prior arts — sources and the evidence behind the rules

Open when revising create-skill itself, or when a rule needs its
provenance. Digested 2026-08-09 from primary sources.

## Contents

1. Agent Skills specification (the format baseline)
2. Anthropic authoring guidance and skill-creator
3. Sentry skills (skill-writer)
4. superpowers (writing-skills) and the Vincent blog findings
5. Live tensions the house rules resolve

## 1. Agent Skills specification — agentskills.io

- Frontmatter: `name` (≤64, lowercase-alnum-hyphen, no
  leading/trailing/doubled hyphens, must match directory) and
  `description` (≤1024, non-empty) required; `license`,
  `compatibility` (≤500), `metadata` (string map), `allowed-tools`
  (experimental) optional. No version field — `metadata` by
  convention, history in git.
- `scripts/`/`references/`/`assets/` are named conventions, not a
  closed set ("may contain any files and directories beyond the
  required SKILL.md").
- Progressive disclosure: catalog ~100 tokens always; body <500
  lines / <5k tokens at activation; resources on demand. File
  references relative, one level deep.
- Triggering is model judgment — no harness-side matching; trivial
  tasks don't trigger even on perfect matches.
- Validator: `skills-ref validate ./my-skill`
  (github.com/agentskills/agentskills/tree/main/skills-ref;
  reference-grade, not production).

## 2. Anthropic — platform.claude.com best-practices, anthropics/skills skill-creator

- Evaluation-driven development: "Create evaluations BEFORE writing
  extensive documentation." Two-Claude pattern: an expert instance
  drafts, a fresh instance reveals gaps in real use.
- skill-creator's loop: 2-3 realistic eval prompts → with-skill and
  baseline subagents spawned in the same turn → objective
  assertions → benchmark aggregates → human reviews outputs before
  the agent self-critiques → generalize from feedback, don't
  overfit.
- Descriptions: third person mandatory; "pushy" to counter
  under-triggering; bad negative evals are obvious misses ("'Write
  a fibonacci function' as a negative test for a PDF skill is too
  easy"); description optimization selects by held-out test score.
- Degrees of freedom: text instructions where many approaches are
  valid; parameterized patterns where one is preferred; exact
  scripts where operations are fragile.
- "If you find yourself writing ALWAYS or NEVER in all caps... 
  that's a yellow flag — reframe and explain the reasoning."
- Naming: gerund preferred (house diverges to imperative
  verb-object); no "claude"/"anthropic"; no vague or generic names.
- Update in place: "if the installed skill is research-helper,
  output research-helper.skill (not research-helper-v2)".

## 3. Sentry — getsentry/skills skill-writer (dotagents is the installer CLI)

- Anatomy adds SPEC.md (maintenance contract: intent, scope,
  runtime contract, validation, limitations) and SOURCES.md
  (provenance/changelog) so SKILL.md stays a pure runtime router:
  "every bundled reference file should be flat under references/
  and listed... with a direct 'open when...' reason."
- Five critical dimensions: trigger precision, artifact
  minimality, runtime concision, progressive disclosure,
  validation. Maintainer evals (AXIS harness) are never linked
  from SKILL.md — runtime and maintenance content separate.
- Description style: trigger-only, quoted-phrase lists ("Use when
  asked to 'add a skill', 'install skills'...").

## 4. superpowers — obra/superpowers writing-skills; blog.fsck.com

- "Writing skills IS TDD applied to process documentation": run
  pressure scenarios without the skill, record verbatim
  rationalizations, write the minimal skill against those
  failures, re-test, close loopholes. "NO SKILL WITHOUT A FAILING
  TEST FIRST."
- Match the form to the failure: prohibition + rationalization
  table for rule-skipping under pressure; positive recipe for
  wrong-shaped output — measured head-to-head, "the prohibition
  arm produced clearly more of the unwanted content than the
  recipe arm."
- Anti-patterns: narrative war stories, multi-language example
  dilution, code in flowcharts, generic labels, negation-framed
  skills ("testing-anti-patterns was a bad skill, because it was
  about what not to do").
- Claude Code injects all skill/command descriptions under one
  silently-truncated budget — "15,000 characters (or around 4000
  tokens)... no warning when you go over"
  (blog.fsck.com/2025/12/17/claude-code-skills-not-triggering).
  Overriding env: `SLASH_COMMAND_TOOL_CHAR_BUDGET`.
- Workflow-summarizing descriptions caused models to "wing it"
  without reading the body; the fix was stripping workflow language
  from descriptions repo-wide and consolidating skills
  (blog.fsck.com/2025/12/18/superpowers-4).

## 5. Live tensions, and how the house rules resolve them

- Pushy what+when (Anthropic) vs trigger-only (Sentry,
  superpowers): resolved as what-at-intent-level + pushy when +
  boundary — breadth on triggers, never procedure summaries.
- Gerund names (Anthropic) vs house imperative verb-object:
  house style wins locally, declared in the skill.
- Full eval harness (Anthropic, Sentry) vs this repo's scale:
  baseline evidence + trigger sanity + two-direction audit as the
  floor; same-turn A/B reserved for high-stakes skills.
