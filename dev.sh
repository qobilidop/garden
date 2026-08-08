#!/bin/bash
# Run a command in the reproducible dev container (built on first use).
# The repo mounts at /work; the host rclone config mounts writable so
# refreshed OAuth tokens persist. No args drops into a shell.
set -euo pipefail
cd "$(dirname "$0")"

IMG=sys0-dev
docker image inspect "$IMG" >/dev/null 2>&1 || docker build -t "$IMG" .devcontainer

TTYFLAG=""
[ -t 0 ] && TTYFLAG="-it"
exec docker run --rm $TTYFLAG \
  -v "$PWD":/work -w /work \
  -v "$HOME/.config/rclone":/root/.config/rclone \
  "$IMG" "${@:-bash}"
