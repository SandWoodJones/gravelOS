{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    networking = {
      ports.spotifyOpen = true;
    };
  };


  system.stateVersion = "24.05";
}
