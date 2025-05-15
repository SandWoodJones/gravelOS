{ lib, config, osConfig, ... }:
let
  cfg = config.gravelOS.ssh;
in {
  options.gravelOS.ssh = {
    enable = lib.mkEnableOption "SSH configuration";
  };

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = osConfig.gravelOS.system.networking.ssh.enable; message = "you must have SSH enabled on your system configuration"; }];
  
    services.ssh-agent.enable = true;

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "git" = lib.mkIf osConfig.gravelOS.git.enable {
          host = "github.com gitlab.com";
          identitiesOnly = true;
          identityFile = [ "${config.home.homeDirectory}/.ssh/id_swj" ];
        };

        "avahi" = lib.mkIf osConfig.gravelOS.system.networking.avahi.enable {
          host = "*.local";
          identitiesOnly = true;
          identityFile = [ "${config.home.homeDirectory}/.ssh/id_swj" ];
        };
      };
    };
  };
}
