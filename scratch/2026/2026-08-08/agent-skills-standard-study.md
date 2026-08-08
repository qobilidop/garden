---
author: Claude Fable 5
---

# Agent Skills standard: study and application

Systematic pass over agentskills.io (2026-08-08): home, specification,
the three skill-creation guides (best practices, evaluating output,
optimizing descriptions), using-scripts, and the client-implementation
guide. Applied findings to this repo's three skills the same day.

## What it is

The Agent Skills format — a skill is a directory whose `SKILL.md`
carries YAML frontmatter plus free-form instructions — originated at
Anthropic, was released as an open standard, and is now governed in the
open (github.com/agentskills/agentskills). The client showcase lists
~45 adopters, including Claude Code, Codex, Gemini CLI, GitHub
Copilot/VS Code, Cursor, Goose, OpenCode, and Letta. A reference
validator (`skills-ref`, Python, install from the repo) checks
frontmatter and naming.

## Spec essentials

- Frontmatter: `name` (≤64 chars, lowercase/digits/hyphens, must match
  the directory name) and `description` (≤1024 chars) required;
  optional `license`, `compatibility` (≤500 chars, environment
  requirements), `metadata` (string→string map), `allowed-tools`
  (experimental).
- Body: free-form; keep under 500 lines / ~5k tokens; overflow goes to
  `references/` files loaded on demand. Conventional subdirs:
  `scripts/`, `references/`, `assets/`.
- File references: relative to the skill root, one level deep, with an
  explicit *when to load* ("read X if Y"), not "see references/".

## The economics: progressive disclosure

Three tiers — catalog (name + description, ~50–100 tokens, always
loaded), instructions (full body, on activation), resources (on
demand). Two consequences worth internalizing:

- The description carries the entire triggering burden. Imperative
  phrasing, user intent not implementation, pushy scope ("even if they
  don't mention X"), and an explicit boundary against near-miss
  neighbors. The strongest negative test cases are near-misses that
  share keywords but need a different skill.
- Every body token competes with the conversation for attention. The
  test for each line: would the agent get this wrong without it? Cut
  what a capable model already knows.

## Authoring principles worth keeping

- Start from real expertise — extract from a hands-on task or
  synthesize from project artifacts (runbooks, review comments, fix
  history). Skills generated from an LLM's general knowledge come out
  vague. Refine by feeding execution traces back in.
- Moderate detail beats exhaustive: over-comprehensive skills send
  agents down paths that don't apply. Provide a default with an escape
  hatch, never a menu.
- Match specificity to fragility — prescriptive for fragile sequences,
  goals-plus-why where variation is fine. Explaining why outperforms
  rigid directives.
- Procedures over declarations: teach the approach that generalizes,
  not the answer to one instance.
- Gotchas are the highest-value content — environment facts that defy
  reasonable assumption, kept in `SKILL.md` itself because the agent
  won't know when to load a reference it doesn't expect to need. Each
  user correction should land there.
- Reliability patterns: output templates over format prose; checklists
  for multi-step flows; validation loops (do → validate → fix →
  repeat); plan-validate-execute for destructive or batch operations.
- Scripts for agents: non-interactive (a TTY prompt hangs forever),
  `--help` as the interface contract, error messages that say what to
  try next, structured stdout with diagnostics on stderr, idempotent,
  `--dry-run` for destructive ops, bounded output (harnesses truncate).
- Eval-driven iteration, when warranted: test cases with assertions
  graded on evidence, with-skill vs without-skill baselines, blind
  comparison for holistic quality, train/validation split when tuning
  descriptions to avoid overfitting. Read traces, not just outputs.

## Ecosystem confirmations for this repo

- `.agents/skills/` is the emerged cross-client convention; clients
  scan it alongside their native directory (`.claude/skills/` is also
  scanned by some for compatibility). This repo's dual-symlink deploy
  matches the ecosystem exactly.
- Project-level skills override user-level ones everywhere; clients
  are advised to trust-gate skills from untrusted repos — a reason to
  keep this repo's skills clean of anything a reader wouldn't audit.

## Audit of this repo's skills

All three (`evolve`, `ingest-paper`, `ingest-post`) pass `skills-ref
validate` unchanged. Already conformant: names, what+when imperative
descriptions, small bodies, defaults not menus, gotcha-dense
instructions, prescriptive-where-fragile calibration, close-with-
verification steps.

Gaps found and fixed the same day:

- Environment requirements (shadow/ checkout, rclone `store:` remote,
  `./dev.sh` toolchain) lived only in body prose → surfaced in the
  spec's `compatibility` field on both ingest skills. The first attempt
  reproduced the exact cross-client hazard the implementation guide
  warns about — an unquoted `store:` colon breaking the YAML — and
  `skills-ref validate` caught it. Quote frontmatter values containing
  colons.
- Near-miss boundary: "ingest this article" plus a URL matched both
  ingest skills → each description now names the other as the
  boundary.
- ingest-post cited "ingest-paper §2/§4" without a path a client could
  resolve → now `../ingest-paper/SKILL.md`, valid in both the
  canonical tree and the symlinked deploys.
- evolve routes lessons into skills but said nothing about format →
  its Skill routing bullet now points at the standard's core test
  (description does the triggering; body only what agents get wrong
  unaided).

Deliberately not adopted, with reasons:

- The eval harness (`evals/evals.json`, assertions, benchmarks):
  designed for skills serving many users at volume. Here the user is
  the regression gate and /evolve is the iteration loop; the overhead
  isn't earned at n=1. Revisit if a skill is ever exported standalone.
- `metadata` author/version: git records both; duplicating them in
  frontmatter invites drift.
- `license` field: the repo's licenses govern; add only if a skill is
  exported standalone.

## Open threads

- ~~Staged: `tools/capture.sh` for the ingest skills' mechanical
  tier~~ — resolved by the same day's /evolve: built, tested against
  the karpathy captures (both modes reproduce the manual
  verifications), wired into both ingest skills. Synthesis and
  self-review stay manual — they are the quality core, not overhead.

- Skill scoping decided 2026-08-08: the ingest pair is correctly
  project-level; evolve's correct home is user level (most sessions
  happen outside sys0, and a harness-improvement ritual confined to the
  harness repo misses most of its evidence). Promote on the first real
  cross-repo need, not before — promotion is a design task, not a
  symlink: the body's routing surfaces (skills/, config/ mirrors,
  scratch/) must be re-grounded as "the sys repo" by stable location
  instead of cwd, and reflections from private-repo sessions need an
  explicit rule for what may cross into public scratch. Canonical file
  stays in sys0; deployment via `~/.claude/skills/` and
  `~/.agents/skills/` symlinks managed with the other user-scope
  config. Project copy shadows the user copy on collision, so the dual
  deploy resolves cleanly in sys0 itself.
