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
    target = lib.mkOption {
      default = "wayland-session@hyprland.desktop.target";
      example = "graphical-session.target";
      description = "The default Systemd target for Hyprland service units.";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    gravelOS.hyprland.services.hypridle.enable = lib.mkDefault true;

    services = {
      hyprpolkitagent.enable = true;
      mako.enable = true;
    };

    systemd.user.services = {
      mako = {
        Install.WantedBy = [ cfg.target ];
        Unit = {
          Description = "Lightweight Wayland notification daemon";
          Documentation = [ "man:mako(1)" ];
          PartOf = [ cfg.target ];
          After = [ cfg.target ];
        };
        Service = {
          Type = "dbus";
          BusName = "org.freedesktop.Notifications";
          ExecCondition = "${pkgs.runtimeShell} -c '[ -n \"$WAYLAND_DISPLAY\" ]'";
          ExecStart = "${pkgs.mako}/bin/mako";
          ExecReload = "${pkgs.mako}/bin/makoctl reload";
        };
      };

      hyprpolkitagent = {
        Install.WantedBy = lib.mkForce [ cfg.target ];
        Unit = {
          PartOf = lib.mkForce [ cfg.target ];
          After = lib.mkForce [ cfg.target ];
        };
      };
    };

    programs = {
      hyprlock.enable = true;
      quickshell.systemd = {
        enable = true;
        target = cfg.target;
      };
    };

    home.packages = [ pkgs.networkmanagerapplet ];
    wayland.windowManager.hyprland.settings.exec-once = "uwsm app -- nm-applet --indicator";
  };
}
