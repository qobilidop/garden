#!/bin/bash
# Run a command in the reproducible dev container; no args drops into a shell.
#
#   ./dev.sh [--pull | --build] [cmd...]
#     --pull    refresh the image from GHCR (picks up new publishes)
#     --build   build the image locally from .devcontainer/ (Dockerfile work;
#               push to main afterwards so CI republishes for every machine)
#
# Image comes from GHCR (published by .github/workflows/dev-image.yml); local
# build is the fallback when the pull fails (offline). Override the image with
# DEV_IMAGE=... for sha-pinned debugging. The repo mounts at /work.
# (On a Linux host this would need user mapping to avoid root-owned files;
# Docker Desktop on macOS handles ownership transparently.)
set -euo pipefail
cd "$(dirname "$0")"

# Opportunistically arm the leak-guard hooks (idempotent; survives fresh clones).
git config core.hooksPath hooks 2>/dev/null || true

IMG="${DEV_IMAGE:-ghcr.io/qobilidop/sys0/dev:latest}"

DEV_SETUP_ACTION=""
case "${1:-}" in
  -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
  --pull)    shift; DEV_SETUP_ACTION="pull" ;;
  --build)   shift; DEV_SETUP_ACTION="build" ;;
esac

# The host checkout shares site/node_modules with this container. Running a
# package manager here replaces host-native dependencies with Linux builds.
case "${1:-}" in
  npm|npx|yarn|pnpm)
    echo "dev.sh: run site package commands on the host, not through dev.sh" >&2
    exit 2
    ;;
esac

case "$DEV_SETUP_ACTION" in
  pull)  docker pull "$IMG" ;;
  build) docker build -t "$IMG" .devcontainer ;;
esac

if ! docker image inspect "$IMG" >/dev/null 2>&1; then
  docker info >/dev/null 2>&1 || { echo "dev.sh: docker daemon not running" >&2; exit 1; }
  if [ -n "${DEV_IMAGE:-}" ]; then
    docker pull "$IMG"  # explicit pin: never substitute a local build for it
  else
    docker pull "$IMG" || docker build -t "$IMG" .devcontainer
  fi
fi

# Warn when .devcontainer/ changed after the image was created (advisory only).
created="$(docker image inspect -f '{{.Created}}' "$IMG" 2>/dev/null || true)"
if [ -n "$created" ]; then
  newer="$(python3 -c "
import datetime, os, sys
img = datetime.datetime.fromisoformat('$created'.replace('Z', '+00:00')).timestamp()
files = [os.path.join(r, f) for r, _, fs in os.walk('.devcontainer') for f in fs]
print(' '.join(f for f in files if os.path.getmtime(f) > img))" 2>/dev/null || true)"
  [ -n "$newer" ] && echo "dev.sh: note — newer than image: $newer (use --build to test locally, --pull after CI republishes)" >&2
fi

TTYFLAG=""
[ -t 0 ] && [ -t 1 ] && TTYFLAG="-it"
exec docker run --rm $TTYFLAG \
  -v "$PWD":/work -w /work \
  "$IMG" "${@:-bash}"
