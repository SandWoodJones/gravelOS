{ inputs, config, ... }:
  let secretsPath = builtins.toString inputs.mysecrets;
  in {
    config = {
      sops = {
        age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        defaultSopsFile = "${secretsPath}/secrets.yaml";
        validateSopsFiles = false;

        secrets.ssh-key.path = "${config.home.homeDirectory}/.ssh/id_swj";
      };

      services.ssh-agent.enable = true;
      programs.ssh = {
        enable = true;
        matchBlocks = {
          "git" = {
            host = "github.com";
            identitiesOnly = true;
            identityFile = [ "${config.home.homeDirectory}/.ssh/id_swj" ];
          };

          "secrets" = {
            host = "secrets.github.com";
            hostname = "github.com";
            identitiesOnly = true;
            identityFile = [ "${config.home.homeDirectory}/.ssh/id_nixOS_secrets" ];
          };
        };
      };
    };
}
