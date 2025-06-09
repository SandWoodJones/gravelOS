{
  pkgs,
  lib,
  config,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "sd_mod"
      "thunderbolt"
      "usb_storage"
      "vmd"
      "xhci_pci"
    ];
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "xe.force_probe=46a3"
      "ahci.mobile_lpm_policy=1"
    ];
  };

  hardware = {
    graphics.extraPackages = [ pkgs.vpl-gpu-rt ];
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/25a2db9b-8560-4204-aa35-afe518fd50a4";
      fsType = "btrfs";
      options = [
        "subvol=root"
        "compress=zstd"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/3C18-23C2";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/25a2db9b-8560-4204-aa35-afe518fd50a4";
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=zstd"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/25a2db9b-8560-4204-aa35-afe518fd50a4";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/0db64767-a328-4f2c-9f44-e2e64d3e4bb4"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
