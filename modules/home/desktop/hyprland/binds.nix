{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.hyprland;

  workspaceBinds = builtins.concatLists (
    builtins.genList (
      i:
      let
        workspace = toString (i + 1);
      in
      [
        "$mod, ${workspace}, workspace, ${workspace}"
        "$mod+SHIFT, ${workspace}, movetoworkspace, ${workspace}"
      ]
    ) 9
  );

  windowMovementBinds =
    let
      directions = [
        {
          key = "H";
          dir = "l";
        }
        {
          key = "L";
          dir = "r";
        }
        {
          key = "K";
          dir = "u";
        }
        {
          key = "J";
          dir = "d";
        }
      ];
    in
    builtins.concatMap (
      { key, dir }:
      [
        "$mod, ${key}, movefocus, ${dir}"
        "$mod+SHIFT, ${key}, movewindow, ${dir}"
        "$mod+CTRL, ${key}, swapwindow, ${dir}"
      ]
    ) directions;
in
lib.mkIf cfg.enable {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod+SHIFT, r, execr, hyprctl reload"
      "$mod, l, execr, uwsm-app -- hyprlock"
      "ALT, F4, killactive,"

      "$mod, space, togglefloating,"

      "$mod, Return, exec, uwsm-app -- $terminal"
      "$mod, apostrophe, exec, uwsm-app -- $launcher"

      "$mod, 0, workspace, 10"
      "$mod+SHIFT, 0, movetoworkspace, 10"
      "$mod, S, togglespecialworkspace,"
      "$mod SHIFT, S, movetoworkspace, special"
    ]
    ++ workspaceBinds
    ++ windowMovementBinds;

    # l -> works when lockscreen is active.
    bindl = [
      "CTRL+ALT, q, exec, uwsm stop"

      '', switch:on:"Lid Switch", exec, hyprctl dispatch dpms on''
      '', switch:off:"Lid Switch", exec, hyprctl dispatch dpms off''

      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    # e -> repeat when held.
    bindel = [
      ",XF86MonBrightnessUp, exec, brillo -A 5 -q"
      ",XF86MonBrightnessDown, exec, brillo -U 5 -q"
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    # m -> mouse.
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
