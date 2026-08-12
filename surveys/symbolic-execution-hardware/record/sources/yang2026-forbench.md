---
citekey: yang2026-forbench
work:
  title: "Forbench: Symbolic Simulation Helps Make Your Testbench More Formal"
  author: "Ziyi Yang, Wenbin Che, Ziyue Zheng, Guangyu Hu, Hongce Zhang"
  venue: "ICCAD 2026 (forthcoming preprint)"
  date: 2026
  arxiv: 2608.01045
read: full-text
source: "arXiv v1, https://arxiv.org/pdf/2608.01045v1"
canonical-note: library/papers/2026/yang2026-forbench/notes.md
retrieved: 2026-08-08
notes-by: Codex GPT-5.6 Sol (survey adversarial revision)
notes-date: 2026-08-12
synthesis: "Forbench symbolically steps a clocked RTL transition model but forks only procedural testbench conditions while merging design alternatives into expressions; that makes it a close E3 comparator rather than a design-path executor under the sharpened third condition."
---

# Forbench: Symbolic Simulation Helps Make Your Testbench More Formal

## Evidence

- Section 4 and Algorithm 1 represent RTL as a transition system and maintain
  symbolic states across bounded clock steps.
- Section 4.3 makes the decisive choice explicit: the runtime forks at
  testbench `wait_cond` decisions, not at design branches. Design alternatives
  remain merged in symbolic expressions; SAT checks choose or split coroutine
  control.
- Section 4.4 offers user-supplied abstraction predicates for merging difficult
  testbench forks; Section 4.5 notes backward simulation and symbolic initial
  states.
- Tables 2–4 report simulation speed, branch coverage, and injected-bug results
  over five processor/datapath designs, ITC'99 and processor modules, and ten
  micro-RISC-V bugs, all under bounded configurations.

## Bearing on RQs

- **RQ1 / boundary:** Forbench satisfies symbolic-value and feasibility
  conditions, but the distinguished paths are procedural testbench paths. The
  executed design representation does not preserve design-branch path
  identities, so the paper fails condition 3 and is E3.
- **RQ2:** the executor steps a Yosys-derived BTOR2 transition model through a
  Python-facing simulation interface. Its design/operational bridge is clear
  enough for symbolic simulation claims, but does not alter the path boundary.
- **RQ3:** it demonstrates the practical benefit of deliberately leaving
  design alternatives in formulas while exposing only a smaller testbench
  frontier.
- **RQ4/RQ5:** positive bug witnesses and bounded coverage are useful evidence;
  “full” coverage and usability claims remain qualified by cycle bounds,
  baselines, authored testbenches, and the absence of a user study.

## Evidence limits

The version read is a 2026 preprint for a forthcoming venue. Its comparisons
span symbolic simulation, STE, BMC, and concrete simulation with different
contracts. The boundary judgment is about the method's native path identity,
not its engineering value or its ability to find bugs.
