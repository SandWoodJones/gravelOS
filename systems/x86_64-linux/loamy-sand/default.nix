{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];
  
  gravelOS = {
    display.enable = true;
    audio.enable = true;
    kde.plasma.enable = true;
    ssh = { enable = true; secure = true; };
    git = { enable = true; enableConfig = true; };
    cli = { configEnable = true; nix-index.enable = true; };
    nh = { enable = true; clean.enable = true; };

    zsh = {
      enable = true;
      enableConfig = true;
      default = true;
    };

    bluetooth.enable = true;
    
    networking = {
      wifi.enable = true;
      avahi.enable = true;
    };

    desktop = {
      gaming.steam.enable = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # DO NOT CHANGE
  system.stateVersion = "24.11";
}
