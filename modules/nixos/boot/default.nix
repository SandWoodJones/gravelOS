{ lib, config, ... }:
let
  cfg = config.gravelOS.boot;
in {
  options.gravelOS.boot = {
    dualBoot = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable dual boot related options";
      type = lib.types.bool;
    };
  };

  config = {
    time.hardwareClockInLocalTime = cfg.dualBoot;

    boot = {
      loader = {
        systemd-boot.enable = true; 
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
