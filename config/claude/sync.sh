#!/bin/bash
# Sync Claude Code user configs between this repo (canonical) and ~/.claude (live).
# Copies, not symlinks: Claude Code rewrites settings.json itself, and an
# atomic rename would silently sever a symlink.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
LIVE="$HOME/.claude"
FILES=(settings.json statusline.sh)

case "${1:-}" in
  diff)
    status=0
    for f in "${FILES[@]}"; do
      diff -u "$REPO/$f" "$LIVE/$f" || status=1
    done
    [ "$status" -eq 0 ] && echo "in sync"
    exit "$status"
    ;;
  pull)
    for f in "${FILES[@]}"; do cp -p "$LIVE/$f" "$REPO/$f"; done
    ;;
  push)
    for f in "${FILES[@]}"; do cp -p "$REPO/$f" "$LIVE/$f"; done
    ;;
  *)
    echo "usage: sync.sh diff|pull|push   (pull: live -> repo, push: repo -> live)" >&2
    exit 2
    ;;
esac
