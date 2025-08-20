{
  lib,
  ...
}:
{
  inherit (lib.gravelOS) nix;

  manual.html.enable = true;
}
