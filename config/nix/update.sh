#!/bin/sh
# Routine update: move every pinned input (nixpkgs, nix-darwin, home-manager,
# the Homebrew taps that version the brew-updated casks such as Claude Code,
# the VS Code extension overlay), keep the root dev-shell lock in step, build
# as the user, show what moved, then switch. Both locks are committed
# afterwards, by hand.
#
#   ~/my/garden/config/nix/update.sh
#   # then, from a fresh login shell:
#   ~/my/garden/config/nix/verify.sh
#
# The locks are written and the system built before the sudo switch, so the
# locks stay owned by the user (AGENTS.md) and a broken input fails here,
# before any password prompt. The switch itself is bootstrap.sh's later-run
# path, which reuses the build.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
garden="$(cd "$here/../.." && pwd)"

switched=no
report() {
  [ "$switched" = yes ] && return
  echo >&2
  echo "update: stopped before the switch; the locks may have moved:" >&2
  git -C "$garden" status --short -- flake.lock config/nix/flake.lock >&2
  echo "update: fix and rerun, or revert: git -C $garden checkout -- flake.lock config/nix/flake.lock" >&2
}
trap report EXIT

nix flake update --flake "$here"
# The root flake follows this nixpkgs by relative path; Nix never refreshes
# that copy on its own, and hooks/lint.sh refuses a commit where it lags.
nix flake update host --flake "$garden"

case "$(uname -s)" in
  Darwin)
    attr="darwinConfigurations.mac.system"
    current=/run/current-system
    ;;
  Linux)
    attr="homeConfigurations.$(id -un).activationPackage"
    current="$HOME/.local/state/nix/profiles/home-manager"
    ;;
  *) echo "unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac
new="$(nix build --no-link --print-out-paths "$here#$attr")"
if [ -e "$current" ]; then
  echo
  echo "update: closure changes:"
  nix store diff-closures "$current" "$new"
fi

"$here/bootstrap.sh"
switched=yes

echo
echo "update: switched; lock changes to review and commit:"
git -C "$garden" status --short -- flake.lock config/nix/flake.lock
echo "update: then, from a fresh login shell: $here/verify.sh"
