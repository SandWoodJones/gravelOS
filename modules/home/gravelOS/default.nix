{ lib, ... }: {
  config = {
    nix = { inherit (lib.gravelOS.nix) settings; };
  };
}
