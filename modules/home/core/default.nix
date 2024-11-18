{ lib, osConfig, config, ... }: {
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

    desktop = {
      enable = lib.mkEnableOption "a desktop environment";
      blender.enable = lib.mkEnableOption "blender";
      gaming = {
        enable = lib.mkEnableOption "gaming support";
        openMW.enable = lib.mkEnableOption "OpenMW";
      };
    };
  };

  config = {
    nix = { inherit (lib.gravelOS.nix) settings; };

    gravelOS = {
      networking.bluetooth.enable = lib.mkDefault osConfig.gravelOS.networking.bluetooth.enable;
      desktop = {
        enable = lib.mkDefault osConfig.gravelOS.desktop.enable;
        gaming.enable = lib.mkDefault (osConfig.gravelOS.desktop.gaming.enable && config.gravelOS.desktop.enable);
      };
    };
  };
}
