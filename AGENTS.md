# AGENTS.md

## Principles

- Think from first principles.
- Prefer simplicity.

## Scope

This is Bili's public digital garden. The private counterpart is `den`.

The only rule for what belongs here: would I be glad a stranger stumbled on this?

- Yes → garden (public). Rough is welcome; being seen is the point.
- No, it would expose something sensitive → `den`.
- No, it's raw machine exhaust (transcripts, traces, logs) → `den`.

Sensitivity is the only public/private cut. Everything safe to show lives here, polished or not.

## Philosophy

Content is immutable; only machinery is maintained.

- Content (`library/`, `comments/`, `notes/`) is a stream of dated artifacts. Never rewritten — superseded by a newer dated artifact. Staleness is honest, not a bug.
- Machinery (`toolbox/`, `website/`) is kept current, because its value is being functional.
- Knowledge worth keeping up to date is out of scope as a maintained doc. If it's worth maintaining, it's a project; if it grows, it gets its own repo.
- Living views (topic indexes, open questions, now-page) are computed by the website from the stream, never maintained by hand.

## Structure

- `inbox.md` — Capture queue. Raw items you'll mine, not read. The only soil in the public repo.
- `library/` — Notes on external sources. Light sources → monthly catalog; heavy sources → one file each. Notes in `index/` (tracked); raw files in `store/` (gitignored).
- `comments/` — Reactions to external things. Anchored to a target; dated; not rewritten.
- `notes/` — Standalone pieces (blog posts). Your own ideas; dated; not rewritten.
- `projects/` — Bounded projects (`{yyyy}/{mm}-{dd}-{name}/`). The date is the start, never renamed. Larger projects graduate to their own repo.
- `toolbox/` — Reusable tools and agent skills. Source of truth, deployed to platform dirs.
- `website/` — The published view. Renders a chosen subset of the above, plus computed views.

## Placement

Walk top to bottom; first match wins:

1. Raw capture you'll mine, not read? → `inbox.md`
2. Part of building/publishing the site? → `website/`
3. A reusable tool or skill? → `toolbox/`
4. About one external source (digesting it)? → `library/`
5. A reaction to an external thing? → `comments/`
6. A bounded project? → `projects/`
7. Otherwise — your own standalone piece → `notes/`

## Ownership

- `toolbox/`: Bili curates, agents consume via deploy.
- Everything else: agents + Bili collaborate.

## Conventions

- Writing: straight quotes (`""`), sentence-case headings.
- Write all temporary files (plans, specs, drafts) to `.agent_scratch/`. It is gitignored. Never write temporary files to tracked directories.
