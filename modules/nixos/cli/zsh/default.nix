# NOTE: change to fish

{
  pkgs,
  ...
}:
{
  config = {
    # Needed to get system package completions for home-manager's zsh
    environment.pathsToLink = [ "/share/zsh" ];

    programs.zsh = {
      enable = true;

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
        ];
      };

      setOptions = [
        "ALWAYS_TO_END"
        "AUTO_LIST"
        "AUTO_MENU"
        "AUTO_PARAM_SLASH"
        "COMBINING_CHARS"
        "COMPLETE_IN_WORD"
        "EXTENDED_HISTORY"
        "HIST_EXPIRE_DUPS_FIRST"
        "HIST_FCNTL_LOCK"
        "HIST_FIND_NO_DUPS"
        "HIST_IGNORE_DUPS"
        "HIST_SAVE_NO_DUPS"
        "HIST_VERIFY"
        "INTERACTIVE_COMMENTS"
        "NO_CLOBBER"
        "NO_FLOW_CONTROL"
        "NO_NOTIFY"
        "RC_QUOTES"
        "SHARE_HISTORY"
      ];
    };

    users.defaultUserShell = pkgs.zsh;
  };
}
