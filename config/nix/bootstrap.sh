#!/bin/sh
# New machine: install upstream Nix (community installer), then apply this
# flake. Idempotent; later runs are plain switches.
#
#   git clone https://github.com/qobilidop/garden ~/my/garden
#   ~/my/garden/config/nix/bootstrap.sh
#   # then, from a fresh login shell:
#   ~/my/garden/config/nix/verify.sh
#
# .github/workflows/host-config.yml runs this on a clean Ubuntu runner.
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
      # First run: the pinned system carries its own darwin-rebuild, so the
      # CLI that applies the flake is the one the flake locks.
      # shellcheck disable=SC2086
      out="$(nix build $features --no-link --print-out-paths "$here#darwinConfigurations.mac.system")"
      sudo "$out/sw/bin/darwin-rebuild" switch --flake "$here#mac"
    fi
    ;;
  Linux)
    if command -v home-manager >/dev/null 2>&1; then
      home-manager switch -b hm-backup --flake "$here#$(id -un)"
    else
      # First run: activate the pinned generation directly; it installs the
      # home-manager CLI (programs.home-manager.enable) for later switches.
      # shellcheck disable=SC2086
      out="$(nix build $features --no-link --print-out-paths "$here#homeConfigurations.$(id -un).activationPackage")"
      HOME_MANAGER_BACKUP_EXT=hm-backup "$out/activate"
    fi
    # Login shell: the zsh home.nix installs and configures. The OS keeps
    # the record (/etc/shells, passwd), the one shell step outside Nix.
    zsh="$HOME/.nix-profile/bin/zsh"
    if [ "$(getent passwd "$(id -un)" | cut -d: -f7)" != "$zsh" ]; then
      grep -qxF "$zsh" /etc/shells || echo "$zsh" | sudo tee -a /etc/shells >/dev/null
      sudo chsh -s "$zsh" "$(id -un)"
    fi
    ;;
  *) echo "unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac
