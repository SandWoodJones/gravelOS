{ config, ... }: {
  config = {
    services.ssh-agent.enable = true;
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "git" = {
          host = "github.com";
          identitiesOnly = true;
          identityFile = [ "${config.home.homeDirectory}/.ssh/id_swj" ];
        };
      };
    };
  };
}
