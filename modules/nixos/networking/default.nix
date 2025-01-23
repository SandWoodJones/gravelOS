{ lib, config, ... }:
let
  cfg = config.gravelOS.networking;
in {
  config = {
    networking.useDHCP = lib.mkDefault true;
    networking.networkmanager.enable = cfg.wifi.enable;

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
  };
}
