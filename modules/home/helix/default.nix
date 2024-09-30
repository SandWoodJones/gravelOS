{ config, ... }: {
  config = { 
    programs.helix = {
      enable = true;
      defaultEditor = true;
    };
    
    programs.helix.settings = {
      editor.cursor-shape.insert = "bar";
      editor.auto-format = false;
      editor.bufferline = "multiple";

      editor.statusline.center = [ "version-control" ];
      editor.statusline.right = [ "diagnostics" "file-type" "selections" "register" "position" "file-encoding" ];

      keys = {
        normal = {
          tab = "move_parent_node_end";
          S-tab = "move_parent_node_start";
        };

        insert = {
          S-tab = "move_parent_node_start";
        };

        select = {
          tab = "extend_parent_node_end";
          S-tab = "extend_parent_node_start";
        };
      };
    };
  };
}
