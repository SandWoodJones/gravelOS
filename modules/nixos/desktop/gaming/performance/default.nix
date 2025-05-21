# TODO: configure gamemode gpu settings

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.gaming.performance;
in
{
  options.gravelOS.desktop.gaming.performance.enable =
    lib.mkEnableOption "performance optimizations for dedicated gaming setups";

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        protontricks.enable = true;
        remotePlay.openFirewall = true;
      };

      gamemode = {
        enable = true;
        settings = {
          general = {
            softrealtime = "auto";
            renice = 10;
          };
          cpu.pin_cores = "yes";
        };
      };
    };

    security.pam.loginLimits = [
      {
        domain = "@gamemode";
        item = "nice";
        type = "soft";
        value = "-20";
      }
    ];
  };
}
