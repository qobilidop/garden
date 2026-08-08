# Global rules

- Project instructions live in AGENTS.md. CLAUDE.md is a one-line `@AGENTS.md`
  import shim, plus genuinely Claude-specific notes only — never a second home
  for shared rules. When creating instruction files in any repo, follow this
  pattern.
- Agent commits end with a `Co-Authored-By: <agent + model> <email>` trailer,
  using an email that links to the agent's GitHub account when one exists
  (`noreply@anthropic.com` → `claude`). This matches the default trailer —
  never drop or abbreviate it.
