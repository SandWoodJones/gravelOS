{ lib, ... }: {
  options.gravelOS = with lib; {
    desktop = {
      enable = mkOption {
        default = true;
        description = "Whether to enable a display server and desktop environment.";
        type = types.bool;
      };
    
      audio.enable = mkOption {
        default = true;
        description = "Whether to enable audio with pipewire.";
        type = types.bool;
      };

      gaming.enable = mkOption {
        default = false;
        description = "Whether to enable gaming support.";
        type = types.bool;
      };
    };

    networking = {
      bluetooth.enable = mkOption {
        default = false;
        description = "Whether to enable bluetooth services.";
        type = types.bool;
      };

      wifi.enable = mkOption {
        default = false;
        description = "Whether to enable network manager.";
        type = types.bool;
      };

      ports.spotifyOpen = mkOption {
        default = false;
        description = "Whether to open the necessary ports for spotify";
        type = types.bool;
      };
    };
  
    services.nh-clean = {
      enable = mkOption {
        default = true;
        description = "Whether to enable nh's periodic garbage collection.";
        type = types.bool;
      };

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
      dualBoot = mkOption {
        default = false;
        description = "Whether this system has a dual boot windows installation.";
        type = types.bool;
      };
    };

    nix.nil.enable = mkOption {
      default = true;
      description = "Whether to enable nil, the NIx Language server.";
      type = types.bool;
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
