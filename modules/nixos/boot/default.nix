{ config, lib, pkgs, ... }: {
  config = {
    time.hardwareClockInLocalTime = config.gravelOS.boot.dualBoot;

    boot = {
      kernelPackages = lib.mkIf config.gravelOS.desktop.zenKernel pkgs.linuxPackages_zen;
      loader = {
        systemd-boot.enable = true; 
        efi.canTouchEfiVariables = true; 
      };
    };
  };
}
