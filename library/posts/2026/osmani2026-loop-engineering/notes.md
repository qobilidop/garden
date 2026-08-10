---
citekey: osmani2026-loop-engineering
work:
  title: Loop Engineering
  author: Addy Osmani
  date: 2026-06-07
source: https://addyosmani.com/blog/loop-engineering/
discussions:
  - https://x.com/addyosmani/status/2064127981161959567  # 2026-06-08
  - https://news.ycombinator.com/item?id=48514387  # 2026-06-13
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "Practitioner naming of the layer above the harness — five now-converged product primitives plus external state turn agent-prompting into a designed system — with the honest concession that the loop amplifies the operator's judgment or its absence."
---

# Loop Engineering

Practitioner essay naming and popularizing the layer this library has so
far met from the research side: stop prompting agents and design the
system that prompts them. Osmani anchors the shift in two quotes — Peter
Steinberger ("designing loops that prompt your agents") and Boris Cherny
of Claude Code ("my job is to write loops") — and positions loop
engineering "one floor above" his earlier harness-engineering framing:
the harness on a timer, spawning helpers, feeding itself.

## The five primitives plus state

The post's core claim is convergence: what required a bespoke pile of
bash a year earlier now ships as first-class features in both the Codex
app and Claude Code, under different names but with identical
capability, so a loop design is tool-portable. The inventory:

1. **Automations** — the heartbeat: scheduled discovery and triage,
   findings landing in an inbox, empty runs self-archiving. Includes an
   in-session variant the post flags as closest to its thesis: `/goal`
   runs until a written stopping condition holds, graded after each turn
   by a separate model — the maker/checker split applied to the stop
   condition itself.
2. **Worktrees** — mechanical isolation for parallel agents; the
   familiar two-engineers-same-lines collision, solved by git rather
   than coordination.
3. **Skills** — project knowledge written down once where every run
   reads it; the fix for agents that "start every session cold" and
   fill intent gaps with confident guesses. Without skills the loop
   re-derives the project from zero every cycle.
4. **Plugins/connectors** (MCP) — the difference between an agent that
   says "here is the fix" and a loop that opens the PR and updates the
   ticket.
5. **Sub-agents** — "keep the maker away from the checker": the model
   that wrote the code is too generous grading its own homework, so a
   verifier with different instructions (and sometimes a different
   model) is what makes walking away defensible.

The sixth piece is state outside the context window — a markdown file
or issue board holding what's done and what's next, because "the agent
forgets, the repo doesnt." The worked example composes all six: a
morning automation calls a triage skill over CI failures and issues,
writes findings to the state file, opens a worktree per finding with a
drafting sub-agent and a reviewing sub-agent, connectors open the PR,
and anything unhandled lands in the human's triage inbox; the state
file lets tomorrow's run resume where today's stopped.

## The counterweights

The closing third argues three problems sharpen as the loop improves:
verification stays on the human ("done" is a claim, not a proof);
comprehension debt grows faster the smoother the loop ships code you
did not write; and the comfortable posture — taking whatever the loop
returns — is what he calls cognitive surrender. The line worth keeping:
two people can build the same loop and get opposite results — one moves
faster on work they understand deeply, the other avoids understanding
at all, and the loop cannot tell the difference.

## Assessment

This is synthesis and advocacy, not a system report: no measurements,
and nearly every load-bearing concept cites one of Osmani's own prior
posts (eleven self-citations — harness engineering, intent debt,
comprehension debt, cognitive surrender, orchestration tax, and more),
so the essay is best read as the index volume of a personal series. The
product-mechanism claims (Codex's Automations tab and TOML sub-agents,
`/goal`'s separate grading model) are asserted without sources and are
the fastest-aging content in the piece. The author has a stake: an
O'Reilly book on AI-assisted engineering is promoted in-page, and the
coinage visibly became content-marketing fodder within weeks — the
ingestion-time Reddit sweep found courses, newsletters, and copycat
posts reusing the term, evidence of reach rather than validity. The HN
thread is a single sustained objection the post itself concedes:
whether comprehension of a production system survives this working
style at all.

- **Durable:** the maker/checker split extended to the stop condition;
  state on disk rather than in context; loop designs made portable by
  primitive convergence; the loop-amplifies-the-operator closing.
- **Era-bound:** the entire product-feature table, already
  version-specific at publication.
- **In this library:** names for practitioners the layer
  [[weng2026-harness]] maps as research territory — Weng's design
  patterns (file-system memory, explicit sub-agents, skills) are
  Osmani's primitives seen from the product side, and both posts reach
  the same rule from opposite directions: the grader must sit outside
  the loop that does the work. Against
  [[vincent2026-superpowers-6]]'s autonomy ladder, the loop sketched
  here is delegation without self-improvement — the loop runs the work
  but nothing updates the loop — which is exactly the gap the
  [[self-evolving-agents]] shelf is about. The external-state principle is
  [[karpathy2026-llm-wiki]]'s compile-don't-re-retrieve argument
  applied to task state rather than knowledge.
