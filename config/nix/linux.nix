# Non-NixOS Linux shell around home.nix.
{ ... }:
{
  # Session variables and desktop entries on a host whose OS is not Nix-managed.
  targets.genericLinux.enable = true;
}
