# macOS shell around home.nix: daemon, Homebrew for GUI apps, system defaults.
{
  config,
  inputs,
  lib,
  pkgs,
  user,
  ...
}:
let
  # Who updates each GUI app is a fact recorded here, not remembered.
  # These carry their own updater and run it; brew skips them (the cask
  # declares `auto_updates`).
  selfUpdating = [
    "1password"
    "chatgpt"
    "claude"
    "ghostty"
    "google-chrome"
    "termius"
    "visual-studio-code"
    "zoom"
  ];
  # These have no updater of their own; brew upgrades them at a switch
  # after `nix flake update` moves the pinned cask tap.
  brewUpdated = [
    "claude-code@latest"
    "codex"
    "displaylink"
  ];
in
{
  nixpkgs.hostPlatform = "aarch64-darwin";

  assertions = [
    {
      assertion = lib.intersectLists selfUpdating brewUpdated == [ ];
      message = "darwin.nix: a cask is listed as both self-updating and brew-updated";
    }
  ];

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

  # The terminal font (Ghostty, the VS Code terminal, Starship's glyphs);
  # linux.nix installs the same package through fontconfig.
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  # Homebrew goes on PATH after the Nix profiles (order 1000) and before
  # the system directories (1200), so a Nix tool always wins over a
  # Homebrew one. `brew shellenv` is never evaluated: it calls path_helper,
  # which moves Homebrew to the front on every shell.
  environment.systemPath = lib.mkOrder 1100 [
    "${config.homebrew.prefix}/bin"
    "${config.homebrew.prefix}/sbin"
  ];

  nix-homebrew = {
    enable = true;
    inherit user;
    autoMigrate = true; # adopt the existing /opt/homebrew
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false; # taps update with `nix flake update`, not `brew update`
    # Each would `eval "$(brew shellenv)"`; see environment.systemPath.
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    onActivation = {
      autoUpdate = false; # the taps are pinned inputs
      upgrade = true; # the brewUpdated casks; brew skips the self-updating ones
      # Removes every formula: command-line tools come from home.nix.
      cleanup = "uninstall";
    };
    # GUI apps only; every command-line tool comes from home.nix.
    casks = selfUpdating ++ brewUpdated;
  };

  # macOS preferences (`defaults write` equivalents) go here when wanted.
  system.defaults = { };
}
