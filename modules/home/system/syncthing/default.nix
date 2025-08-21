# TODO: maybe use services.syncthing.tray

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.syncthing;
in
{
  options.gravelOS.system.syncthing = {
    enable = lib.mkEnableOption "Syncthing";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.syncthing-password = {};
    
    services.syncthing = {
      enable = true;
      passwordFile = config.sops.secrets.syncthing-password.path;
      overrideFolders = false;
      settings = {
        gui.user = "swj";
        devices = {
          clay.id = "K2NU5Q5-6RY5VSX-X2ZZTUY-Y7YPWET-SFZ5AFF-WJ3WG3X-IMK3DOS-XCO2OQ3";
          loamy-sand.id = "HEZ34Q3-GLITVEA-KQKLL4U-H7ZVI44-X334BOH-TCSHHJO-MTQZTBH-4B5ZZAN";
        };
      };
    };
  };
}
