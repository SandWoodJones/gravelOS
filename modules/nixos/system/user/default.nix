{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.gravelOS.system.user;
  ifPresent = groups: lib.gravelOS.filterAttrs config.users.groups groups;

  sshKeysPath = "${inputs.self}/keys";
in
{
  options.gravelOS.system.user = {
    defaultUser = {
      enable = lib.mkEnableOption "the creation of the system's default user";

      name = lib.mkOption {
        default = "swj";
        description = "Name for the system's default user.";
        type = lib.types.str;
      };

      description = lib.mkOption {
        default = "SandWood Jones";
        description = "GECOS field for the default user.";
        type = lib.types.str;
      };
    };

    managePasswords = lib.mkOption {
      default = false;
      example = true;
      description = "Whether passwords should be set through secrets. WARNING: make sure to have secrets working before enabling.";
      type = lib.types.bool;
    };
  };

  config = {
    sops.secrets = {
      root-password.neededForUsers = true;
      defaultUser-password.neededForUsers = true;
    };

    users = {
      mutableUsers = !cfg.managePasswords;

      users = {
        root.hashedPasswordFile = lib.mkIf cfg.managePasswords config.sops.secrets.root-password.path;

        "${cfg.defaultUser.name}" = lib.mkIf cfg.defaultUser.enable {
          inherit (cfg.defaultUser) description;

          isNormalUser = true;
          useDefaultShell = true;

          hashedPasswordFile = lib.mkIf cfg.managePasswords config.sops.secrets.defaultUser-password.path;
          openssh.authorizedKeys.keyFiles = [ "${sshKeysPath}/DefaultUser_ID.pub" ];
          extraGroups =
            [
              "wheel"
              "video"
            ]
            ++ ifPresent [
              "networkmanager"
              "gamemode"
            ];
        };
      };
    };
  };
}
