---
citekey: wong2018variational
work:
  title: "Faster Variational Execution with Transparent Bytecode Transformation"
  author: "Chu-Pan Wong, Jens Meinicke, Lukas Lazarek, Christian Kästner"
  venue: "Proceedings of the ACM on Programming Languages, OOPSLA 2018"
  date: 2018
  doi: 10.1145/3276487
read: abstract-only
source: "Primary arXiv abstract and introduction, https://arxiv.org/abs/1809.04193"
retrieved: 2026-08-09
notes-by: Codex GPT-5.6 Sol (publication-review revision)
notes-date: 2026-08-09
synthesis: "Variational execution represents configuration-dependent values under contexts and shares redundant work across many executions; its native output is a shared multi-configuration execution, not exact selection-observation fiber records."
---

# Faster Variational Execution with Transparent Bytecode Transformation

## Evidence

### Evidence locations

- Abstract and Section 1: variational execution explores many configurations,
  tracks configuration-dependent information, and shares redundant execution.
- Introductory transformation example: conditional values pair alternatives
  with propositional configuration contexts and execute branch code under the
  contexts in which it is relevant.

## Bearing on RQs

Variational execution is a guarded-value and shared-execution predecessor.
Its configuration contexts can represent many executions compactly, but the
paper does not define the survey's requested-root selection observer or emit
one exact guard/residual/witness record per observer fiber.

## Evidence limits

Screened from the primary abstract and introduction. The manuscript uses only
the representation and sharing comparison, not the paper's correctness or
performance results.
