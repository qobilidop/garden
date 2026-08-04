#!/usr/bin/env bash

set -euo pipefail

readonly repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly image="${XLSYNTH_SYMEX_PAPER_DEV_IMAGE:-xlsynth-symex-paper-dev:local}"

if (( $# == 0 )); then
  printf 'Usage: ./dev.sh command [args...]\n' >&2
  exit 2
fi

docker build \
  --quiet \
  --platform linux/amd64 \
  --tag "${image}" \
  --file "${repo_dir}/.devcontainer/Dockerfile" \
  "${repo_dir}" >/dev/null

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
