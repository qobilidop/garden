{
  description = "Bili's host configuration: one flake for macOS and Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-homebrew installs Homebrew itself (pinned here like every other
    # input); nix-darwin's homebrew module then drives what brew installs.
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    # Marketplace VS Code extensions that nixpkgs lacks (vscode.nix).
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      nix-vscode-extensions,
      ...
    }:
    let
      user = "qobilidop";
      # One nixpkgs instantiation for both platforms: unfree for the VS Code
      # extensions (Pylance, cpptools, Remote Containers, Claude Code) and
      # the marketplace overlay behind pkgs.nix-vscode-extensions.
      nixpkgsConfig = {
        config.allowUnfree = true;
        overlays = [ nix-vscode-extensions.overlays.default ];
      };
    in
    {
      # macOS: `sudo darwin-rebuild switch --flake .#mac` (bootstrap.sh
      # handles the first run, before darwin-rebuild is on PATH).
      darwinConfigurations.mac = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs user; };
        modules = [
          ./darwin.nix
          { nixpkgs = nixpkgsConfig; }
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = { inherit user; };
            home-manager.users.${user} = import ./home.nix;
          }
        ];
      };

      # Linux (Ubuntu, non-NixOS): `home-manager switch --flake .#qobilidop`.
      # Assumes x86_64; add an aarch64-linux entry if that machine appears.
      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs ({ system = "x86_64-linux"; } // nixpkgsConfig);
        extraSpecialArgs = { inherit user; };
        modules = [
          ./home.nix
          ./linux.nix
        ];
      };
    };
}
