{ lib, ... }: {
  config = {
    nix = { inherit (lib.gravelOS.nix) settings; };

    documentation = {
      dev.enable = true;
      man.generateCaches = true;
    };
  };
}
