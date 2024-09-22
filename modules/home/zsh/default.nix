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

      initExtra = "bindkey \"''$\{key[Up]\}\" up-line-or-search"; # https://wiki.nixos.org/wiki/Zsh#Zsh-autocomplete_not_working
    };
  };
}
