# TODO: look into steam millenium

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.gaming;
in
{
  options.gravelOS.desktop.gaming = {
    enable = lib.mkEnableOption "general gaming support";
    steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics.enable32Bit = true;

    programs.steam = lib.mkIf cfg.steam.enable {
      enable = true;
      package = pkgs.gravelOS.steam-silent;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
