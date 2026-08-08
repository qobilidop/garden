# Global rules

- Project instructions live in `AGENTS.md`. Keep shared project rules there;
  use platform-specific instruction files only for genuinely platform-specific
  behavior. When creating instruction files in any repository, follow this
  pattern.
- Codex-authored commits end with a
  `Co-Authored-By: Codex <active model> <codex@openai.com>` trailer. Immediately
  before every commit, run `"${CODEX_HOME:-$HOME/.codex}/bin/coauthor"` from the
  active Codex session and append its output unchanged. The command resolves
  the session model, not merely the configured default. If it fails, stop and
  report the failure; never guess or hard-code a model name.
- Shell discipline: use absolute paths for file operations that span
  repositories; never pass interactive flags (`-i`) in scripted commands —
  their exit codes are meaningless without a tty; verify a deletion by
  listing the target afterward, never by exit code (git status cannot see
  empty directories).
