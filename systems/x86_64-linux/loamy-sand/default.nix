# TODO: find out how to fix the system from crashing after suspend

{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];
  
  gravelOS = {
    display.enable = true;
    login.enable = true;
    audio.enable = true;

    kde.plasma.enable = true;
    hyprland.enable = true;

    user.createSWJ = true;

    ssh = { enable = true; secure = true; };
    git = { enable = true; enableConfig = true; };
    avahi.enable = true;
  
    bluetooth.enable = true;
    networking = {
      wifi.enable = true;
      ports.spotify = true;
    };

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

    gaming = { enable = true; steam.enable = true; };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # DO NOT CHANGE
  system.stateVersion = "24.11";
}
