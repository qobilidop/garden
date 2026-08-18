---
citekey: trinh2024-alphageometry
work:
  title: Solving olympiad geometry without human demonstrations
  author: Trieu H. Trinh, Yuhuai Wu, Quoc V. Le, He He, Thang Luong (Google DeepMind, NYU)
  venue: Nature 625, pp. 476-482
  date: 2024-01-17
  doi: 10.1038/s41586-023-06747-5
sources:
  pdf: https://www.nature.com/articles/s41586-023-06747-5.pdf  # → shadow; open-access version of record
    # Nature stamps each download, so live fetches are never byte-identical;
    # the stored blob came from a verified existing Wayback capture
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "AlphaGeometry makes the neural-proposes/symbolic-closes split architectural and answers data scarcity with synthetic data from symbolic exploration — but the claim's scope lives in the DSL's translation layer."
---

# Solving olympiad geometry without human demonstrations

The neuro-symbolic landmark (Nature, Jan 2024; the field's most
rigorously reviewed result — submitted April 2023, six months in
review). AlphaGeometry solves 25 of 30 IMO geometry problems
(IMO-AG-30), against 10 for the prior state of the art (Wu's method)
and a rescaled human scale of bronze 19.3 / silver 22.9 / gold 25.9 —
between silver and gold, with solutions the USA IMO coach graded at
full marks for the 2000 and 2015 papers. Its foundational value is
two clean separations: *what the neural part is for* (generating
exogenous terms — auxiliary constructions, geometry's instance of the
infinite-branching problem GPT-f named) and *where training data can
come from* (pure synthetic exploration — no human demonstrations
anywhere in the pipeline).

## The method

Synthetic data: sample ~1B random theorem premises from a
constructive diagram language; run the symbolic engine (DD — Horn
-clause deductive database — plus AR, a new Gaussian-elimination
algebraic-chasing component) to deduction closure; trace back each
reachable conclusion to its minimal premises. The **dependency
difference** — premises the conclusion's objects don't depend on —
becomes the auxiliary-construction part of the proof, which is the
part symbolic engines cannot generate. Result: 100M unique
theorem/proof pairs, 9% requiring auxiliary constructions; the
transformer pretrains on all of it and fine-tunes on that 9%.
Inference is a turn-taking loop: the engine exhausts its closure;
if unsolved, the LM proposes one auxiliary construction; repeat,
under beam search. Everything deductive is delegated to the exact
engine; the LM contributes only what deduction can't reach.

## What the numbers decompose into

The ablation ladder is the paper's real argument: DD alone 7 →
DD+AR 14 (the algebraic-chasing engine is itself a new *symbolic*
SOTA, +4 over the prior best, a contribution buried in the baseline
table) → +human heuristics 18 → +learned auxiliary construction
**25**. GPT-4 scores 0/30 (with contamination caveats the authors
flag themselves). Robustness: 20% of the data or 2% of the search
budget (beam 8 vs 512) still yields 21 — the capability is not
knife-edge. And one genuinely novel artifact: the traceback's
minimal-premise extraction found an *unused premise* in translated
IMO 2004 P1, yielding a strictly more general theorem than the
competition asked — discovery as a by-product of minimality, not of
search.

## Assessment

- **Durable:** the division of labor (neural proposes exogenous terms,
  symbolic closes deduction — the same split
  [[jiang2022-draft-sketch-prove]] found at the tactic level, here
  made architectural); synthetic-data-from-symbolic-exploration as the
  answer to data scarcity, one step more radical than
  [[polu2020-gpt-f]]'s
  human-corpus training; traceback minimality as a generalization
  mechanism.
- **Era-bound:** the model and search scale, GPT-4 as the LLM
  baseline, and the result itself — AlphaGeometry2 reached gold-level
  geometry within a year (per [[jiang2026-solvers]],
  which defers geometry methods to an appendix precisely because the
  DSL makes them hard to generalize from).
- **Caveats (stated plainly by the paper):** IMO-AG-30 is
  *translations* into a narrow domain-specific language covering 75%
  of IMO geometry — the specification layer is where the claim's scope
  lives, the same statement-fidelity boundary the [[ai4math]] shelf tracks
  everywhere else; the comparison to humans is "approximate" by the
  authors' own framing.

What is not approximate is the machine-vs-machine ladder, and that
ladder is the durable evidence that neural guidance plus symbolic
exactness beats either alone.
