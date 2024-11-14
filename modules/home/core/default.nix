{ lib, osConfig, ... }: {
  options.gravelOS = {
    networking.bluetooth = {
      enable = lib.mkEnableOption "bluetooth services";      
      mediaControls = lib.mkOption {
        description = "Whether to enable bluetooth headset buttons to control media players";
        type = lib.types.bool;
        default = false;
      };
    };

    xdg.lowercaseDirs = lib.mkOption {
      description = "Whether to rename the default xdg-user dirs to lowercase";
      type = lib.types.bool;
      default = true;
    };

    desktop.gaming = {
      enable = lib.mkEnableOption "gaming support";
      openMW.enable = lib.mkOption {
        description = "Whether to enable OpenMW";
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = {
    nix = { inherit (lib.gravelOS.nix) settings; };

    gravelOS = {
      networking.bluetooth.enable = lib.mkDefault osConfig.gravelOS.networking.bluetooth.enable;
      desktop.gaming.enable = lib.mkDefault osConfig.gravelOS.desktop.gaming.enable;  
    };
  };
}
