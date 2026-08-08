# AGENTS.md

## Public-repo leak review

- Before committing here, re-read the staged diff for private context —
  personal information, private-project details, content copied from
  `shadow/`. Secrets and structure are machine-checked (`hooks/`); private
  context is not machine-checkable and is on you.
- When notes or scratch relate a work to this system, cite only what this
  repository itself shows — never local setup (installed plugins, machine
  details, private repos' contents).

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

## Skills

- Canonical skills live in `skills/<name>/`; deploy each by committed
  relative symlinks in both `.claude/skills/` (read by Claude Code) and
  `.agents/skills/` (the cross-client convention — Codex and other
  agents).

## Mirrored agent configuration

- Before editing canonical user configuration under `config/`, read that
  platform's scoped instructions, run its sync tool with `diff`, and reconcile
  any drift.
