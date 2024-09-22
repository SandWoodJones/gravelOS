{ config, ... }: {
  config = {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      autosuggestion.enable = true;

      historySubstringSearch.enable = true;
      historySubstringSearch.searchDownKey = "$terminfo[kcud1]";
      historySubstringSearch.searchUpKey = "$terminfo[kcuu1]";
      history.path = "${config.xdg.stateHome}/zsh_history";
    };
  };
}
