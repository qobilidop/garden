---
citekey: vincent2026-superpowers-6
work:
  title: Superpowers 6
  author: Jesse Vincent
  date: 2026-06-15
source:  # snapshot → shadow; cross-posted to primeradiant.com/blog
  url: https://blog.fsck.com/2026/06/15/Superpowers-6/
  archived: http://web.archive.org/web/20260703024225/https://blog.fsck.com/2026/06/15/Superpowers-6/
  # predates retrieved, but verified byte-identical to the capture
discussions:
  - https://news.ycombinator.com/item?id=48739459  # 2026-06-30
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-07
synthesis: "The most concrete public numbers yet for a self-improving harness — promotion gated by evals outside the loop, negative results logged — and the Codex-isolation lesson: the evaluator is code too, and an unverified gate passes everything."
---

# Superpowers 6

Release post that is really a field report of harness self-improvement
run at production scale: the Superpowers build loop (the subagent-driven
development orchestration this library first met in
vincent2025-superpowers) optimized by a frontier model against a
regression eval suite, cutting wall-clock time ~50% and token spend
~60% with, per their evals, no quality loss. The optimizer was
Anthropic's Fable during its brief availability window ("shipped (and
unshipped)"); the post is upfront that expensive-and-slow was
Superpowers' chronic complaint, and that the cost came from exactly the
discipline that made it work — up-front planning, strict red-green TDD,
and dual review (spec compliance + code quality) of every change.

## The escalation ladder

The post reads as three rungs of increasing autonomy, each gated by the
eval suite. (1) *Assisted analysis*: Fable mined thousands of
subagent-driven-development sessions, found reviewers burning tokens on
git archaeology, and replaced instructions with a script that pre-bakes
a review packet — about −10%. (2) *Overnight delegation*: asked to find
another 15%, it independently reached the same hypothesis Vincent had
posted to internal Slack (merge the spec-compliance and code-quality
reviewers), tested it, and delivered the 15%. (3) *Autonomous research*:
a one-line goal — run an autoresearch loop, ≥25 experiments, hypothesis
log, opus as coordinator — produced an experiment harness and an
overnight run (~$165) with every hypothesis pre-registered, a ship
candidate cutting benchmark build cost from ~$12–15 to ~$6.6, quantified
wins (terse reviewer contract −41% reviewer output with verdicts
intact), and — as valuable — *provably dead* ideas (capping coordinator
thinking backfires: turns rose 92→138) and closed leads recorded "so
nobody re-buys them."

Two epistemic details elevate the report. The loop's manual-inspection
discipline caught three of its own measurement bugs mid-run, one
retracted verdict re-measured from −74% to an honest −41%. And the
Codex evals initially showed zero improvement — because an isolation
bug meant they were still benchmarking the old version; the evaluator
itself had to be debugged before the result held up. There is also a
transferable risk finding: reviewers given only a pre-baked diff packet
produce *confident* spec verdicts that silently redefine "spec" as the
global constraints — none of five flagged the missing brief.

## Assessment

The most concrete public numbers yet for a self-improving harness in a
widely-deployed framework, and a live demonstration of the architecture
the academic shelf prescribes: proposals from a model, promotion gated
by a regression eval suite outside the loop
(zhang2026-self-harness's protocol at commercial scale), negative
results and closed leads logged (the literature-bias fix
weng2026-harness calls for), and pre-registered predictions against the
"p-hacking and eureka-ing" failure mode.

- **Durable:** the Codex-isolation incident's lesson, which the papers
  understate — the evaluator is code too, and an unverified gate passes
  everything.
- **Era-bound:** model roster and prices.
- **Caveats:** all numbers are self-reported on the project's own young
  eval suite; the post has a recruiting and product stake; and the
  note-writer is the model the post credits, which readers should
  weigh.
- **In this library:** for the evolve skill, rung (1)–(3) is a useful
  maturity map — this repo's loop is at rung one by design, with the
  human as the gate; what the post argues is that each further rung is
  earned by building the eval infrastructure first, not by trusting the
  proposer more.
