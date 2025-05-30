{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.networking;
in
{
  options.gravelOS.system.networking = {
    bluetooth.mediaControls.enable = lib.mkEnableOption "media controls for Bluetooth devices via MPRIS2";
  };

  config = {
    services.mpris-proxy.enable = cfg.bluetooth.mediaControls.enable;
  };
}
