# TODO: fix crash after suspend

_: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    system = {
      boot.zen.enable = true;
      user.managePasswords = true;
      audio.enable = true;

      networking = {
        wifi.enable = true;
        bluetooth.enable = true;
        avahi.enable = true;
        ssh.secure = true;
      };

      services.nh.clean.enable = true;
    };

    cli = {
      sudo.defaults.enable = true;
      devEnv.enable = true;
      nix-index.enable = true;
    };

    desktop = {
      display.enable = true;
      hyprland.enable = true;
      kde.enable = true;

      gaming = {
        enable = true;
        steam.enable = true;
      };
    };
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernate=yes
    AllowHybridSleep=no
  '';

  # DO NOT CHANGE
  system.stateVersion = "24.11";
}
