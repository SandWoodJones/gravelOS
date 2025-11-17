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
  };

  config = lib.mkIf cfg.enable {
    programs = {
      eza = {
        enable = true;
        colors = "auto";
        icons = "auto";
        extraOptions = [ "--hyperlink" ];
      };

      fish.shellAbbrs.tree = "eza -T --git-ignore";
    };
  };
}
