# Personal system repos design

2026-07-28. Status: settled in discussion. Extends the digital life system
design (2026-07-03) and the year-bounding decision (2026-07-25, in den):
volumes are temporal, projects are durable. Left open then: does an evergreen
central repo still make sense? The library idea forced the question.

## Resolution: no evergreen content repo

"Personal system" is a designation, not a wall — the same argument that kept
`legacy/` from becoming a store. Nothing external enforces its boundary; its
only membership criterion is "mine," which is true of everything. A central
evergreen repo would also recreate the bloat that year-bounding solved.

The personal system is not a repo. It is:

- **yearly volumes** (`garden-{yyyy}`) — sealed temporal record,
- **collection repos** — one per collection, created lazily (below),
- **den** — private monorepo,
- **Drive** — non-git homes,
- **`~/i/`** — the local embodiment, all homes side by side; integration
  happens on the filesystem, not inside one git history,
- **website** — the public embodiment: the slow-moving index over volumes and
  collections. This closes the 07-25 open question (index repo vs website:
  website).

## Stream or collection?

The one classification question, replacing "is this a project?":

- **Streams** — time-ordered records that seal (scratchpad, blog posts,
  digested reading). Home: yearly volumes.
- **Collections** — curated maintained state, usually with software around it
  (library, notebook, album). Home: one repo each.

Website indexes both but is canonical home for neither: it renders derived
views. Content never lives in the website repo (precedent: blog posts live in
volumes; website surfaces them). Blog stays a stream — posts are dated
immutable records; wanting to routinely edit old posts would be the trigger
to revisit.

## Graduation decision procedure

No granularity judgment; defaults plus checkable triggers:

1. **Default: everything starts in the year volume.** No decision at creation
   time.
2. **Graduate only when something external forces it:**
   - needs a wall the volume lacks (private, or doesn't fit git);
   - needs repo machinery (releases, CI, issues, package name, collaborators);
   - survives two year-end carry-forwards (one carry = still earning its
     place; needing a second = durable).
3. **Granularity of a graduated thing: one repo, split only along enforced
   walls.** Never split by component voluntarily.

Wrong calls are cheap: repos merge and split with history preserved — a
mechanical migration, not lost data. So granularity gets a default, not
deliberation. The year-end ritual is the only moment graduation is
considered: batched, once a year, a rule to apply rather than a decision to
make.

## Collections foreseen (each waits for its trigger)

| Collection | Trigger that creates it | Status |
|---|---|---|
| `library` | needs walls + machinery day one | create at birth |
| website (`qobilidop.github.io`) | already exists | continue |
| `notebook` | first evergreen note promoted | wait |
| `album` | den dir until machinery/collaborators force a repo | wait |
| `toolbox` | second year-end carry-forward | wait (~2028) |
| health | real analysis need emerges (07-03 doc) | wait, maybe never |

Listing more would be speculative: the procedure generates the list; it is
not enumerated up front.

## Worked example: library

A system spanning homes, not an asset with one home. Layers mapped onto the
visibility × medium grid:

| Layer | git-fit | public-fit | Home |
|---|---|---|---|
| software (librarian agent) | yes | yes | `library` repo |
| catalog / index | yes | yes | `library` repo |
| transcripts (extracted Markdown) | yes | no (copyright) | den |
| the PDFs etc. | no | no | Drive |

Three homes because the walls force exactly three. Album has the same shape:
media is already canonical in the photos silo (Archives, per the silo
procedure); the repo layer is software plus curation metadata.

## Open

- Library's own design (librarian agent, catalog format, transcript
  pipeline).
- Website repo mechanics: GitHub Pages user site requires the literal name
  `qobilidop.github.io`; "website" is a role, possibly not a rename.
- Garden's current `library/` bed splits along stream/collection lines:
  digested-reading notes are stream (stay in volumes); durable catalog state
  moves to the `library` repo. Details to the library design.
- Garden's current `website/` bed moves to the website repo at the next
  year-end ritual (maintained state doesn't seal).
