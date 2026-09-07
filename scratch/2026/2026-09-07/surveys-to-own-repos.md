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
  `site/src/lib/portfolio.ts`) now feeds the portfolio page, dated by
  each work's first commit; old `/surveys/…` URLs are not redirected
  (Bili's call); five `[[slug]]` links in wiki and library became
  plain URLs.

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

## Process residue for /evolve

Staged (single occurrence each):

- Absorbed history may round-trip: before force-replacing a reused
  repository, compare the absorbed side's trees and commit objects
  with the original (here only GPG signatures differed), then replay
  and merge instead. Worth a rule if a second absorb/spin-off happens.
- Spin-off checklist for the next spoke repository: history by
  `filter-repo --path`/`--path-rename`, guards carried (gitleaks
  allowlist, hooks armed by `dev.sh`), the same dev Dockerfile for CI
  and host, relative imports swept at every depth, then build in the
  container before the first commit. Three repositories used it once.
- The deeper `.typ` imports were a lapse of the existing
  sweep-by-name rule (AGENTS.md §Conventions), not a gap in it.
- `gh api -X POST repos/<r>/pages -f build_type=workflow` works on an
  empty repository; no first push needed.

Settled (Bili, same day): survey repositories do not carry the evolve
skill. They are projects he works on and produces, not harness; a
campaign's method lessons fold into that repository's own run-survey
skill directly, and garden's /evolve stays the retrospective for the
harness.

## Evolve outcome (run at session end)

Accepted and applied, all four: (1) memory — front-load the steps that
might need Bili; (2) memory hygiene — the retired survey-layer
paragraphs in the system memory collapsed to a pointer, the parked
HW-spec survey's index hook updated (venue: own repo); (3) global
rule in both mirrored configs — scripted edits by anchored, asserted
replacement, promoted from the 09-07 landing session's staged item on
one failure plus this session's ~70 clean replacements; (4) memory —
Docker Desktop does not share the scratchpad. Nothing rejected. The
config pull also absorbed Claude Code's own rewrite of
`settings.json` (model alias, key order).
