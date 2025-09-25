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
      enable = lib.mkEnableOption "Rofi (Wayland fork) and set it as the default application launcher";
    };
  };

  config = {
    programs.rofi = lib.mkIf cfg.rofi.enable {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };
}
