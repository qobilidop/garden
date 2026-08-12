---
citekey: ryan2023sylvia
work:
  title: "Sylvia: Countering the Path Explosion Problem in the Symbolic Execution of Hardware Designs"
  author: "Kaki Ryan, Cynthia Sturton"
  venue: "FMCAD 2023"
  date: 2023
  doi: 10.34727/2023/isbn.978-3-85448-060-0_19
read: full-text
source: "Version of record, https://doi.org/10.34727/2023/isbn.978-3-85448-060-0_19"
canonical-note: surveys/dataflow-selection-enumeration/record/sources/ryan2023sylvia.md
retrieved: "-"
notes-by: Codex GPT-5.6 Sol (survey adversarial revision)
notes-date: 2026-08-12
synthesis: "Sylvia independently explores RTL path fragments, composes compatible fragments with SMT, and returns replayable witnesses; its construction reduction is real, but the fragment cross-product keeps end-to-end solver work exponential in the paper's own model."
---

# Sylvia: Countering the Path Explosion Problem in the Symbolic Execution of Hardware Designs

## Evidence

- Sections II.B–II.C (pp. 111–112) define an RTL symbolic state and paths over
  synthesizable Verilog.
- Sections III.B–III.C (pp. 113–114) explore sequential blocks independently,
  combine one fragment from each block, conjoin their path conditions and
  partial stores, and use SMT to filter infeasible combinations and recover a
  concrete replay.
- Section III.D (pp. 114–115) distinguishes explored-line and solver-query
  counts. With `N` blocks and at most `b` binary branches per block, local
  exploration is proportional to `N 2^b`, while composition can still require
  `2^(bN)` SMT queries.
- Sections IV and VI (pp. 115–119) describe implementation, cone-of-influence
  pruning, caching, repeated-submodule handling, multi-cycle execution, and an
  evaluation over five designs and 84 properties.

## Bearing on RQs

- **RQ1:** classical symbolic execution composed from explicit path fragments.
- **RQ2:** direct synthesizable-Verilog execution; composition must reconcile
  partial stores and cycle semantics across blocks.
- **RQ3:** demonstrates a genuine reduction in path construction while leaving
  a separate exponential compatibility ledger. This is the main evidence for
  distinguishing executor work from formula/composition work.
- **RQ4:** returns replayable assertion-violation witnesses under bounded RTL
  semantics; failed or untested combinations are not a global proof.
- **RQ5:** reports multi-design implementation evidence, but its headline
  “linear” reduction applies to local exploration rather than total solver
  work.

## Evidence limits

The benchmark and property set supports a systems result, not an architecture-
independent scaling law. Cone-of-influence pruning is block-granular, and the
paper's composition correspondence should not be generalized beyond its RTL
subset, cycle model, and replay checks.
