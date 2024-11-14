{ lib, ... }: {
  options.gravelOS = with lib; {
    desktop = {
      enable = lib.mkEnableOption "a display server and desktop environment";
      gaming.enable = lib.mkEnableOption "gaming support";
    
      audio.enable = mkOption {
        default = true;
        description = "Whether to enable audio with pipewire";
        type = types.bool;
      };
    };

    networking = {
      bluetooth.enable = mkEnableOption "bluetooth services";
      avahi.enable = mkEnableOption "the Avahi daemon";
      wifi.enable = mkEnableOption "network manager";

      ports.spotifyOpen = mkOption {
        default = false;
        description = "Whether to open the necessary ports for spotify";
        type = types.bool;
      };
    };
  
    services.nh-clean = {
      enable = mkEnableOption "periodic garbage collection with nh";

      keepGenerations = mkOption {
        default = 10;
        description = "The minimum number of generations that nh-clean should keep.";
        type = types.ints.unsigned;
      };

      keepSince = mkOption {
        default = "10d";
        description = "The time range since now of generations that should be kept by nh-clean.";
        type = types.nonEmptyStr;
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
  };
}
