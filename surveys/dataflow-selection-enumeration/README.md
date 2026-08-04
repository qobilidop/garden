# Symbolic Evaluation of Pure Dataflow Graphs

This repository contains the research record and eventual paper on exhaustive,
demand-sensitive symbolic evaluation of finite pure dataflow graphs. The work
begins with a systematic survey and novelty audit; the manuscript follows only
after the terminology and theoretical contribution survive that audit.

The implementation that motivated the research lives in the separate
[`xlsynth-symex`](https://github.com/qobilidop/xlsynth-symex) repository. XLS is
an eventual case study, not the definition of the research problem.

## Current phase

The project is in the survey phase. See [`research/README.md`](research/README.md)
for the evidence workflow and [`research/survey/protocol.md`](research/survey/protocol.md)
for the review protocol.

## Development

Run repository checks inside the development container:

```console
./dev.sh ./scripts/check.sh
```

The local `.scratch/` directory is ignored and may hold downloaded papers,
search exports, or temporary notes. Durable findings must be distilled into the
committed research record.
