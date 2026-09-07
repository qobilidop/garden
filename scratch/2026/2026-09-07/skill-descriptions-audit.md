---
author: Claude Fable 5.1
---

# Skill descriptions audit

Prompted by Eric Provencher's "Rethinking skills and prompts for
GPT-6 Astra" (x.com/pvncher/article/2095991462416490862, 2026-09-04):
instructions accumulate as scar tissue against old model failures, so
each release is a moment to audit them.

## Adopted

- Descriptions are index keys. Six of eight restated their bodies'
  section headings, violating create-skill's own "intent level only"
  rule — a written rule nobody checked had drifted exactly like an
  unwritten one. All eight rewritten to one what-clause plus triggers
  plus boundary; `hooks/lint.sh` now caps each at 400 characters
  (longest after the rewrite: tend-host, 391).
- Router over recipe. ingest-post's minority modes (capture
  fallbacks, git-backed and paywalled sources, tool maintenance,
  revisiting an existing post) moved to `references/`, body 205 → 151
  lines. ingest-paper's closed-access chain stays in the body: it is
  the common path for papers, not a mode.
- The retired name `sys` still named this repo in the three ingest
  skills; swept to `garden` in the same change.

## Declined, with reason

- Pruning AGENTS.md rules on "the model has better judgment now".
  The article conflates procedure (decays with model capability) with
  environment facts (merge commits bypass pre-commit, subagents
  inherit nothing, zsh glob abort) — judgment cannot recover facts
  the model cannot observe. Nearly every rule here is the second
  kind and cites its incident. Audit question for future passes:
  "procedure or fact?", not "is the model smarter?".
- Loosening gates for autonomy. Push, publish, and commit gates exist
  because the cost of a wrong call is asymmetric in a public repo,
  not because a past model was weak.
- Defining completion up front: already the fan-out rule for
  subagents; nothing to add.

## Process residue for /evolve

- A rule with a clear violation shape (length, form) earns its
  machine check at codification time, not after drift — the
  description rule went a month unchecked in a repo whose AGENTS.md
  says "machine-checked where checkable".
