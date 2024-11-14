{ lib, config, ... }: {
  config = lib.mkIf config.gravelOS.networking.bluetooth.enable {
    services.mpris-proxy.enable = config.gravelOS.networking.bluetooth.mediaControls;
  };
}
