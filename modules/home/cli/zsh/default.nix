{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    autosuggestion.enable = true;

    historySubstringSearch = {
      enable = true;
      searchDownKey = "$terminfo[kcud1]";
      searchUpKey = "$terminfo[kcuu1]";
    };
    history.path = "${config.xdg.stateHome}/zsh_history";

    # https://stackoverflow.com/a/69014927
    completionInit = ''
      zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      autoload -U compinit && compinit
    '';

    initContent = lib.mkMerge [
      ''bindkey "''${key[Up]}" up-line-or-search'' # https://wiki.nixos.org/wiki/Zsh#Zsh-autocomplete_not_working
      (import ./cp.nix { inherit pkgs lib; })
      (import ./tp.nix { inherit pkgs lib; })
    ];
  };
}
