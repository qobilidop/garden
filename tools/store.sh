#!/bin/bash
# Move blobs between shadow/store/ (local cache) and the Drive store remote.
# Explicit copy only, never sync: nothing deletes automatically, and the
# committed manifest keeps every remote blob visible from git.
# Requires: rclone with a `store:` remote; the private shadow/ checkout.
set -euo pipefail

SHADOW="$(cd "$(dirname "$0")/.." && pwd)/shadow"
[ -d "$SHADOW" ] || { echo "no shadow/ checkout — store operations need the private data repo" >&2; exit 1; }
REMOTE="store:"
MANIFEST="$SHADOW/store.manifest.json"

case "${1:-}" in
  push)
    rclone copy "$SHADOW/store/" "$REMOTE" --progress
    rclone lsjson -R "$REMOTE" > "$MANIFEST"
    ;;
  pull)  # pull [path] — path relative to store root; omit for everything
    rclone copyto "$REMOTE${2:-}" "$SHADOW/store/${2:-}" --progress
    ;;
  manifest)
    rclone lsjson -R "$REMOTE" > "$MANIFEST"
    ;;
  check)  # verify local cache files all exist intact on the remote
    rclone check "$SHADOW/store/" "$REMOTE" --one-way
    ;;
  *)
    echo "usage: store.sh push | pull [path] | manifest | check" >&2
    exit 2
    ;;
esac
