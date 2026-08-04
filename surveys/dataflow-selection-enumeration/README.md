# Exhaustive Symbolic Enumeration for Pure Dataflow Graphs

This repository contains a theory-backed survey and formal synthesis of
exhaustive symbolic enumeration for finite pure dataflow graphs. The subject is
not merely constructing one symbolic value or one SMT encoding: it is
enumerating every distinct **selection observation** with exact guards and
residual values while omitting selections in inactive case cones. Starting at
the requested result, the observation traversal follows every operand of a
strict operator and only the selected cases of a selection operator. A
novelty audit found that the original broad theory proposal decomposes into
established semantic and enumeration machinery; the formal development is
therefore retained as a unifying lens rather than presented as a new
foundational calculus.

The implementation that motivated the research lives in the separate
[`xlsynth-symex`](https://github.com/qobilidop/xlsynth-symex) repository. XLS is
an eventual case study, not the definition of the research problem.

## Current phase

The project is completing the systematic map and formal synthesis before
drafting the manuscript. See [`research/README.md`](research/README.md) for the
evidence workflow and [`research/survey/protocol.md`](research/survey/protocol.md)
for the review protocol.

## Development

Run repository checks inside the development container:

```console
./dev.sh ./scripts/check.sh
```

The local `.scratch/` directory is ignored and may hold downloaded papers,
search exports, or temporary notes. Durable findings must be distilled into the
committed research record.
