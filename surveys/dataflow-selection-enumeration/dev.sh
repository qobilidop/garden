#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly repo_dir
readonly image="${XLSYNTH_SYMEX_PAPER_DEV_IMAGE:-xlsynth-symex-paper-dev:local}"

force_build=false
if [[ "${1:-}" == "--build" ]]; then
  force_build=true
  shift
fi

if (( $# == 0 )); then
  printf 'Usage: ./dev.sh [--build] command [args...]\n' >&2
  exit 2
fi

if [[ "${force_build}" == true ]] || ! docker image inspect "${image}" >/dev/null 2>&1; then
  docker build \
    --quiet \
    --platform linux/amd64 \
    --tag "${image}" \
    --file "${repo_dir}/.devcontainer/Dockerfile" \
    "${repo_dir}" >/dev/null
fi

terminal_args=(--interactive)
if [[ -t 0 && -t 1 ]]; then
  terminal_args+=(--tty)
fi

mkdir -p "${repo_dir}/.cache/tmp"

exec docker run --rm "${terminal_args[@]}" \
  --platform linux/amd64 \
  --volume "${repo_dir}:/workspace/xlsynth-symex-paper" \
  --volume "${repo_dir}/.cache/tmp:/tmp" \
  --workdir /workspace/xlsynth-symex-paper \
  --env HOME=/tmp \
  --env GIT_CONFIG_COUNT=1 \
  --env GIT_CONFIG_KEY_0=safe.directory \
  --env GIT_CONFIG_VALUE_0=/workspace/xlsynth-symex-paper \
  --user "$(id -u):$(id -g)" \
  "${image}" "$@"
