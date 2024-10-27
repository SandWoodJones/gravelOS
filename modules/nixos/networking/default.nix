{ config, lib, ... }:
let
  cfg = config.gravelOS.networking;
in {
  config = lib.mkMerge [
    {
      networking.useDHCP = lib.mkDefault true;

      services.avahi = {
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
    }
  
    (lib.mkIf cfg.bluetooth.enable {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
    })

    (lib.mkIf cfg.wifi.enable {
      networking.networkmanager.enable = true;
    })
  ]; 
}
