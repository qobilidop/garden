# config/nix

Host configuration for every machine: one flake, upstream Nix.

- `home.nix` is the portable user layer (packages, shell, git, direnv;
  `vscode.nix` for the editor); `darwin.nix` and `linux.nix` are thin
  OS shells. Command-line tools come from Nix on both platforms; GUI
  apps come from Homebrew casks on macOS (declared in `darwin.nix`,
  brew installed by nix-homebrew) and from apt on Ubuntu (outside this
  flake). Project libraries and toolchains belong to per-repository
  flakes, never here.
- Apply with `bootstrap.sh` (first run installs Nix) or, afterwards,
  `sudo darwin-rebuild switch --flake .#mac` / `home-manager switch
  --flake .#qobilidop`. Update with `nix flake update` then a switch;
  `flake.lock` is the pin and is committed. Flakes evaluate only
  git-tracked files: `git add` new files before switching. Lock as the
  user (`nix flake lock`) before a sudo switch: a switch that has to
  lock a new input writes `flake.lock` as root.
- Claude Code and Codex configs stay on `config/claude` and
  `config/codex` (copies, not store symlinks: both tools rewrite their
  own files). The activation step pushes them on every switch; their
  binaries install natively, outside Nix. Ubuntu GUI apps (VS Code,
  Chrome, Zoom, Termius, 1Password) are a manual apt step, untested.
- VS Code: the app is a cask (apt on Ubuntu); `vscode.nix` owns
  settings, keybindings, and extensions as store symlinks, so the
  settings UI and the Extensions view cannot save — declare the change
  and switch. Extensions come from `pkgs.vscode-extensions` first and
  from the nix-vscode-extensions overlay only where nixpkgs has none;
  `nix.serverPath` and the formatter are store paths (a Finder-launched
  app has no shell PATH).
- Implementation choice is one line in `darwin.nix`: upstream now; Lix
  is `nix.package = pkgs.lix`, Determinate is `nix.enable = false` plus
  its installer. Recorded in
  `scratch/2026/2026-09-07/host-config-nix.md`.
- PATH order is Nix profiles, then Homebrew, then the system, set in
  `darwin.nix` through `environment.systemPath`; `brew shellenv` is
  never evaluated, because it re-fronts Homebrew on every shell.
