# TODO: add and configure plymouth https://github.com/mxxntype/Aeon-snowfall/blob/main/modules/nixos/boot/default.nix

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.boot;
in
{
  options.gravelOS.system.boot = {
    dualBoot.enable = lib.mkEnableOption "dual booting";
    zen.enable = lib.mkEnableOption "the ZEN kernel";
  };

  config = {
    time.hardwareClockInLocalTime = cfg.dualBoot.enable;

    boot = {
      kernelPackages = lib.mkIf cfg.zen.enable pkgs.linuxPackages_zen;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
