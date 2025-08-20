{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  inherit (lib.gravelOS) nix;
  environment.systemPackages = [ pkgs.home-manager ];
  documentation.nixos.extraModules = builtins.attrValues inputs.self.nixosModules;
}
