{ config, lib, ... }:
let
  cfg = config.gravelOS.networking;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.bluetooth.enable {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
    })

    (lib.mkIf cfg.wifi.enable {
      networking.networkmanager.enable = true;
    })
  ]; 
}
