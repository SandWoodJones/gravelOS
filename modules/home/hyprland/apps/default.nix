# TODO: use eww instead of waybar
# TODO: move waybar configuration into nix

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.hyprland.apps;
in
{
  options.gravelOS.hyprland.apps = {
    enable = lib.mkEnableOption "Wayland desktop apps";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "wayland-session@Hyprland.target";
      };
    };
  };
}
