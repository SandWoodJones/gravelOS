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
    settings.locking = {
      enable = lib.mkEnableOption "Hypridle locking the screen on idling";

      timeout = lib.mkOption {
        default = 15;
        description = "The number of minutes of idling before locking the screen.";
        type = lib.types.numbers.positive;
      };
    };
  };

  config = lib.mkIf cfg.settings.locking.enable {
    services.hypridle.settings.listener = [
      {
        timeout = builtins.floor (60 * cfg.settings.locking.timeout);
        on-timeout = "pidof hyprlock || (loginctl lock-session && brillo -I)";
      }
    ];
  };
}
