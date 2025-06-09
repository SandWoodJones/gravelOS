# TODO: replace kwallet with gnome-keyring

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.hyprland;
in
{
  options.gravelOS.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    # Enable default PAM rules for hyprlock
    security.pam.services.hyprlock = { };

    hardware.brillo.enable = true;
    services.playerctld.enable = true;

    environment.sessionVariables = {
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    };
  };
}
