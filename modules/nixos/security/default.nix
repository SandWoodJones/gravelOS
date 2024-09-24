{ inputs, lib, config, pkgs, ... }:
  let secretsPath = builtins.toString inputs.mysecrets;
  in {
    options.gravelOS.openSpotifyPorts = lib.mkOption {
      description = "Whether to open the necessary ports for spotify";
      type = lib.types.bool;
      default = false;
    };
  
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

      networking.firewall = lib.mkIf config.gravelOS.openSpotifyPorts {
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
