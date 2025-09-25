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
    enable = lib.mkEnableOption "WezTerm and set it as the default terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };

    home.packages = [ pkgs.maple-mono.variable ];
  };
}
