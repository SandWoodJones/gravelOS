{ config, ... }: {
  config = {
    home.sessionVariables = {
      GRAVELOS_PATH = "${config.home.homeDirectory}/projects/gravelOS";
    };

    home.shellAliases = {
      sus = "systemctl --user";
      rm = "printf \"\\e[31mCommand not executed\\e[0m\\n\""; # Disable rm in favor of using trashy
    };
  
    programs = {
      zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };

      thefuck.enable = true;
      tealdeer.enable = true;
    };
  };
}
