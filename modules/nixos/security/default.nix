{ inputs, config, lib, pkgs, ... }:
let
  secretsPath = builtins.toString inputs.mysecrets;
in {
  config = {
    security.sudo.extraConfig = ''
      Defaults env_reset,pwfeedback,timestamp_timeout=120
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

    sops = {
      defaultSopsFile = "${secretsPath}/secrets.yaml";
      validateSopsFiles = false;
      age = {
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };

    environment.systemPackages = with pkgs; [
      age
      sops
      ssh-to-age
    ];
  };
}
