# Exhaustive Enumeration of Selection Observations in Pure Dataflow Graphs

This repository contains a theory-backed survey and formal synthesis of
exhaustive symbolic enumeration for finite pure dataflow graphs. The subject is
not merely constructing one symbolic value or one SMT encoding: it is
enumerating every distinct **selection observation** with exact guards and
residual values while omitting selections in unobserved case cones. Starting at
the requested result, the observation traversal follows every operand of a
strict operator and only the selected cases of a selection operator. A
formal development connects this observer to established semantic and
enumeration machinery and serves as a unifying lens across the surveyed
literatures.

## Current phase

The repository now maintains a living survey. Its initial systematic-map
baseline is closed relative to the captured sources, queries, rankings, and
4 August 2026 access date; later research is incorporated through registered
recurring searches and citation refreshes. This is not a claim of worldwide
literature completeness.

Start with [`research/survey/README.md`](research/survey/README.md) for the file
map and update lifecycle, or inspect current freshness directly:

```console
./dev.sh python3 scripts/survey/update.py status
```

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

The first invocation builds the image from `ubuntu:24.04`, using the latest
successful `main` development image from GitHub Container Registry as a cache
when it is accessible; later invocations reuse the local image. Pass `--build`
after changing the Dockerfile or when an explicit rebuild is wanted:

```console
./dev.sh --build ./scripts/check.sh
```

The same command compiles `manuscript/main.typ` to
`build/manuscript.pdf` and verifies that the PDF contains extractable text.
GitHub Actions interprets the same `.devcontainer/devcontainer.json` through
the Dev Containers CLI and publishes successful `main` images as
`ghcr.io/qobilidop/dataflow-selection-enumeration/dev`.

To stage the next due literature searches without committing unfinished
results:

```console
./dev.sh python3 scripts/survey/update.py fetch --due
```

The staged batch is written under `.scratch/`; the survey update guide defines
the screening and promotion steps.

### Downloading the PDF from GitHub

The [paper website](https://qobilidop.github.io/dataflow-selection-enumeration/)
links to the latest manuscript and the public research record. The PDF is also
available [directly](https://qobilidop.github.io/dataflow-selection-enumeration/manuscript.pdf).
The **Verify survey and build paper** workflow republishes the website and PDF
to GitHub Pages after every successful push to `main`.

The **Verify survey and build paper** workflow builds and verifies the
manuscript on every push to `main`, on pull requests, and when started manually
from the Actions tab. To download its result:

1. Open the repository's **Actions** tab.
2. Select **Verify survey and build paper** and open a successful workflow run.
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
