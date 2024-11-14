{ config, lib, pkgs, ... }:
let
  cfgDsk = config.gravelOS.desktop;
in {
  config = lib.mkIf (cfgDsk.enable && cfgDsk.gaming.enable) {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
    };

    environment.systemPackages = with pkgs; [
      heroic
      lutris
    ];
  };
}
