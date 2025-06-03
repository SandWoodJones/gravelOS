{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.wezterm;
in
{
  options.gravelOS.desktop.wezterm = {
    enable = lib.mkEnableOption "WezTerm";
    default.enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to set WezTerm as the default terminal emulator.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };

    home.packages = [ pkgs.maple-mono.variable ];
  };
}
