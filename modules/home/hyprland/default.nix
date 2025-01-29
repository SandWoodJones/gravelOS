# TODO: install a screenshot utility
# TODO: configure hyprland, customize it, rice it, add plugins, etc

{ pkgs, lib, config, inputs, osConfig, ... }:
let
  cfg = config.gravelOS.hyprland;
  pkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};

in {
  options.gravelOS.hyprland.enable = lib.mkEnableOption "Hyprland";

  imports = [ ./rofi.nix ];

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = osConfig.gravelOS.hyprland.enable; message = "you must also enable the system Hyprland module"; }];

    # TODO: make a wezterm submodule instead of kitty
    home.packages = [ pkgs.kitty ];

    # TODO: start using eww instead
    # TODO: move configuration into nix
    programs.waybar = {
      enable = true;
      systemd = { enable = true; target = "wayland-session@Hyprland.target"; };
    };

    # TODO: check out hypr-nix https://github.com/hyprland-community/hyprnix
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkg.hyprland;
      systemd.enable = false;

      # TODO: move extra config to hyprland.settings and delete hyprland.conf
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    # TODO: move to a binds.nix module
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";

      input.kb_layout = osConfig.services.xserver.xkb.layout;

      bind = import ./binds.nix;
    };
  };
}
