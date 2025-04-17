{ lib, config, ... }:
let
  cfg = config.gravelOS.hyprland.theming;
  
  mkUnsigned = n: lib.mkOption { default = n; type = lib.types.ints.unsigned; };
in {
  options.gravelOS.hyprland.theming = {
    gaps = {
      smart = lib.mkOption {
        default = false;
        example = true;
        description = "Change gap options when the workspace has a single visible window.";
        type = lib.types.bool;
      };
    
      default_in = mkUnsigned 5;
      default_out = mkUnsigned 5;
      smart_in = mkUnsigned 0;
      smart_out = mkUnsigned 3;
    };

    border.size = mkUnsigned 2;

    rounding = {
      default = mkUnsigned 10;
      smart = mkUnsigned 5;
    };
  };

  config = lib.mkIf config.gravelOS.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      general = {
        gaps_in = cfg.gaps.default_in;
        gaps_out = cfg.gaps.default_out;
        border_size = cfg.border.size;
      };
      
      workspace = lib.mkIf cfg.gaps.smart [
        "w[tv1], gapsout:${builtins.toString cfg.gaps.smart_out}, gapsin:${builtins.toString cfg.gaps.smart_in}"
        "f[1], gapsout:${builtins.toString cfg.gaps.smart_out}, gapsin:${builtins.toString cfg.gaps.smart_in}"
      ];

      windowrulev2 = lib.mkIf cfg.gaps.smart [
        "rounding ${builtins.toString cfg.rounding.smart}, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
    };
  };
}
