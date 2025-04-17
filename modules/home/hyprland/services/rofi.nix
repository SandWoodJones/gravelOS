# TODO: look into fuzzel, wofi, bemenu, tofi. Maybe just use fuzzel with kando
# 
{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.hyprland.services.rofi;
in {
  options.gravelOS.hyprland.services.rofi.enable = lib.mkEnableOption "Rofi (Wayland fork)";

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = config.gravelOS.hyprland.enable; message = "You must also enable the Hyprland module"; }];

    # TODO: configure rofi
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    # https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#5-launchers
    wayland.windowManager.hyprland.settings."$launcher" = ''rofi -show drun -show-icons -run-command "uwsm app -- {cmd}"'';
  };
}
