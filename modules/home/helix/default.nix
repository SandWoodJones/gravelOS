{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.helix;
in {
  options.gravelOS.helix = {
    enable = lib.mkEnableOption "helix";
    enableConfig = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to enable gravelOS's helix configuration.";
      type = lib.types.bool;
    };
    defaultEditor = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to configure helix as the default editor.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nil ]; # nix lsp

    # TODO: further configure helix
    programs.helix = {
      enable = true;
      defaultEditor = cfg.defaultEditor;
    
      settings = lib.mkIf cfg.enableConfig {
        editor.cursor-shape.insert = "bar";
        editor.auto-format = false;
        editor.bufferline = "multiple";

        editor.statusline.center = [ "version-control" ];
        editor.statusline.right = [ "diagnostics" "file-type" "selections" "register" "position" "file-encoding" ];

        # TODO: edit the monokai theme to fit more to my liking
        theme = "monokai";

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
  };
}
