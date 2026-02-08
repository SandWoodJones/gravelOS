{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.hyprland.settings;
in

lib.mkIf cfg.enable {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      {
        name = "float-nm-editor";
        "match:class" = "^(nm-connection-editor)$";
        float = "on";
      }
      {
        name = "global-nomax";
        "match:class" = "negative:^(firefox)$";
        suppress_event = "maximize";
      }

      # XWayland
      {
        name = "xwayland-ghost";
        "match:class" = "^$";
        "match:title" = "^$";
        "match:xwayland" = true;
        "match:float" = true;
        "match:fullscreen" = false;
        "match:pin" = false;
        no_focus = "on";
      }
      {
        name = "videobridge";
        "match:class" = "^(xwaylandvideobridge)$";
        no_anim = "on";
        no_initial_focus = "on";
        max_size = "1 1";
        no_blur = "on";
        no_focus = "on";
        opacity = "0.0 override";
      }
    ];
  };
}
