{ lib, config, ... }:
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
    # TODO: further configure helix
    programs.helix = {
      enable = true;
      defaultEditor = cfg.defaultEditor;
    
      settings = lib.mkIf cfg.enableConfig {
        editor = {
          cursor-shape.insert = "bar";
          auto-format = false;
          bufferline = "multiple";

          lsp.auto-signature-help = false;

          statusline.center = [ "version-control" ];
          statusline.right = [ "diagnostics" "file-type" "selections" "register" "position" "file-encoding" ];
        };

        # TODO: edit the monokai theme to fit more to my liking
        theme = "monokai";

        keys = {
          normal = {
            tab = "move_parent_node_end";
            S-tab = "move_parent_node_start";

            C-x = ":toggle lsp.auto-signature-help";
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
