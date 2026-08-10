---
citekey: favaro2026-ai-builds-itself
work:
  title: When AI builds itself
  author: Marina Favaro and Jack Clark
  date: 2026
source:  # snapshot → shadow; figures (3 PNGs) → store
  url: https://www.anthropic.com/institute/recursive-self-improvement
  archived: https://web.archive.org/web/20260807042131/https://www.anthropic.com/institute/recursive-self-improvement
  # The page omits a publication date; HN's first public discussion is 2026-06-04.
  # The archive predates retrieval, but its text was verified against the capture.
discussions:
  - https://news.ycombinator.com/item?id=48400842  # 2026-06-04
retrieved: 2026-08-09
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-09
synthesis: "First-party evidence that AI development is automating from execution upward: implementation and fixed-goal experimentation have accelerated sharply, while problem choice, review, and verification remain the binding constraints—not yet a closed recursive self-improvement loop."
---

# When AI builds itself

Anthropic Institute essay combining public capability benchmarks with
previously unreported internal telemetry to argue that AI is already
accelerating AI development, though not yet recursively improving itself.
Its most useful contribution is an organizational bottleneck map:
implementation and fixed-goal experimentation have become much cheaper in
human time, so review, goal selection, research taste, and verification move
upstream as the scarce work. The evidence is unusually concrete for a lab
essay, but it remains first-party, partly LLM-judged, and strategically
framed by a company whose capabilities and policy case both benefit from a
fast-progress narrative.

## The claim is a ladder, not yet a loop

The article narrates five stages: human-built models (2021–2023), chatbot
assistance (2023–2025), coding agents (2025–2026), today's longer-running
autonomous agents, and a possible future in which agents design and train
their successors. Favaro and Clark explicitly say the last stage has not
arrived and is not inevitable. Their present-tense evidence concerns AI
*participating in the production of later AI systems*; it does not show an
agent autonomously initiating a persistent change to its own model or
harness and validating the successor.

That boundary matters against [[gao2025-self-evolving-survey]]:
experience-dependent, persistent, self-initiated change is its operational
test for self-evolution. [[weng2026-harness]] and
[[zhang2026-self-harness]] describe mechanisms that can actually close such
a loop around the harness. This essay instead supplies evidence about the
organizational substrate on which a future loop might run.

## What the internal evidence supports

- **Code volume accelerated.** As of May 2026, Anthropic attributes more
  than 80% of merged production-code lines to Claude, versus low single
  digits before the February 2025 Claude Code research preview. In Q2 2026,
  lines merged per active contributor were 8× the pre-2025 average. The
  figure caps per-PR line counts at the 99th percentile and marks Q2 as
  partial; the authors themselves say lines of code overstate productivity
  because they measure quantity, not quality, and note gaps in attribution.
- **Staff report large gains, but not experimentally.** In a March 2026
  poll of 130 research employees, the median estimate was roughly 4× the
  output they would have produced without AI on the same kinds of projects.
  The article expects the true uplift to be lower and cites evidence that
  developers overestimate AI productivity. This corroborates perceived
  acceleration, not a causal estimate.
- **Open-ended execution improved fastest from the lowest base.** A weekly,
  four-week trailing internal series puts success on open-ended Claude Code
  problems at 76% in May 2026, fifty percentage points above six months
  earlier; routine and trivial work began much higher. Both success and task
  difficulty are assigned by LLMs, and workload changes can move the series,
  so it is a consistent internal instrument rather than an independent
  benchmark.
- **Fixed-goal experimentation is the strongest case.** On the recurring
  task of optimizing training code under a fixed correctness test, the
  reported speedup rose from about 3× for Opus 4 in May 2025 to about 52×
  for Mythos Preview in April 2026; a skilled human reaches roughly 4× in
  four to eight hours. The footnote warns that the absolute multiple depends
  on how inefficient the starting code is and is not a real-world training
  speedup. The like-for-like trend, not 52× itself, is the evidence.
- **Research autonomy remains bounded by human specification.** In the
  cited weak-to-strong supervision project, agents recovered 97% of the
  available performance gap over 800 cumulative agent-hours and about
  $18,000 of compute, versus 23% for two humans over roughly a week. The
  result did not transfer cleanly to production-scale models, and humans
  chose both the problem and scoring rubric.
- **The research-judgment probe is deliberately asymmetric.** Across 129
  moments selected because the human's next move had room for improvement,
  the model-preferred rate rose from 51% for Opus 4.5 to 64% for Mythos
  Preview. A model with access to the eventual session outcome judged the
  alternatives. On a separate 127-moment set where the human move was
  already strong, models won only about 20% of the time. This is evidence of
  improving local next-step choice, not parity with human research taste.

The article adds two vivid operational examples—more than 800 cleanup fixes
that reduced one API-error class by three orders of magnitude, and an
underspecified debugging incident solved in about two hours instead of an
estimated two to three days. They make the mechanism legible but remain
case reports supplied by the organization itself.

## Bottlenecks migrate upward

The synthesis is Amdahl's law applied to an AI lab. Once code generation and
experiment execution accelerate, code review, shared infrastructure,
problem selection, and deciding which results to trust cap the organization.
The article says Anthropic is already seeing review queues and more ideas
than it can pursue. This sharpens [[research-craft]]: Hamming's important-
problem ritual and Alon's feasibility×interest selection do not become less
important when execution gets cheap; they become a larger fraction of the
remaining human contribution.

The authors offer three futures: capability growth stalls but diffuses;
labs keep compounding efficiency while humans retain direction and
judgment; or systems close the full successor-design loop. They consider the
middle scenario most consistent with current evidence. Full recursive
self-improvement is the consequential extrapolation, not the measured
result.

Their policy conclusion follows from that extrapolation: a verifiable,
multilateral option to slow or pause frontier development would be valuable,
but unilateral restraint merely changes the leader. Verification is the
hard part because training runs are concealable, inputs are general-purpose,
and defection is highly rewarded. This is an institutional proposal, not an
empirical finding of the internal studies.

## Assessment

- **Durable:** the execution→review→direction bottleneck migration; the
  separation between running a fixed experiment and choosing a worthwhile
  one; and the unusually transparent caveats around lines of code,
  self-reported uplift, selected judgment examples, and non-transfer.
- **Era-bound:** every model-specific curve, the 80%/8×/76% measurements,
  and extrapolations from short exponential runs. They are a dated frontier-
  lab snapshot, not stable coefficients of automation.
- **Weaknesses:** the underlying data, classifiers, judges, and most
  protocols are not independently inspectable here; several measures use
  Claude to evaluate Claude; productivity has no external counterfactual;
  and the company is simultaneously evidence source, model vendor, and
  policy advocate.
- **Against the library:** [[jiang2026-solvers-to-research]] finds the
  same execution-versus-discovery boundary in formal mathematics, where
  support work overwhelms genuinely novel solutions. Together they argue
  that abundant verified doing does not by itself demonstrate research
  direction-setting. [[weng2026-harness]] supplies the mechanism map this
  essay lacks; this essay supplies frontier-lab operational evidence that
  the mechanism map lacks.

The piece is therefore best retained as evidence of rapid *AI-R&D
automation* and migrating organizational constraints, not as evidence that
recursive self-improvement has already arrived.
