# TODO: move away from SDDM and into greetd
{ lib, config, ... }:
let
  cfg = config.gravelOS.login;
in {
  options.gravelOS.login.enable = lib.mkEnableOption "a login manager";

  config = lib.mkIf cfg.enable {
    assertions = [{ assertion = config.gravelOS.display.enable; message = "you must have graphical display support enabled to use a login manager"; }];

    services.displayManager.sddm.enable = true;
  };
}
