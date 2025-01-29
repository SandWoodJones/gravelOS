let
  workspaceBinds = builtins.concatLists ( builtins.genList (i:
    let workspace = toString (i + 1); in [
      "$mod, ${workspace}, workspace, ${workspace}"
      "$mod+SHIFT, ${workspace}, movetoworkspace, ${workspace}"
    ]
  ) 9);
in [  
  "CTRL+ALT, q, exec, uwsm stop"
  "$mod+SHIFT, r, execr, hyprctl reload"
  "ALT, F4, killactive,"

  "$mod, Return, exec, uwsm app -- kitty.desktop"
  "$mod, apostrophe, exec, uwsm app -- $launcher"

  "$mod, 0, workspace, 10"
  "$mod+SHIFT, 0, movetoworkspace, 10"
] ++ workspaceBinds
