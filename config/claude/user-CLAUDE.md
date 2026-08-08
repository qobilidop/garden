# Global rules

- Project instructions live in AGENTS.md. CLAUDE.md is a one-line `@AGENTS.md`
  import shim, plus genuinely Claude-specific notes only — never a second home
  for shared rules. When creating instruction files in any repo, follow this
  pattern.
- Agent commits end with a `Co-Authored-By: <agent + model> <email>` trailer,
  using an email that links to the agent's GitHub account when one exists
  (`noreply@anthropic.com` → `claude`). This matches the default trailer —
  never drop or abbreviate it.
- Shell discipline: use absolute paths for file operations that span
  repositories; never pass interactive flags (`-i`) in scripted commands —
  their exit codes are meaningless without a tty; verify a deletion by
  listing the target afterward, never by exit code (git status cannot see
  empty directories).
