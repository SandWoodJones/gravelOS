{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    networking = {
      bluetooth.enable = true;
      ports.spotifyOpen = true;
    };
  };

  # DO NOT CHANGE
  system.stateVersion = "24.05";
}
