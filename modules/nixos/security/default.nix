{ config, lib, ... }: {
  config = {
    security.sudo.extraConfig = ''
      Defaults env_reset,pwfeedback,timestamp_timeout=120,passwd_timeout=0
    '';

    services.openssh.enable = true;
    programs.ssh.startAgent = true;
    programs.gnupg.agent = {
      enable = true;
      enableBrowserSocket = true;
    };

    networking.firewall = lib.mkIf config.gravelOS.networking.ports.spotifyOpen {
      allowedTCPPorts = [ 57621 ];
      allowedUDPPorts = [ 5353 ];
    };
  };
}
