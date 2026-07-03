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

- **Secrets / identity** (passwords, keys, recovery codes): password manager.
  Root of trust for everything else.
- **Accepted silos** (calendar, email, photos, …): each app gets an explicit
  policy — see the silo decision procedure below. Minimize app count; prefer
  file-native tools (exit cost ≈ 0).

Google Drive chosen for familiarity; open to alternatives later.

## Silo decision procedure

Public ≠ durable: a platform being public says nothing about anything being
preserved. Classify each app by what kind of thing it is:

1. **Venues** (social media, e.g. X) — places to discuss, not to store.
   POSSE: author anything worth keeping in the garden first; post elsewhere
   for discussion only. One-time archive export → Drive as insurance for the
   past; no recurring ritual; the account's life is the platform's life.
2. **Archives** (email, photos) — silos that keep accumulating irreplaceable
   data that can't be re-homed. The rare case earning a periodic export
   (Takeout → local disk). Almost nothing else qualifies.
3. **Instruments** (self-tracking, e.g. Strava, Apple Health) — the data is
   born in the silo (the app is the sensor); POSSE is impossible. Keep the app
   only if the ongoing loop earns its place; export only if the accumulation
   would be mourned — to Drive if insurance, to den if it will be queried.
   Consolidate instruments into one hub where possible.

Worked examples:

- **X**: venue. POSSE going forward; one-time archive → Drive; then accepted
  silo, dies with the platform. Heirs would want the best thoughts, which live
  in the garden already.
- **Strava**: instrument, demoted to venue by the Apple Health hub — a social
  view over data whose canonical copy is in Health. No export policy needed.
- **Apple Health**: instrument hub; canonical home for all health/fitness
  streams — nothing under my control stores it better (E2E encrypted with
  2FA). Key subtlety: **backup ≠ export** — the XML export is readable but not
  restorable; only a device backup (iCloud, or *encrypted* local backup)
  restores Health. Policy: deliberate device backups (the safety net) +
  annual manual export → Drive (portability insurance for ecosystem exit) +
  den ingestion only if a real analysis need emerges.

## Longevity

Distinguish assets worth passing on from those that can vanish. Two
principles:

- **Legacy is a designation, not a place.** Unlike visibility and medium, no
  external wall enforces it, and an asset's legacy value drifts — so it
  doesn't split stores. One exception: **Drive gets a top-level `legacy/`
  folder**, with an asymmetric rule that concentrates effort where it's owed:
  organizing effort is only owed inside `legacy/`; everything else may stay a
  mess and die with the account. Promotion into `legacy/` is deliberate
  (soil → plant again).
- **Longevity is an access problem, not a storage problem.** Data that
  persists is still lost if heirs can't reach it. Handover checklist:
  1. Password manager emergency access for survivors — the keystone; unlocks
     everything else.
  2. Google Inactive Account Manager — share `legacy/` + Photos with a named
     person after inactivity; delete the rest (the "fine to remove" wish is a
     checkbox here).
  3. GitHub successor designation — public repos mostly preserve themselves by
     being public.
  4. Apple Digital Legacy contact — verify per-category coverage.
  5. A one-page digital will in den: what exists, where, keep vs delete. This
     design doc is most of it; the rest is names and intentions (which stay in
     den, not here).

Legacy-thinking doubles as the minimalism test with teeth: not wanted after
me and not needed now → delete, don't organize. Every accepted silo must
answer "what happens to this when I stop logging in?"

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

- Run remaining apps through the silo decision procedure as they come up.
- Backup automation specifics — after structure settles.
- Handover checklist execution (emergency access, inactive-account settings,
  successors, digital will) — after backups.
- Non-git public assets: revisit R2 (website media) / Zenodo (citable research
  artifacts) when a concrete need appears.
