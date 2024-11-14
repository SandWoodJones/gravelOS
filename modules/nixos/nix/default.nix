{ config, lib, pkgs, ... }:
let
  cfgNH = config.gravelOS.services.nh-clean;
in {
  config = {
    nix = { inherit (lib.gravelOS.nix) settings; };
  
    programs.nh = {
      enable = true;
      clean = {
        enable = cfgNH.enable;
        extraArgs = "--keep ${builtins.toString cfgNH.keepGenerations} --keep-since ${cfgNH.keepSince}";
      };
    };

    environment.systemPackages = [ pkgs.nil ];
  };
}
