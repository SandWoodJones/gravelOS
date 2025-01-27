{ pkgs, lib, config, inputs, ... }:
let
  cfg = config.gravelOS.hyprland;
  pkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in {
  options.gravelOS.hyprland.enable = lib.mkEnableOption "Hyprland";

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = config.gravelOS.display.enable; message = "you must have graphical display support enabled to use Hyprland"; }];

    programs.hyprland = {
      enable = true;
      package = pkg.hyprland;
      portalPackage = pkg.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
