---
author: Claude Fable 5
---

# Folding the store tier into shadow

Bili asked whether the shadow/store split was still earning its keep.
The manifest answered: 114 files, 126.8 MB total, largest blob 16.2 MB,
median 0.23 MB — nothing within an order of magnitude of git's real
ceiling (GitHub's 100 MB per-file hard limit), accumulated during eleven
days of unusually heavy bootstrap. The store tax was being paid on every
ingestion (rclone push, manifest regeneration, a two-tier seam in every
ingest skill, a pending client_id migration) while its benefits — no
size ceiling, partial local cache, Drive-native access — had been
exercised zero times.

Decision (Bili, 2026-08-18): fold store into shadow. Blobs live beside
their transcripts and snapshots at the same `library/...` paths; one
private repo, one backup story, artifacts of a work findable in one
directory. Rule 5 ("directories are evidence of work; intentions are
queue lines") cut against keeping pre-built machinery for artifacts
that had not materialized.

Executed the same day:

- shadow: all 114 blobs moved from `store/` to their mirrored library
  paths — verified against the manifest by count and byte size, and
  against Drive by `rclone check` (114 matching, 0 differences) before
  the manifest and `/store/` gitignore were dropped.
- sys0: `tools/store.sh` deleted; `transcribe.sh` reads the shadow
  path; `check-ingest.mjs` checks blobs directly (no manifest);
  ingest-paper / ingest-post / ingest-batch updated; rclone removed
  from the dev image and `dev.sh`; stale `→ store` tier comments in
  library notes and survey evidence records mechanically retargeted.

The store *concept* survives as a queue line, not machinery: the first
real artifact too large for git (a >50 MB scanned book, a talk video)
is the trigger to rebuild a blob tier — cheap to do then, since shadow
is private and single-user. Same deferral for Bili's
one-shadow-repo-per-year sharding idea: revisit when size actually
hurts, not before. The Drive `sys-store` folder and the host rclone
remote are now unused; deleting them is Bili's call.
