# config/nix

Host configuration for every machine: one flake, upstream Nix.

- `home.nix` is the portable user layer (packages, shell, git, direnv;
  `vscode.nix` for the editor); `darwin.nix` and `linux.nix` are thin
  OS shells. Command-line tools come from Nix on both platforms; GUI
  apps come from Homebrew casks on macOS (declared in `darwin.nix`,
  brew installed by nix-homebrew) and from apt on Ubuntu (outside this
  flake). Project libraries and toolchains belong to per-repository
  flakes, never here.
- Apply with `bootstrap.sh` (first run installs Nix and activates the
  pinned generation directly) or, afterwards, `sudo darwin-rebuild
  switch --flake .#mac` / `home-manager switch --flake .#qobilidop`;
  then `verify.sh` from a fresh login shell. Update with `nix flake
  update` here, then `nix flake update host` at the repo root (the
  root flake follows this nixpkgs, and Nix neither refreshes nor checks
  that copy on its own — `hooks/lint.sh` and the Host config workflow
  do), then a switch; both `flake.lock` files are committed. Flakes
  evaluate only git-tracked files: `git add` new files before
  switching. Lock as the user (`nix flake lock`) before a sudo switch:
  a switch that has to lock a new input writes `flake.lock` as root.
- `.github/workflows/host-config.yml` runs `bootstrap.sh` and
  `verify.sh` on a clean Ubuntu runner as this user, builds the darwin
  system on a macOS runner (no activation: that would test cask
  downloads, not this config), and checks the two locks agree.
- Claude Code and Codex configs stay on `config/claude` and
  `config/codex` (copies, not store symlinks: both tools rewrite their
  own files). The activation step pushes them on every switch; their
  binaries install natively, outside Nix. zsh comes from `home.nix`;
  on Ubuntu `bootstrap.sh` registers it as the login shell
  (`/etc/shells`, `chsh`), the one shell step the OS owns. Ubuntu GUI
  apps (VS Code, Chrome, Zoom, Termius, 1Password, Ghostty — official
  apt from 26.04, the community `.deb` before) are a manual apt step,
  untested.
- Ghostty: cask on macOS, apt on Ubuntu; `home.nix` owns
  `~/.config/ghostty/config` (`programs.ghostty`, `package = null`, so
  the module's config validation does not run — check a changed config
  with `ghostty +validate-config` before switching).
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
