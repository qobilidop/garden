---
author: Claude Fable 5.1
---

# Host configuration moves to Nix

Bili's decision: every machine's packages, shell, and GUI apps are
declared in `config/nix/`, so a new Mac or Ubuntu box is "install Nix,
clone garden, one switch". Written after the config landed and before
the first switch on the Mac.

## Decisions

- **Nix over a Brewfile plus dotfile manager.** The small dotfile
  surface was an effect of waiting for a portable home, not evidence
  against one; a Linux machine is imminent; the expressions are
  agent-written, so the learning cliff is not Bili's cost.
- **Upstream Nix, community installer** (`artifacts.nixos.org`).
  Nixpkgs, home-manager, and nix-darwin test against upstream first
  and nothing sits between them and a vendor. Lix is the fallback if
  upstream churn bites (`nix.package = pkgs.lix`); Determinate only if
  macOS upgrades keep breaking the daemon (`nix.enable = false` plus
  its installer, which no longer offers upstream since 2026-01-01).
  The choice is one line in `darwin.nix`; on Ubuntu it is a reinstall
  with the config untouched.
- **Three layers.** Host (`home.nix` portable, `darwin.nix` and
  `linux.nix` thin shells); project (`flake.nix` per repository with a
  dev shell, CI runs the same shell); dev container (only for
  repositories with collaborators, derived from the flake so the two
  cannot disagree). Garden is curator-only, so its image retires once
  the flake shell reproduces a transcript byte-identically and CI
  builds the site from it.
- **Command-line tools from Nix on both platforms; GUI apps from the
  OS's native channel** (casks on macOS, declared in `darwin.nix` and
  installed by brew, which nix-homebrew itself installs and pins; apt
  on Ubuntu, outside the flake). Nixpkgs carries the Linux GUI apps
  but non-NixOS hosts need nixGL and get uneven desktop integration.
- **Project libraries leave the host.** boost, antlr, its C++
  runtime, re2c, and the JDK were installed for compiler projects and
  now belong to those repositories' flakes.
- **Tool-rewritten configs stay on copies.** Home-manager's
  `programs.claude-code` and `programs.codex` modules write read-only
  store symlinks; Claude Code rewrites settings.json and its Linux
  sandbox fails on a store symlink (anthropics/claude-code#52525,
  closed as not planned); Codex writes trust records into
  config.toml. The existing sync tools are the community's
  copy-instead-of-symlink workaround already written; the activation
  step runs them on every switch. The two CLIs install natively.
- **Freshness.** nixpkgs unstable was within days of upstream for
  every checked tool except z3 (4.16.0 against 5.1.0) and trails
  Claude Code by a few versions; stable lags months. Effective lag is
  the `nix flake update` cadence, weekly intended.

## Findings

- home-manager's git module now takes `settings.user.name` /
  `settings.user.email` (verified against the module source before
  writing).
- `homebrew.onActivation.cleanup` starts at `"none"`: the first switch
  must not remove the 99 formulae until the Nix copies are verified,
  and VS Code (this session's terminal) must not be reinstalled;
  brew's upgrade skips self-updating casks unless greedy.
- Flakes evaluate only git-tracked files; new files are staged before
  the first switch.

## Done since

- Four switches on the Mac the same day: the first switch, then the
  PATH-order fix with `cleanup = "uninstall"` (Homebrew's `shellenv`
  re-fronted Homebrew on every shell; it is never evaluated under
  nix-darwin now), then `python3` for the Codex sync tool (Homebrew's
  Python left with the formulae), then VS Code settings and extensions
  from `vscode.nix`. Every host tool resolves from the Nix profile,
  both sync tools report in sync, zero formulae remain.

- Layer 2 the same day: the garden root `flake.nix` follows this
  flake's nixpkgs through a relative path input (one nixpkgs pin, two
  lock files; Nix neither refreshes nor checks the root copy, so
  `hooks/lint.sh` and CI compare them and `nix flake update host` is
  the repair). CI runs in that shell on upstream Nix; the transcript
  gate passed (two papers byte-identical, one modulo editor-stripped
  whitespace) and the dev image, `dev.sh`, and `.devcontainer/` are
  gone. Language package managers come from Nix, language packages
  from their lockfiles (uv for `tools/`, npm for `site/`).
- `host-config.yml` runs `bootstrap.sh` and `verify.sh` on a clean
  Ubuntu runner as this user (Nix install, pinned activation, the Nix
  zsh registered as login shell) and builds the darwin system on a
  macOS runner. It found two bootstrap bugs before any real Ubuntu box
  did: the first-run CLI came unpinned from master, and the Codex sync
  refused a home Codex had never written.

## Pending

- Ubuntu: the real box (existing dotfiles, `hm-backup` collisions),
  the apt GUI step, possibly an aarch64-linux entry. The clean-home
  path is CI-verified.
- Sentiment and ecosystem notes from the research (governance strain,
  three implementations, alternatives) live in the session, not here;
  re-research before revisiting the implementation choice.
