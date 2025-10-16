{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.hyprland.services;
in
{
  options.gravelOS.hyprland.services = {
    enable = lib.mkEnableOption "user services for Hyprland";
  };

  config = lib.mkIf cfg.enable {
    gravelOS.hyprland.services.hypridle.enable = lib.mkDefault true;
    
    services.hyprpolkitagent.enable = true;
    systemd.user.services.hyprpolkitagent = {
      Install.WantedBy = lib.mkForce [ "wayland-session@Hyprland.target" ];
      Unit = {
        PartOf = lib.mkForce [ "wayland-session@Hyprland.target" ];
        After = lib.mkForce [ "wayland-session@Hyprland.target" ];
      };
    };

    programs.hyprlock.enable = true;

    home.packages = [ pkgs.networkmanagerapplet ];
    wayland.windowManager.hyprland.settings.exec-once = "uwsm app -- nm-applet --indicator";
  };
}
