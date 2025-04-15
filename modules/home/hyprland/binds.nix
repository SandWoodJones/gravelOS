{ lib, config, ... }:
let
  cfg = config.gravelOS.hyprland;

  workspaceBinds = builtins.concatLists ( builtins.genList (i:
    let workspace = toString (i + 1); in [
      "$mod, ${workspace}, workspace, ${workspace}"
      "$mod+SHIFT, ${workspace}, movetoworkspace, ${workspace}"
    ]
  ) 9);

  windowMovementBinds = let
    directions = [
      { key = "H"; dir = "l"; } { key = "L"; dir = "r"; } { key = "K"; dir = "u"; } { key = "J"; dir = "d"; }
    ];
  in builtins.concatMap ({ key, dir }: [
    "$mod, ${key}, movefocus, ${dir}" 
    "$mod+SHIFT, ${key}, movewindow, ${dir}" 
    "$mod+CTRL, ${key}, swapwindow, ${dir}" 
  ]) directions;
in lib.mkIf cfg.enable {
  # l -> works when lockscreen is active.
  # r -> trigger on release.
  # o -> trigger on long press.
  # e -> repeat when held.
  # n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
  # m -> mousw.
  # t -> cannot be shadowed by other binds.
  # i -> ignore modifiers.
  # s -> arbitrarily combine keys between each mod/key.
  # d -> allows bind description.
  # p -> bypasses the app's requests to inhibit keybinds.
  wayland.windowManager.hyprland.settings = {
    bind = [  
      "CTRL+ALT, q, exec, uwsm stop"
      "$mod+SHIFT, r, execr, hyprctl reload"
      "ALT, F4, killactive,"

      "$mod, space, togglefloating,"

      "$mod, Return, exec, uwsm app -- $terminal"
      "$mod, apostrophe, exec, uwsm app -- $launcher"

      "$mod, 0, workspace, 10"
      "$mod+SHIFT, 0, movetoworkspace, 10"
      "$mod, S, togglespecialworkspace,"
      "$mod SHIFT, S, movetoworkspace, special"
    ] ++ workspaceBinds ++ windowMovementBinds;
    
    bindel = [
      ",XF86MonBrightnessUp, exec, brillo -A 5 -q"
      ",XF86MonBrightnessDown, exec, brillo -U 5 -q"
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];
    bindl = [
      '', switch:on:"Lid Switch", exec, hyprctl dispatch dpms on''
      '', switch:off:"Lid Switch", exec, hyprctl dispatch dpms off''
    
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
