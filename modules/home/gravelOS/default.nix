{ lib, ... }: {
  config = {
    nix = { inherit (lib.gravelOS.nix) settings; };
    fonts.fontconfig.enable = true;
  };
}
