# Portable user layer: identical on macOS and Linux.
{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  garden = "${config.home.homeDirectory}/my/garden";
in
{
  home.username = user;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${user}" else "/home/${user}";
  # Compatibility marker for the first install; never bumped casually.
  home.stateVersion = "26.05";

  # Command-line tools. Project libraries (boost, antlr, jdk, re2c) live in
  # per-repository flakes, not here. gitleaks is a pin site: nixpkgs' version
  # must match GITLEAKS_VERSION in .github/workflows/gitleaks.yml and the
  # .devcontainer/Dockerfile download.
  home.packages =
    with pkgs;
    [
      # version control and repo hygiene
      gh
      git
      git-filter-repo
      gitleaks
      pre-commit
      # documents
      pandoc
      poppler-utils
      typst
      # build tools
      cmake
      ninja
      bazelisk
      # toolchain managers; the toolchains themselves are per project
      rustup
      # containers: CLI here, daemon from colima (macOS) or apt (Linux)
      docker
      docker-buildx
      devcontainer
      # solvers
      z3
      # sync
      rclone
      # agents (Claude Code and Codex install natively, see AGENTS.md)
      gemini-cli
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [ colima ];

  programs.home-manager.enable = true;

  # Homebrew's PATH entry is the OS shell's business (darwin.nix).
  programs.zsh.enable = true;
  home.sessionPath = [
    "$HOME/.cargo/bin" # rustup proxies
    "$HOME/.local/bin" # native installers (Claude Code)
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "Bili Dong";
      email = "qobilidop@gmail.com";
    };
    ignores = [ "**/.claude/settings.local.json" ];
  };

  # Per-project flakes activate through direnv (`use flake` in .envrc).
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Claude Code and Codex rewrite their own config files, so those stay on
  # the copy-based sync tools in config/claude and config/codex rather than
  # store symlinks; every switch pushes the canonical copies.
  home.activation.syncAgentConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "${garden}/config" ]; then
      export PATH="${pkgs.python3}/bin:$PATH"
      mkdir -p "$HOME/.claude" "$HOME/.codex"
      run "${garden}/config/claude/sync.sh" push
      run "${garden}/config/codex/sync.sh" push
    else
      warnEcho "garden not found at ${garden}; Claude/Codex configs not synced"
    fi
  '';
}
