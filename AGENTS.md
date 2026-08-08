# AGENTS.md

## Public-repo leak review

- Before committing here, re-read the staged diff for private context —
  personal information, private-project details, content copied from
  `shadow/`. Secrets and structure are machine-checked (`hooks/`); private
  context is not machine-checkable and is on you.
- When notes or scratch relate a work to this system, cite only what this
  repository itself shows — never local setup (installed plugins, machine
  details, private repos' contents).

## Guards

- A machine check that runs in more than one place (hooks, dev image,
  CI) pins a single version, and each pin site cross-references the
  others — divergent scanner versions once made CI and hooks disagree
  on the same config.

## Fan-out

- Subagents inherit no operating rules. A fan-out prompt that could
  touch a gated capability (browser-mediated downloads, deletions,
  pushes) states the gate explicitly — three survey pipelines once
  escalated to the user's browser unprompted
  (surveys/agent-assisted-review-methodology/decisions/0007).

## Scratch

- Notes live at `scratch/YYYY/YYYY-MM-DD/slug.md`. The date directory is the
  capture date and the H1 is the title — no date or title frontmatter.
- Authorship is binary — the writer of the prose. A note with no `author:`
  frontmatter is Bili's; agent-written notes open with an `author:` field
  naming the model, matching the commit trailer:

  ```markdown
  ---
  author: Claude Fable 5
  ---
  ```

## Wiki

- `wiki/<topic>.md`: flat, living topic pages distilling the library
  across works — agent-written, human-directed, citing works by
  `[[citekey]]`. Ingestion updates the pages a work touches; a new page
  needs enough accumulated material to synthesize, never a single work.
  No index, no per-page frontmatter: the directory lists, git logs.

## Site

- `site/` renders the repo to GitHub Pages (Astro). It reads exactly
  `wiki/` and `library/` — the two collections in
  `site/src/content.config.ts` are the allowlist — and writes nothing
  back; presentation needs never reshape note conventions.
- Owned logic lives in `site/src/lib/` (wikilink resolution, backlink
  graph, work metadata); everything else is rented substrate (Astro,
  remark, KaTeX, Pagefind, Mermaid). An unresolved `[[target]]` fails
  the build.
- Build with Node from the dev image (`./dev.sh`); CI builds in the same
  image via `.github/workflows/site.yml`.

## Conventions

- A convention found to exist only by imitation gets codified in its
  governing skill in the same change, and machine-checked where
  checkable — unwritten conventions drift (H1 shapes, display names,
  and citation forms all did).

## Skills

- Canonical skills live in `skills/<name>/`; deploy each by committed
  relative symlinks in both `.claude/skills/` (read by Claude Code) and
  `.agents/skills/` (the cross-client convention — Codex and other
  agents).

## Mirrored agent configuration

- Before editing canonical user configuration under `config/`, read that
  platform's scoped instructions, run its sync tool with `diff`, and reconcile
  any drift.
