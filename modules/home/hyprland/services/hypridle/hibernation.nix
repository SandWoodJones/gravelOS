{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.hyprland.services.hypridle;
in
{
  options.gravelOS.hyprland.services.hypridle = {
    settings.hibernation = {
      enable = lib.gravelOS.mkEnableDefault "Hypridle sending the system into hibernation on idling";

      timeout = {
        ac = lib.mkOption {
          default = 60;
          description = "The number of minutes of idling while charging before the system hibernates.";
          type = lib.types.numbers.positive;
        };
        battery = lib.mkOption {
          default = 30;
          description = "The number of minutes of idling while on battery before the system hibernates.";
          type = lib.types.numbers.positive;
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.hypridle.settings.listener = lib.mkIf cfg.settings.hibernation.enable [
      {
        timeout = builtins.floor (60 * cfg.settings.hibernation.timeout.ac);
        on-timeout = "systemd-ac-power && systemctl hibernate";
      }

      {
        timeout = builtins.floor (60 * cfg.settings.hibernation.timeout.battery);
        on-timeout = "systemd-ac-power || systemctl hibernate";
      }
    ];
  };
}
