{ ... }: {
  imports = [ ./hardware-configuration.nix ];
  
  gravelOS = {
    ssh = { enable = true; secure = true; };
    git = { enable = true; enableConfig = true; };
    cli = { configEnable = true; nix-index.enable = true; };
    nh = { enable = true; clean.enable = true; };

    bluetooth.enable = true;
    
    networking = {
      wifi.enable = true;
      avahi.enable = true;
    };

    desktop = {
      enable = true;
      gaming.steam.enable = true;
    };
  };

  # DO NOT CHANGE
  system.stateVersion = "24.11";
}
