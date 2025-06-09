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
    settings.screenOff = {
      enable = lib.mkEnableOption "Hypridle turning the screen off on idling";

      timeout = lib.mkOption {
        default = 20;
        description = "The number of minutes of idling before the screen is turned off.";
        type = lib.types.numbers.positive;
      };
    };
  };

  config = lib.mkIf cfg.settings.screenOff.enable {
    services.hypridle.settings.listener = [
      {
        timeout = builtins.floor (60 * cfg.settings.screenOff.timeout);
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
    ];
  };
}
