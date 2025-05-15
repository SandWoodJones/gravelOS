# TODO: add and configure plymouth https://github.com/mxxntype/Aeon-snowfall/blob/main/modules/nixos/boot/default.nix

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.boot;
in
{
  options.gravelOS.system.boot = {
    dualBoot = lib.mkEnableOption "dual booting.";
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
