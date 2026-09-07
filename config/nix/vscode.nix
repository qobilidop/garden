# VS Code user configuration: settings, keybindings, extensions. The app itself
# comes from the OS layer (Homebrew cask on macOS, apt on Ubuntu), so
# `package = null`; Home Manager manages only what lives under the user dir.
# settings.json and ~/.vscode/extensions become store symlinks: edit here and
# switch, never through the settings UI or the Extensions view.
{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  flake = "${config.home.homeDirectory}/my/garden/config/nix";
  # nixpkgs first (reviewed, with platform fixups); the marketplace overlay
  # covers what nixpkgs lacks. Both move with `nix flake update`.
  nixpkgsExt = pkgs.vscode-extensions;
  marketExt = pkgs.nix-vscode-extensions.vscode-marketplace;
in
{
  programs.vscode = {
    enable = true;
    package = null;
    mutableExtensionsDir = false;

    profiles.default = {
      enableExtensionUpdateCheck = false; # extensions update through Nix

      extensions =
        (with nixpkgsExt; [
          # nix
          jnoortheen.nix-ide
          # agents
          anthropic.claude-code
          # python
          ms-python.python
          ms-python.debugpy
          ms-python.vscode-pylance
          ms-python.vscode-python-envs
          # c++ and build
          ms-vscode.cpptools
          ms-vscode.cpptools-extension-pack
          ms-vscode.cmake-tools
          # containers and ci
          ms-vscode-remote.remote-containers
          ms-azuretools.vscode-containers
          github.vscode-github-actions
          # documents
          tomoki1207.pdf
        ])
        ++ (with marketExt; [
          ms-vscode.cpp-devtools
          ms-vscode.cpptools-themes
        ]);

      userSettings = {
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
        "containers.containerClient" = "com.microsoft.visualstudio.containers.docker";
        "containers.orchestratorClient" = "com.microsoft.visualstudio.orchestrators.dockercompose";

        # Nix IDE drives nixd; store paths, because a Finder-launched app does
        # not see the shell PATH. They refresh with every switch.
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = lib.getExe pkgs.nixd;
        "nix.formatterPath" = lib.getExe pkgs.nixfmt;
        "nix.serverSettings".nixd = {
          formatting.command = [ (lib.getExe pkgs.nixfmt) ];
          nixpkgs.expr = "import (builtins.getFlake \"${flake}\").inputs.nixpkgs { }";
          # Option completion for this flake's own modules.
          options =
            if pkgs.stdenv.hostPlatform.isDarwin then
              {
                nix-darwin.expr = "(builtins.getFlake \"${flake}\").darwinConfigurations.mac.options";
                home-manager.expr = "(builtins.getFlake \"${flake}\").darwinConfigurations.mac.options.home-manager.users.type.getSubOptions [ ]";
              }
            else
              {
                home-manager.expr = "(builtins.getFlake \"${flake}\").homeConfigurations.${user}.options";
              };
        };
      };

      keybindings = [
        {
          # Shift+Enter in the terminal sends ESC CR: a newline inside a
          # CLI agent's prompt instead of submitting it. Nix strings have no
          # \u escape, so the sequence goes through JSON.
          key = "shift+enter";
          command = "workbench.action.terminal.sendSequence";
          args.text = builtins.fromJSON ''"\u001b\r"'';
          when = "terminalFocus";
        }
      ];
    };
  };
}
