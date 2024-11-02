{ config, ... }: {
  config = {
    services.ssh-agent.enable = true;

    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
    
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "git" = {
          host = "github.com";
          identitiesOnly = true;
          identityFile = [ "${config.home.homeDirectory}/.ssh/id_swj" ];
        };

        "avahi" = {
          host = "*.local";
          identitiesOnly = true;
          identityFile = [ "${config.home.homeDirectory}/.ssh/id_swj" ];
        };
      };
    };
  };
}
