---
author: Claude Fable 5
---

# sys: a generational public hub

2026-08-07. Status: settled in discussion, not yet built. Revisits — and
partially reverses — the personal system repos design (2026-07-28), starting
from scratch rather than extending it.

## The shape

- **sys** — permanent name of the system; incarnations are numbered repos
  (`sys0`, `sys1`, …). Public GitHub hub for knowledge, skills, lab, library
  catalog, projects index.
- **shadow** — permanent private repo of non-redistributable content
  (transcripts, snapshots). Nested at `sys/shadow/`, gitignored — not a
  submodule. Mirrors sys's paths exactly.
- **store** — Google Drive tier for large blobs. Canonical in Drive; partial
  local cache at `sys/shadow/store/` (gitignored in shadow). Moved only by
  explicit `rclone copy` push/pull; a committed manifest (`rclone lsjson`)
  keeps every blob visible from git.
- **den** — permanent private repo, unchanged. Same skeleton eventually.
- **project repos** — separate spokes; sys indexes them, lab incubates them,
  graduation runs both ways.
- **website** — its own repo, rendering from sys rather than living in it.

```
sys/library/papers/1986/hamming1986-your-research/   # notes, synthesis
sys/shadow/library/papers/1986/hamming1986-.../              # transcript
sys/shadow/store/library/papers/1986/hamming1986-.../        # pdf
```

## Against 07-28: why a central repo returns

07-28 rejected an evergreen central repo on two grounds: "mine" is not a
membership criterion, and bloat is what year-bounding solved. Both objections
get different answers now:

- Membership is not "mine" but *public knowledge, skills, and process*.
  Projects with their own lifecycle stay out; the hub owns the flywheel, not
  the code.
- Bloat is answered by **generations instead of years**: sysN → sysN+1 copies
  the good files forward; the old incarnation archives in place with a
  pointer. Reseed is triggered by irreversible mistake or structural rot, not
  the calendar — expected cadence is years, and the mechanism's main value is
  the discipline it imposes: value must live in the worktree, never in
  history.

Yearly volumes bounded *time*; generations bound *structure*. Scratch is the
layer that keeps the temporal property: `scratch/<year>/` expires with each
generation, never copied forward — distill before reseed or lose it.

## Names

`sys` over `garden{N}` (garden says notes; this is bigger) and `sysv` (System
V collision). `shadow` over `stacks`/`annex`: shadow library is the term of
art, the repo is literally sys's shadow under the mirrored-path rule, and the
name states its visibility. Candor cost accepted.

## Rules (destined for sys CLAUDE.md)

1. Value lives in the worktree, never in history, issues, or wiki.
2. Agents read shadow freely; never copy from it into tracked files.
   Transformation crosses the boundary, transfer doesn't. Test: a note
   writable only with the source open → shadow; what someone who understood
   it would say → sys.
3. Publishing enumerates via `git ls-files`, never a filesystem walk.
4. Paths are deterministic from the citekey across all tiers; no lookup
   tables.
5. Directories are evidence of work; intentions are queue lines.
6. Store moves by explicit push/pull; nothing syncs, nothing deletes
   automatically.

## Library conventions

Type-first directories (`papers/`, `books/`, `posts/`, `talks/`) because type
determines the capture profile — which artifacts exist at which tier. Papers
and books year-sharded from day one (`papers/<year>/<citekey>/`); posts and
talks flat until volume forces it. Agent synthesis goes to sys,
author-labeled, unless it is a close derivative of the source — then shadow.
Ingestion procedures become sys skills; writing them is the flywheel's first
turn.

## Decided

CC BY for content, MIT/Apache for code, AI-authorship note in README. GitHub
issues, wiki, and most platform features disabled — the platform-level
enforcement of rule 1. Projects index added at build time. Garden absorbed
into sys0 and archived.

## Deferred

Secret-hygiene safeguards (gitleaks pre-commit and friends); reseed trigger
criteria in detail. Both to future sessions.

## Watch-out

The failure mode of personal-system projects is meta-work displacing
object-work. Measure sys by papers ingested and skills exercised, not by
conventions refined. More commits to CLAUDE.md than to library/ in a month is
the signal.
