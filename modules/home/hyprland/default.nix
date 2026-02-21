# TODO: install a screenshot utility
# TODO: configure hyprland, customize it, rice it, add plugins, etc
# TODO: check out hypr-nix https://github.com/hyprland-community/hyprnix

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.hyprland;
in
{
  options.gravelOS.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf cfg.enable {
    gravelOS.hyprland = {
      settings.enable = lib.mkDefault true;
      services.enable = lib.mkDefault true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = false;
        variables = [ "--all" ];
      };

      # Force use packages from system
      package = null;
      portalPackage = null;
    };

    home.packages = [ pkgs.gravelOS.posy-hyprcursor ];
  };
}
