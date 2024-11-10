{ config, ... }: {
  config = {
    home.sessionVariables = {
      GRAVELOS_PATH = "${config.home.homeDirectory}/projects/gravelOS";
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
