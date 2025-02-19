{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.hyprland;
in lib.mkIf cfg.enable {
    # TODO: maybe make a PR to home manager
    home.packages = [ pkgs.hyprpolkitagent ];

    systemd.user.services = {
      hyprpolkitagent = {
        Unit = {
          Description = "Hyprland Polkit Authentication Agent";
          PartOf = [ "wayland-session@Hyprland.target" ];
          After = [ "wayland-session@Hyprland.target" ];
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };

        Service = {
          ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
          Slice = "session.slice";
          TimeoutStopSec = "5sec";
          Restart = "on-failure";
        };

        Install = { WantedBy = [ "wayland-session@Hyprland.target" ]; };
      };
    };
}
