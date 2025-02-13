# TODO: install a screenshot utility
# TODO: configure hyprland, customize it, rice it, add plugins, etc

{ pkgs, lib, config, osConfig, ... }:
let
  cfg = config.gravelOS.hyprland;
in {
  options.gravelOS.hyprland.enable = lib.mkEnableOption "Hyprland";

  imports = [ ./rofi.nix ];

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = osConfig.gravelOS.hyprland.enable; message = "you must also enable the system Hyprland module"; }];

    # TODO: start using eww instead
    # TODO: move configuration into nix
    programs.waybar = {
      enable = true;
      systemd = { enable = true; target = "wayland-session@Hyprland.target"; };
    };

    # TODO: make a hyprpolkitagent module, maybe make a PR to home manager
    home.packages = [ pkgs.hyprpolkitagent ];
    systemd.user.services.hyprpolkitagent = {
      Unit = {
        Description = "Hyprland Polkit Authentication Agent";
        PartOf = [ "wayland-session@Hyprland.target" ];
        After = [ "wayland-session@Hyprland.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      Service = {
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Slice = "session.slice";
        TimeoutStopSec = "5sec";
        Restart = "on-failure";
      };

      Install = { WantedBy = [ "wayland-session@Hyprland.target" ]; };
    };

    # TODO: check out hypr-nix https://github.com/hyprland-community/hyprnix
    wayland.windowManager.hyprland = {
      enable = true;
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
