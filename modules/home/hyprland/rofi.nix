{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.hyprland.rofi;
in {
  options.gravelOS.hyprland.rofi.enable = lib.mkOption {
    default = false;
    example = true;
    description = "Whether to enable Rofi (Wayland fork) as Hyprland's application launcher";
    type = lib.types.bool;
  };

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = config.gravelOS.hyprland.enable; message = "you must also enable the Hyprland module"; }];

    # TODO: configure rofi
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    wayland.windowManager.hyprland.settings."$launcher" = "rofi -show drun -show-icons";
  };
}
