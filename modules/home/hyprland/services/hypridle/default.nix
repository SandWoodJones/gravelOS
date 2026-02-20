{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.hyprland.services.hypridle;
in
{
  imports = [
    ./dimming.nix
    ./locking.nix
    ./screenOff.nix
    ./hibernation.nix
  ];

  options.gravelOS.hyprland.services.hypridle = {
    enable = lib.mkEnableOption "Hypridle";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.hypridle = {
      Install.WantedBy = lib.mkForce [ config.gravelOS.hyprland.services.target ];
      Unit = {
        PartOf = lib.mkForce [ config.gravelOS.hyprland.services.target ];
        After = lib.mkForce [ config.gravelOS.hyprland.services.target ];
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
