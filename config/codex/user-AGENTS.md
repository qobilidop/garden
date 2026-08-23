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
  never issue a `cd` to shorten a path, and never rely on one persisting
  from an earlier call — a shell that looks like it kept its directory
  is the third recurrence of this trap; when a tool genuinely needs a
  working directory, scope it inside that one call and treat the shell
  as resetting afterwards. Invoke repo tools by absolute path, and use
  absolute paths inside heredocs and generated scripts; `$?` after a pipeline is
  the last command's exit, not the interesting one's — run a gating
  command unpiped with output captured to a file and test bare `$?`
  (grep/tail the file afterwards); when a pipe is unavoidable, check
  `pipestatus` (zsh) / `PIPESTATUS` (bash); `while read` silently
  drops a final line that lacks a trailing newline — iterate lists
  with a tool that reads to EOF, and verify bulk operations by
  recount against the input, never by loop completion.
- Browser-mediated setup on the user's behalf: fill forms to one click
  and hand off — the human clicks Create/Delete/Submit on destructive or
  account-changing actions and handles every credential value; take no
  screenshot while a secret is on screen; a blocked confirmation is
  handed over, never worked around.
