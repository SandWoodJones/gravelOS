{ osConfig, config, lib, ... }:
let
  osCfg = osConfig.gravelOS.networking.bluetooth;
  cfg = config.gravelOS.networking.bluetooth;
in {
  config = lib.mkIf (osCfg.enable && cfg.mediaControls) {
    services.mpris-proxy.enable = true;
  };
}
