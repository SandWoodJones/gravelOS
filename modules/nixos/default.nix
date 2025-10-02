{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  inherit (lib.gravelOS) nix;
  scheme = lib.gravelOS.mkScheme pkgs;
  environment.systemPackages = [ pkgs.home-manager ];
  documentation.nixos.extraModules = builtins.attrValues inputs.self.nixosModules;
}
