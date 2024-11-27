{ config, lib, pkgs, ... }:
let
  cfgDsk = config.gravelOS.desktop;
in {
  config = lib.mkIf (cfgDsk.enable && cfgDsk.gaming.enable) {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.gamemode = {
      enable = true;
      settings = {
        general = { softrealtime = "auto"; renice = 10; };
        cpu.pin_cores="yes";
      };
    };

    security.pam.loginLimits = [
      { domain = "@gamemode"; item = "nice"; type = "soft"; value = "-20"; }
    ];

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
