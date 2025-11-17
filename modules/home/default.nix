# TODO: add ephemeral (https://github.com/danisztls/ephemeral) step when building the home

{
  pkgs,
  lib,
  ...
}:
{
  inherit (lib.gravelOS) nix scheme;
  manual.html.enable = true;
}
