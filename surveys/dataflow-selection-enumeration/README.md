# Exhaustive Enumeration of Selection Observations in Pure Dataflow Graphs

This repository contains a theory-backed survey and formal synthesis of
exhaustive symbolic enumeration for finite pure dataflow graphs. The subject is
not merely constructing one symbolic value or one SMT encoding: it is
enumerating every distinct **selection observation** with exact guards and
residual values while omitting selections in unobserved case cones. Starting at
the requested result, the observation traversal follows every operand of a
strict operator and only the selected cases of a selection operator. A
novelty audit found that the original broad theory proposal decomposes into
established semantic and enumeration machinery; the formal development is
therefore retained as a unifying lens rather than presented as a new
foundational calculus.

## Current phase

The systematic map is closed under its recorded protocol, and the formal
synthesis is available as a complete manuscript. Closure is relative to the
captured sources, queries, rankings, and 4 August 2026 access date; it is not a
claim of worldwide literature completeness. See
[`research/README.md`](research/README.md) for the evidence workflow and
[`research/survey/protocol.md`](research/survey/protocol.md) for the review
protocol.

## Authorship and AI assistance

Bili Dong is the sole author of record and is responsible for the manuscript.
OpenAI Codex (GPT-5.6 Sol) provided substantial assistance with literature-search
planning, evidence organization, cross-paper synthesis, formal presentation,
manuscript drafting and editing, and repository tooling. The manuscript remains
a draft under continuing human review. AI output is not treated as evidence;
literature claims are intended to rest on the cited primary sources and the
accompanying evidence record.

## Development

The manuscript is written in Typst and uses the repository's BibTeX database
directly. Run repository checks inside the development container:

```console
./dev.sh ./scripts/check.sh
```

The first invocation builds the image from `ubuntu:24.04`; later invocations
reuse that local image. Pass `--build` after changing the Dockerfile or when an
explicit rebuild is wanted:

```console
./dev.sh --build ./scripts/check.sh
```

The same command compiles `manuscript/main.typ` to
`build/manuscript.pdf` and verifies that the PDF contains extractable text.

### Downloading the PDF from GitHub

The [paper website](https://qobilidop.github.io/dataflow-selection-enumeration/)
links to the latest manuscript and the public research record. The PDF is also
available [directly](https://qobilidop.github.io/dataflow-selection-enumeration/manuscript.pdf).
The **Build paper** workflow republishes the website and PDF to GitHub Pages
after every successful push to `main`.

The **Build paper** workflow builds and verifies the manuscript on every push
to `main`, on pull requests, and when started manually from the Actions tab.
To download its result:

1. Open the repository's **Actions** tab.
2. Select **Build paper** and open a successful workflow run.
3. In that run's **Artifacts** section, download **manuscript-pdf**.

The downloaded archive contains `manuscript.pdf`. Artifacts are retained for
90 days. A manual build can be started with **Run workflow** on the workflow's
Actions page.

[`CITATION.cff`](CITATION.cff) contains machine-readable metadata for citing a
specific repository revision. [`REPRODUCIBILITY.md`](REPRODUCIBILITY.md) records
the pinned build inputs and PDF accessibility limitation, and [`LICENSE`](LICENSE)
states the current rights status while the manuscript remains under review. No
versioned release is currently designated.

The local `.scratch/` directory is ignored and may hold downloaded papers,
search exports, or temporary notes. Durable findings must be distilled into the
committed research record.
