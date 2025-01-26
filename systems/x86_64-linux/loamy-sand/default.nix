{ pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];
  
  gravelOS = {
    user.createSWJ = true;
    display.enable = true;
    audio.enable = true;
    kde.plasma.enable = true;

    ssh = { enable = true; secure = true; };
    git = { enable = true; enableConfig = true; };
  
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
  boot.kernelParams = [ "i915.force_probe=46a3" "initcall_debug" "pm_debug" "no_console_suspend" ];
  boot.crashDump.enable = true;
  services.xserver.config = lib.mkAfter ''
    Section "Device"
      Identifier "Intel Graphics"
      Driver "modesetting"
      Option "NoAccel" "True"
    EndSection
  '';
  services.xserver.exportConfiguration = true;

  # DO NOT CHANGE
  system.stateVersion = "24.11";
}
