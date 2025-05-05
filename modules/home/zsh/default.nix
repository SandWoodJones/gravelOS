{ lib, config, ... }:
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
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = lib.mkMerge [
      { enable = true; }

      (lib.mkIf cfg.enableConfig {        
        dotDir = ".config/zsh";
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

        initExtra = "source ${./.zshrc}";
      })
    ];
  };
}
