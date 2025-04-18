{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    display.enable = true;
    login.enable = true;
    audio.enable = true;

    kde.plasma.enable = true;

    user = { createSWJ = true; managePasswords = true; };
  
    bluetooth.enable = true;
    networking = {
      wifi.enable = true;
      ports.spotify = true;
    };

    ssh = { enable = true; secure = true; };
    git = { enable = true; enableConfig = true; };
    avahi.enable = true;

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

    gaming = {
      enable = true;
      dedicated = true;
      steam.enable = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.amdgpu.initrd.enable = true;

  system.stateVersion = "24.05";
}
