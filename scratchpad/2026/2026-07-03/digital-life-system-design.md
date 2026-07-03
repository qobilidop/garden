# Digital life system design

2026-07-03. Status: draft for review.

## Goal

One clear system managing all digital assets and works in progress, with
minimal stores, minimal rules, and a checkable answer to "where does this go?"

## The unifying rule

**Every asset has exactly one canonical home.** Everything else is a derived
copy. Backups are defined per-home, not per-file.

## Canonical homes

Stores are split along walls the world enforces (visibility × medium), not
walls I'd have to enforce myself.

|  | fits git | doesn't fit git |
|---|---|---|
| **public** | `garden` (+ graduated public repos) | public Google Drive folder; GitHub Releases when tied to a repo |
| **private** | `den` (+ private repos) | Google Drive |

Plus two homes outside the grid:

- **Secrets / identity** (passwords, keys, recovery codes): 1Password. Root of
  trust for everything else.
- **Accepted silos** (calendar, email, photos, …): each app I use gets an
  explicit policy — (a) canonical there, accepted; (b) canonical there, backed
  up via periodic export; or (c) must migrate into the system. Minimize app
  count; prefer file-native tools (exit cost ≈ 0).

Google Drive chosen for familiarity; open to alternatives later.

## Backup (deferred, by design)

The realistic failure mode is account-level lock, not disk loss. GitHub and
Google are the two single points of failure; each should back up the other:

- git repos → periodic `git bundle` into Drive (+ current local clones).
- Drive/Gmail/Photos → periodic Google Takeout onto local disk.
- Automate or calendar it; a manual "periodically" becomes "never".

To set up after the structure settles.

## Garden repo structure

- `scratchpad/` — soil. Lowest-friction entry point for anything that fits git.
  - `yyyy/yyyy-mm-dd.md` — the day's captures (appended text).
  - `yyyy/yyyy-mm-dd/` — optional, only when needed: standalone artifacts born
    that day.
  - Full-date basenames: the filename escapes its directory (tabs, search,
    links) and must self-identify.
  - Pure record: no checkboxes, no state, never rewritten. Triage views can be
    computed later if ever wanted.
- `notebook/` — polished standalone pieces (renames `notes/`). Absorbs the
  planned `comments/`: anchored reactions are ordinary entries.
- `library/` — others' sources, digested. Unchanged.
- `projects/` — incubator for bounded doc-projects; larger ones graduate to
  their own repos. Kept: repo-per-experiment pays real costs (cross-link
  breakage, session straddling, discovery sprawl) for a wall only I enforce.
- `toolbox/` — maintained tools/skills. Unchanged.
- `website/` — maintained published view. Unchanged.
- `TODO.md` — maintained mutable state, created lazily on first real TODO.
  Actionable items are promoted here explicitly; state never rides on stream
  content.

Retired: `inbox.md` (capture → scratchpad; its current links migrate into
today's day file), `journal/` (function subsumed by scratchpad; the name named
a practice, scratchpad names the function), planned `comments/` (folded into
notebook).

## Capture workflow (amendment)

The capture workflow (see capture-workflow-design.md) targets
`scratchpad/yyyy/yyyy-mm-dd.md` — timestamped appends, no sections — instead
of `inbox.md`.

## Migration steps (on approval)

1. Rename `notes/` → `notebook/`; update its README.
2. Remove `journal/`.
3. Migrate `inbox.md` links into `scratchpad/2026/2026-07-03.md`; remove
   `inbox.md`.
4. Update `AGENTS.md` / `README.md` to describe the new structure.
5. Amend capture-workflow-design target (done in this commit).

## Open questions

- Per-silo policy table (which apps, which of a/b/c) — enumerate later.
- Backup automation specifics — after structure settles.
- Non-git public assets: revisit R2 (website media) / Zenodo (citable research
  artifacts) when a concrete need appears.
