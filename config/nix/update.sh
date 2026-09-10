#!/bin/sh
# Routine update: move every pinned input (nixpkgs, nix-darwin, home-manager,
# the Homebrew taps that version the brew-updated casks such as Claude Code,
# the VS Code extension overlay), keep the root dev-shell lock in step, then
# switch. Both locks are committed afterwards, by hand, after a look at what
# moved (the diff nix prints above the switch).
#
#   ~/my/garden/config/nix/update.sh
#   # then, from a fresh login shell:
#   ~/my/garden/config/nix/verify.sh
#
# The locks are written before the sudo switch, so they stay owned by the
# user (AGENTS.md). The switch itself is bootstrap.sh's later-run path.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
garden="$(cd "$here/../.." && pwd)"

nix flake update --flake "$here"
# The root flake follows this nixpkgs by relative path; Nix never refreshes
# that copy on its own, and hooks/lint.sh refuses a commit where it lags.
nix flake update host --flake "$garden"

"$here/bootstrap.sh"

echo
echo "update: switched; lock changes to review and commit:"
git -C "$garden" status --short -- flake.lock config/nix/flake.lock
echo "update: then, from a fresh login shell: $here/verify.sh"
