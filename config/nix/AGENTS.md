# config/nix

Host configuration for every machine: one flake, upstream Nix.

- `home.nix` is the portable user layer (packages, shell, git, direnv);
  `darwin.nix` and `linux.nix` are thin OS shells. Command-line tools
  come from Nix on both platforms; GUI apps come from Homebrew casks on
  macOS (declared in `darwin.nix`, brew installed by nix-homebrew) and
  from apt on Ubuntu (outside this flake). Project libraries and
  toolchains belong to per-repository flakes, never here.
- Apply with `bootstrap.sh` (first run installs Nix) or, afterwards,
  `sudo darwin-rebuild switch --flake .#mac` / `home-manager switch
  --flake .#qobilidop`. Update with `nix flake update` then a switch;
  `flake.lock` is the pin and is committed. Flakes evaluate only
  git-tracked files: `git add` new files before switching.
- Claude Code and Codex configs stay on `config/claude` and
  `config/codex` (copies, not store symlinks: both tools rewrite their
  own files). The activation step pushes them on every switch; their
  binaries install natively, outside Nix. Ubuntu GUI apps (VS Code,
  Chrome, Zoom, Termius, 1Password) are a manual apt step, untested.
- Implementation choice is one line in `darwin.nix`: upstream now; Lix
  is `nix.package = pkgs.lix`, Determinate is `nix.enable = false` plus
  its installer. Recorded in
  `scratch/2026/2026-09-07/host-config-nix.md`.
- Pending: flip `homebrew.onActivation.cleanup` to `"uninstall"` after
  the Nix-provided tools are verified on the Mac.
