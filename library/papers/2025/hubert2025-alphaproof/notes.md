---
citekey: hubert2025-alphaproof
work:
  title: Olympiad-level formal mathematical reasoning with reinforcement learning
  author: Thomas Hubert et al. (39 authors, Google DeepMind; senior author David Silver)
  venue: Nature 651, pp. 607-613 (print issue 2026-03-19)
  date: 2025-11-12
  doi: 10.1038/s41586-025-09833-y
sources:
  pdf: https://www.nature.com/articles/s41586-025-09833-y.pdf  # → shadow; open-access version of record
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "AlphaProof is verifier-grounded RL at AlphaZero scale plus test-time RL on problem variants — IMO silver at a compute scale beyond academia, with competition math's fixed concept library marking where research mathematics begins."
---

# Olympiad-level formal mathematical reasoning with reinforcement learning

The AlphaZero-of-mathematics paper (Nature, Nov 2025; 39 DeepMind
authors, Silver as senior author) — the formal write-up, sixteen
months later, of the IMO 2024 silver-medal result the field had been
citing from a blog post. Lean's tactic mode is cast as an RL
environment (state = tactic state, action = tactic string, reward −1
per step), a 3B encoder–decoder proof network provides policy and
value, and an AND–OR adaptation of AlphaZero's PUCT search explores
proofs. Everything else is scale and two genuinely new mechanisms:
fidelity-agnostic auto-formalization for training, and test-time RL.

## The training pipeline

300B tokens of code/math pretraining → SFT on ~300k Mathlib
state–tactic pairs → the main RL loop: a Gemini-based formalizer
translated ~1M natural-language problems into **~80M formal Lean
statements**, and a matchmaker randomly assigns actors to *prove or
disprove* each. The design insight the paper states plainly: an
auto-formalized statement is useful training signal *regardless of
its fidelity* to the original problem — mistranslations are still
well-formed formal statements. A beautiful inversion of the
specification-fidelity problem [[jiang2026-solvers]]
documents on the evaluation side: infidelity poisons benchmarks but
feeds curricula. Main RL ran ~80,000 TPU-days, and its yield is
partly *efficiency*: the final agent reaches ~30% on historical IMO
problems with 300 search simulations, a level earlier checkpoints
could not reach with vastly more search — training compute converted
into inference-time competence.

## Test-time RL

For problems unsolved by search scaling, TTRL generates ~400k
problem-specific variants (simplifications, generalizations) and
runs the same RL loop on that bespoke curriculum — per problem,
for days. It adds ~15 absolute points over 12-TPU-hour search on
both formal-imo (43.7 → 58.3%) and PutnamBench-test (39.4 → 56.1%),
and it is what solved the IMO problems (2–3 days each). This is a
third scaling axis — beyond model and search — and the paper's most
distinctive methodological contribution: adaptation as inference.

## Results and the trust machinery

miniF2F-test 99.6% (on a corrected dataset, with the caveat stated),
PutnamBench-test 56.1% versus 5.3% for DeepSeek-Prover-V2. At IMO
2024: P1, P2, P6 solved (P6, the hardest, solved by five human
contestants), plus AlphaGeometry 2's P4 — 28/42, silver, one point
under gold. Answer-finding used Gemini to guess candidates and
AlphaProof to *refute* the wrong ones — disproof as a filter, an
operational use of formal negation. The engineering discipline is
noteworthy for this shelf: every found proof gets an independent
final check by the standard Lean toolchain plus an axiom audit
(exactly three accepted axioms), the internalSorry machinery is
scoped private, and the team's custom lemmas were upstreamed into
Mathlib. The trust chain
[[demoura2026-kernel-soundness]] stress-tests is
being consciously operated here.

## Assessment

- **Durable:** verifier-grounded RL at scale as the experience-based
  pillar of AI4Math (versus the human-corpus pillar of
  [[polu2020-gpt-f]],
  which it cites as the origin of the line, and the informal-guided
  pillar of [[jiang2022-draft-sketch-prove]]); TTRL; the
  fidelity-agnostic curriculum; the minimum-return objective over
  AND-subgoals (incentivizing balanced decompositions — a small design
  gem).
- **Era-bound:** every compute figure, and the headline itself —
  Gemini Deep Think reached gold within a year (the paper's own
  timing: received June 2025, eleven months after the result it
  reports).
- **Limitations (stated by the authors):** multi-day inference against
  humans' 4.5 hours; a scale "likely beyond most academic groups";
  combinatorics unsolved (P3/P5 — and formal-imo combinatorics at
  20.3% vs ~73–76% for algebra/NT, the same domain gap
  [[jiang2026-solvers]]'s tables show field-wide);
  and the closing admission that competition math has a fixed concept
  library, while research mathematics requires theory building — the
  exact boundary the solvers-to-researchers survey draws.
- **In this library:** in
  [[liu2026-agent-taxonomy]]'s terms, the loop
  here closes on competition benchmarks with perfect verification;
  what lies beyond it is conjecture generation, which is
  [[novikov2025-alphaevolve]]'s territory.
