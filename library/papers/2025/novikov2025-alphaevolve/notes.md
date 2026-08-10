---
citekey: novikov2025-alphaevolve
work:
  title: "AlphaEvolve: A coding agent for scientific and algorithmic discovery"
  author: Alexander Novikov et al. (18 authors, 9 equal-contribution; Google DeepMind)
  date: 2025-06-16
  doi: 10.48550/arXiv.2506.13131
  arxiv: 2506.13131 (v1, sole version; white paper, not peer-reviewed)
sources:
  pdf:  # → store; pinned to v1
    url: https://arxiv.org/pdf/2506.13131v1
    archived: https://web.archive.org/web/20250705213148/https://arxiv.org/pdf/2506.13131
    # bare-pointer record, verified byte-identical to the pinned download
    # (v1 is the only version the pointer ever served)
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "Evolution as the harness that converts test-time compute into discovery: only executed, scored code persists, sidestepping hallucination — within evaluator reach, and only there."
---

# AlphaEvolve: A coding agent for scientific and algorithmic discovery

DeepMind white paper (June 2025) for the discovery-by-evolution
pillar of AI4Math: an evolutionary coding agent where frontier LLMs
are the mutation operator over entire codebases, and a programmatic
evaluator grounds every generation. The loop: a program database
(MAP-elites plus island populations, balancing quality with
diversity) feeds a prompt sampler (parent program, high-scoring
"inspirations", optional context up to PDFs, and self-evolved meta
prompts); an LLM ensemble proposes SEARCH/REPLACE diffs to code
marked with EVOLVE-BLOCK comments; an evaluator cascade scores
survivors, with multi-metric scoring used deliberately as a
diversity mechanism even when one metric is the target. Against
FunSearch, its predecessor: whole files instead of one Python
function, any language, hours-long parallel evaluations, thousands
rather than millions of samples, and — per the ablations — real
benefit from stronger base models. Every component ablates positive
(evolution, prompt context, meta-prompts, full-file scope, model
strength).

## Results across three registers

- **Algorithm discovery.** 14 matrix-multiplication SOTA
  improvements, headlined by 4×4 complex matrices in 48
  multiplications — the first improvement over Strassen's recursive
  49 in characteristic 0 in 56 years (AlphaTensor's 47 was mod-2
  only). Found by evolving a *tensor-decomposition search program*
  (loss shaping, hallucination noise, discretization annealing —
  Fig. 4's 15-mutation diff), not the algorithm directly.
- **Open mathematics.** 50+ construction problems curated with
  external mathematicians (Gómez-Serrano, Tao): best-known matched
  on ~75%, improved on ~20% — including Erdős's minimum overlap
  problem and the kissing number in 11 dimensions (593, from 592).
  The method insight: evolve *search heuristics* rather than
  constructions, chaining specialized heuristics (coarse gains
  early, fine-tuning late) each seeded with the predecessor's best
  construction.
- **Production infrastructure.** A Borg scheduling heuristic
  recovering 0.7% of fleet compute (deployed; chosen over deep RL
  explicitly for interpretability and debuggability), Gemini kernel
  tiling heuristics (23% kernel speedup, 1% training-time reduction,
  months of tuning → days), a TPU Verilog simplification, and 32%
  FlashAttention IR speedup. The deployed-in-production register is
  what separates this from demo papers — and includes the reflexive
  loop of Gemini optimizing its own training stack, which the
  discussion is careful to size honestly: gains moderate, iteration
  cycle months.

## Assessment

- **Durable:** evolution as the harness that converts test-time
  compute into discovery, with the evaluator sidestepping
  hallucination entirely (only executed, scored code persists —
  verification-before-persistence at population scale,
  [[wang2023-voyager]]'s rule with the critic replaced by ground
  truth); the evolve-the-searcher abstraction choice; multi-metric
  scoring as diversity pressure; the
  solution-vs-constructor-vs-searcher abstraction menu.
- **Era-bound:** model roster, every specific record (the math details
  were deferred to a follow-up paper), and the white-paper genre — no
  peer review, self-reported infra numbers.
- **Boundary:** stated by the authors (automated evaluators only) and
  sharpened by [[jiang2026-solvers]] —
  score-function-driven exploration is bound to predefined objectives,
  transfers no structure across problems, and invents no concepts; it
  widens search, not understanding. That critique coexists with this
  shelf's strongest counterpoint to it: within evaluator reach, the
  system produced provably correct, humanly-verified new mathematics.
- **In this library:** in
  [[liu2026-agent-taxonomy]]'s taxonomy this is
  the canonical artifact-locus system, and its complement is
  [[hubert2025-alphaproof]]:
  AlphaProof searches proof space under a fixed verifier, AlphaEvolve
  searches object space under a fixed scorer — proofs of statements
  versus witnesses for bounds, the two halves of what
  [[openai2026-math-advances]]-style claims must
  eventually integrate.
