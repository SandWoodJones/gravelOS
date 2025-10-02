# TODO: add ephemeral (https://github.com/danisztls/ephemeral) step when building the home

{
  pkgs,
  lib,
  ...
}:
{
  inherit (lib.gravelOS) nix;
  scheme = lib.gravelOS.mkScheme pkgs;
  manual.html.enable = true;
}
