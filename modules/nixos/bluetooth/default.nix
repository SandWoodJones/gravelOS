{ lib, config, ... }: {
  options.gravelOS.bluetooth.enable = lib.mkEnableOption "bluetooth";

  config = lib.mkIf config.gravelOS.bluetooth.enable {
    hardware.bluetooth = { enable = true; powerOnBoot = true; };
  };
}
