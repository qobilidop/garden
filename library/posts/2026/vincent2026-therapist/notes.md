---
citekey: vincent2026-therapist
work:
  title: The Therapist Pattern
  author: Jesse Vincent
  date: 2026-07-20
source: https://blog.fsck.com/2026/07/20/the-therapist-pattern/  # snapshot → shadow; cross-posted to primeradiant.com/blog
# discussions: none found at retrieval (HN, Lobsters swept) — post is two weeks old
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-07
synthesis: "Identity as an evolution locus with a receipt rule: a claimed lesson counts only when it lands in a versioned, inspectable surface through the designated writer — 'I'll remember that' is a red flag, a diff is evidence."
---

# The Therapist Pattern

Field report from Prime Radiant (Jesse Vincent's company; Sen is their
"agentic colleague" harness, pre-open-source) proposing a governance
pattern for the hardest part of self-evolution: letting a long-lived
agent modify *itself* — persona, standing rules, identity — without a
human approving every change and without runaway drift. The mechanism:
the agent cannot write to its own mutable identity. A dedicated
**Therapist subagent is the only role with write access** to the persona
surface (`mutable-identity/identity.md`, injected into the system prompt
every turn), and the way an agent changes itself is to talk the change
through with its Therapist.

The post documents the first autonomous use. Ada Sen (their first
instance, working as an engineer) opened a PR against Superpowers that
ignored the repo's contribution conventions and leaked internal
shorthand into the public PR body. Told so, Ada claimed it was "adding a
standing rule" — exactly the kind of assertion Vincent flags as a red
flag from any agent, since such notes normally evaporate. Asked *where*
the rule got written, Ada produced the receipt: the verbatim rule
(house-conventions-first, no internal context in public artifacts),
appended to its identity file at a specific line, written via the
Therapist because Ada itself has no write access. The claimed learning
was structurally real, not performative.

The design argument: self-modification is "an open door for unchecked
arbitrary change" — the human analogy is deciding overnight to be a
different person, with no memory of having been different, cascading.
Vincent's goal is explicitly to keep humans *out* of the loop for
routine self-iteration, which is what makes the internal gate
load-bearing: externalizing the change process to a single privileged
role that exists only for that purpose. Planned extension: slow-rolled
changes requiring multiple sessions across calendar days before a
persona edit lands — time as a second gate. The post also situates the
pattern in Vincent's running bet that human self-work metaphors transfer
to agents (the feelings journal, later supported by a 2389 paper and
Anthropic research; Cialdini persuasion principles, later reproduced
against frontier models by Cialdini, Mollick, and Shapiro — claims
cited, not detailed).

## Assessment

Freshest entry on this shelf (two weeks old at ingestion) and the only
one addressing *identity* as an evolution locus — a surface the
skills/rules/memory taxonomy doesn't name.

- **Durable:** the receipt — a claimed lesson counts only when it lands
  in a versioned, inspectable surface through the designated writer;
  "I'll remember that" is a red flag, a diff is evidence. That is the
  transferable idea for the evolve skill.
- **Era-bound and unverified:** single anecdote, no eval harness yet
  (said plainly in the post), product pre-release, author's stake
  obvious.
- **In this library:** convergent evolution with the academic line —
  sole write access through a dedicated role is
  [[zhang2025-ace]]'s LLM-proposes/gatekeeper-merges
  split and [[zhang2026-self-harness]]'s proposer/promoter separation,
  applied to persona; the planned multi-day slow-roll adds a gate
  dimension (time) none of the papers use. It is also the direct answer
  to the "misevolution" and drift risks
  [[gao2025-self-evolving-survey]] catalogs — but where the
  survey's checklist assumes human approval gates, this pattern
  deliberately replaces them with structural internal ones, a genuine
  philosophical fork worth watching.
