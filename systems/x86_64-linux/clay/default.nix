{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    desktop.gaming.enable = true;
    networking.ports.spotifyOpen = true;
  };


  system.stateVersion = "24.05";
}
