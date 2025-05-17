{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    login.enable = true;

    kde.plasma.enable = true;

    user = { createSWJ = true; managePasswords = true; };
  
    system = {
      audio.enable = true;
      networking = {
        wifi.enable = true;
        bluetooth.enable = true;
        avahi.enable = true;
        ssh = { enable = true; secure = true; };
      };
    };

    git = { enable = true; enableConfig = true; };
    # syncthing.enable = true;

    nh = { enable = true; clean.enable = true; };
    cli = {
      packages = {
        archive.enable = true;
        encryption.enable = true;
      };
      sudoDefaults = true;
      nix-index = { enable = true; comma.enable = true; };
      devEnv.enable = true;
    };

    zsh = {
      enable = true;
      enableConfig = true;
      default = true;
    };

    desktop = {    
      display.enable = true;
      gaming = {
        enable = true;
        performance.enable = true;
        steam.enable = true;
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.amdgpu.initrd.enable = true;

  system.stateVersion = "24.05";
}
