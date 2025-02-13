{ lib, config, ... }:
let
  cfg = config.gravelOS.hyprland;
in {
  options.gravelOS.hyprland.enable = lib.mkEnableOption "Hyprland";

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = config.gravelOS.display.enable; message = "you must have graphical display support enabled to use Hyprland"; }];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
