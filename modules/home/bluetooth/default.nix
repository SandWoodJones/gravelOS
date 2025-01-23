{ lib, config, osConfig, ... }: {
  options.gravelOS.bluetooth.mediaControls = lib.mkEnableOption "bluetooth media controls";

  config = lib.mkIf config.gravelOS.bluetooth.mediaControls {
    assertions = [{ assertion = osConfig.gravelOS.bluetooth.enable; message = "to enable bluetooth media controls, bluetooth must be enabled on the system"; }];

    services.mpris-proxy.enable = true;
  };
}
