# 0004 — Maintain a living survey rather than a one-time closure artifact

- **Status:** accepted
- **Date:** 2026-08-04

## Context

The repository was initially organized around testing an original-theory claim
and then executing one increasingly elaborate mapping-closure campaign. The
resulting evidence record was strong, but future maintenance had no stable
query registry, freshness state, staging workflow, or concise operational entry
point. A chronological closure narrative had also become the main description
of the process.

## Decision

Organize the repository around a repeatable survey lifecycle:

- keep primary-source notes, thematic syntheses, the claim ledger, and durable
  decisions as the maintained reasoning record;
- retain the first mapping campaign as a dated baseline with audited logs and
  frozen result sets;
- register recurring Crossref and arXiv searches separately from their
  completion state;
- execute those searches over overlapping date windows with source-appropriate
  relevance or recency ordering, so each run targets newly registered work
  rather than repeating the baseline;
- stage new API output under `.scratch/` and promote it only after full
  screening and reconciliation;
- refresh database searches every 90 days and critical forward citations at
  least annually; and
- treat formal definitions and proofs as a survey formal synthesis rather than
  a separate original-paper workspace.

An update is complete only when catalog dispositions, primary-source notes,
thematic syntheses, claims, evidence rows, and manuscript consequences agree.
Fetching or citing a paper alone is not completion.

## Consequences

- `research/survey/README.md` is the operational entry point.
- `updates/queries.tsv`, `updates/state.tsv`, and `updates/tasks.tsv` make
  freshness inspectable.
- `scripts/survey/update.py` reports due work and stages registered searches.
- GitHub Actions checks weekly for overdue recurring searches.
- The initial 563 screening snapshots live under a dated baseline directory.
- The chronological closure diary is removed from the current tree; Git history
  retains it, while `baseline.md` records its durable outcome.
- Contributor-local temporary state has one home, `.scratch/`; `dev.sh` no
  longer recreates `.cache/`.
