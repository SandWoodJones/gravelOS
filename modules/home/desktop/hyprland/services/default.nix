{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.hyprland.services;
in
{
  imports = [
    ./bar.nix
    ./hyprlock.nix
  ];

  options.gravelOS.desktop.hyprland.services = {
    nm-applet.enable = lib.mkEnableOption "nm-applet";
  };

  config = {
    gravelOS.desktop.hyprland.services = {
      nm-applet.enable = lib.mkDefault true;
      waybar.enable = lib.mkDefault true;
      hyprlock.enable = lib.mkDefault true;
    };

    home.packages = lib.optional cfg.nm-applet.enable pkgs.networkmanagerapplet;
    wayland.windowManager.hyprland.settings.exec-once =
      lib.mkIf cfg.nm-applet.enable "uwsm app -- nm-applet --indicator";
  };
}
