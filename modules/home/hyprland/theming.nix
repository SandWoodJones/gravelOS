{ lib, ... }: let
  mkUnsigned = n: lib.mkOption { default = n; type = lib.types.ints.unsigned; };
in {
  options.gravelOS.hyprland.theming = {
    gaps = {
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
}
