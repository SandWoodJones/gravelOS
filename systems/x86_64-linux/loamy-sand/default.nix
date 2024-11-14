{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    networking = {
      wifi.enable = true;
      bluetooth.enable = true;
      ports.spotifyOpen = true;
      avahi.enable = true;
    };
  };

  # DO NOT CHANGE
  system.stateVersion = "24.05";
}
