# Self-evolving agents

Systems that modify themselves from their own experience. Shelf:
[[gao2025-self-evolving-survey]] (the field map),
[[zhang2025-ace]] (context as playbook),
[[zhang2026-self-harness]] (harness self-improvement protocol),
[[wang2023-voyager]] (the founding skill-library exemplar),
[[liu2026-agent-taxonomy]] (the three-locus cut),
[[weng2026-harness]] (harness engineering as the near-term RSI site),
[[favaro2026-ai-builds-itself]] (frontier-lab evidence of R&D
automation),
[[osmani2026-loop-engineering]] (the loop layer from the product side),
[[ye2026-cake]] (the environment locus, with the controlled
experiment),
[[willison2025-lethal-trifecta]] (capability composition as a security
boundary),
[[vincent2026-therapist]] and [[vincent2026-superpowers-6]]
(field reports), [[karpathy2026-llm-wiki]] (the pattern applied to
knowledge rather than procedures).

## The consensus architecture

Read together, the shelf converges from four directions — survey risk
analysis, methods ablations, protocol design, production practice — on
one loop shape:

- **Evidence before proposal.** Improvements start from real traces —
  weakness mining with deterministic failure clustering
  ([[zhang2026-self-harness]]), reflection over actual trajectories
  ([[zhang2025-ace]]), session mining at
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
  non-regressing candidates; [[gao2025-self-evolving-survey]]
  reaches the same rule from the risk side (evaluation and permissions
  outside the loop, approval gates, rollback). By mid-2026 the rule
  ships as a consumer primitive: [[osmani2026-loop-engineering]]'s tour
  of coding-agent products finds the maker/checker split built into
  both major tools, down to run-until-done stop conditions graded by a
  model other than the one doing the work.
- **Authority is partitioned across the whole path.**
  [[willison2025-lethal-trifecta]] identifies the dangerous composition:
  private-data access + attacker-controlled content + an externally visible
  communication channel. A model-level checker does not break that path if it
  shares the same secrets and output authority. After untrusted content enters
  a trajectory, consequential reads, writes, and communication need structural
  separation or an independently authorized gate.
- **Receipts.** A claimed lesson counts only as a diff in a versioned,
  inspectable surface through the designated writer
  ([[vincent2026-therapist]]); audit records name behavior,
  surface, evidence, and validation ([[zhang2026-self-harness]]).
- **Negative results are logged, not discarded** — rejected proposals,
  provably dead ideas, closed leads ([[vincent2026-superpowers-6]],
  [[weng2026-harness]]'s literature-bias challenge).

## What evolves — the loci

[[gao2025-self-evolving-survey]] cuts four ways (weights,
context, tools, architecture); [[liu2026-agent-taxonomy]]
coarsens to model/harness/artifact and adds the artifact as a
first-class locus (its canonical exemplar, [[novikov2025-alphaevolve]],
is now in the library: evolution over programs under a fixed scorer,
with MAP-elites diversity and verification-before-persistence at
population scale); [[vincent2026-therapist]] names one the
taxonomies miss (identity/persona); [[karpathy2026-llm-wiki]] shows the
same loop with *knowledge* as the evolving artifact — compile sources
into a maintained wiki instead of re-retrieving, with the Memex's
unsolved maintenance burden absorbed by the LLM. [[ye2026-cake]] adds a
locus none of the taxonomies had measured: the *environment* between
agent and hardware. Model and scaffold stay fixed while recurring
kernel failures evolve a domain compiler — verifier rules, IR
primitives, cost calibrations — under corpus tests and human merge
gates, the consensus loop shape intact at a new address. Its matched
clean-start experiment is the shelf's cleanest evidence that the locus
pays: same model, same budget, implementation-hidden task, and the
co-designed IR-plus-harness arm reaches 1.144× a tuned baseline where
the raw-CUDA arm stalls at 0.928×. The bundle is the treatment —
representation and feedback are not separated — but that is the point:
the environment, not the agent, was the variable. Liu's three-question
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
  ([[gao2025-self-evolving-survey]]).
- **The evaluator is code too.** Superpowers' Codex evals showed zero
  improvement because an isolation bug benchmarked the old version —
  an unverified gate passes everything.
- **Useful tools are also information-flow edges.** File access, retrieval,
  email, browsers, and network calls improve a harness while potentially
  completing the lethal trifecta. Threat review therefore follows an
  attacker-controlled input to sensitive sources and observable sinks; it
  cannot stop at approving each tool independently
  ([[willison2025-lethal-trifecta]]).

## Autonomy is a ladder

[[vincent2026-superpowers-6]]'s three rungs — assisted analysis,
overnight delegation, autonomous research — each earned by building
eval infrastructure first, never by trusting the proposer more. The
ladder's floor is now mainstream practice:
[[osmani2026-loop-engineering]]'s scheduled triage-and-fix loops run
the work autonomously but never update themselves — delegation without
self-improvement, the substrate the rest of the shelf evolves.
At frontier-lab scale, [[favaro2026-ai-builds-itself]] supplies the
same distinction with internal operational evidence: code volume and
fixed-goal experiment execution rose sharply, while humans still chose
research problems and scoring rubrics, and review became the bottleneck.
Its open-ended-task curves are LLM-judged and its next-step comparison
selects moments where the human had room to improve, so they show a rung
being climbed, not research-taste parity. Under the field map's
experience-dependent, persistent, self-initiated test, this is accelerated
delegation inside AI R&D, not yet a self-evolving system.
[[vincent2026-therapist]] explores replacing human gates
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
