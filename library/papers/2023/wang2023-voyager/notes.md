---
citekey: wang2023-voyager
work:
  title: "Voyager: An Open-Ended Embodied Agent with Large Language Models"
  author: Guanzhi Wang et al. (8 authors; NVIDIA, Caltech, UT Austin, Stanford, UW Madison)
  venue: Transactions on Machine Learning Research, 03/2024
  date: 2023-05-25
  doi: 10.48550/arXiv.2305.16291
  arxiv: 2305.16291 (v2, 2023-10-19; the TMLR version, not arXiv v2, is the version of record)
sources:
  pdf: https://openreview.net/pdf?id=ehfRiF0R3a  # → shadow; TMLR camera-ready, fetched via an existing Wayback capture because OpenReview gates direct downloads
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-08  # figure pass 2026-08-08
synthesis: "The founding exemplar of skill-library evolution: verification before persistence, frontier-aware task proposal, and skills indexed by purpose — demonstrated against notably handicapped baselines."
---

# Voyager: An Open-Ended Embodied Agent with Large Language Models

The canonical skill-library paper (NVIDIA-led, TMLR 03/2024, first posted
May 2023): a GPT-4 agent in Minecraft that proposes its own tasks, writes
executable code to accomplish them, and banks verified programs in an
ever-growing library — "lifelong learning" implemented entirely in
context and files, no weight updates. Read from 2026 its architecture is
strikingly familiar, because the modern coding-agent stack inherited it:
skills as description-indexed executable procedures, retrieval by
embedding, environment feedback loops, an LLM critic gating what gets
persisted. Three components carry everything: an **automatic curriculum**
(GPT-4 proposes the next task from the agent's current state and its
completed/failed task history, under a standing goal of "discover as many
diverse things as possible" — in-context novelty search, frontier-aware
so tasks stay challenging but feasible), a **skill library** (each
mastered skill is a JavaScript program over Mineflayer APIs, keyed by the
embedding of its natural-language description, retrieved top-5 by
similarity to the current plan; complex skills compose simpler ones), and
an **iterative prompting mechanism** (up to four rounds of generate →
execute → refine on environment feedback and interpreter errors, ending
when a separate GPT-4 **self-verification** critic confirms task success
— only then is the program committed to the library).

## Results

Against re-interpreted ReAct, Reflexion, and AutoGPT baselines in
MineDojo: 63 unique items in 160 prompting iterations (3.3× the best
baseline), wooden-tool tech-tree level unlocked 15.3× faster, stone 8.5×,
iron 6.4×, and Voyager alone reaches diamond (one of three runs). In a
fresh world with cleared inventory, Voyager solves all four unseen tasks;
no baseline solves any — and bolting Voyager's skill library onto AutoGPT
lifts it from zero to partial success, showing the library is a portable
asset, not an entangled component. A limitations-section demo (Fig. 10)
shows one capability the loop alone lacks: with a human supplying visual
critique or curriculum, Voyager builds complex 3D structures (nether
portal, house) — spatial feedback its text-only self-verification cannot
provide. The ablations rank the parts:
removing the curriculum costs 93% of discovered items, removing
self-verification costs 73% (the largest of any feedback type), no skill
library means plateau in later stages, and GPT-3.5 in place of GPT-4 for
code generation costs 5.7× — capability of the base model gates
everything else.

## What the design gets right (2026 reading)

Three decisions proved durable. (1) **Skills are code with a
natural-language index** — temporally extended, interpretable,
composable, and immune to catastrophic forgetting because they live
outside the model; this is the direct ancestor of skills in today's
coding agents. (2) **Nothing persists without verification** — the
critic, not the generator, decides what enters the library; the ablation
showing self-verification as the single most valuable feedback type is
the paper's most transferable empirical result. (3) **The curriculum
reads the frontier** — next tasks come from current state plus the
completed/failed record, not a fixed list; progress compounds because
new skills build on banked ones.

## Assessment

- **Durable:** the skill-library pattern itself, the
  verification-before-persistence rule, frontier-aware task proposal,
  and the demonstration that an external, inspectable memory of
  executable procedures both compounds capability and transfers across
  agents.
- **Era-bound:** the baselines are the paper's weak point — ReAct,
  Reflexion, and AutoGPT were never designed for embodied Minecraft and
  had to be re-interpreted by the authors, so the headline multipliers
  measure Voyager against handicapped opponents; three runs per
  condition is thin; and the hallucination/cost limitations (copper
  swords, cobblestone as fuel, GPT-4 at 15× GPT-3.5 prices) date it
  precisely. The "first LLM-powered embodied lifelong learning agent"
  claim is marketing-adjacent but roughly earned.
- **In this library:** in [[gao2025-self-evolving-survey]]'s
  frame this is the founding exemplar of tool/skill evolution; for a
  personal system whose skills directory grows by distilling sessions,
  the two lessons that carry over verbatim are: index skills by what
  they're for (description), not how they work; and let a verification
  step, not the enthusiasm of the generating pass, decide what gets
  committed.
