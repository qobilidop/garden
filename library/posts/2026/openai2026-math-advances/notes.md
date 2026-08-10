---
citekey: openai2026-math-advances
work:
  title: Ten advances in mathematics and theoretical computer science
  author: OpenAI
  date: 2026-08-01
source:
  url: https://openai.com/index/ten-advances-in-mathematics/
  archived: https://web.archive.org/web/20260806092810/https://openai.com/index/ten-advances-in-mathematics/
  # capture is the archive's original-content record (origin 403s non-browser
  # clients); text verified identical to the live page at retrieval
discussions:
  - https://x.com/SebastienBubeck/status/2083456300692979886  # 2026-08-01
  - https://www.reddit.com/r/singularity/comments/1vcgutk/  # 2026-08-01
  - https://www.reddit.com/r/mathematics/comments/1vcgwiu/  # 2026-08-01
  - https://www.reddit.com/r/math/comments/1vch950/  # 2026-08-01
  - https://www.reddit.com/r/slatestarcodex/comments/1vcha0r/  # 2026-08-01
  - https://x.com/polynoamial/status/2083467194663571701  # 2026-08-01
  - https://news.ycombinator.com/item?id=49157930  # 2026-08-03
  - https://x.com/OpenAI/status/2084352165464903730  # 2026-08-03
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-07
synthesis: "The evidentiary weight rests entirely on Lean certificates neutralizing corporate-claim skepticism — modulo statement fidelity — and the disclosed workflow is draft-sketch-prove's shape at research scale."
---

# Ten advances in mathematics and theoretical computer science

Org-authored announcement post, not a technical exposition: OpenAI claims
ten results, each resolving or making substantial progress on a
long-standing open problem in mathematics or theoretical computer science,
produced by an internal version of Astra ("our next major model"). The
mathematical substance lives in three linked artifacts — the paper
(cdn.openai.com/pdf/ten-proofs-oai.pdf), per-solution reasoning
walkthroughs (cdn.openai.com/pdf/reasoning-walkthroughs.pdf), and Lean
certificates (github.com/openai/ten-proofs). The post itself is the
milestone claim, the workflow description, and a positioning statement.

## The claims

The ten problems span high-dimensional geometry, coding theory, arithmetic
circuit complexity, group theory, operator algebras, quantum complexity,
lattice cryptography, and extremal combinatorics: sphere-packing upper
bounds down to the Cohn–Elkies threshold; exponentially improved
binary/spherical code bounds; existence of non-sofic groups; disproof of
Connes's rigidity conjecture; permanent lower bounds (arithmetic-formula
bound of order n⁴/log n); exponential quantum parallel repetition;
polynomial-factor CVP hardness of approximation; Ehrhart's volume
conjecture in every dimension; superexponential multicolor triangle Ramsey
lower bound (Erdős problem 183); and the compactness and degeneracy
conjectures in extremal graph theory (Erdős problems 146 and 180).

The disclosed workflow: the model generated the mathematical arguments
(total solution-finding compute "roughly $2,000 at Sol API rates" — a
deliberately provocative number); humans prepared the manuscripts with the
same model; the model then formalized each argument in Lean, making
correctness machine-checkable rather than resting on the company's
say-so. A per-solution "narration of its thinking process" is also
released. Context given: this follows the May 2026 AI-generated disproof
of the Erdős unit-distance conjecture, which the footnote credits with
inspiring five named follow-up papers by human mathematicians.

## Positioning

A "Responsibility to the mathematical community" section stakes out an
attribution ethic — claiming human authorship for an AI-generated proof
"would misrepresent both the system's contribution and the nature of
genuine human intellectual work" — explicitly acknowledges the Leiden
declaration signers, and takes responsibility for correctness while
crediting the arguments to the system. The post bookends with access
framing (ChatGPT for Academic Researchers, 100k free seats).

## Assessment

A primary source for a capability milestone, thin by design: no
mathematics is exhibited, so the post's evidentiary weight rests entirely
on the linked paper and the Lean certificates — the latter being the
load-bearing move, since machine-checked proofs neutralize the usual
skepticism about corporate research claims (modulo checking that the
formal statements match the informal ones).

- **Durable:** the workflow shape (model-generated arguments →
  human-assisted manuscripts → Lean formalization → released reasoning
  traces) and the attribution stance, which is an early, explicit
  position in a live dispute.
- **Era-bound:** model/pricing specifics and the access-initiative
  framing.
- **In this library:** in [[liu2026-agent-taxonomy]]
  terms, this is the loop closing on science rather than benchmarks. If
  the mathematical content becomes relevant, the paper itself is the
  thing to ingest as a papers/ entry; this entry records the
  announcement.
