{ config, lib, pkgs, ... }:
let
  nh-cfg = config.gravelOS.services.nh-clean;
in {
  config = {
    nix = { inherit (lib.gravelOS.nix) settings; };
  
    programs.nh = {
      enable = true;
      clean = {
        enable = nh-cfg.enable;
        extraArgs = "--keep ${builtins.toString nh-cfg.keepGenerations} --keep-since ${nh-cfg.keepSince}";
      };
    };

    environment.systemPackages = with pkgs; lib.mkIf config.gravelOS.nix.nil.enable [
      nil
    ];
  };
}
