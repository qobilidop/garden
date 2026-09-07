---
author: Claude Fable 5.1
---

# Surveys move to their own repositories

Bili's decisions: each survey is a self-contained, resumable repository
with its own copy of the `run-survey` skill, evolving independently (no
shared skill repository, no submodule); garden lists surveys in the
portfolio and nothing more; GitHub Pages serves the manuscripts; the
archived `dataflow-selection-enumeration` repository is reused.

## What moved where

- `surveys/<slug>/` → `github.com/qobilidop/<slug>` with history
  (`git filter-repo --subdirectory-filter`; the two new repositories
  also carry the skill's history via `--path`). `index.md` became
  `README.md`; the style and stylesheet sit in `manuscript/`; the
  validator, update tool, and build run from the repository root; CI
  builds the same dev image as `dev.sh` and deploys to Pages.
- Garden dropped `surveys/`, `skills/run-survey/`, the manuscript
  build, `paper.css`, and the survey collection, pages, backlinks, and
  recency. `portfolio/portfolio.yaml` (zod-checked by
  `site/src/lib/portfolio.ts`) now feeds the portfolio page;
  `site/public/_redirects` maps every old survey URL; five `[[slug]]`
  links in wiki and library became plain URLs.

## Findings

- The absorbed history round-trips. Garden's absorbed side was the
  old repository's commits re-rooted under `surveys/` with only the
  GPG signatures stripped, trees identical at the absorption point.
  Replaying the garden-era commits onto the real signed commit and
  merging the pointer tip with `-s ours` made the push a fast-forward;
  no force push, signed history intact.
- Docker Desktop does not share the agent's temp scratchpad
  directory: the bind mount came up empty inside the container with no
  error. Assemble a repository that needs the dev image in a shared
  location from the start.
- Without garden's `.gitleaks.toml` allowlist the same source notes
  trip `generic-api-key`; each repository now carries the allowlist
  and gitleaks hooks armed by `dev.sh`.
- One cross-repository delegation: the hardware log delegated a Sylvia
  bibliography decision to the dataflow log. It stays verifiable
  offline through a verbatim excerpt under `record/external/`, mapped
  by `external_decision_homes` in the local `check.py`; the log rows
  themselves are untouched history.
- Section files imported the shared style by a deeper relative path
  than the wrapper; a grep for the wrapper's import missed them and
  only the typst build caught it. Sweep imports at every depth.
- License: the pre-move repository reserved all rights; garden's
  CC BY 4.0 + MIT carried into all three, since the content has been
  public under them since August.
