{ lib, config, inputs, ... } :
let
  ifPresent = groups: lib.gravelOS.filterAttrs config.users.groups groups;
  sshKeysPath = "${inputs.self}/lib/keys";

  cfg = config.gravelOS.user;
in {
  options.gravelOS.user = {
    createSWJ = lib.mkOption {
      default = false;
      example = true;
      description = "Whether gravelOS should create the SandWood Jones user.";
      type = lib.types.bool;
    };

    managePasswords = lib.mkOption {
      default = false;
      example = true;
      description = "Whether passwords should be set through secrets. WARNING: make sure to have secrets working before enabling.";
      type = lib.types.bool;
    };
  };

  config = {
    users = {
      mutableUsers = !cfg.managePasswords;
    
      users = {
        root.hashedPasswordFile = lib.mkIf cfg.managePasswords config.sops.secrets.root-password.path;
        
        swj = lib.mkIf cfg.createSWJ {
          hashedPasswordFile = lib.mkIf cfg.managePasswords config.sops.secrets.swj-password.path;
          isNormalUser = true;
          description = "SandWood Jones";
          openssh.authorizedKeys.keyFiles = [ "${sshKeysPath}/id_swj.pub" ];
          useDefaultShell = true;
          extraGroups = [
            "wheel"
            "video"
          ] ++ ifPresent [
            "networkmanager"
            "gamemode"
          ];
        };
      };
    };
  };
}
