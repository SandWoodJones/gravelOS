{ lib, config, pkgs, ... }: {
  options.gravelOS = {
    desktop = {
      enable = lib.mkOption {
        default = true;
        description = "Whether to enable a display server and desktop environment.";
        type = lib.types.bool;
      };
    
      audio.enable = lib.mkOption {
        default = true;
        description = "Whether to enable audio with pipewire.";
        type = lib.types.bool;
      };
    };

    networking = {
      bluetooth.enable = lib.mkOption {
        default = false;
        description = "Whether to enable bluetooth services.";
        type = lib.types.bool;
      };

      wifi.enable = lib.mkOption {
        default = true;
        description = "Whether to enable network manager.";
        type = lib.types.bool;
      };

      ports.spotifyOpen = lib.mkOption {
        default = false;
        description = "Whether to open the necessary ports for spotify";
        type = lib.types.bool;
      };
    };
  
    services.nh-clean = {
      enable = lib.mkOption {
        default = true;
        description = "Whether to enable nh's periodic garbage collection.";
        type = lib.types.bool;
      };

      keepGenerations = lib.mkOption {
        default = 10;
        description = "The minimum number of generations that nh-clean should keep.";
        type = lib.types.ints.unsigned;
      };

      keepSince = lib.mkOption {
        default = "10d";
        description = "The time range since now of generations that should be kept by nh-clean.";
        type = lib.types.nonEmptyStr;
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
