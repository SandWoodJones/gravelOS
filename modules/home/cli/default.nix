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
    rm.enable = lib.gravelOS.mkEnableDefault "the rm command. You may want to disable this when switching to a trash manager program.";
  };

  config = {
    home.shellAliases.rm = lib.mkIf (!cfg.rm.enable) "printf \"\\e[31mCommand not executed\\e[0m\\n\"";

    programs = {
      zoxide.enable = true;
      tealdeer.enable = true;
      ripgrep = {
        enable = true;
        arguments = [ "--smart-case" ];
      };
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
