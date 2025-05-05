{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7b83098a-8333-417f-8493-250c5119a593";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/403D-1902";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/6eda002e-73a5-411c-870a-0e4096c5c83d";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/00b148d6-9701-4742-aff9-a5ae7335a7f4"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
