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
    enable = lib.gravelOS.mkEnableDefault "eza";
    tree.enable = lib.mkOption {
      default = true;
      example = false;
      description = "Whether to create an alias for eza's tree function.";
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

    home.shellAliases = {
      tree = lib.mkIf cfg.tree.enable "eza -T --git-ignore";
    };
  };
}
