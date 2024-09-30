{ config, lib, ... }:
let
  nh-cfg = config.gravelOS.services.nh-clean;
in {
  config = {
    nix = { inherit (lib.gravelOS.nix) settings; };
  
    programs.nh = {
      enable = true;
      clean = {
        enable = config.gravelOS.services.nh-clean.enable;
        extraArgs = "--keep ${builtins.toString nh-cfg.keepGenerations} --keep-since ${nh-cfg.keepSince}";
      };
    };
  };
}
