---
citekey: liu2026-a-taxonomy-of-self-evolving-agents
work:
  title: A Taxonomy of Self-evolving Agents
  author: Shilong Liu
  venue: Self-published, personal blog (lsl.zone)
  date: 2026-07-08
  x-article: https://x.com/atasteoff/status/2074800880017342665 (companion thread)
sources:
  html:  # → shadow snapshot; figures (5 PNGs) → store
    url: https://lsl.zone/blog/2026/a-taxonomy-of-self-evolving-agents/
    archived: https://web.archive.org/web/20260801121942/https://lsl.zone/blog/2026/a-taxonomy-of-self-evolving-agents/
    # snapshot predates retrieved by 6 days, but verified byte-identical to
    # the capture (save endpoint unreachable from this session)
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-07
---

# Notes: A Taxonomy of Self-evolving Agents

A practitioner's blog post that cuts the self-evolving-agents field along a
single axis — *what evolves* — into three loci: **model**, **harness**, and
**artifact**. Starting from "Agent = Model + Harness," it adds artifacts
(the agent's outputs: discovered kernels, generated papers, robot policies)
as a third, less-discussed locus, then sorts current work into three levels:
artifact iterative optimization, harness self-improvement, and model
learning without gold answers. The author is a computer-vision/agents
researcher writing informally; two of the cited systems (Eevee, Alita-G)
are his own work.

## The three levels

**Artifact iterative optimization** — the agent improves an external
output, not itself. Human sets target and evaluation criteria; the agent
loops propose → check until criteria are met (AlphaEvolve for algorithm
discovery, Analemma AI's FARS auto-research run — 417 hours, 166 papers,
~$180k — GPU-kernel search). The post's historical framing: this is
neural-architecture-search with the hand-designed operator set and search
heuristic both replaced by the LLM, which widens the search space and
improves the searcher at once; longer agent horizons (from <5 tool calls in
2024's LLaVA-Plus to hours of autonomy now) made the loop practical. The
frontier is physical environments — robots (NVIDIA), bio labs (LabOS),
quantum materials (Qumus).

**Harness self-improvement** — the agent modifies its own components
without touching weights, motivated by training cost. Two sublevels:
prompt/memory (GEPA, ACE playbooks, Mem0 — "learning" is a fair label
because a harness update is functionally like a parameter update) and
tools/skills (Alita, Mem-UI; skills as formalized by Claude Code, framed
as context management — reusable procedure without carrying detail in
context). Single-agent harnesses stop scaling as playbooks and tool sets
grow — retrieval gets noisy and semantics collide — motivating multi-agent
self-evolution: per-domain expert agents plus a router (Eevee, Alita-G).
Routing is named as the key bottleneck, needing strong base models; the
post's aphorism is that human experts' most valuable skill is also
routing.

**Model learning without gold answers** — weight updates when only
questions, weak signals, or environment access exist. Three sources of
signal: pseudo-labels or model-internal confidence (self-training, TTRL,
R1-style RL when signals become rewards), self-play and environment
interaction grouped as one category since an opponent is just environment
(SPIN, Absolute Zero, early-experience learning), and test-time training
as an architectural special case (sequence models doing implicit gradient
updates at inference; DeltaNet lineage). A section on continual learning
notes the older catastrophic-forgetting framing (replay still the main
remedy) and observes that terms drift: today's "continual learning" in LLM
discourse often means self-evolving agents, the way "multi-modal" meant
captioning in 2017, CLIP in 2021, VLMs in 2023.

## Synthesis and closing argument

The boundary is admittedly blurry — optimizing an artifact well may
require improving the harness; a saturated harness motivates weight
updates (SIA cited as early combined work) — and the post predicts the
three loops merge: better models → better harnesses → faster artifact
search → new data for model learning. Value should be measured outside
the agent system, by real-world artifacts. The distilled takeaway is a
three-question test for any self-evolving system: **what evolves, what
feedback drives it, and where does the loop close** — benchmarks, code,
science, or the physical world.

## Assessment

Category: informal position/organization piece, not a survey — the
citation base is a few dozen exemplar systems, chosen for illustration.
Read against gao2025-a-survey-of-self-evolving-agents (this library): the
post's model/harness split is a coarsening of the survey's four "what
evolves" loci (weights vs context+tools+architecture), and its third
level maps onto the survey's population-based/evolutionary paradigm. The
genuinely additive moves are (1) elevating the *artifact* to a
first-class evolution locus, which cleanly separates
agents-that-improve-outputs from agents-that-improve-themselves — a
distinction the survey's agent-centric formalism handles awkwardly — and
(2) the "where does the loop close" question, a sharper deployment-facing
probe than the survey's when/how axes. Durable: the three-locus cut and
the three questions, both cheap to apply to any concrete system.
Era-bound: the specific system roster and the "skills are now de facto
standard" observations; casual factual claims (FARS run costs, dates) are
repeated from primary sources without verification, and self-citations go
unflagged. Honest about its own blur — the taxonomy is offered as a way
to stop arguing about names, not as a formal partition.
