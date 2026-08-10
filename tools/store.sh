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

write_manifest() {
  local raw sorted
  raw="$(mktemp)"
  sorted="$(mktemp)"
  if ! rclone lsjson -R "$REMOTE" > "$raw"; then
    rm -f "$raw" "$sorted"
    return 1
  fi
  if ! python3 - "$raw" > "$sorted" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as source:
    records = sorted(json.load(source), key=lambda record: record["Path"])

print("[")
for index, record in enumerate(records):
    suffix = "," if index + 1 < len(records) else ""
    print(json.dumps(record, separators=(",", ":")) + suffix)
print("]")
PY
  then
    rm -f "$raw" "$sorted"
    return 1
  fi
  mv "$sorted" "$MANIFEST"
  rm -f "$raw"
}

case "${1:-}" in
  push)
    rclone copy "$SHADOW/store/" "$REMOTE" --progress
    write_manifest
    ;;
  pull)  # pull [path] — path relative to store root; omit for everything
    rclone copyto "$REMOTE${2:-}" "$SHADOW/store/${2:-}" --progress
    ;;
  manifest)
    write_manifest
    ;;
  check)  # verify local cache files all exist intact on the remote
    rclone check "$SHADOW/store/" "$REMOTE" --one-way
    ;;
  *)
    echo "usage: store.sh push | pull [path] | manifest | check" >&2
    exit 2
    ;;
esac
