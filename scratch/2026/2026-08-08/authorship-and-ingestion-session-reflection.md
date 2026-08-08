---
author: Claude Fable 5
---

# authorship and ingestion session reflection

2026-08-08, closing the session that designed the scratch authorship
convention, studied the Agent Skills standard and aligned the repo's
skills with it, ingested karpathy2026-llm-wiki, and ran /evolve on the
whole.

## Principles that emerged

- **Voice is not authorship evidence.** The design/research split I
  inferred from prose style was wrong — every scratch note was
  agent-written. In a repo where agents draft everything, only
  transcripts, creating commits, and the user's own testimony settle
  who wrote what.
- **Subagent reports are claims, not evidence.** The episodic-search
  agent's Haiku attribution came with fabricated corroboration and
  survived until a primary-source grep. Promoted into the
  evidence-before-assertion memory as pattern 4.
- **Minimal form first.** Both elaborations of the authorship
  convention (co-written forms, agent+model strings) were cut mid-turn
  by the user. Conventions get the same treatment as prose: start
  minimal, add distinctions only when a case forces them.
- **Subtraction is evolution** (user's own framing, this session):
  retrospectives should mine for dead weight — unexercised rules,
  drifted facts, stale names — not only for additions. Now in the
  evolve skill (§1 mining bullet, §4 removal deltas).
- **Figure-blind synthesis mostly survived its audit.** The user caught
  that ingest-paper's read-the-transcript rule meant no figure was ever
  viewed (pymupdf4llm drops them silently). The skill now requires
  viewing load-bearing figures from the stored PDF, and the reread of
  all four figure-bearing papers confirmed the existing notes with one
  real gap (Voyager's human-feedback building demo) — captions carry
  more than expected, but the rule was still wrong.
- **The standard repaid study immediately.** The YAML-colon hazard the
  client-implementation guide warns about was reproduced live in this
  repo's own frontmatter within the hour, and caught by the validator
  the spec recommends.

## Errors worth remembering

- Misattributed the design notes to Bili on voice/genre grounds;
  corrected by user testimony plus git archaeology (three trailer-less
  creation commits; a journal era of checked-in Gemini chats).
- Stamped "Claude Haiku" from a subagent's report; the transcript said
  claude-fable-5 in all 30 messages. Caught pre-commit, but only
  because the user asked for a second look.
- zsh compliance failures recurred despite existing rules: an
  unquoted `===` (equals-expansion abort) and an unquoted `d6418f3f*`
  glob (whole-command abort). Rule text was not the gap; ad-hoc
  one-liners were. The structural answer is the session's shift of
  mechanical work into tested scripts (capture.sh).
- Re-hit the documented gzip gotcha on a Wayback `id_` record before
  re-applying the documented fix. Same lesson: encoded in capture.sh
  now, not just in skill prose.
- First capture.sh draft had a broken `>=` test and compared full-page
  text (chrome timestamps drift between snapshots); fixed to `-ge` and
  article-region comparison, then verified against the day's manual
  results.
- In the five-paper batch ingestion, wrote a *fabricated* Wayback
  timestamp into polu2020's frontmatter — the batch capture had
  printed only `archived: True`, and a plausible URL got invented to
  fill the field. Caught in self-review, replaced with the CDX-recovered,
  byte-verified record. Same failure shape as the Haiku attribution:
  a confident placeholder crossing into a persisted artifact. Habit
  fix: batch captures must persist each capture.sh JSON, never
  summarize it to booleans.
- Wayback's availability API returned false negatives twice (DSP,
  polu2020) while CDX had the records; SPN accepted repeatedly
  without materializing snapshots. Staged capture.sh improvement:
  query CDX as fallback when availability returns empty.
- Nature stamps every PDF download, so live fetches are never
  byte-identical to any archive record; resolved by adopting the
  verified Wayback record itself as the stored blob (AlphaGeometry).

## Proposal outcomes (this /evolve)

Applied: P1 subagent-verification (evidence-before-assertion memory,
pattern 4); P2 minimal-conventions extension (prefer-minimal-prose
memory); P3 author-versioned-source procedure + X quote-card gotcha
(ingest-post); P5 tools/capture.sh built, tested, and wired into both
ingest skills; P6 subtraction-as-evolution (evolve skill, from the
user's direct suggestion).

Rejected: P4 (YAML-colon clause in evolve's skill-routing bullet) — by
P6's own logic it was additive tinkering; the gotcha is recorded in the
study note and enforced by skills-ref validation. Do not re-propose.

Subtraction pass: MEMORY.md's OPPX hook still said "WEIR" (two renames
stale — now Pakeles); oppx memory cited pre-rename `scratchpad/` paths
(now `scratch/`, verified); prefer-minimal-prose scoped itself to the
renamed `garden` repo.

## Staged, not promoted

- GitHub's REST gists endpoint returns `{"message": "Server Error"}`
  for high-fork gists while raw and clone paths work (one occurrence,
  karpathy run). Promote into ingest-post if a second versioned-source
  ingestion hits it.
- Gist comment sections as a discussions venue: present on the
  captured page but uncounted this run; decide handling when a gist
  with substantial comments arrives.

## Open threads

- Evolve's user-level promotion decision: recorded in the study note
  (2026-08-08), trigger is the first cross-repo need.
- First multi-author thread-as-work ingestion still pending (carried
  from the posts-pipeline reflection).
- capture.sh's SPN path is untested live (SPN was timing out all
  session); exercise it on the next ingestion with a missing snapshot.
- hubert2025's archive record is pending: SPN accepted three times
  on 2026-08-08 but no snapshot materialized; frontmatter carries the
  deviation comment. Recheck, verify, and adopt the id_ record.
