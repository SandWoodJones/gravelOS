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
    settings.screenOff = {
      enable = lib.gravelOS.mkEnableDefault "Hypridle turning the screen off on idling";

      timeout = lib.mkOption {
        default = 20;
        description = "The number of minutes of idling before the screen is turned off.";
        type = lib.types.numbers.positive;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.hypridle.settings.listener = lib.mkIf cfg.settings.screenOff.enable [
      {
        timeout = builtins.floor (60 * cfg.settings.screenOff.timeout);
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
    ];
  };
}
