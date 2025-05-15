# TODO: use secrets to have fixed ssh keys for hosts

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
    bluetooth.enable = lib.mkEnableOption "Bluetooth.";
    avahi.enable = lib.mkEnableOption "Avahi.";
    ssh = {
      enable = lib.mkEnableOption "OpenSSH.";
      secure = lib.mkOption {
        default = false;
        example = true;
        description = "Whether to disable SSH login without private key.";
        type = lib.types.bool;
      };
    };
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

    hardware.bluetooth = lib.mkIf cfg.bluetooth.enable {
      enable = true;
      powerOnBoot = true;
    };

    services = {
      avahi = lib.mkIf cfg.avahi.enable {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
        };
      };

      openssh = lib.mkIf cfg.ssh.enable {
        enable = true;
        settings.PasswordAuthentication = cfg.ssh.secure;
        settings.KbdInteractiveAuthentication = cfg.ssh.secure;
      };
    };
  };
}
