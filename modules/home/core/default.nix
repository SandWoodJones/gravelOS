{ lib, osConfig, config, ... }: {
  options.gravelOS = {
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
      desktop = {
        enable = lib.mkDefault osConfig.gravelOS.desktop.enable;
        gaming.enable = lib.mkDefault (osConfig.gravelOS.desktop.gaming.enable && config.gravelOS.desktop.enable);
      };
    };
  };
}
