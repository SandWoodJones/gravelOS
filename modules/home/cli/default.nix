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

    zoxide.cdReplace = lib.mkOption {
      default = false;
      example = true;
      description = "Whether `cd` should be replaced with zoxide.";
      type = lib.types.bool;
    };
  };

  config = {
    gravelOS.cli = {
      git.delta.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      ov.enable = lib.mkDefault true;
    };

    home = {
      shellAliases = {
        rm = lib.mkIf (!cfg.rm.enable) "printf \"\\e[31mCommand not executed\\e[0m\\n\"";

        sus = "systemctl --user";
        gs = "git status";
      };
    };

    programs = {
      zoxide = {
        enable = true;
        options = lib.mkIf cfg.zoxide.cdReplace [ "--cmd cd" ];
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
