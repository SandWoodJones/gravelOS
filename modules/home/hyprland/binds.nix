let
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
in [  
  "CTRL+ALT, q, exec, uwsm stop"
  "$mod+SHIFT, r, execr, hyprctl reload"
  "ALT, F4, killactive,"

  "$mod, space, togglefloating,"

  "$mod, Return, exec, uwsm app -- $terminal"
  "$mod, apostrophe, exec, uwsm app -- $launcher"

  "$mod, 0, workspace, 10"
  "$mod+SHIFT, 0, movetoworkspace, 10"
] ++ workspaceBinds ++ windowMovementBinds
