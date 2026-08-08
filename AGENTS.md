# AGENTS.md

## Public-repo leak review

- Before committing here, re-read the staged diff for private context —
  personal information, private-project details, content copied from
  `shadow/`. Secrets and structure are machine-checked (`hooks/`); private
  context is not machine-checkable and is on you.

## Mirrored agent configuration

- Before editing canonical user configuration under `config/`, read that
  platform's scoped instructions, run its sync tool with `diff`, and reconcile
  any drift.
