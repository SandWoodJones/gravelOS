{ config, lib, ... }: {
  config = {
    security.sudo.extraConfig = "Defaults env_reset,pwfeedback,timestamp_timeout=120,passwd_timeout=0";

    networking.firewall = lib.mkIf config.gravelOS.networking.spotifyOpenPorts {
      allowedTCPPorts = [ 57621 ];
      allowedUDPPorts = [ 5353 ];
    };
  };
}
