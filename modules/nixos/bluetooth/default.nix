{ lib, config, ... }: {
  options.gravelOS.bluetooth = {
    enable = lib.mkOption {
      description = "Whether to enable bluetooth services";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.gravelOS.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}
