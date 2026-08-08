# config/claude

Canonical Claude Code user configs; live copies in `~/.claude`.

Before editing anything here, run `./sync.sh diff` and reconcile drift
(usually `pull` first). Edit in this directory, then `./sync.sh push`.

`user-CLAUDE.md` is the global `~/.claude/CLAUDE.md` under a mapped name
(a literal CLAUDE.md here would double-load as directory instructions).

`attribution` is deliberately absent from settings.json: only the default
gives a dynamic model name in the commit trailer; any explicit value is a
static string that would freeze it.
