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
    home.shellAliases = {
      sus = "systemctl --user";
      rm = "printf \"\\e[31mCommand not executed\\e[0m\\n\""; # Disable rm in favor of using trashy
    };
  
    programs = {
      zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };

      # TODO: maybe replace with pay respects
      thefuck.enable = true;
      tealdeer.enable = true;
    };
  };
}
