{ config, lib, ... }:
let
  cfg = config.gravelOS.networking;
in {
  config = {
    networking.useDHCP = lib.mkDefault true;
    networking.networkmanager.enable = cfg.wifi.enable;

    hardware.bluetooth = lib.mkIf cfg.bluetooth.enable { enable = true; powerOnBoot = true; };

    services.avahi = lib.mkIf cfg.avahi.enable {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
      };
    };

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    programs.ssh.startAgent = true;
  };
}
