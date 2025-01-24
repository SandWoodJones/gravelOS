{ pkgs, lib, config, ... }:
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

    kernel = lib.mkOption {
      default = pkgs.linuxPackages;
      example = pkgs.linuxPackages_latest;
      description = "The Linux kernel used.";
    };

    # https://discourse.nixos.org/t/fix-freeze-after-wake-from-sleep-suspend-with-intel-raptor-lake-and-alder-lake-p/51677
    fixIntelVBT = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable a kernel patch for freezes related to Intel graphics";
      type = lib.types.bool;
    };
  };

  config = {
    time.hardwareClockInLocalTime = cfg.dualBoot;

    boot = {
      kernelPackages = cfg.kernel;
      kernelPatches = lib.optional cfg.fixIntelVBT { name = "Fix incorrect VBT"; patch = ./VBTfix.patch; };
    
      loader = {
        systemd-boot.enable = true; 
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
