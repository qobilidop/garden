---
citekey: jiang2022-draft-sketch-and-prove
work:
  title: "Draft, Sketch, and Prove: Guiding Formal Theorem Provers with Informal Proofs"
  author: Albert Q. Jiang, Sean Welleck, Jin Peng Zhou, et al. (9 authors; Meta AI, Cambridge, UW/AI2, Google, Cornell, Stanford)
  venue: ICLR 2023
  date: 2022-10-21
  doi: 10.48550/arXiv.2210.12283
  arxiv: 2210.12283 (v3, 2023-02-20, camera-ready — header confirms ICLR 2023)
sources:
  pdf:  # → store; pinned to v3
    url: https://arxiv.org/pdf/2210.12283v3
    archived: https://web.archive.org/web/20260723021031/https://arxiv.org/pdf/2210.12283
    # bare-pointer record captured while it served v3, verified byte-identical
    # to the pinned download (no snapshot of the v3 URL itself exists)
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "Draft–sketch–prove operationalizes Wiedijk's proof sketches: neural proposes structure, symbolic closes rigor — the division of labor every informal-guided prover since inherits."
---

# Draft, Sketch, and Prove: Guiding Formal Theorem Provers with Informal Proofs

The paradigm paper for informal-guided formal proving (ICLR 2023;
equal-contribution leads Jiang, Welleck, Zhou). The architecture is a
three-stage pipeline: **draft** an informal proof (by a human or an
LLM), **sketch** it into a formal proof skeleton via few-shot
prompting — intermediate conjectures stated, justifications left as
holes — and **prove** the holes with an off-the-shelf automated
prover (Sledgehammer plus eleven heuristic tactics, in Isabelle).
The design premise: formal data is scarce (the largest corpus,
Isabelle's, was under 0.6 GB) but informal mathematics is abundant,
and prior neural provers couldn't capitalize on it. On miniF2F the
method nearly doubles the automated prover's success rate — 20.9% →
39.3% (test) with human drafts, 38.9% with Minerva-540B drafts —
then-SOTA for Isabelle. Why it's foundational:
[[jiang2026-from-solvers-to-research]] invokes it in three separate
sections, and the decomposition lineage (DeepSeek-Prover-V2's
subgoals, Seed-Prover's lemma style, Hilbert's recursion to 99.2%)
descends from this structure.

## What the ablations locate

The automated prover matters most (−9.0 test points without it),
informal drafts second (−5.3), in-line comments aligning informal
segments to formal blocks third (−2.8). So the load-bearing insight
is not "LLMs can write formal proofs" but the *division of labor*:
the LLM contributes structure (the sketch mirroring the informal
argument), symbolic automation contributes rigor at the leaves. Two
contrasts with the [[polu2020-generative-language-modeling-for-automated-theorem-proving]]
line: DSP constructs the whole proof structure in one decoding pass
instead of thousands of search expansions (~100 model queries per
problem versus ~1k GPU-hours per evaluation), and it uses a huge
general model few-shot (Codex, 175B-class) where the search line
fine-tuned small specialists.

## The findings that aged best

- **Diversity beats ground truth at scale.** One IMO problem
  (imo_1959_p1) fell to a Minerva draft but not the human proof; at
  200 autoformalization attempts, 100 sampled LLM drafts solve more
  problems (209) than one human draft resampled (203). Budget
  allocation confirms it: more drafts per problem beats more
  sketches per draft.
- **Formal validity is robust to informal error.** Of 50 audited
  Minerva drafts that yielded valid formal proofs, only 58% were
  fully correct informally; 21 flawed drafts still succeeded — 13
  because the prover ignored them, 8 because the autoformalizer
  *corrected* the flawed step in translation. The mirror image of
  the specification-fidelity problem: here the formal layer rescues
  the informal one, at the price that a checked proof tells you
  little about the draft that guided it.
- **The bottleneck migrates.** Minerva 62B drafts guide as well as
  540B drafts — draft quality stopped being limiting; sketching and
  gap-proving became the constraint. An early sighting of the
  pattern where scaling one pipeline stage just moves the wall.

## Assessment

- **Durable:** the draft–sketch–prove decomposition itself; the sketch
  as the interface object between informal and formal (Wiedijk's proof
  sketches, operationalized); the neural-proposes/symbolic-closes
  division of labor; the diversity-over-correctness economics.
- **Era-bound:** the model roster (Codex, Minerva),
  Isabelle/Sledgehammer specifics, and every number — miniF2F is now
  saturated at 99.6% by descendants of exactly this recipe fused with
  the search line's expert iteration.
- **Caveats (half-acknowledged by the paper):** the correctness audit
  is n=50 and manual; the "autoformalizer corrects errors" claim rests
  on 8 cases; and the human-draft baseline is one proof per problem
  versus 100 samples, so the headline human-vs-model comparison
  conflates draft quality with draft count.
- **In this library:** in
  [[openai2026-ten-advances-in-mathematics]]'s disclosed workflow
  (model arguments → human-assisted manuscripts → Lean formalization)
  the DSP shape is recognizable at research scale — which also imports
  its caveat: the formal artifact certifies the endpoint, not the
  narrative that produced it.
