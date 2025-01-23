{ lib, config, ... }:
let
  cfg = config.gravelOS.cli;
in {
  options.gravelOS.cli = {
    configEnable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's environment variables, shell aliases and essential CLI tools";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.configEnable {
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
