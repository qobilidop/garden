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
  empty directories); in zsh one-liners, quote bare `=`-prefixed words and
  any glob that may not match — an unmatched glob aborts the whole command;
  never rely on a `cd` persisting from earlier in a compound command or a
  previous call — invoke repo tools by absolute path, and use absolute
  paths inside heredocs and generated scripts; `$?` after a pipeline is
  the last command's exit, not the interesting one's — run a gating
  command unpiped with output captured to a file and test bare `$?`
  (grep/tail the file afterwards); when a pipe is unavoidable, check
  `pipestatus` (zsh) / `PIPESTATUS` (bash); `while read` silently
  drops a final line that lacks a trailing newline — iterate lists
  with a tool that reads to EOF, and verify bulk operations by
  recount against the input, never by loop completion.
