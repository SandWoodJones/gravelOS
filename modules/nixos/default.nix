{
  lib,
  inputs,
  ...
}:
{
  inherit (lib.gravelOS) nix sops;
  documentation.nixos.extraModules = builtins.attrValues inputs.self.nixosModules;
}
