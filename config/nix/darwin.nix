# macOS shell around home.nix: daemon, Homebrew for GUI apps, system defaults.
{
  config,
  inputs,
  user,
  ...
}:
{
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Upstream Nix: nix-darwin owns the daemon. Determinate Nix would need
  # `nix.enable = false`; Lix would be `nix.package = pkgs.lix`.
  nix.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 7;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.primaryUser = user;
  users.users.${user}.home = "/Users/${user}";

  # Installs the shell hooks that put Nix on PATH.
  programs.zsh.enable = true;

  nix-homebrew = {
    enable = true;
    inherit user;
    autoMigrate = true; # adopt the existing /opt/homebrew
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false; # taps update with `nix flake update`, not `brew update`
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    onActivation = {
      autoUpdate = false; # the taps are pinned inputs
      upgrade = true; # self-updating casks (VS Code, Chrome) are skipped by brew
      # "none" for the first switch; flip to "uninstall" once the Nix-provided
      # tools are verified, to remove the formulae Homebrew no longer owns.
      cleanup = "none";
    };
    # GUI apps only; every command-line tool comes from home.nix.
    casks = [
      "1password"
      "chatgpt"
      "claude"
      "claude-code@latest"
      "codex"
      "displaylink"
      "google-chrome"
      "termius"
      "visual-studio-code"
      "zoom"
    ];
  };

  # macOS preferences (`defaults write` equivalents) go here when wanted.
  system.defaults = { };
}
