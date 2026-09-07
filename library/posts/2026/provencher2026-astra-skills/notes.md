---
citekey: provencher2026-astra-skills
work:
  title: Rethinking skills and prompts for GPT-6 Astra
  author: Eric Provencher
  date: 2026-09-04
source: https://x.com/pvncher/article/2095991462416490862
discussions:
  - https://x.com/pvncher/status/2095991462416490862  # 2026-09-04
retrieved: 2026-09-07
notes-by: Claude Fable 5.1
notes-date: 2026-09-07
synthesis: "Vendor release guidance naming the audit each model generation forces on accumulated instructions — descriptions as routing keys, root skills as routers, scaffolding the model has internalized — without separating procedure, which decays, from environment facts, which do not."
---

# Rethinking skills and prompts for GPT-6 Astra

An X Article by an author whose profile bio reads "Codex DX" at
OpenAI, written for the arrival of GPT-6 Astra, on what to remove
from the instruction surfaces around a coding agent:
skill files, AGENTS.md, and task prompts. Category: practitioner
guidance from inside the vendor, ~900 words, two illustrated
before/after examples, no measurements. Its argument is that
instructions accumulate as compensation for a previous model's
failures, and a new model release is the moment to find which
compensations have become dead weight.

## The argument

**Skills are a retrieval problem.** Every installed skill contributes
a name and description to the always-loaded catalog, and Codex
shortens descriptions when the catalog outgrows its budget, so
adding skills degrades the model's view of each one. The fix is
short descriptions that state only when the skill applies: the
illustrated example keeps the same "create and validate Postgres
schema migrations" intent but narrows the trigger from "databases,
queries, models, or persistence" to "adding or changing a
migration, or reviewing its rollout" (fig-3). Two further rules
came with an update to Codex's skill-creator: multi-workflow skills
should be a minimal router over supporting documents rather than a
single body, and skills written as "elaborate itineraries or
recipes" now hinder a model that handles nuance unaided. A
multi-model caveat closes the section: repository skills are read
by other contributors' agents, and guidance tuned for one model may
overconstrain another.

**AGENTS.md carries scar tissue.** Instructions to read a stack of
documents before every edit, or to run tests and check work, were
prompts for a model that would not otherwise do so; the new model
does both unprompted, so the instructions now burn context or
trigger unnecessary test runs. The illustrated replacement is
contextual pointers ("database.md for schema changes") over a
blanket read-first rule (fig-4).

**Boundaries and persistence are the new tuning axes.** Strong
"ask first" language added against an earlier model's overreach now
makes the new one stop where the user would rather it continue,
because it "takes your boundaries seriously." The post concedes a
behavior change relative to its predecessor, GPT-5.6 Sol: Astra is
"more tentative about when to stop" and may return after a first
implementation. The remedy is to define completion before starting
and to grant standing permission for workflows known to be safe,
with a sample AGENTS.md clause authorizing a local test loop without
per-step approval. The closing advice is to ask the model itself to
audit the repository against the article.

## Assessment

The post is written from inside a model vendor's product team, and
it reads as a field instance of
[[weng2026-harness]]'s prediction that harness functions internalize
into models while interfaces persist: read-first and test-after
scaffolding is exactly the kind of function that just internalized,
and the description catalog is exactly the interface that did not.
Against [[vincent2025-superpowers]], whose 2,249-memories null result
argued that most accumulated lessons are already absorbed, this post
gives the absorption a clock: a model release.

- **Durable:** descriptions as index keys competing in one fixed
  budget, so a description's job is to say when, not what; the
  router-over-recipe shape for multi-workflow skills; and defining
  completion up front rather than stopping for review by default.
  The multi-model caveat also travels — a skill shared across
  contributors is written for a reader roster, not a model.
- **Era-bound:** the model roster and its behaviors (Astra stops
  earlier than Sol; Astra tests unprompted) are unverified vendor
  assertions about a days-old release, with no measurements. The
  description-shortening mechanism is Codex's; other harnesses cap
  the catalog differently.
- **Weaknesses:** the audit question is framed as "is the model
  smarter now?", which conflates two kinds of instruction. Procedure
  (read these first, run the tests) decays with model capability;
  environment facts (which hooks merge commits bypass, what a
  subagent inherits, which commands need a tty) do not, because no
  amount of judgment recovers what the model cannot observe. Every
  instruction the post proposes retiring is of the first kind, and its
  closing advice
  to have the model audit and prune invites a wholesale rewrite of
  the very surface [[zhang2025-ace]] shows collapses under wholesale
  rewrites — the consensus loop on this shelf ([[self-evolving-agents]])
  wants evidence-first, itemized subtractions, not a release-day
  sweep. The "decision boundaries" section also reads as tuning for
  autonomy without distinguishing gates that existed for a weak
  model from gates that exist because a wrong call is irreversible.
- **Author's stake:** the author works on Codex's developer
  experience; the post is de facto release guidance and a reframing of a
  behavior regression (earlier stopping) as user-side configuration.
- **In this library:** the description rule was already written in
  this repository's create-skill skill and had drifted anyway — six
  of eight skill descriptions restated their bodies' sections when
  audited on 2026-09-07 — so the durable lesson here was less the
  rule than that a rule with a checkable shape needs its check
  (`hooks/lint.sh` now caps description length). The ingest-post
  skill took the router shape the same day.
