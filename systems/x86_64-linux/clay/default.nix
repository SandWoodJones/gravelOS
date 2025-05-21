_: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    system = {
      boot = {
        dualBoot.enable = true;
        zen.enable = true;
      };

      user = {
        defaultUser.enable = true;
        managePasswords = true;
      };

      networking = {
        wifi.enable = true;
        bluetooth.enable = true;
        avahi.enable = true;
        ssh = {
          enable = true;
          secure = true;
        };
      };

      audio.enable = true;
      services.nh.clean.enable = true;
    };

    cli = {
      packages = {
        archive.enable = true;
        encryption.enable = true;
      };

      zsh.default = true;
      sudoDefaults = true;
      devEnv.enable = true;
      nix-index = {
        enable = true;
        comma.enable = true;
      };

      git.delta.enable = true;
    };

    desktop = {
      display.enable = true;
      kde.enable = true;

      gaming = {
        enable = true;
        performance.enable = true;
        steam.enable = true;
      };
    };
  };

  # DO NOT CHANGE
  system.stateVersion = "24.05";
}
