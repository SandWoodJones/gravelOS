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
    nix-index = {
      enable = lib.mkOption {
        default = false;
        example = true;
        description = "Whether to replace command-not-found with nix-index";
        type = lib.types.bool;
      };

      comma.enable = lib.mkEnableOption "comma with nix-index-database.";
    };

    sudoDefaults = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to increase sudo's password timeout and enable password feedback.";
      type = lib.types.bool;
    };
  };

  config = {
    programs = {
      command-not-found.enable = !cfg.nix-index.enable;
      nix-index.enable = cfg.nix-index.enable;

      nix-index-database.comma.enable = cfg.nix-index.comma.enable;
    };

    security.sudo.extraConfig = lib.mkIf cfg.sudoDefaults "Defaults env_reset,pwfeedback,timestamp_timeout=120,passwd_timeout=0";
  };
}
