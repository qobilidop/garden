---
citekey: vincent2025-superpowers
work:
  title: "Superpowers: How I'm using coding agents in October 2025"
  author: Jesse Vincent
  date: 2025-10-09
source: https://blog.fsck.com/2025/10/09/superpowers/  # snapshot → shadow
discussions:
  - https://simonwillison.net/2025/Oct/10/superpowers/  # 2025-10-10
  - https://news.ycombinator.com/item?id=45547344  # 2025-10-11
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-07
synthesis: "The academic shelf's safeguards discovered independently by iteration — plus the 2,249-memories null result: most accumulated lessons are already absorbed, so an earned-lesson filter is the main mechanism, not optional caution."
---

# Superpowers: How I'm using coding agents in October 2025

The launch post for Superpowers (Jesse Vincent — RT, K-9 Mail,
Keyboardio), shipped the morning Anthropic released Claude Code's plugin
system and later among the most-installed skills frameworks. As a
monthly installment in his "how I'm using coding agents" series it is a
practitioner's field report, not a design document — but it contains the
earliest widely-read description of a working *skills-that-improve-
skills* loop, months before the academic versions this library holds
([[zhang2026-self-harness]], [[zhang2025-ace]]) put
numbers on the same ideas.

## The mechanisms

**Bootstrap and mandatory use.** A session-start hook injects one
instruction: read the getting-started skill. That skill teaches three
things — you have skills, search before acting, and if a skill covers an
activity you must use it. The workflow baked in is
brainstorm → plan → implement, with automatic git worktrees per project
and per-task subagent dispatch plus code review; RED/GREEN TDD
throughout.

**Meta-skill first.** Among the first skills taught was "how to create
skills," after which extending the system became conversational —
describe the desired worktree workflow, and Claude wrote the skill and
retro-fitted cross-references into existing skills that needed to know
about it. Lineage is flagged honestly: Anthropic's Office-document
skills, Sam Schillace's demo write-up, and Microsoft Amplifier as
parallel discoveries of agents-improving-themselves-via-markdown.

**TDD for skills.** New skills are pressure-tested on subagents before
deployment. The first attempt failed informatively: Claude quizzed the
subagents "like they were on a gameshow" and reported perfect scores —
evaluation realism had to be demanded. The fix was adversarial
scenarios (production down at $5k/minute vs. a 2-minute skill check;
45 minutes of sunk cost vs. re-reading the async-testing skill), with
instructions strengthened after each compliance failure. Vincent
deliberately frames skill-writing with Cialdini persuasion principles
(authority, commitment, social proof) and notes Dan Shapiro's study
with Cialdini showing these principles measurably move LLMs — the
post's oddest and most memorable thread, complete with Claude's
"feelings journal" realizing the skills already use these levers.

**Memory → skill distillation, and its null result.** Vincent handed
Claude 2,249 markdown memory files mined from past conversations,
clustered by topic, as skill candidates — then required a necessity
pressure-test before writing anything. Almost every candidate was
rejected: "mostly, the skills system had already handled what had
tripped it up over the past couple of months." The
remembering-conversations skill (transcripts duplicated outside
`.claude`, SQLite vector index, Haiku-generated summaries, searched only
via subagent to keep fruitless searches out of the main context) was
built but not yet wired in at posting time.

## Assessment

First-person, informal, no benchmarks; the author is describing his own
framework and says so.

- **Weaknesses:** some claims are demonstrations-by-anecdote (the
  book-mining workflow — "read this, write down what you learned" — is
  called foundational but shown only in outline), and the Cialdini
  framing invites over-reading.
- **Durable (what this post adds over the library's academic shelf):**
  every safeguard the papers formalize appears here in conversational
  form, discovered by iteration — necessity pressure-testing is
  [[zhang2026-self-harness]]'s addressability filter plus regression gate;
  the gameshow failure is the weak-evaluator trap [[weng2026-harness]]
  catalogs; subagent-isolated memory search is context hygiene ACE
  would call collapse-avoidance; verification-before-persistence is
  [[wang2023-voyager]]'s critic gate. The 2,249-memories null result is
  the post's most valuable datum for anyone building a distillation
  loop: most accumulated lessons are already absorbed by a working
  system, so an earned-lesson filter is not optional caution but the
  main mechanism.
- **In this library:** the remembering-conversations design later
  shipped as the episodic-memory plugin, and this library's evolve
  skill's stage-then-promote rule is this post's necessity test made
  explicit.
