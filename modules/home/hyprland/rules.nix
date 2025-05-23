_: {
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
