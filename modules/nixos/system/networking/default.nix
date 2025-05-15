{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.system.networking;

  allUserPkgs = lib.gravelOS.connectLists config.home-manager.users (
    userCfg: userCfg.home.packages or [ ]
  );

  hasPkg =
    pkgName:
    lib.gravelOS.hasElement lib.getName pkgName config.environment.systemPackages
    || lib.gravelOS.hasElement lib.getName pkgName allUserPkgs;
in
{
  options.gravelOS.system.networking = {
    wifi.enable = lib.mkEnableOption "Wi-Fi.";
  };

  config = {
    networking = {
      networkmanager.enable = cfg.wifi.enable;

      firewall = {
        allowedTCPPorts = lib.concatLists [
          (lib.optional (hasPkg "spotifywm") 57621)
        ];

        allowedUDPPorts = lib.concatLists [
          (lib.optional (hasPkg "spotifywm") 5353)
        ];
      };
    };
  };
}
