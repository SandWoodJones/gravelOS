{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    boot = { zenKernel = true; dualBoot = true; };

    networking = {
      bluetooth.enable = true;
      avahi.enable = true;
      ports.spotifyOpen = true;
    };

    desktop = {
      enable = true;
      gaming.enable = true;
    };

    services.nh-clean.enable = true;
  };

  hardware.amdgpu.initrd.enable = true;

  system.stateVersion = "24.05";
}
