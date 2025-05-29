_: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    system = {
      boot = {
        dualBoot.enable = true;
        zen.enable = true;
      };

      user.managePasswords = true;

      networking = {
        bluetooth.enable = true;
        avahi.enable = true;
        ssh.secure = true;
      };

      services.nh.clean.enable = true;
    };

    cli = {
      packages = {
        archive.enable = true;
        encryption.enable = true;
      };

      zsh.default = true;
      sudo.enableDefaults = true;
      devEnv.enable = true;
      nix-index.enable = true;

      git.delta.enable = true;
    };

    desktop = {
      display.enable = true;
      kde.enable = true;

      gaming = {
        enable = true;
        performance.enable = true;
      };
    };
  };

  # DO NOT CHANGE
  system.stateVersion = "24.05";
}
