# TODO: remove strict_env when it becomes the default

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.devEnv;
in
{
  options.gravelOS.cli.devEnv = {
    enable = lib.mkEnableOption "per-project environments with direnv";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        silent = true;
        settings.global = {
          load_dotenv = true;
          strict_env = true;
        };
      };
    };
  };
}
