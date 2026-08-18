---
name: ingest-batch
description: Coordinate ingestion of a selected batch of two or more works into the sys library. Use when asked to ingest a list, series, reading set, or mixed collection while consolidating validation and commit closeout. For one work use ingest-paper or ingest-post; this skill orchestrates those item workflows and does not redefine them.
compatibility: "Requires the sys repo and the capabilities required by each selected item skill."
---

# Ingest a batch

Work from the sys repo root. This is a thin orchestration layer over
`../ingest-paper/SKILL.md` and `../ingest-post/SKILL.md`; their capture,
judgment, provenance, synthesis, and writeback rules remain canonical.

## 1. Freeze the batch before capture

Build one working inventory from the user's selected works. For each item,
resolve its canonical identity, classify it, and assign a collision-checked
citekey before writing artifacts:

- a formally published work with a DOI, arXiv identity, or venue follows
  `ingest-paper`;
- a web-native informal work with no version-of-record follows `ingest-post`.

Do not force an artifact into the nearest category. If a talk, video, book,
dataset, thread-as-work, or other item lacks an ingestion model, leave that item
uncaptured and report the missing preservation tier; continue the supported
items when they do not depend on it. Classification before capture avoids
creating evidence that the library is not yet prepared to maintain.

Read each selected item skill completely once, then apply it independently to
every item of that type. Record the intended public and shadow paths in the
inventory so citekeys and years cannot drift between tiers.

## 2. Complete items, share only mechanical work

For every work, finish the relevant item workflow: canonical capture,
source-grounded notes, discussion curation, figure judgment, and wiki
writeback. A batch does not lower the evidence bar or turn source-specific
judgments into bulk classification.

Share operations only when their semantics are identical across the batch:
metadata requests to the same service, immutable downloads, and bounded
discussion queries may be grouped. Keep temporary candidates outside public
and shadow destinations until their identity and tier are settled.

## 3. Consolidate closeout

After all supported items are ready:

1. Run one `node tools/check-ingest.mjs <citekey> [citekey ...]` over the whole
   batch.
2. For posts, run one archive request with a repeated `--citekey <citekey>` for
   each post, `--request-missing`, a request cap equal to the number of posts,
   and `--delay-ms 0`. As in `ingest-post`, a service failure is reported but
   does not block locally preserved work.
3. Run the focused tool tests required by changed infrastructure, then one
   host `npm --prefix site run build` for the completed batch.
4. Stage intentional paths and run the staged checks required by each item
   skill. Do not replace their mechanical-capture exclusions with a generic
   all-shadow whitespace check.

Group commits by coherent subject and rollback boundary rather than making one
commit per work mechanically. Keep public notes/wiki changes separate from
private preservation commits, and re-read every staged public diff for private
context. Obtain the active-session coauthor trailer immediately before every
commit as required by `AGENTS.md`. Existing user authority to commit and push
covers the batch; otherwise stop at the commit proposal gate inherited from the
item skills.

After pushing both repositories, compare the intended local branch tips with
their remote refs and require clean worktrees. Successful pushes finish a
commit-and-push request; deployment watching remains outside scope unless the
user asked for publication verification.
