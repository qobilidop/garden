#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly repo_dir
readonly image="${DATAFLOW_SELECTION_ENUMERATION_DEV_IMAGE:-dataflow-selection-enumeration-dev:local}"
readonly cache_image="${DATAFLOW_SELECTION_ENUMERATION_DEV_CACHE_IMAGE-ghcr.io/qobilidop/dataflow-selection-enumeration/dev:latest}"
readonly container_tmp="${repo_dir}/.scratch/container-tmp"

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
  build_args=(--platform linux/amd64)
  if [[ -n "${cache_image}" ]] && docker pull "${cache_image}" >/dev/null 2>&1; then
    build_args+=(--cache-from "${cache_image}")
  elif [[ -n "${cache_image}" ]]; then
    printf 'Published development-image cache unavailable; building locally.\n' >&2
  fi

  docker build \
    "${build_args[@]}" \
    --tag "${image}" \
    --file "${repo_dir}/.devcontainer/Dockerfile" \
    "${repo_dir}"
fi

terminal_args=(--interactive)
if [[ -t 0 && -t 1 ]]; then
  terminal_args+=(--tty)
fi

ssh_args=()
if [[ -n "${SSH_AUTH_SOCK:-}" && -S "${SSH_AUTH_SOCK}" ]]; then
  ssh_args+=(
    --volume "${SSH_AUTH_SOCK}:/run/host-ssh-agent"
    --env SSH_AUTH_SOCK=/run/host-ssh-agent
  )
fi
if [[ -f "${HOME}/.ssh/known_hosts" ]]; then
  ssh_args+=(
    --volume "${HOME}/.ssh/known_hosts:/etc/ssh/ssh_known_hosts:ro"
  )
fi

mkdir -p "${container_tmp}"

exec docker run --rm "${terminal_args[@]}" \
  --platform linux/amd64 \
  --volume "${repo_dir}:/workspace/dataflow-selection-enumeration" \
  --volume "${container_tmp}:/tmp" \
  --workdir /workspace/dataflow-selection-enumeration \
  --env HOME=/tmp \
  --env GIT_CONFIG_COUNT=1 \
  --env GIT_CONFIG_KEY_0=safe.directory \
  --env GIT_CONFIG_VALUE_0=/workspace/dataflow-selection-enumeration \
  --user "$(id -u):$(id -g)" \
  "${ssh_args[@]}" \
  "${image}" "$@"
