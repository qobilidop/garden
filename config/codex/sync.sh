#!/bin/bash
# Sync managed Codex user configuration between this repo and $CODEX_HOME.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
exec python3 "$SCRIPT_DIR/sync.py" "$@"
