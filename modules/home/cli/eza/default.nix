{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.eza;
in
{
  imports = [
    ./theme.nix
  ];

  options.gravelOS.cli.eza = {
    enable = lib.mkEnableOption "eza";
    replace.enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to alias ls and tree to eza.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      eza = {
        enable = true;
        colors = "auto";
        icons = "auto";
        extraOptions = [ "--hyperlink" ];
      };

      # Disable LS_COLORS so it doesn't interfere with theme.yml
      zsh.initContent = ''eza() { env -u LS_COLORS eza "$@"}'';
    };
  
    home.shellAliases = lib.mkIf cfg.replace.enable {
      ls = "eza -x";
      tree = "eza -T --git-ignore";
    };
  };
}
