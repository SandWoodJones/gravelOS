{ lib, config, ... }:
let
  cfg = config.gravelOS.networking;
in {
  options.gravelOS.networking = {
    wifi.enable = lib.mkEnableOption "Wi-Fi";
    ports.spotify = lib.mkOption {      
      default = false;
      example = true;
      description = "Whether to open the necessary ports for spotify.";
      type = lib.types.bool;
    };
  };

  config = {
    networking = {
      useDHCP = lib.mkDefault true;
      networkmanager.enable = cfg.wifi.enable;
    
      firewall = lib.mkIf cfg.ports.spotify {
        allowedTCPPorts = [ 57621 ];
        allowedUDPPorts = [ 5353 ];
      };
    };
  };
}
