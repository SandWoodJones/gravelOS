{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "ahci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" ];
    blacklistedKernelModules = [ "xe" ];
    kernelParams = [ "i915.force_probe=46a3" "ahci.mobile_lpm_policy=1" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/25a2db9b-8560-4204-aa35-afe518fd50a4";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

    "/home" = { 
      device = "/dev/disk/by-uuid/25a2db9b-8560-4204-aa35-afe518fd50a4";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/25a2db9b-8560-4204-aa35-afe518fd50a4";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/3C18-23C2";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/0db64767-a328-4f2c-9f44-e2e64d3e4bb4"; }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
