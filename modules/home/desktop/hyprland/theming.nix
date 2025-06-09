{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.hyprland;

  mkUnsigned =
    n: desc:
    lib.mkOption {
      default = n;
      description = desc;
      type = lib.types.ints.unsigned;
    };
in
{
  options.gravelOS.desktop.hyprland = {
    theming = {
      enable = lib.mkOption {
        default = false;
        example = true;
        description = "Whether to set theming options for Hyprland.";
        type = lib.types.bool;
      };

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

  config = lib.mkIf cfg.theming.enable {
    wayland.windowManager.hyprland.settings = {
      general = {
        gaps_in = cfg.theming.gaps.default_in;
        gaps_out = cfg.theming.gaps.default_out;
        border_size = cfg.theming.border.size;
      };

      decoration = {
        rounding = cfg.theming.rounding.default;
      };

      workspace = lib.mkIf cfg.theming.smart.enable [
        "w[tv1], gapsout:${builtins.toString cfg.theming.gaps.smart_out}, gapsin:0"
        "f[1], gapsout:${builtins.toString cfg.theming.gaps.smart_out}, gapsin:0"
      ];

      windowrulev2 = lib.mkIf cfg.theming.smart.enable [
        "rounding ${builtins.toString cfg.theming.rounding.smart}, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
    };
  };
}
