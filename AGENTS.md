# AGENTS.md

## Public-repo leak review

- Before committing here, re-read the staged diff for private context —
  personal information, private-project details, content copied from
  `shadow/`. Secrets and structure are machine-checked (`hooks/`); private
  context is not machine-checkable and is on you.
- When notes or scratch relate a work to this system, cite only what this
  repository itself shows — never local setup (installed plugins, machine
  details, private repos' contents).

## Skills

- Canonical skills live in `skills/<name>/`; deploy each by committed
  relative symlinks in both `.claude/skills/` (read by Claude Code) and
  `.agents/skills/` (read by Codex).

## Mirrored agent configuration

- Before editing canonical user configuration under `config/`, read that
  platform's scoped instructions, run its sync tool with `diff`, and reconcile
  any drift.
