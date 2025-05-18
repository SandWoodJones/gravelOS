{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.login;
in
{
  options.gravelOS.desktop.login = {
    enable = lib.mkEnableOption "a graphical login manager";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
  };
}
