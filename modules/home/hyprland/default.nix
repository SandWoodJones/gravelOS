# TODO: look into fuzzel, wofi, bemenu, tofi. Maybe just use fuzzel with kando
# TODO: install a screenshot utility

{ pkgs, lib, config, inputs, osConfig, ... }:
let
  cfg = config.gravelOS.hyprland;
  pkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in {
  options.gravelOS.hyprland.enable = lib.mkEnableOption "Hyprland";

  imports = [ ./rofi.nix ];

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = osConfig.gravelOS.hyprland.enable; message = "you must also enable the system Hyprland module"; }];

    # TODO: check out hypr-nix https://github.com/hyprland-community/hyprnix
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkg.hyprland;
      systemd.enable = false;

      # TODO: move extra config to hyprland.settings and delete hyprland.conf
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    # TODO: make a wezterm submodule
    home.packages = [ pkgs.kitty ];

    # TODO: configure hyprland, customize it, rice it, add plugins, etc
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";

      input.kb_layout = osConfig.services.xserver.xkb.layout;
      
      bind = [
        "CTRL+ALT, q, exec, uwsm stop"
        "$mod+SHIFT, r, execr, hyprctl reload"
        "ALT, F4, killactive,"

        "$mod, Return, exec, uwsm app -- kitty.desktop"
        "$mod, apostrophe, exec, uwsm app -- $launcher"
      ];
    };
  };
}
