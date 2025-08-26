# TODO: use eww instead of waybar
# TODO: move waybar configuration into nix

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
    waybar.enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.waybar.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "wayland-session@Hyprland.target";
      };
    };

    systemd.user.services.waybar = {
      Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];
      Unit.PartOf = lib.mkForce [ "hyprland-session.target" ];
    };
  };
}
