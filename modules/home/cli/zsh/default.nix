# INFO: maybe look into https://github.com/goolord/simple-zsh-nix-shell if it feels needed
# TODO: evaluation warning: getExe: Package "nms-1.0.1" does not have the meta.mainProgram attribute. We'll assume that the main program has the same name for now, but this behavior is deprecated, because it leads to surprising errors when the assumption does not hold. If the package has a main program, please set `meta.mainProgram` in its definition to make this warning go away. Otherwise, if the package does not have a main program, or if you don't control its definition, use getExe' to specify the name to the program, such as lib.getExe' foo "bar".

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
      (builtins.readFile (pkgs.replaceVars ./cp.sh { cp = lib.getExe pkgs.xcp; }))
      (builtins.readFile (pkgs.replaceVars ./tp.sh { trash = lib.getExe pkgs.trashy; }))
      (builtins.readFile (
        pkgs.replaceVars ./motd.sh (
          lib.mapAttrs (_: pkg: lib.getExe pkg) (
            with pkgs;
            {
              inherit fortune nms lolcat;
              cowsay = neo-cowsay;
            }
          )
        )
      ))
    ];
  };
}
