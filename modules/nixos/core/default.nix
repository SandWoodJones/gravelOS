{ lib, config, ... }: {
  options.gravelOS = with lib; {
    desktop = {
      enable = lib.mkEnableOption "a display server and desktop environment";
      gaming = {
        steam.enable = lib.mkEnableOption "steam";
        enable = lib.mkEnableOption "gaming support";
      };
    
      audio.enable = mkOption {
        default = true;
        description = "Whether to enable audio with pipewire";
        type = types.bool;
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
  
    boot = {
      zenKernel = mkEnableOption "the Zen kernel";
      
      dualBoot = mkOption {
        default = false;
        description = "Whether this system has a dual boot windows installation.";
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
