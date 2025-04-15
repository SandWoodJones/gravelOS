{ lib, config, ... }:
let
  cfg = config.gravelOS.hyprland.hypridle;
in {
  options.gravelOS.hyprland.hypridle = {
    enable = lib.mkEnableOption "hypridle";

    dimming = {
      enable = lib.mkEnableOption "hypridle dimming the screen.";
      timeout = lib.mkOption {
        default = 10;
        description = "Number of minutes of idling before the screen starts dimming.";
        type = lib.types.numbers.positive;
      };

      minBrightness = lib.mkOption {
        default = 10;
        description = "The minimum brightness value the screen should dim to.";
        type = lib.types.ints.unsigned;
      };

      dimDuration = lib.mkOption {
        default = 5;
        description = "Duration, in minutes, over which the brightness gradually decreases to minBrightness";
        type = lib.types.numbers.positive;
      };
    };

    locking = {
      enable = lib.mkEnableOption "hypridle locking the screen.";
      timeout = lib.mkOption {
        default = 15;
        description = "Number of minutes of idling before locking the screen.";
        type = lib.types.numbers.positive;
      };

      dimming = {
        enable = lib.mkEnableOption "hypridle dimming the lock screen.";
        minBrightness = lib.mkOption {
          default = 1;
          description = "The minimum brightness value the locked screen should dim to.";
          type = lib.types.ints.unsigned;
        };

        dimDuration = lib.mkOption {
          default = 4;
          description = "Duration, in minutes, over which the locked screen brightness gradually decreases to minBrightness";
          type = lib.types.numbers.positive;
        };
      };
    };

    screenOff = {
      enable = lib.mkEnableOption "hypridle turning the screen off.";
      timeout = lib.mkOption {
        default = 20;
        description = "Number of minutes of idling before the screen is turned off.";
        type = lib.types.numbers.positive;
      };
    };

    hibernation = {
      enable = lib.mkEnableOption "hypridle hibernation.";
      timeoutAC = lib.mkOption {
        default = 60;
        description = "Number of minutes of idling while charging before the system hibernates.";
        type = lib.types.numbers.positive;
      };

      timeoutBattery = lib.mkOption {
        default = 30;
        description = "Number of minutes of idling while on battery before the system hibernates.";
        type = lib.types.numbers.positive;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.hypridle = {
      Install.WantedBy = lib.mkForce [ "wayland-session@Hyprland.target" ];
      Unit = {
        PartOf = lib.mkForce [ "wayland-session@Hyprland.target" ];
        After = lib.mkForce [ "wayland-session@Hyprland.target" ];
      };
    };
  
    services.hypridle = {
      enable = true;
      
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = [
            "systemctl --user restart hypridle.service" # TODO: remove after https://github.com/hyprwm/hypridle/issues/73 is fixed
            "hyprctl dispatch dpms on"
          ];
        };

        listener = let
          dimming_min = builtins.toString cfg.dimming.minBrightness;
          dimming_dur = builtins.toString ((60 * cfg.dimming.dimDuration) * 1000000);

          lock_dimming_min = builtins.toString cfg.locking.dimming.minBrightness;
          lock_dimming_dur = builtins.toString ((60 * cfg.locking.dimming.dimDuration) * 1000000);
        in [
          # Screen dimming
          (lib.mkIf cfg.dimming.enable {
            timeout = builtins.floor (60 * cfg.dimming.timeout);
            on-timeout = "brillo -O && if pidof hyprlock; then brillo -S ${lock_dimming_min} -u ${lock_dimming_dur}; else brillo -S ${dimming_min} -u ${dimming_dur}; fi";
            on-resume = "pkill brillo 2>/dev/null; brillo -I";
          })

          # Screen lock
          (lib.mkIf cfg.locking.enable { 
            timeout = builtins.floor (60 * cfg.locking.timeout);
            on-timeout = "pidof hyprlock || (loginctl lock-session && brillo -I)";
          })
         
          # Screen lock dimming
          (lib.mkIf cfg.locking.dimming.enable { 
            timeout = builtins.floor (60 * cfg.locking.timeout + 60 * cfg.dimming.timeout);
            on-timeout = "brillo -S ${lock_dimming_min} -u ${lock_dimming_dur}";
          })

           # Screen off
          (lib.mkIf cfg.screenOff.enable {
            timeout = builtins.floor (60 * cfg.screenOff.timeout);
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          })

          # Hibernation AC
          (lib.mkIf cfg.hibernation.enable {
            timeout = builtins.floor (60 * cfg.hibernation.timeoutAC);
            on-timeout = "systemd-ac-power && systemctl hibernate";
          })

          # Hibernation battery
          (lib.mkIf cfg.hibernation.enable {
            timeout = builtins.floor (60 * cfg.hibernation.timeoutBattery);
            on-timeout = "systemd-ac-power || systemctl hibernate";
          })
        ];
      };
    };
  };
}
