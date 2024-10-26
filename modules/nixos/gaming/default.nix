{ config, lib, pkgs, ... }:
let
  cfg = config.gravelOS.desktop;
in {
  config = lib.mkIf (cfg.enable && cfg.gaming.enable) {
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
    };

    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
