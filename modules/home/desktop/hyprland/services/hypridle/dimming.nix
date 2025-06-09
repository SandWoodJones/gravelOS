{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.hyprland.services.hypridle;
in
{
  options.gravelOS.desktop.hyprland.services.hypridle = {
    settings = {
      dimming = {
        enable = lib.mkEnableOption "Hypridle dimming the screen on idling";

        timeout = lib.mkOption {
          default = 10;
          description = "The number of minutes of idling before the screen starts dimming.";
          type = lib.types.numbers.positive;
        };
        minBrightness = lib.mkOption {
          default = 10;
          description = "The minimum brightness value the screen should dim to.";
          type = lib.types.ints.unsigned;
        };
        dimDuration = lib.mkOption {
          default = 5;
          description = "The duration, in minutes, over which the brightness gradually decreases to settings.dimming.minBrightness";
          type = lib.types.numbers.positive;
        };
      };

      locking.dimming = {
        enable = lib.mkEnableOption "Hypridle dimming the lock screen on idling";

        minBrightness = lib.mkOption {
          default = 1;
          description = "The minimum brightness value the locked screen should dim to.";
          type = lib.types.ints.unsigned;
        };
        dimDuration = lib.mkOption {
          default = 4;
          description = "The duration, in minutes, over which the locked screen's brightness gradually decreases to config.gravelOS.desktop.hyprland.services.hypridle.settings.locking.dimming.minBrightness";
          type = lib.types.numbers.positive;
        };
      };
    };
  };

  config =
    let
      dimming_min = builtins.toString cfg.settings.dimming.minBrightness;
      dimming_dur = builtins.toString ((60 * cfg.settings.dimming.dimDuration) * 1000000);

      lock_dimming_min = builtins.toString cfg.settings.locking.dimming.minBrightness;
      lock_dimming_dur = builtins.toString ((60 * cfg.settings.locking.dimming.dimDuration) * 1000000);

      lockedCommand =
        if cfg.settings.locking.dimming.enable then
          "brillo -S ${lock_dimming_min} -u ${lock_dimming_dur};"
        else
          ":";
    in
    {
      services.hypridle.settings.listener = [
        (lib.mkIf cfg.settings.dimming.enable {
          timeout = builtins.floor (60 * cfg.settings.dimming.timeout);
          on-timeout = lib.concatStringsSep " " [
            "brillo -O &&"
            "if pidof hyprlock; then"
            "${lockedCommand}"
            "else"
            "brillo -S ${dimming_min} -u ${dimming_dur};"
            "fi"
          ];
          on-resume = "pkill brillo 2>/dev/null; brillo -I";
        })

        (lib.mkIf cfg.settings.locking.dimming.enable {
          timeout = builtins.floor (60 * cfg.settings.locking.timeout + 60 * cfg.settings.dimming.timeout);
          on-timeout = "brillo -S ${lock_dimming_min} -u ${lock_dimming_dur}";
        })
      ];
    };
}
