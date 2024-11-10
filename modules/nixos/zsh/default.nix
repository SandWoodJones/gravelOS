{ ... }: {
  config = {
    programs.zsh = {
      enable = true;
      histSize = 10000;

      setOptions = [
        "AUTO_PUSHD" "PUSHD_IGNORE_DUPS" "PUSHD_SILENT"
        "PUSHD_TO_HOME" "MULTIOS" "EXTENDED_GLOB" "NO_CLOBBER"

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

      shellAliases = {
        sus = "systemctl --user";
        clearx = "clear -x";
        gs = "git status";

        ls = "eza";
        tree = "eza -T --git-ignore";
  
        # Disable rm in favor of using trashy
        rm = "printf \"\\e[31mCommand not executed\\e[0m\\n\"";
        tp = "trash put";

        nix = "noglob nix"; # Disable globbing when running nix commands so that .#~ doesn't fail
      };
    };

    environment.pathsToLink = [ "/share/zsh" ]; # As suggested here: https://github.com/nix-community/home-manager/blob/14929f7089268481d86b83ed31ffd88713dcd415/modules/programs/zsh.nix#L366-L370
  };
}
