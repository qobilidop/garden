# Symbolic Evaluation of Pure Dataflow Graphs

This repository contains a theory-backed survey of exhaustive, demand-sensitive
symbolic evaluation of finite pure dataflow graphs. A novelty audit found that
the original broad theory proposal decomposes into established semantic and
enumeration machinery; the formal development is retained as a unifying lens
rather than presented as a new foundational calculus.

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
