{ pkgs, lib, config, ... }:
let
  cfg = config.gravelOS.hyprland.services;
  
  bitwardenHelper = pkgs.writeShellApplication {
    name = "hyprland-bitwarden-helper";
    runtimeInputs = with pkgs; [ socat jq ];
    text = builtins.readFile ./hyprland-bitwarden-helper.sh;
  };
in {
  options.gravelOS.hyprland.services = {
    hyprpolkit.enable = lib.mkEnableOption "Hyprland Polkit Authentication Agent";
    nm-applet.enable = lib.mkEnableOption "nm-applet";
  };

  imports = [
    ./hypridle.nix
    ./rofi.nix
  ];

  config = lib.mkIf config.gravelOS.hyprland.enable (lib.mkMerge [
    {
      programs = {
        # TODO: start using eww instead
        # TODO: move configuration into nix
        waybar = {
          enable = true;
          systemd = { enable = true; target = "wayland-session@Hyprland.target"; };
        };

        # TODO: configure hyprlock
        hyprlock = {
          enable = true;
        };
      };

      systemd.user.services.hyprland-bitwarden-helper = {
        Unit = {
          PartOf = [ "wayland-session@Hyprland.target" ];
          After = [ "wayland-session@Hyprland.target" ];
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };
      
        Service = {
          ExecStart = "${bitwardenHelper}/bin/hyprland-bitwarden-helper";
          Restart = "on-failure";
        };

        Install.WantedBy = [ "wayland-session@Hyprland.target" ];
      };
    }
  
    (lib.mkIf cfg.hyprpolkit.enable {
      services.hyprpolkitagent.enable = cfg.hyprpolkit.enable;
      systemd.user.services.hyprpolkitagent = lib.mkIf cfg.hyprpolkit.enable {
        Install.WantedBy = lib.mkForce [ "wayland-session@Hyprland.target" ];
        Unit = {
          PartOf = lib.mkForce [ "wayland-session@Hyprland.target" ];
          After = lib.mkForce [ "wayland-session@Hyprland.target" ];
        };
      };
    })

    (lib.mkIf cfg.nm-applet.enable {
      home.packages = [ pkgs.networkmanagerapplet ];
      wayland.windowManager.hyprland.settings.exec-once = "uwsm app -- nm-applet --indicator";
    })
  ]);
}
