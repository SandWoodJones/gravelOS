{ lib, config, ... }:
let  
  cfg = config.gravelOS.hyprland;
  theme = cfg.theming;
in {
  config = lib.mkMerge [
    {
      wayland.windowManager.hyprland.settings = {
        windowrulev2 = [
          "float, class:^(nm-connection-editor)$"
          "suppressevent maximize, class:^(firefox)$"

          # Ignore maximizing requests
          "suppressevent maximize, class:.*"

          # XWayland
          "nofocus,              class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          "noanim,               class:^(xwaylandvideobridge)$"
          "noinitialfocus,       class:^(xwaylandvideobridge)$"
          "maxsize 1 1,          class:^(xwaylandvideobridge)$"
          "noblur,               class:^(xwaylandvideobridge)$"
          "nofocus,              class:^(xwaylandvideobridge)$"
          "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        ];
      };
    }

    (lib.mkIf cfg.smartgaps {
      wayland.windowManager.hyprland.settings = {
        workspace = [
          "w[tv1], gapsout:${builtins.toString theme.gaps.smart_out}, gapsin:${builtins.toString theme.gaps.smart_in}"
          "f[1], gapsout:${builtins.toString theme.gaps.smart_out}, gapsin:${builtins.toString theme.gaps.smart_in}"
        ];

        windowrulev2 = [
          "rounding ${builtins.toString theme.rounding.smart}, floating:0, onworkspace:w[tv1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"
        ];
      };
    })
  ];
}
