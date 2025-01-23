{ lib, config, ... }:
let
  cfg = config.gravelOS.nh;
in {
  options.gravelOS.nh = {
    enable = lib.mkEnableOption "the NH nix helper";
    clean.enable = lib.mkEnableOption "periodic garbage collection with nh";
  };

  config = lib.mkIf cfg.enable {  
    programs.nh = {
      enable = true;
      clean = lib.mkIf cfg.clean.enable {
        enable = true;
        extraArgs = "--keep 10 --keep-since 10d";
      };
    };
  };
}
