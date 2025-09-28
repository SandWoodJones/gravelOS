_: {
  imports = [ ./hardware-configuration.nix ];

  gravelOS = {
    system = {
      boot = {
        dualBoot.enable = true;
        zen.enable = true;
      };
      user.managePasswords = true;
      audio.enable = true;

      networking = {
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
