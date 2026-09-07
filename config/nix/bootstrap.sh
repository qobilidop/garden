#!/bin/sh
# New machine: install upstream Nix (community installer), then apply this
# flake. Idempotent; later runs are plain switches.
#
#   git clone https://github.com/qobilidop/garden ~/my/garden
#   ~/my/garden/config/nix/bootstrap.sh
set -eu
here="$(cd "$(dirname "$0")" && pwd)"

if ! command -v nix >/dev/null 2>&1; then
  curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
features="--extra-experimental-features nix-command --extra-experimental-features flakes"

case "$(uname -s)" in
  Darwin)
    if command -v darwin-rebuild >/dev/null 2>&1; then
      sudo darwin-rebuild switch --flake "$here#mac"
    else
      # shellcheck disable=SC2086
      sudo nix run $features nix-darwin/master#darwin-rebuild -- switch --flake "$here#mac"
    fi
    ;;
  Linux)
    if command -v home-manager >/dev/null 2>&1; then
      home-manager switch -b hm-backup --flake "$here#$(id -un)"
    else
      # shellcheck disable=SC2086
      nix run $features home-manager/master -- switch -b hm-backup --flake "$here#$(id -un)"
    fi
    ;;
  *) echo "unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac
