{ config, ... }: {
  config = {
    time.hardwareClockInLocalTime = config.gravelOS.boot.dualBoot;

    boot = {
      loader = {
        systemd-boot.enable = true; 
        efi.canTouchEfiVariables = true; 
      };
    };
  };
}
