{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];
  
  gravelOS = {
    login.enable = true;

    user = { createSWJ = true; managePasswords = true; };

    system = {
      audio.enable = true;
      networking = {
        wifi.enable = true;
        bluetooth.enable = true;
        avahi.enable = true;
        ssh = { enable = true; secure = true; };
      };
      services.nh.clean.enable = true;
    };

    cli = {
      packages = {
        archive.enable = true;
        encryption.enable = true;
      };
      sudoDefaults = true;
      nix-index = { enable = true; comma.enable = true; };
      devEnv.enable = true;
      git.delta.enable = true;
    };

    zsh = {
      enable = true;
      enableConfig = true;
      default = true;
    };

    desktop = {    
      display.enable = true;
      hyprland.enable = true;
      kde.enable = true;
      gaming = {
        enable = true;
        performance.enable = true;
        steam.enable = true;
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.graphics = {
    extraPackages = [ pkgs.intel-media-driver ];
    extraPackages32 = [ pkgs.pkgsi686Linux.intel-media-driver ];
  };

  # TODO: find out how to fix the system from crashing after suspend
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernate=yes
    AllowHybridSleep=no
  '';

  # DO NOT CHANGE
  system.stateVersion = "24.11";
}
