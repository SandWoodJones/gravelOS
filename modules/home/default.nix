# TODO: add ephemeral (https://github.com/danisztls/ephemeral) step when building the home

{
  lib,
  ...
}:
{
  inherit (lib.gravelOS) nix;

  manual.html.enable = true;
}
