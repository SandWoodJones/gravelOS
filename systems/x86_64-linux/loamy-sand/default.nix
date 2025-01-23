{ ... }: {
  imports = [ ./hardware-configuration.nix ];
  
  gravelOS = {
    ssh = { enable = true; secure = true; };
    bluetooth.enable = true;
    
    networking = {
      wifi.enable = true;
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
