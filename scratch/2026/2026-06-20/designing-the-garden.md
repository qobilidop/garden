# Designing my digital garden from first principles

*2026-06-20. Staged draft — move to `notes/` once that bed exists.*

I rebuilt the scope and structure of this repo from scratch. Here's the reasoning, so future-me remembers *why*, not just *what*. (The *what* lives in the README and AGENTS.md, kept current; this is the immutable record of the thinking.)

## Two boundaries

A repo like this has two boundaries. The outer one — what's in here vs the private `den` — sets the **scope**. The inner one — how this repo is divided — sets the **structure**. Get the outer one first; it decides what even belongs.

## The one-line test

The instinct is to split public/private by *maturity*: polished goes public, rough stays private. That's wrong for a garden — the whole point is to think and build *in the open*, which means showing rough work. So maturity can't be the cut.

What actually forces something private is narrower:

1. **Sensitivity** — it would harm me or someone else to be seen.
2. **Raw exhaust** — machine byproducts (transcripts, traces, logs) with no audience as written.

Everything else is public. The test, at the moment a file is born:

> Would I be glad a stranger stumbled on this?

Rough is not a no. Rough is welcome.

## Soil and plant

The metaphor that made it click: **soil and plant**.

- A **plant** is a composed whole you *read* — cultivated, on display, even a seedling.
- **Soil** is raw substrate you *mine*, not read — logs, transcripts, the medium plants grow from.

These are two independent axes:

- **Sensitivity (public/private)** → which **repo**. This is a wall the world enforces (GitHub), so it must be a repo boundary. → `garden` vs `den`.
- **Composedness (plant/soil)** → which **directory**. Nobody but me enforces this, so it's folders, not repos.

So: one repo per visibility level, full stop. More repos for finer categories would split on a boundary only I enforce — paying real costs (cross-links break, every work session straddles two clones) for nothing the world makes me gain.

Public soil is real but *thin* (the inbox: hand-typed links, born clean). Private soil is *fat* (machine exhaust, born dirty). So I don't impose a soil/plant split inside `garden` — it's almost all plants plus one capture file. Structure follows where the volume is.

## Stream-only: content is immutable, only machinery is maintained

I dropped `waiki/` (an agent-maintained wiki). Maintenance is a burden, and a wiki that rots silently *lies* — it claims to be current. A dated note never lies: it's a timestamp of what I thought then.

So the philosophy: **content is immutable; only machinery is maintained.**

- Content (`library`, `comments`, `notes`) is a dated stream. Never rewritten — superseded by a newer dated artifact.
- Machinery (`toolbox`, `website`) is kept current, because its value *is* being functional.
- Knowledge worth keeping current isn't a maintained doc here — it's a **project**, and if it grows, its **own repo**. Maintenance is opt-in, one level up in commitment.
- This loses nothing, because living *views* (topic indexes, open questions, a now-page) are **computed by the site** from the stream, not maintained by hand. Stream-only is a rule about storage, not presentation. An open question is a dated post; its answer is a later post linking back; "open questions" is a rendered view of the unanswered ones.

## The beds

Organized by *kind of artifact* (the fastest answer to "where does this go?"), not by workflow stage (fuzzy, a file spans several).

- `inbox.md` — capture (the only public soil)
- `library/` — others' sources (light → monthly catalog; heavy → file per source)
- `comments/` — my reactions, anchored to external things
- `notes/` — my standalone pieces (blog posts)
- `projects/` — bounded projects (`yyyy/mm-dd-name`); start date, not finish; big ones graduate out
- `toolbox/` — reusable tools and skills
- `website/` — the published view + computed views

The two collapsible-looking pairs resist collapse for real reasons: `library` vs `comments` is *digest vs reaction*; `comments` vs `notes` is *anchored vs standalone*. Tie-breaker for the gray zones: does it primarily *respond to* a target, or *develop my own idea*? And graduation is expected — a comment that grows up becomes a note; a light library entry that grows gets its own file.

## Completeness check

Tested against a lifecycle × substance lattice. Everything I *emit* (dated records, made things) has a home. The one thing deliberately *not* covered is anything I'd *maintain* — and that's the point of stream-only, not a gap. The design doc itself proves the structure works: its immutable "why" streams into `notes/`; its current "where things go" lives in the maintained machinery (README / AGENTS). Same immutable/maintained line the whole system runs on.
