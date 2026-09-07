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
  };

  outputs =
    inputs@{ nixpkgs, nix-darwin, home-manager, nix-homebrew, ... }:
    let
      user = "qobilidop";
    in
    {
      # macOS: `sudo darwin-rebuild switch --flake .#mac` (bootstrap.sh
      # handles the first run, before darwin-rebuild is on PATH).
      darwinConfigurations.mac = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs user; };
        modules = [
          ./darwin.nix
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
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit user; };
        modules = [
          ./home.nix
          ./linux.nix
        ];
      };
    };
}
