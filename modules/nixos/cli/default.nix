{ pkgs, lib, config, ... }:
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

    nix-index.enable = lib.mkEnableOption "the nix-index database";
  };

  config = lib.mkIf cfg.configEnable {
    programs = {
      direnv = { enable = true; silent = true; };
      command-not-found.enable = false;

      nix-index.enable = cfg.nix-index.enable;
      nix-index-database.comma.enable = cfg.nix-index.enable;
    };
 
    environment = {
      systemPackages = with pkgs; [
        helix
        file
        trashy
        fzf
        eza
        ov
        p7zip
        unrar
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
