# Website graduates to its own repo

2026-08-02. Status: done. Executes — early — the last bullet of the 2026-07-28
personal system repos design, and closes its "website repo mechanics" open
question.

## What moved

Nothing, as it turned out. The site source had never left
`qobilidop.github.io`: the April 9 "move into monorepo" copied it into garden's
`website/` bed and rerouted deployment, but left the original repo's `main`
intact. The two copies were byte-identical except `.gitignore`, where the
website repo's was already a superset. So graduation reduced to undoing the
rerouting.

| Before | After |
|---|---|
| garden builds `website/`, force-pushes output to `gh-pages` | `qobilidop.github.io` builds itself on push to `main` |
| Pages serves the `gh-pages` branch (`build_type: legacy`) | Pages serves the Actions artifact (`build_type: workflow`) |
| repo's own `deploy.yml` disabled manually | re-enabled, plus `workflow_dispatch` for manual redeploys |
| `WEBSITE_DEPLOY_KEY` secret + write deploy key across repos | neither; nothing outside the repo can write to it |

Residue: the `gh-pages` branch still exists at `ae950f6`. Stale build output, no
longer read by anything.

## Why early rather than at the year-end ritual

The ritual exists to batch *judgment* — is this durable, what granularity, does
it need its own walls. None of that was outstanding here: the 07-28 note already
decided website graduates, and the repo already existed. What remained was a
mechanical move, and batching a mechanical move only delays it.

The forcing trigger was ordinary: the next real website work (a profile home
page rendered from structured data — sketched, never committed) would otherwise
have been authored in a bed already scheduled to move.

The coupling evidence was unambiguous. Of garden's 214 commits, exactly one
touched `website/` — the import itself — and none touched both `website/` and
anything else. The monorepo never once paid off.

**Refinement to the graduation procedure:** the year-end batch is for decisions,
not for moves already decided. When a thing has its own walls and zero coupling
to its current home, execute on discovery.

## Resolved: repo name vs role

07-28 left open whether "website" is a rename or just a role, given that a Pages
user site must live in a repo literally named `qobilidop.github.io`. Resolved by
not splitting them: one repo holds the source *and* serves it. The awkward name
is the publishing convention's price, paid once, and no second repo exists to
hold build output. "Website" stays a role in the system's vocabulary, never a
directory or a repo name.

## Open

When the site becomes the index over volumes and collections, pushes to *those*
repos will not rebuild it — the build is triggered only by pushes to its own
`main`. Needs `repository_dispatch` from each volume, or a scheduled rebuild.
The capture workflow (2026-07-03) already dispatches into garden, so the
mechanism is familiar; the question is whether the index rebuilds on every
upstream push or on a cadence.
