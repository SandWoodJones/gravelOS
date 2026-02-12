{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.networking;
in
{
  options.gravelOS.system.networking = {
    bluetooth.mediaControls.enable = lib.mkEnableOption "media controls for Bluetooth devices via MPRIS2";

    ssh = {
      identityPath = lib.mkOption {
        default = null;
        example = "/home/username/.ssh/id_key";
        description = "The path to the default SSH private key used for authentication.";
        type = lib.types.path;
      };

      git.enable = lib.mkEnableOption "SSH access to GitHub and GitLab with config.gravelOS.system.networking.ssh.identityPath";
      avahi.enable = lib.mkEnableOption "SSH access to .local hosts with config.gravelOS.system.networking.ssh.identityPath";
    };
  };

  config = {
    services.mpris-proxy.enable = cfg.bluetooth.mediaControls.enable;

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          forwardAgent = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          compression = false;
          addKeysToAgent = "no";
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
          sendEnv = [ "COLORTERM" ];
        };

        git = lib.mkIf cfg.ssh.git.enable {
          host = "github.com gitlab.com";
          identitiesOnly = true;
          identityFile = [ (toString cfg.ssh.identityPath) ];
        };

        avahi = lib.mkIf cfg.ssh.avahi.enable {
          host = "*.local";
          identitiesOnly = true;
          identityFile = [ (toString cfg.ssh.identityPath) ];
        };
      };
    };
  };
}
