{
  lib,
  inputs,
  ...
}:
{
  inherit (lib.gravelOS) nix;
  documentation.nixos.extraModules = builtins.attrValues inputs.self.nixosModules;
}
