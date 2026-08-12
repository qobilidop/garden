---
citekey: tan2026autoverifix
work:
  title: "AutoVeriFix+: High-Correctness RTL Generation via Trace-Aware Causal Fix and Semantic Redundancy Pruning"
  author: Yan Tan; Xiangchen Meng; Zijun Jiang; Yangdi Lyu
  venue: arXiv
  date: 2026
  arxiv: 2603.11489
read: full-text
source: https://arxiv.org/abs/2603.11489
facets: "relation: core; artifact: rtl; execution: concolic; goal: functional; evidence: experiment"
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: AutoVeriFix+ contains a genuine concolic RTL stage inside an LLM repair loop, but near-complete branch coverage and a generated oracle do not justify exhaustive correctness.
---

# AutoVeriFix+: High-Correctness RTL Generation via Trace-Aware Causal Fix and Semantic Redundancy Pruning

## Evidence

- Stage 3 instruments generated Verilog basic blocks and registers, concretely simulates cycle-indexed paths, and records branch IDs plus state snapshots (Section III.C–D; Listings 1 and Figures 6–7).
- The concolic engine selects an uncovered branch, extracts cumulative constraints through the observed prefix, negates the target predicate, invokes SMT, and re-simulates the returned vector. This is the load-bearing mechanism that distinguishes the paper from trace-only RTL repair (Section III.D.1–2).
- Concolic tests drive differential checking against an LLM-generated Python model and furnish cycle-accurate debug feedback to a second LLM. Uncovered branches are only potential pruning candidates, and deletion is tested again rather than proved semantics-preserving (Section III.D.3–4).
- Experiments on VerilogEval and RTLLM report near-100% branch coverage after concolic refinement, reduced false-positive rates, pass@k changes, and gate-count pruning. The paper’s “exhaustive” language exceeds its own timeout/state-explosion caveats (Section IV; Tables II–VI and Figures 10–11).

## Bearing on RQs

- **RQ1:** AutoVeriFix+ is core concolic hardware execution even though its primary application is LLM RTL repair.
- **RQ2:** It operates directly on generated Verilog, with Python used only as a functional oracle.
- **RQ3:** Seed refinement, branch mutation, and iterative repair guide exploration; no completeness result follows.
- **RQ4–RQ5:** Coverage and differential matches are test evidence. They are conditioned on the generated oracle, test bounds, and solver completion.

## Evidence limits

- The March 2026 arXiv manuscript is a preprint. It omits enough concolic implementation detail to independently reproduce RTL constraint extraction.
- The Python reference is LLM-generated and therefore not an authoritative specification; reported correctness and false-positive results inherit oracle error.
- Near-100% branch coverage does not justify calling uncovered logic unreachable or safe to remove.
