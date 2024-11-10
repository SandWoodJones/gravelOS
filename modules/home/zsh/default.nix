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

      # https://stackoverflow.com/a/69014927
      completionInit = ''
        zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
        autoload -U compinit && compinit
      '';

      initExtra = "source ${./.zshrc}";
    };
  };
}
