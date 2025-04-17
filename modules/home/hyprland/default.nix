# TODO: install a screenshot utility
# TODO: configure hyprland, customize it, rice it, add plugins, etc

{ lib, config, osConfig, ... }:
let
  cfg = config.gravelOS.hyprland;
in {
  options.gravelOS.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  imports = [
    ./binds.nix
    ./rules.nix
  ];

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = osConfig.gravelOS.hyprland.enable; message = "you must also enable the system Hyprland module"; }];

    # TODO: check out hypr-nix https://github.com/hyprland-community/hyprnix
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;

      # TODO: move extra config to hyprland.settings and delete hyprland.conf
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";

      input.kb_layout = osConfig.services.xserver.xkb.layout;

      dwindle.preserve_split = true;

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
    };
  };
}
