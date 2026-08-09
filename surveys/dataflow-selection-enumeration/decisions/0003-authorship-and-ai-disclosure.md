# 0003 — Use human authorship with explicit AI-assistance disclosure

- **Status:** accepted
- **Date:** 2026-08-04

## Context

The initial repository draft named OpenAI Codex as the manuscript author. That
byline does not match current scholarly practice: generative AI systems cannot
accept responsibility for a paper or satisfy the authorship policies of arXiv
and many conventional venues. Omitting the system entirely would, however,
conceal its substantial role in the research and writing workflow.

## Decision

Bili Dong, an independent researcher without an institutional affiliation, is
the sole author of record and accepts responsibility for the manuscript.
OpenAI Codex (GPT-5.6 Sol) is identified in a dedicated disclosure as providing
substantial assistance with literature-search planning, evidence organization,
cross-paper synthesis, formal presentation, manuscript drafting and editing,
and repository tooling.

The manuscript remains a draft under continuing human review. AI output is not
evidence: literature claims must rest on cited primary sources and the durable
evidence record, and mathematical claims must be checked against the stated
definitions and proofs. Human review must be completed before submission to
arXiv or another conventional venue.

## Consequences

- The manuscript, website, PDF metadata, and citation metadata identify Bili
  Dong as the sole author.
- Codex is credited through the disclosure and commit co-authorship trailers,
  not the scholarly byline.
- The repository retains its current no-license status while the manuscript is
  under review and the publication route is unsettled.
- A future submission must preserve an AI-use disclosure appropriate to the
  selected venue.
