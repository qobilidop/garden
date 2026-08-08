#!/bin/bash
# Sync Claude Code user configs between this repo (canonical) and ~/.claude (live).
# Copies, not symlinks: Claude Code rewrites settings.json itself, and an
# atomic rename would silently sever a symlink.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
LIVE="$HOME/.claude"
# repo-name:live-name; user-CLAUDE.md maps to the global CLAUDE.md because a
# literal CLAUDE.md here would double-load as directory instructions.
FILES=(settings.json statusline.sh user-CLAUDE.md:CLAUDE.md)

case "${1:-}" in
  diff)
    status=0
    for spec in "${FILES[@]}"; do
      diff -u "$REPO/${spec%%:*}" "$LIVE/${spec##*:}" || status=1
    done
    [ "$status" -eq 0 ] && echo "in sync"
    exit "$status"
    ;;
  pull)
    for spec in "${FILES[@]}"; do cp -p "$LIVE/${spec##*:}" "$REPO/${spec%%:*}"; done
    ;;
  push)
    for spec in "${FILES[@]}"; do cp -p "$REPO/${spec%%:*}" "$LIVE/${spec##*:}"; done
    ;;
  *)
    echo "usage: sync.sh diff|pull|push   (pull: live -> repo, push: repo -> live)" >&2
    exit 2
    ;;
esac
