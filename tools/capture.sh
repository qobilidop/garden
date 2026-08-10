#!/usr/bin/env bash
# capture.sh — fetch one canonical library source into the local preservation
# tier. Public archive coverage is separate, asynchronous maintenance.
set -euo pipefail

usage() { cat <<'EOF'
Usage: tools/capture.sh <url> <dest-file>

Fetches <url> to <dest-file> and reports the canonical URL, destination, and
SHA-256 as JSON. An existing non-empty destination is kept rather than
refetched. Wayback lookup and Save Page Now requests deliberately do not run
here; tools/archive-library.mjs maintains public archive coverage in batches.
EOF
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi
if [ "$#" -ne 2 ]; then
  usage >&2
  exit 1
fi

URL=$1
DEST=$2
mkdir -p "$(dirname "$DEST")"

if [ -s "$DEST" ]; then
  echo "note: $DEST exists, keeping it (pass a fresh path to refetch)" >&2
else
  TMP=$(mktemp "${DEST}.tmp.XXXXXX")
  trap 'rm -f "$TMP"' EXIT
  curl -fsSL --max-time 120 "$URL" -o "$TMP"
  [ -s "$TMP" ] || { echo "Error: fetch produced an empty file" >&2; exit 1; }
  mv "$TMP" "$DEST"
  trap - EXIT
fi

SHA=$(shasum -a 256 "$DEST" | cut -d' ' -f1)
python3 - "$URL" "$DEST" "$SHA" <<'PY'
import json, sys
url, dest, sha256 = sys.argv[1:4]
print(json.dumps({"url": url, "dest": dest, "sha256": sha256}, indent=1))
PY
