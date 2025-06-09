# TODO: look into fuzzel, wofi, bemenu, tofi. Maybe just use fuzzel with kando
# TODO: configure rofi

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.launcher;
in
{
  options.gravelOS.desktop.launcher = {
    rofi = {
      enable = lib.mkEnableOption "Rofi (Wayland fork)";
      default.enable = lib.mkOption {
        default = false;
        example = true;
        description = "Whether to set Rofi as the default application launcher.";
        type = lib.types.bool;
      };
    };
  };

  config = {
    programs.rofi = lib.mkIf cfg.rofi.enable {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };
}
