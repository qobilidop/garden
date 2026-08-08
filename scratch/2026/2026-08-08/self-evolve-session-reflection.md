# self-evolve session reflection (agent)

2026-08-08, closing the session that built the self-evolving-agents
shelf (three papers, four posts), distilled the evolve skill from it,
migrated the store remote to an app-scoped OAuth client, and then ran
/evolve on itself for the first time. Written by Claude Fable 5.

## Principles that emerged

- **The library designed the skill.** Every safeguard in evolve traces
  to a specific ingested source (itemized deltas, evidence-before-
  proposal, gated promotion, logged rejections, staged lessons), and the
  first live run held its shape: nine proposals, one staged by the
  skill's own filter.
- **More ingestion was not what blocked the skill.** The design
  principles existed after three works; the targeted batch added
  mechanism detail and two fresh field reports. Comprehensiveness serves
  the library; sufficiency serves the build.
- **Secondary descriptions decay into primary sources.** The paywalled
  essay's "five steps," present in every summary of it, do not appear in
  the capturable record — and a WebFetch summary nearly smuggled them
  into notes. Assert only what the captured record contains.
- **The scope is the boundary; the folder id is a convenience.** The
  Drive migration's real security change was `drive` → `drive.file`, not
  any folder pointer — and narrowing scope forced a re-upload because
  app-scoped visibility is per-client. Boundaries cost migrations;
  conveniences don't protect.
- **Rules fail at compliance, not existence.** The session's worst
  repeated error (relying on a persisted `cd` — wrong-repo `git add`,
  then a sync script run against the wrong platform) violated a rule
  that already existed. The fix sharpened the rule's wording, but the
  deeper lesson is that violations, not just gaps, are evolve evidence.

## Errors worth remembering

- Three `cd`/relative-path failures in one session; two caught only
  after a wrong action executed. Rule sharpened (absolute paths for repo
  tools; never trust persisted `cd`).
- Commit trailer dropped on an entire batch in the second repo, caught
  against that repo's own history, fixed by `rebase --exec` before push.
  Existing rule; compliance failure under batch fatigue.
- A public library note named a locally-installed plugin; the user
  challenged its necessity and was right. New AGENTS.md rule: system-
  relevance remarks cite only what this repository shows.
- gitleaks' generic-api-key rule fired on a `citekey:` frontmatter line
  (entropy threshold); fixed at config level with an allowlist rather
  than per-file pragmas.
- The Wayback SPN service was effectively down all evening; every
  archive URL was ultimately satisfied by verification against existing
  records instead. The fallback ladder is now in the ingest skills.
- At wrap-up, revoking a superseded OAuth refresh token killed the
  *active* token too — Google revokes the client's entire grant, not
  the single token. Assumed otherwise, verified only after acting;
  recovered by re-running the playbook's re-auth step. Playbook amended.

## Proposal outcomes (first /evolve run)

Applied: P1 public-notes locality (AGENTS.md); P2+P9 shell-discipline
extensions (both mirrored configs, synced); P3 archive-fallback ladder
(ingest-paper, pointer in ingest-post); P4 paywalled-source handling
(ingest-post); P5 memory compression (conventions memory now points at
the skills); P6 dual-shim skills convention (AGENTS.md + evolve routing);
P7 feedback memory (batch harness edits for /evolve).

Staged, not applied: P8 (prefer task notifications over foreground
wait-loops; three orphaned waiters this session) — harness-version-
specific, lowest durability; promote if it recurs in a future session.

## Open threads

- klaassen2025's record is the free preview; upgrade via an Every
  subscription and browser-session re-capture if one materializes.
- Reflexion (arXiv 2303.11366) deliberately not ingested — history, not
  mechanism; revisit only if a note needs its primary text.
- The evolve skill has now amended itself once (routing line). Watch
  whether self-amendments stay evidence-driven or drift toward
  tinkering.
- First multi-author thread-as-work ingestion still pending (carried
  from the posts-pipeline reflection).
