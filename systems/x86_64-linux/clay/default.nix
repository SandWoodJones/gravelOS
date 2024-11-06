{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    desktop.zenKernel = true;
    networking.bluetooth.enable = true;
    desktop.gaming.enable = true;
    networking.ports.spotifyOpen = true;
    boot.dualBoot = true;
  };


  system.stateVersion = "24.05";
}
