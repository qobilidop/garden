# Non-NixOS Linux shell around home.nix.
{ pkgs, ... }:
{
  # Session variables and desktop entries on a host whose OS is not Nix-managed.
  targets.genericLinux.enable = true;

  # The terminal font, registered with the OS through fontconfig; darwin.nix
  # installs the same package through nix-darwin.
  fonts.fontconfig.enable = true;
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
