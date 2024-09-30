{ config, ... }: {
  config = {
    programs.git = {
      enable = true;
      extraConfig = {
        user.name = "SandWood Jones";
        user.email = "sandwoodjones@outlook.com";
        user.signingKey = "${config.home.homeDirectory}/.ssh/id_swj";
        gpg.format = "ssh";
        commit.gpgSign = true;
      };
    };
  };
}
