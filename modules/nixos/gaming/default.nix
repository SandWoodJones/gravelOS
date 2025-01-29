{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.gaming;
in {
  options.gravelOS.gaming = {
    enable = lib.mkEnableOption "light gaming support";
    dedicated = lib.mkEnableOption "heavy gaming support";
    steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics.enable32Bit = true;

    # TODO: look into millenium
    programs.steam = lib.mkIf cfg.steam.enable {      
      enable = true;
      package = pkgs.gravelOS.steam-silent;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = cfg.dedicated;
      remotePlay.openFirewall = cfg.dedicated;
    };

    # TODO: figure out gpu configuration
    programs.gamemode = lib.mkIf cfg.dedicated {
      enable = true;
      settings = {
        general = { softrealtime = "auto"; renice = 10; };
        cpu.pin_cores="yes";
      };
    };

    security.pam.loginLimits = lib.mkIf cfg.dedicated [
      { domain = "@gamemode"; item = "nice"; type = "soft"; value = "-20"; }
    ];
  };
}
