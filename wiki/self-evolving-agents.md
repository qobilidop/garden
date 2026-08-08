# Self-evolving agents

Systems that modify themselves from their own experience. Shelf:
[[gao2025-a-survey-of-self-evolving-agents]] (the field map),
[[zhang2025-agentic-context-engineering]] (context as playbook),
[[zhang2026-self-harness]] (harness self-improvement protocol),
[[wang2023-voyager]] (the founding skill-library exemplar),
[[liu2026-a-taxonomy-of-self-evolving-agents]] (the three-locus cut),
[[weng2026-harness]] (harness engineering as the near-term RSI site),
[[osmani2026-loop-engineering]] (the loop layer from the product side),
[[vincent2026-the-therapist-pattern]] and [[vincent2026-superpowers-6]]
(field reports), [[karpathy2026-llm-wiki]] (the pattern applied to
knowledge rather than procedures).

## The consensus architecture

Read together, the shelf converges from four directions — survey risk
analysis, methods ablations, protocol design, production practice — on
one loop shape:

- **Evidence before proposal.** Improvements start from real traces —
  weakness mining with deterministic failure clustering
  ([[zhang2026-self-harness]]), reflection over actual trajectories
  ([[zhang2025-agentic-context-engineering]]), session mining at
  production scale ([[vincent2026-superpowers-6]]). An addressability
  filter drops failures that reflect task difficulty or model limits —
  not every failure deserves a patch.
- **Itemized minimal deltas, never wholesale rewrites.** ACE's ablation
  locates the value precisely: without incremental delta updates most
  of the gain vanishes, and letting an LLM rewrite accumulated context
  collapses it (18,282 → 122 tokens in one step). Bounded edits to
  declared surfaces, one concern per edit.
- **The gate sits outside the evolving loop.** What persists is decided
  by a verifier, not the generating pass — Voyager's self-verification
  critic was its single most valuable feedback type; ACE's merge is
  deterministic code no LLM touches; Self-Harness accepts only
  non-regressing candidates; [[gao2025-a-survey-of-self-evolving-agents]]
  reaches the same rule from the risk side (evaluation and permissions
  outside the loop, approval gates, rollback). By mid-2026 the rule
  ships as a consumer primitive: [[osmani2026-loop-engineering]]'s tour
  of coding-agent products finds the maker/checker split built into
  both major tools, down to run-until-done stop conditions graded by a
  model other than the one doing the work.
- **Receipts.** A claimed lesson counts only as a diff in a versioned,
  inspectable surface through the designated writer
  ([[vincent2026-the-therapist-pattern]]); audit records name behavior,
  surface, evidence, and validation ([[zhang2026-self-harness]]).
- **Negative results are logged, not discarded** — rejected proposals,
  provably dead ideas, closed leads ([[vincent2026-superpowers-6]],
  [[weng2026-harness]]'s literature-bias challenge).

## What evolves — the loci

[[gao2025-a-survey-of-self-evolving-agents]] cuts four ways (weights,
context, tools, architecture); [[liu2026-a-taxonomy-of-self-evolving-agents]]
coarsens to model/harness/artifact and adds the artifact as a
first-class locus (its canonical exemplar, [[novikov2025-alphaevolve]],
is now in the library: evolution over programs under a fixed scorer,
with MAP-elites diversity and verification-before-persistence at
population scale); [[vincent2026-the-therapist-pattern]] names one the
taxonomies miss (identity/persona); [[karpathy2026-llm-wiki]] shows the
same loop with *knowledge* as the evolving artifact — compile sources
into a maintained wiki instead of re-retrieving, with the Memex's
unsolved maintenance burden absorbed by the LLM. Liu's three-question
test travels furthest: what evolves, what feedback drives it, where
does the loop close.

## Binding constraints

- **Feedback quality gates everything.** Without labels or execution
  signals, adaptation goes negative (ACE's online-FiNER result);
  deployment-time reward hacking via memory and "misevolution" are the
  survey's core risks. No reliable signal → no self-update.
- **Updating is cheap; benefiting is scarce.** Harness-updating
  capability is flat across model scale, harness-benefit is
  non-monotonic (via [[weng2026-harness]]); STOP found recursion helps
  strong models and degrades weak ones. Machinery is not the
  bottleneck.
- **Retention is the neglected dimension.** Nearly all benchmarks reset
  agent state between tasks, so the one thing that distinguishes
  self-evolving agents — accumulation and its decay — goes unmeasured
  ([[gao2025-a-survey-of-self-evolving-agents]]).
- **The evaluator is code too.** Superpowers' Codex evals showed zero
  improvement because an isolation bug benchmarked the old version —
  an unverified gate passes everything.

## Autonomy is a ladder

[[vincent2026-superpowers-6]]'s three rungs — assisted analysis,
overnight delegation, autonomous research — each earned by building
eval infrastructure first, never by trusting the proposer more. The
ladder's floor is now mainstream practice:
[[osmani2026-loop-engineering]]'s scheduled triage-and-fix loops run
the work autonomously but never update themselves — delegation without
self-improvement, the substrate the rest of the shelf evolves.
[[vincent2026-the-therapist-pattern]] explores replacing human gates
with structural internal ones (sole-writer roles, time as a gate) — a
philosophical fork from the survey's human-approval checklist worth
watching.

## Local instantiation

This repo runs the consensus loop at the human-gated rung: the evolve
skill implements evidence mining → itemized proposals → user-as-
regression-gate → git audit trail, with rejections logged in session
reflections. The library's shadow/notes tiers are the raw/wiki layers
of [[karpathy2026-llm-wiki]]'s architecture; this page is its writeback
layer. Open questions the shelf leaves for future ingestions: how to
measure retention decay in a personal harness; whether identity ever
becomes a locus here; what evidence would justify climbing a rung.
