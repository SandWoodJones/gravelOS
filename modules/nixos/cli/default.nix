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
        description = "Whether to replace command-not-found with nix-index.";
        type = lib.types.bool;
      };

      comma.enable = lib.mkOption {
        default = cfg.nix-index.enable;
        defaultText = lib.literalExpression "config.gravelOS.cli.nix-index.enable";
        example = true;
        description = "Whether to enable comma with the nix-index-database.";
        type = lib.types.bool;
      };
    };

    sudo.enableDefaults = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to increase sudo's password timeout and enable password feedback.";
      type = lib.types.bool;
    };
  };

  config = {
    documentation = {
      dev.enable = true;
      man.generateCaches = true;
    };

    programs = {
      command-not-found.enable = !cfg.nix-index.enable;
      nix-index.enable = cfg.nix-index.enable;
      nix-index-database.comma.enable = cfg.nix-index.comma.enable;

      nh.enable = true;
    };

    security.sudo.extraConfig = lib.mkIf cfg.sudo.enableDefaults "Defaults env_reset,pwfeedback,timestamp_timeout=120,passwd_timeout=0";
  };
}
