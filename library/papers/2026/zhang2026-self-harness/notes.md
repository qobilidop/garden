---
citekey: zhang2026-self-harness
work:
  title: "Self-Harness: Harnesses That Improve Themselves"
  author: Hangfan Zhang et al. (8 authors, Shanghai AI Laboratory)
  date: 2026-06-08
  doi: 10.48550/arXiv.2606.09498
  arxiv: 2606.09498 (v1, preprint — no venue)
sources:
  pdf:  # → store; pinned to v1
    url: https://arxiv.org/pdf/2606.09498v1
    archived: http://web.archive.org/web/20260612123149/https://arxiv.org/pdf/2606.09498v1
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-07
---

# Notes: Self-Harness

Shanghai AI Lab preprint defining the paradigm this library first met
through weng2026-harness's summary: a fixed model improves the harness it
runs under — no human engineer, no stronger external agent (their contrast
with Meta-Harness). The framing is deliberately narrow and the paper is
candid about it: not open-ended self-improvement, but whether the same
model, under its current harness, can propose a *bounded* edit to declared
harness surfaces and have that edit survive regression testing. The
one-sentence lesson the conclusion draws is the durable part: **harness
improvement is an empirical state transition** — a legitimate edit names
the behavior it targets, the surface it modifies, the evidence motivating
it, and the evaluation justifying promotion; the proposer's rationale
alone is never sufficient.

## The loop

Three stages per round over a harness lineage h₀, h₁, …:

**Weakness Mining.** Run the agent on a held-in task split; collect traces
with verifier outcomes. Failed traces are clustered *deterministically* by
a failure signature — (terminal verifier-level cause, causal status of the
implicated agent behavior, abstract mechanism) — with exact-match
grouping, explicitly not latent semantic similarity. Two timeouts land in
different clusters if different behaviors caused them. Clusters are ranked
by support and actionability into an evidence bundle that describes
failures but never prescribes edits — keeping evaluator and optimizer
separate.

**Harness Proposal.** The same model, invoked as proposer, sees the
editable surfaces, the evidence bundle, passing behaviors to preserve, and
previously attempted edits. It generates K mutually-distinct candidate
edits, each with an audit record (targeted pattern, edited surface,
expected effect, regression risks). Two constraints do the work:
*diversity across* branches, *minimality within* each (touch only the
surface needed; no architecture rewrites). An addressability filter drops
failure clusters that reflect task difficulty or model capability rather
than a missing execution rule — not every failure deserves a patch.

**Proposal Validation.** Each candidate is evaluated on both splits;
accepted only if it degrades neither and improves at least one
(repeat-aggregated when evaluation is stochastic). Compatible accepted
edits merge into h_{t+1}; rejections are logged, not applied. Every
transition is auditable.

## Experiments and what they show

Terminal-Bench-2.0 (64-task subset), a deliberately minimal
DeepAgent-based initial harness whose editable surfaces are declared
config points (system prompt, memory sources, subagents, skills,
bootstrap/execution/verification/failure-recovery instructions, runtime
control policy), and three models: MiniMax M2.5, Qwen3.5-35B-A3B, GLM-5.
Held-out pass rates rise 40.5→61.9, 23.8→38.1, and 42.9→57.1 respectively;
the trajectories show a handful of accepted edits among many rejections
and abandoned branches (Qwen's subagent and skill branches were dropped
for yielding nothing — the gate visibly working).

The qualitative finding is the paper's best evidence that this is more
than prompt-padding: **different models earned different harnesses from
identical starting conditions**. MiniMax needed early artifact creation
and a tool-message cap; Qwen needed dependency prechecks, retry
discipline, and a loop-breaking middleware; GLM-5 needed environment
persistence across shell sessions and a nudge from exploration to
implementation. The shared theme — artifact reliability — plus
model-specific pathologies is exactly the argument for per-model harness
adaptation the introduction makes.

## Assessment

Two methodological soft spots, neither acknowledged as such. First, the
held-out split is not a test set: it gates *every* promotion round, so
the final harness has been selected against it repeatedly, and the
headline "held-out" gains carry selection bias — a true untouched split
would be needed to measure generalization cleanly. Second, the initial
harness is a deliberate floor (a few sentences of prompt plus bare
tools), so the large relative gains (+138% for Qwen) substantially
measure rediscovery of standard harness furniture — loop breakers,
artifact checks — that mature harnesses ship with; there is no comparison
against a well-engineered baseline. n=64 tasks with two attempts per
candidate also makes individual accept decisions noisy, only partly
mitigated by the non-regression rule. What survives these caveats: the
loop architecture itself (evidence before proposal, addressability
filtering, bounded surfaces, conservative gating, audit records, logged
rejections), the different-models-need-different-harnesses result, and
the closing warning that pass-rate non-regression is too weak a gate for
higher-stakes harness changes. This answers the abstraction-boundary
concern weng2026-harness raised — surfaces here are explicitly fenced —
and for a human-gated personal system the transferable pattern is the
evidence discipline: mine weaknesses from real traces, propose minimal
itemized edits tied to specific failures, and treat human review as the
regression gate the paper says pass-rates alone cannot provide.
