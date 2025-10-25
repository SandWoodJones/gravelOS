# TODO: configure tealdeer
# TODO: configure ripgrep

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli;
in
{
  options.gravelOS.cli = {
    rm.enable = lib.mkOption {
      default = true;
      example = false;
      description = "Whether the rm command should be enabled. You may want to disable this when switching to a trash manager program.";
      type = lib.types.bool;
    };
  };

  config = {
    home = {
      shellAliases = {
        rm = lib.mkIf (!cfg.rm.enable) "printf \"\\e[31mCommand not executed\\e[0m\\n\"";

        sus = "systemctl --user";
        gs = "git status";
        storegrep = "nix-store --query --requisites /run/current-system | rg";
      };
    };

    programs = {
      zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };
      ripgrep = {
        enable = true;
        arguments = [ "--smart-case" ];
      };
      tealdeer.enable = true;
      pay-respects = {
        enable = true;
        options = [
          "--alias"
          "--nocnf"
        ];
      };
    };
  };
}
