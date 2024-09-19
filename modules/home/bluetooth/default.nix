{ lib, osConfig, config, ... }: {
  options.gravelOS.bluetooth.mediaControls = {
    enable = lib.mkOption {
      description = "Whether to enable bluetooth headset buttons to control media players";
      type = lib.types.bool;
      default = false;
    };
  };
  
  config = lib.mkIf (osConfig.gravelOS.bluetooth.enable && config.gravelOS.bluetooth.mediaControls.enable) {
    services.mpris-proxy.enable = true;
  };
}
