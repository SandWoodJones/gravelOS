{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  inherit (lib.gravelOS) nix sops;
  environment.systemPackages = [ pkgs.home-manager ];
  documentation.nixos.extraModules = builtins.attrValues inputs.self.nixosModules;
}
