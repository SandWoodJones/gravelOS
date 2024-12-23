{ config, lib, pkgs, ... }:
let
  cfgDsk = config.gravelOS.desktop;
in {
  config = lib.mkIf cfgDsk.enable (lib.mkMerge [
    (lib.mkIf cfgDsk.gaming.enable {
      hardware.graphics.enable32Bit = true;

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

      environment.systemPackages = with pkgs; [
        wine
        heroic
        lutris
      ];
    })

    {
      programs.steam = lib.mkIf cfgDsk.gaming.steam.enable {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
      };
    }
  ]);
}
