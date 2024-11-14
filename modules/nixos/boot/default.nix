{ config, lib, pkgs, ... }:
let
  cfg = config.gravelOS.boot;
in {
  config = {
    time.hardwareClockInLocalTime = config.gravelOS.boot.dualBoot;

    boot = {
      kernelPackages = lib.mkIf cfg.zenKernel pkgs.linuxPackages_zen;
      loader = {
        systemd-boot.enable = true; 
        efi.canTouchEfiVariables = true; 
      };
    };
  };
}
