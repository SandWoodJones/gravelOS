# TODO: move extraConfig to hyprland.settings option and delete hyprland.conf

{
  lib,
  config,
  osConfig,
  ...
}:
let
  cfg = config.gravelOS.hyprland.settings;
in
{
  options.gravelOS.hyprland.settings = {
    enable = lib.mkEnableOption "Hyprland configuration";
  };

  imports = [
    ./binds.nix
    ./rules.nix
    ./theming.nix
  ];

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      extraConfig = builtins.readFile ./hyprland.conf;
      settings = {
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
  };
}
