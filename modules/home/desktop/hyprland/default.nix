# TODO: install a screenshot utility
# TODO: configure hyprland, customize it, rice it, add plugins, etc
# TODO: check out hypr-nix https://github.com/hyprland-community/hyprnix
# TODO: move extraConfig to hyprland.settings option and delete hyprland.conf

{
  lib,
  config,
  osConfig,
  ...
}:
let
  cfg = config.gravelOS.desktop.hyprland;
in
{
  options.gravelOS.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  imports = [
    ./binds.nix
    ./rules.nix
    ./theming.nix
  ];

  config = lib.mkIf cfg.enable {
    gravelOS.desktop.hyprland.services.enable = lib.mkDefault true;

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = false;
        variables = [ "--all" ];
      };

      extraConfig = builtins.readFile ./hyprland.conf;

      # Force use packages from system
      package = null;
      portalPackage = null;
    };

    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      "$terminal" = lib.mkIf config.gravelOS.desktop.wezterm.enable "wezterm";

      # https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#5-launchers
      "$launcher" =
        lib.mkIf config.gravelOS.desktop.launcher.rofi.enable ''rofi -show drun -show-icons -run-command "uwsm app -- {cmd}"'';

      input.kb_layout = osConfig.services.xserver.xkb.layout;

      dwindle.preserve_split = true;

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
    };
  };
}
