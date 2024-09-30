{ lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  gravelOS = {
    networking = {
      bluetooth.enable = true;
      ports.spotifyOpen = true;
    };
  };

  # DO NOT CHANGE
  system.stateVersion = "24.05";
}
