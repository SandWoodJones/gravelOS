{ lib, config, ... }: {
  options.gravelOS = with lib; {
    desktop = {
      gaming = {
        steam.enable = lib.mkEnableOption "steam";
        enable = lib.mkEnableOption "gaming support";
      };
    };

    networking = {
      avahi.enable = mkEnableOption "the Avahi daemon";
      wifi.enable = mkEnableOption "network manager";

      spotifyOpenPorts = mkOption {
        default = false;
        description = "Whether to open the necessary ports for spotify";
        type = types.bool;
      };
    };
  };

  config = {
    documentation = {
      dev.enable = true;
      man.generateCaches = true;
    };

    time.timeZone = "America/Sao_Paulo";

    gravelOS.networking.spotifyOpenPorts = config.gravelOS.desktop.enable;
  };
}
