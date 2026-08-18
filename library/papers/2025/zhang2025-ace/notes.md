---
citekey: zhang2025-ace
work:
  title: "Agentic Context Engineering: Evolving Contexts for Self-Improving Language Models"
  author: Qizheng Zhang, Changran Hu, et al. (13 authors)
  venue: ICLR 2026
  date: 2025-10-06
  doi: 10.48550/arXiv.2510.04618
  arxiv: 2510.04618 (v3, 2026-03-29, camera-ready)
sources:
  pdf: https://arxiv.org/pdf/2510.04618v3  # → shadow; pinned to v3 — the bare arXiv pdf URL is a mutable pointer
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-07
synthesis: "Contexts should grow as itemized, provenance-counted entries with deterministic merges — brevity bias and context collapse name why blob rewrites fail, and feedback quality binds any self-updating context."
---

# Agentic Context Engineering: Evolving Contexts for Self-Improving Language Models

ICLR 2026 methods paper (Stanford, SambaNova, UC Berkeley) in the
natural-language-feedback lineage (Reflexion → TextGrad → GEPA → Dynamic
Cheatsheet): adapt an LLM system by editing its context, not its weights.
Its contribution is a diagnosis plus a mechanism. Diagnosis: existing
context adaptation fails in two named ways — **brevity bias** (optimizers
collapse toward short generic prompts, discarding the domain detail that
agents actually need) and **context collapse** (letting an LLM rewrite
accumulated context wholesale eventually erases it — their case study drops
from 18,282 tokens to 122 in a single adaptation step, with accuracy
falling below the no-adaptation baseline). Mechanism: treat context as a
structured playbook that only grows through localized, itemized edits
merged by deterministic non-LLM code. The paper's core stance is
contrarian to the prompt-optimization tradition: contexts should be
comprehensive playbooks, not concise summaries — long-context models can
distill relevance at inference time, so preserve detail and let the model
decide what matters.

## The mechanism

Three specialized roles over the same base model: **Generator** produces
trajectories on real tasks, **Reflector** distills concrete lessons from
successes and failures (iteratively, ~3–5 rounds; more under-extracts or
over-thinks), **Curator** turns lessons into candidate delta items. The
context itself is a list of **bullets**, each with metadata (unique id,
helpful/harmful counters incremented by Generator feedback) and one small
content unit (a strategy, a domain concept, a failure mode). Updates are
**delta-only**: new bullets append, existing ones update in place; merging
is deterministic string/id logic, never an LLM rewrite. **Grow-and-refine**
keeps it bounded: embedding-based dedup, pruning triggered proactively or
lazily when a length cap is hit. Separating reflection from curation, and
both from the merge, is the point — every step an LLM performs is
fallible, so the irreversible operation (what enters the playbook) is the
one no LLM touches.

## Results and what actually carries them

On AppWorld (DeepSeek-V3.1 as base), offline ACE reaches 59.4% average
(+17.0 over ReAct), beating ICL and GEPA by ~12%; online ACE reaches 59.5%
— matching the then-#1 leaderboard agent (IBM CUGA, GPT-4.1-based
production system) and beating it on the harder test-challenge split,
with a much smaller open model. On finance benchmarks (FiNER, Formula)
offline ACE gains +12.8 average with labels. Adaptation cost drops
sharply versus both GEPA (−82% latency, −75% rollouts; GEPA's evolutionary
loop re-validates full prompt variants) and Dynamic Cheatsheet (−91.5%
latency, −83.6% token cost; DC rewrites its whole cheatsheet each step).
The long-playbook overhead at serving time is largely absorbed by KV
caching (91.8% of input tokens cached in their GPT-5.1 study).

The ablations locate the load-bearing part: **without incremental delta
updates, most of the gain vanishes** (test-normal average falls from
+17.0 to +3.6) — the deterministic merge, not the agentic role-play, is
the innovation that matters. The Reflector and multi-epoch adaptation add
a few points each. Robustness is decent: a much weaker Reflector still
yields most of the gain, and injected harmful reflections degrade
performance gradually, dipping below baseline only when every single
update is adversarial.

## The caveat that gates everything

ACE adapts without ground-truth labels only where **natural execution
feedback** exists (code ran, task completed). Where neither labels nor
execution signals are available, adaptation can go negative: online FiNER
without labels *hurts* (−3.4 vs base), and DC degrades worse. The authors
are explicit: context pollution from unreliable feedback is a fundamental
limitation of inference-time adaptation, not an implementation detail.
They also concede ACE's regime is detail-hungry tasks; tasks needing one
concise insight (HotPotQA-style retrieval, fixed-strategy games) gain
nothing from a large playbook.

## Assessment

- **Durable:** the two named failure modes (brevity bias, context
  collapse) as vocabulary; the design rule that LLMs propose but
  deterministic code merges; itemized context with provenance counters
  as the unit of memory; the ablation evidence that
  incremental-vs-monolithic is where the value is; feedback quality as
  the binding constraint on any self-updating context.
- **Era-bound:** the specific numbers and leaderboard placements, the
  KV-cache economics argument (true today, framed as a trend), and the
  system roster.
- **Weaknesses:** gains are demonstrated where dense reusable domain
  structure exists — two finance benchmarks plus one agent suite is a
  narrow base for the "comprehensive playbooks beat concise prompts"
  generalization, and the paper itself shows the counter-regime; a
  citation slip survives to camera-ready (Dynamic Cheatsheet attributed
  to "Krause et al., 2019" in §2.1, correctly Suzgun et al. 2025
  elsewhere).
- **In this library:** for a harness that persists memory and rules
  across sessions (this repo included), this is the direct blueprint:
  itemized entries over blob rewrites, deterministic merges,
  dedup-and-prune hygiene, helpful/harmful provenance, and no
  self-update without a reliable feedback signal — convergent with the
  safety architecture [[gao2025-self-evolving-survey]] reaches
  from the risk side.
