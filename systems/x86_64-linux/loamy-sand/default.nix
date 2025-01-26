{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];
  
  gravelOS = {
    display.enable = true;
    audio.enable = true;
    kde.plasma.enable = true;

    bluetooth.enable = true;
    networking = {
      wifi.enable = true;
      ports.spotify = true;
    };
    ssh = { enable = true; secure = true; };
    git = { enable = true; enableConfig = true; };
    nh = { enable = true; clean.enable = true; };
    cli = {
      configEnable = true;
      sudoDefaults = true;
      nix-index.enable = true;
    };

    zsh = {
      enable = true;
      enableConfig = true;
      default = true;
    };

    desktop = {
      gaming.steam.enable = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # DO NOT CHANGE
  system.stateVersion = "24.11";
}
