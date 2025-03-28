# TODO: install a screenshot utility
# TODO: configure hyprland, customize it, rice it, add plugins, etc

{ pkgs, lib, config, osConfig, ... }:
let
  cfg = config.gravelOS.hyprland;
in {
  options.gravelOS.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
    nm-applet.enable = lib.mkEnableOption "nm-applet";
  };

  imports = [
    ./binds.nix
    ./services.nix
    ./rofi.nix
  ];

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = osConfig.gravelOS.hyprland.enable; message = "you must also enable the system Hyprland module"; }];

    home.packages = lib.optional cfg.nm-applet.enable pkgs.networkmanagerapplet;

    # TODO: start using eww instead
    # TODO: move configuration into nix
    programs.waybar = {
      enable = true;
      systemd = { enable = true; target = "wayland-session@Hyprland.target"; };
    };

    # TODO: check out hypr-nix https://github.com/hyprland-community/hyprnix
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;

      # TODO: move extra config to hyprland.settings and delete hyprland.conf
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = lib.optional cfg.nm-applet.enable "uwsm app -- nm-applet --indicator";
    
      "$mod" = "SUPER";

      input.kb_layout = osConfig.services.xserver.xkb.layout;

      dwindle.preserve_split = true;

      windowrule = [
        "float, nm-connection-editor"
      ];
    };
  };
}
