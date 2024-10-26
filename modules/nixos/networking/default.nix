{ config, lib, ... }:
let
  cfg = config.gravelOS.networking;
in {
  config = lib.mkMerge [
    {
      networking.useDHCP = true;
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
