{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.hyprland.services.hypridle;
in
{
  imports = [
    ./dimming.nix
    ./locking.nix
    ./screenOff.nix
    ./hibernation.nix
  ];

  options.gravelOS.desktop.hyprland.services.hypridle = {
    enable = lib.mkEnableOption "Hypridle";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.hypridle = {
      Install.WantedBy = lib.mkForce [ "wayland-session@Hyprland.target" ];
      Unit = {
        PartOf = lib.mkForce [ "wayland-session@Hyprland.target" ];
        After = lib.mkForce [ "wayland-session@Hyprland.target" ];
      };
    };

    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = [
            "systemctl --user restart hypridle.service" # TODO: remove after https://github.com/hyprwm/hypridle/issues/73 is fixed
            "hyprctl dispatch dpms on"
          ];
        };
      };
    };
  };
}
