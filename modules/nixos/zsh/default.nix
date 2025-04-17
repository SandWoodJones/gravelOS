{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.zsh;
in {
  options.gravelOS.zsh = {
    enable = lib.mkEnableOption "ZSH";
    enableConfig = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's ZSH configuration.";
      type = lib.types.bool;
    };
    default = lib.mkOption {
      default = false;
      example = true;
      description = "Set ZSH as the default shell for all users.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    users.defaultUserShell = lib.mkIf cfg.default pkgs.zsh;

    # As suggested here: https://github.com/nix-community/home-manager/blob/14929f7089268481d86b83ed31ffd88713dcd415/modules/programs/zsh.nix#L366-L370
    environment.pathsToLink = lib.mkIf cfg.enableConfig [ "/share/zsh" ];

    programs.zsh = lib.mkMerge [
      { enable = true; }

      (lib.mkIf cfg.enableConfig {
        histSize = 10000;

        setOptions = [
          "AUTO_PUSHD" "PUSHD_IGNORE_DUPS" "PUSHD_SILENT"
          "PUSHD_TO_HOME" "MULTIOS" "NO_CLOBBER"

          "HIST_IGNORE_DUPS" "HIST_IGNORE_ALL_DUPS"
          "HIST_EXPIRE_DUPS_FIRST" "HIST_FIND_NO_DUPS"
          "HIST_SAVE_NO_DUPS" "EXTENDED_HISTORY" "BANG_HIST"
          "SHARE_HISTORY" "HIST_FCNTL_LOCK" "HIST_VERIFY"

          "COMBINING_CHARS" "INTERACTIVE_COMMENTS" "RC_QUOTES"

          "AUTO_RESUME" "NO_HUP" "NO_BG_NICE" "NOTIFY" "NO_CHECK_JOBS"

          "COMPLETE_IN_WORD" "ALWAYS_TO_END" "PATH_DIRS"
          "AUTO_MENU" "AUTO_LIST" "AUTO_PARAM_SLASH"
          "NO_MENU_COMPLETE" "NO_FLOW_CONTROL"
        ];

        syntaxHighlighting = {
          enable = true;
          highlighters = [ "main" "brackets" ];
        };
      })
    ];
  };
}
