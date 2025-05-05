{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.cli;
in {
  options.gravelOS.cli = {
    configEnable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's environment variables, shell aliases and essential CLI tools.";
      type = lib.types.bool;
    };

    sudoDefaults = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to change sudo's password timeout and add password feedback.";
      type = lib.types.bool;
    };

    nix-index.enable = lib.mkEnableOption "the nix-index database";
  };

  config = lib.mkIf cfg.configEnable {
    programs = {
      direnv = {
        enable = true;
        silent = true;
        settings.global = {
          load_dotenv = true;
          strict_env = true; # TODO: remove when it becomes the default
        };
      };
      command-not-found.enable = false;

      nix-index.enable = cfg.nix-index.enable;
      nix-index-database.comma.enable = cfg.nix-index.enable;
    };

    services.lorri.enable = true;

    security.sudo.extraConfig = lib.mkIf cfg.sudoDefaults "Defaults env_reset,pwfeedback,timestamp_timeout=120,passwd_timeout=0";
 
    environment = {
      systemPackages = with pkgs; [
        helix
        file
        trashy
        fzf
        eza
        ov
        p7zip unrar unzip
        sops age ssh-to-age
        statix
      ];

      shellAliases = {
        clearx = "clear -x";
        gs = "git status";

        ls = "eza";
        tree = "eza -T --git-ignore";
      };

      variables = {
        EDITOR = "${pkgs.helix}/bin/hx";
        PAGER = "${pkgs.ov}/bin/ov-less";
      };
    };
  };
}
