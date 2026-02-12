{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.hyprland.settings;

  mkUnsigned =
    n: desc:
    lib.mkOption {
      default = n;
      description = desc;
      type = lib.types.ints.unsigned;
    };
in
{
  options.gravelOS.hyprland.settings = {
    theming = {
      smart.enable = lib.mkOption {
        default = false;
        example = true;
        description = "Change theming options when the workspace has a single visible window.";
        type = lib.types.bool;
      };

      gaps = {
        default_in = mkUnsigned 5 "The default size of gaps between windows.";
        default_out = mkUnsigned 5 "The default size of gaps between windows and monitor edges.";
        smart_out = mkUnsigned 3 "The size of gaps between the window and the monitor edge when the workspace has a single visible window.";
      };

      border.size = mkUnsigned 2 "The size of the border around windows.";

      rounding = {
        default = mkUnsigned 10 "The radius of rounded window corners (in px).";
        smart = mkUnsigned 5 "The radius of rounded window corners (in px) when the workspace has a single visible window.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      general = {
        gaps_in = cfg.theming.gaps.default_in;
        gaps_out = cfg.theming.gaps.default_out;
        border_size = cfg.theming.border.size;
      };

      env = [
        "HYPRCURSOR_THEME,Posy_Cursor_Black_Hyprcursor"
        "HYPRCURSOR_SIZE,24"
      ];

      decoration = {
        rounding = cfg.theming.rounding.default;
      };

      workspace = lib.mkIf cfg.theming.smart.enable [
        "w[tv1], gapsout:${toString cfg.theming.gaps.smart_out}, gapsin:0"
        "f[1], gapsout:${toString cfg.theming.gaps.smart_out}, gapsin:0"
      ];

      windowrule = lib.mkIf cfg.theming.smart.enable [
        {
          name = "smart-rounding-tiled";
          "match:workspace" = "w[tv1]";
          "match:float" = false;
          rounding = cfg.theming.rounding.smart;
        }
        {
          name = "smart-fullscreen-cleanup";
          "match:workspace" = "f[1]";
          "match:float" = false;
          border_size = 0;
          rounding = 0;
        }
      ];
    };
  };
}
