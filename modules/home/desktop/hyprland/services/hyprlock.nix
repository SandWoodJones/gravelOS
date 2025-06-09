# TODO: configure hyprlock

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.hyprland.services;
in
{
  options.gravelOS.desktop.hyprland.services = {
    hyprlock.enable = lib.mkEnableOption "Hyprlock";
  };

  config = lib.mkIf cfg.waybar.enable {
    programs.hyprlock = {
      enable = true;
    };
  };
}
