{ ... }: {
  imports = [ ./hardware-configuration.nix ];
  
  gravelOS = {
    networking = {
      wifi.enable = true;
      bluetooth.enable = true;
      avahi.enable = true;
    };

    desktop = {
      enable = true;
      gaming.steam.enable = true;
    };

    services.nh-clean.enable = true;
  };

  # DO NOT CHANGE
  system.stateVersion = "24.11";
}
