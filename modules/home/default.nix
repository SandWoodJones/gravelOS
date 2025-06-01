{
  lib,
  ...
}:
{
  inherit (lib.gravelOS) nix sops;

  manual.html.enable = true;
}
