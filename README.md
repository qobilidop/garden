# Bili's Digital Garden

[![Devcontainer](https://github.com/qobilidop/cyborg/actions/workflows/devcontainer.yml/badge.svg)](https://github.com/qobilidop/cyborg/actions/workflows/devcontainer.yml)
[![Gitleaks](https://github.com/qobilidop/cyborg/actions/workflows/gitleaks.yml/badge.svg)](https://github.com/qobilidop/cyborg/actions/workflows/gitleaks.yml)

Bili's public digital garden — the public surface of an intellectual life: things read, reactions, ideas, and projects, tended in the open.

The private counterpart is `den`.

## What lives here

One rule: **would I be glad a stranger stumbled on this?**

- Yes → here. Rough and unfinished are welcome; being seen is the point.
- It would expose something sensitive → `den`.
- It's raw machine exhaust (transcripts, traces, logs) → `den`.

Sensitivity is the only line between public and private. Everything safe to show lives here, polished or not.

## How it works

**Content is immutable; only machinery is maintained.**

The garden is a stream: notes are dated and never rewritten — when a view changes, a newer note supersedes the old one. Nothing here is kept up to date by hand, so nothing rots silently; a stale note is an honest record of a past moment. Knowledge worth keeping current becomes a project, or graduates to its own repo. The only maintained things are the tools and the site, because their value is being functional. Living overviews (topic indexes, open questions) are computed by the site from the stream, not maintained by hand.

## Structure

- `inbox.md` — Capture queue: raw items to mine later.
- `library/` — Notes on external sources. Light sources → monthly catalog; heavy sources → a file each.
- `comments/` — Reactions to external things.
- `notes/` — Standalone pieces (blog posts).
- `projects/` — Bounded projects (`yyyy/mm-dd-name`).
- `toolbox/` — Reusable tools and agent skills.
- `website/` — The published view.

## Where does it go?

First match wins:

1. Raw capture you'll mine, not read? → `inbox.md`
2. Part of building the site? → `website/`
3. A reusable tool or skill? → `toolbox/`
4. About one external source? → `library/`
5. A reaction to an external thing? → `comments/`
6. A bounded project? → `projects/`
7. Otherwise — your own standalone piece → `notes/`
